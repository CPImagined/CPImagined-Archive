import pyautogui as pag
from PIL import ImageGrab 
import time
import random

###############################
## VARIABLE DEFINITIONS
## Ajust variables as needed.
###################################

# Colors of the mine floor
# For Mac OS colors must be: (r, g, b, a)
# For Windows colors must be: (r, g, b)
GROUND_COLORS  = [(103, 80, 76), (94, 70, 67), (99, 81, 77)]

# Mining region coordinates (x, y)  
MINPOINT = (635, 635)
MAXPOINT = (1011, 907)

# Time (in seconds) to spend mining in place.
MINING_TIME = 12.5

OPEN_PUFFLE_TRICKS_TIME = 0.5

# Average walking time (in seconds).
AVERAGE_WALKING_TIME = 2

####################
## MAIN FUNCTION
####################

def mine():
    # Get random position within the defined mining area
    x, y = random.randint(MINPOINT[0], MAXPOINT[0]), random.randint(MINPOINT[1], MAXPOINT[1]) 
    
    # Using pillows imagegrab module to get the mining region
    image = ImageGrab.grab((x - 5, y - 5, x + 5, y + 5))
    
    # Uncomment this if you want to check which color is being grabbed
    #image.show()

    # Prevent accidental clicks on other penguins
    color = (0, 0, 0)
    for dx in range(10):
        for dy in range(10):
            color = image.getpixel((dx, dy))
            if color not in GROUND_COLORS:
                print(color)
                print("NOT VALID COLOR: %s" % (str(color)))
                print("Looking for new location...")
                return
            
    # Click to walk 
    print("Walking to: x: %s, y: %s" % (str(x), str(y)))
    print("Ground Color: %s" % (str(color)))
    pag.click(x, y)

    time.sleep(AVERAGE_WALKING_TIME + random.uniform(-1.0, 1.0)) 

    # Start mining (assumes you have your mining helmet on, if you don't the penguin will dance instead)
    print("Mining started...")
    print("Opening the Puffle Tricks...")
    
    pag.click(444,980)
    time.sleep(OPEN_PUFFLE_TRICKS_TIME + random.uniform(0.4, 0.4))
    pag.click(468,852)
    time.sleep(OPEN_PUFFLE_TRICKS_TIME + random.uniform(0.4, 0.4))

    pag.press("d") 
    

    # Time spent mining
    time.sleep(MINING_TIME + random.uniform(-2.5, 2.5))

    print("Done mining, finding new place to mine...")

###############################
## UTILITY FUNCTIONS
###################################

def get_region_colors(MINPOINT: tuple, MAXPOINT: tuple):
    min_x, min_y = MINPOINT[0], MINPOINT[1]
    max_x, max_y = MAXPOINT[0], MAXPOINT[1]

    # grab -> (left_x, top_y, right_x, bottom_y)
    mining_zone_image = ImageGrab.grab((min_x, min_y, max_x, max_y))

    # Deconstruct image into a list pixels (store pixel color into set)
    color_set = set()

    # (max_x - min_x): Number of pixels on the x-axis of the selected area.
    # (max_y - min_y): Number of pixels on the y-axis of the selected area.
    for x in range(0, max_x - min_x):
       for y in range(0, max_y - min_y):
            color_set.add(mining_zone_image.getpixel((x, y)))

    print("Colors in region: %s" % (color_set))
    mining_zone_image.show()
    
# Don't run the script if it's being used as a module.
if __name__ == "__main__":

    print("Click the Club Penguin Window, make sure the window is full screen")
    time.sleep(3)

    while True:
        mine()