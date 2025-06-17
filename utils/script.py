from os import makedirs, walk
from zipfile import ZipFile, ZIP_DEFLATED 
import json
import string
import random
import os
import sys
GAME_CONFIG_FILENAME = sys.argv[1]
import shutil
# print('penis')

def get_all_file_paths(directory):
    file_paths = []

    for root, directories, files in os.walk(directory):
        for filename in files:
            filepath = os.path.join(root, filename)
            file_paths.append(filepath)

    return file_paths

class GameConfigBinTool:

    def __init__(self):
        self.path = ''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(20))
        self.functions = {
            "furniture_items.json": self.chungus,
            "game_strings.json": self.get_localization_chunks,
            "mascot_messages.json": self.get_mascot_chunks,
            "paper_items.json": self.chungus,
            "penguin_action_frames.json": self.get_frame_hacks_chunks,
            "puffle_items.json": self.chungus,
            "stamps.json": self.get_stamp_chunks
        }
        self.decompress()
        shutil.rmtree(self.path)
        
    def decompress(self):
        with ZipFile(GAME_CONFIG_FILENAME, 'r') as zip:
            zip.extractall(self.path) 
        with open(f'{self.path}/chunking_map.json', "r") as f:
            # print(f.read()[785])
            chunks = self.fix_chunking_maps(json.loads(f.read()))
            with open(f'{self.path}/chunking_map.json', "w") as f:
                f.write(json.dumps(chunks))
            
        self.recompress()

    def recompress(self):
        with ZipFile('out/' + GAME_CONFIG_FILENAME, 'w', ZIP_DEFLATED) as zip:
            for file in get_all_file_paths(self.path):
                filename = file.split('\\')[1]
                zip.write(file, filename)
       
        
    def chungus(self, lst):
    
        chunks = []
        current_chunk = []
        for item in lst:
            if sys.getsizeof(json.dumps(current_chunk)) > 25000:
                chunks.append(len(current_chunk))
                current_chunk = []
            current_chunk.append(item)
        chunks.append(len(current_chunk))
        return chunks

    def get_localization_chunks(self, file):
        chunks = {}
        for key in file:
            chunks[key] = self.chungus(file[key])
        return chunks

    def fix_chunking_maps(self, chunky):
        new_file = {}
        for filename in chunky:
            with open(f'{self.path}/{filename}', 'r', encoding='LATIN-1') as f:
                file = json.load(f)
                new_file[filename] = self.functions[filename](file)
        return new_file
                
    def get_stamp_chunks(self, stamps):
        chunks = []
        for i in stamps:
            chunks.append(self.chungus(i['stamps']))
        return [self.chungus(stamps), chunks]    
        
    def get_frame_hacks_chunks(self, frames):
        chunks = {}
        for id in frames:
            chunks[id] = self.chungus(frames[id])
            
        return chunks
        
    def get_mascot_chunks(self, mascots):
        chunks = []
        script_chunks = {}
        for i, mascot in enumerate(mascots):
            chunks.append(self.chungus(mascot['mascotScript']))
            for iterater, category in enumerate(mascot['mascotScript']):
                script_chunks[f"{i},{iterater}"] = self.chungus(category['script'])
        return [self.chungus(mascots), chunks, script_chunks]    

GameConfigBinTool()