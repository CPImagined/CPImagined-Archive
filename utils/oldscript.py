from zipfile import ZipFile, ZIP_DEFLATED
import sys
import ujson as json
import os

MAX_BLOCK_SIZE = 30000

REQUIRED_FILES = (
    'stamps.json',
    'stamps_tokenized.json',
    'tour_guide_messages.json',
    'weblogger.php',
    'chunking_map.json',
    'cover.json',
    'furniture_items.json',
    'game_strings.json',
    'games.json',
    'general.json',
    'igloo_floors.json',
    'igloo_locations.json',
    'igloo_music_tracks.json',
    'igloos.json',
    'jokes.json',
    'mascot_messages.json',
    'mascots.json',
    'newspapers.json',
    'paper_items.json',
    'paths.json',
    'penguin_action_frames.json',
    'player_colors.json',
    'polaroids.json',
    'postcards.json',
    'puffle_items.json',
    'puffles.json',
    'rooms.json'
)
VERIFY_CHUNKING = (
    'paper_items.json',
    'furniture_items.json',
    'puffle_items.json',
    'game_strings.json'
)
GAME_FILE = ZipFile(sys.argv[1])
LOADED_FILES = {}
CORRUPTED_FILES = {}
auto_fix = []
game_files = [name for name in GAME_FILE.namelist()]

# Check for missing files
for required in REQUIRED_FILES:
    if required not in game_files:
        print(f"CRITICAL: Missing configuration file: {required}")

if "chunking_map.json" not in game_files:
    print("Missing chunking map, exiting.")
    sys.exit(-1)

# Verify all syntax
for file in game_files:
    data = GAME_FILE.read(file)
    try:
        LOADED_FILES[file] = json.loads(data.decode('utf-8', 'ignore'))
    except ValueError as err:
        CORRUPTED_FILES[file] = data
        print(f"CRITICAL: Failed to parse {file}: {err}")
GAME_FILE.close()

def create_chunk_for_file(chunks, lst):
    chunks.clear()
    current_chunk = []
    for i, item in enumerate(lst):
        size = sys.getsizeof(json.dumps(current_chunk))
        if size in range(MAX_BLOCK_SIZE-2000, MAX_BLOCK_SIZE):
            chunks.append(len(current_chunk))
            current_chunk = []
        current_chunk.append(item)
    chunks.append(len(current_chunk))
    return chunks

def verify_chunk(chunk, name, checking):
    if isinstance(chunk, dict):
        for item in chunk:
            verify_chunk(chunk[item], name+"/"+item, checking[item])
        return
        
    current_block = 0
    for i, block in enumerate(chunk):
        current_chunk = json.dumps(checking[current_block:current_block+block])
        if sys.getsizeof(current_chunk) > MAX_BLOCK_SIZE:
            print(f"WARNING: Size of block at index {i} in {name} exceeds the max block size of {MAX_BLOCK_SIZE} bytes. This may cause stability issues.")
            auto_fix.append(f"Item with index of {i} in {name} is larger then the recommended limit. (NOT CRITICAL)")
            create_chunk_for_file(chunk, checking)
        current_block += block
        
    total = 0
    for block in chunk:
        total += block

    if total > len(checking):
        print(f"WARNING: Size of chunking for {name} is larger than it should be by {total-len(checking)}.")
        auto_fix.append(f"{name} larger then actual by {total-len(checking)}. (NOT CRITICAL)")
        create_chunk_for_file(chunk, checking)
    if total < len(checking):
        print(f"CRITICAL: Size of chunking for {name} is less than it should be by {len(checking)-total}.")
        auto_fix.append(f"{name} is smaller than it should be by {len(checking)-total}. (CRITICAL)")
        create_chunk_for_file(chunk, checking)

for chunk in LOADED_FILES["chunking_map.json"]:
    if chunk not in VERIFY_CHUNKING or chunk not in LOADED_FILES:
        continue
    verify_chunk(LOADED_FILES["chunking_map.json"][chunk], chunk, LOADED_FILES[chunk])

print("\n\n\n\n")
if auto_fix:
    print("The following are all the issues detected which can be fixed automatically:")
    for i, fix in enumerate(auto_fix, start=1):
        print(f"{i}. {fix}")
    answer = input("Enter Y if you would like to autofix all issues.")
    if answer.lower() == "y":
        os.remove(sys.argv[1])
        if sys.version_info.minor >= 7:
            NEW_FILE = ZipFile(sys.argv[1], 'a', compression=ZIP_DEFLATED, compresslevel=9)
        else:
            NEW_FILE = ZipFile(sys.argv[1], 'a')

        for file in LOADED_FILES:
            NEW_FILE.writestr(file, json.dumps(LOADED_FILES[file]))
        for file in CORRUPTED_FILES:
            NEW_FILE.writestr(file, CORRUPTED_FILES[file])
        print("Saved file successfully.")
print(f"Finished reading {sys.argv[1]}")