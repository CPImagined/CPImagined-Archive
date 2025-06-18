import ujson, random, asyncio, time
from houdini.handlers import XTPacket, Priority
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from houdini.data.room import Room
from houdini import handlers, PenguinStringCompiler
from houdini.handlers import games
from houdini.data.penguin import Penguin
from datetime import datetime, timedelta


CookieHandlerId = 20130424 

CookieHandlerName = "shp"
PartyCacheCurrent = "shp2013" 

## Date = Unlocks set in AS2 ##

Bc = 0
Nc = 0

DefaultPartyCookie = {
    'glovePower': 1,
    'gloveTotal': 0,
    'robotPower': 40,
    'snowballPower': 0,
    'built': [0 + Bc] * 8,
    'inventory': [0 + Nc] * 32
}
    

 
async def send_party_cookie(p):
    cookie = ujson.dumps(p.cookie)
    await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    await p.send_xt('shppc', ujson.dumps(p.cookie))
       
       
@handlers.handler(XTPacket(CookieHandlerName, 'shppc'))
async def handle_party_cookie(p, cookie):
    
    # Convert the cookie string to a dictionary
    cookie_dict = ujson.loads(cookie)

    # Update p.cookie with values from the received cookie
    for key in cookie_dict:
        p.cookie[key] = cookie_dict[key]        

    # Convert the updated DefaultPartyCookie to JSON
    updated_cookie = ujson.dumps(p.cookie)

    # Store the updated JSON data in the Redis server cache
    await p.server.redis.hset(PartyCacheCurrent, p.id, updated_cookie)

    # Send the updated JSON data to the client instance via command
    await p.send_xt('shppc', updated_cookie)
       

@handlers.handler(XTPacket(CookieHandlerName, 'shprh'))
async def handle_attack_robots(p, victim_id: int):   
    
    for i in p.server.penguins_by_username.values():
        if(i.id == victim_id and i.room.id == p.room.id):
            i.cookie['robotPower'] -= 5
            PowerLevel = i.cookie['robotPower']
            await p.room.send_xt('shprh', int(PowerLevel), i.id)   
            await send_party_cookie(i)    
            
            if(PowerLevel <= 0):
                await asyncio.sleep(1)
                i.cookie['robotPower'] = 40
                await send_party_cookie(i)    
        
    
    
    
@handlers.handler(XTPacket(CookieHandlerName, 'shpgp'))
async def handle_power_snowball(p): 

    if(p.cookie['glovePower'] > 0):
    
        p.cookie['glovePower'] -= 1
        
        PowerLevel = p.cookie['glovePower']
        
        await p.send_xt('shpgp', int(PowerLevel)) 
        
        await send_party_cookie(p)    






################################################################################################
## BOSS CONFIGURATION ##########################################################################
################################################################################################

minute = 60

StartTime = time.time() 

Length = minute * 3   ## Minutes ##

Elapsed = 0

Remaining = 0

Boss_Health = 100   ## 100 MAX

Boss_Appears = Length * 7/10            ## Length - Boss_Appears = Countdown Interval

HitPoints = 5        ## From Boss_Health

OpenTargets = [0, 3, 6]

##################################################################################################


async def handle_countdown():
    
    global StartTime, Length, Elapsed, Remaining
    global Boss_Health, Boss_Appears
    global OpenTargets        
    
    
    while True:
        
        NowTime = time.time() 
        Elapsed = NowTime - StartTime
        
        Remaining = int(max(0, Length - Elapsed))    
        minutes = Remaining // 60      
 
        ##print(f"{minutes} minutes and {Remaining % 60 - minutes} seconds remaining")   
 
        if Remaining <= 0 or (Boss_Health <= 0 and Remaining < Boss_Appears):           ## RESTART ##     
            StartTime = time.time() 
            print("Timer Restarted")  
            
            
        if Boss_Appears + 20 < Remaining <= Length:      ## SERVER SIDED ##                         
            Boss_Health = 100           

        if Remaining == Length - 20:  
                        
            OpenTargets.clear()
            
            for _ in range(3):
                random_value = random.choice([x for x in range(6) if x not in OpenTargets])
                OpenTargets.append(random_value)
           
            print(f"GlobalOpenTargets {OpenTargets}")

        
        await asyncio.sleep(1) 



            
  



@handlers.boot
async def on_server_boot(server):
    server.show_countdown = asyncio.create_task(handle_countdown())    
    print("Countdown Initialized")
    




GlobalDefeated = 0
       
@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)
async def Send_Boss_Stats(p): 
    
    global Remaining, Boss_Health, Length, GlobalDefeated, Boss_Appears, OpenTargets
    
    GlobalDefeated = 0
    
    if Boss_Health <= 0:       
        
        GlobalDefeated = 1
    
    if p.room.id == 851:    
 
        await p.send_xt('Boss_Status', "INIT", Remaining, GlobalDefeated, Boss_Health, int(Boss_Appears), Length)       
        
        Targets = ', '.join(str(x) for x in OpenTargets)        ## No Need for Battle_Targets as Targets can only be targetted when condition is affirmated ##              
        
        await asyncio.sleep(1) 
        
        await p.room.send_xt("REVEAL", Targets)


        



@handlers.handler(XTPacket('bhs', 'brts'))
async def Battle_Targets(p, TargetID: int):               
    global Boss_Health, HitPoints, OpenTargets       
      
    Boss_Health -= HitPoints if TargetID >= 0 else +HitPoints        ## Villain Hitbox ID = -1 ## 
       
    if len(OpenTargets) <= 5:
        random_value1 = random.choice([x for x in range(7) if x not in OpenTargets])
        OpenTargets.append(random_value1)
    
    if len(OpenTargets) <= 4:
        random_value2 = random.choice([x for x in range(7) if x not in OpenTargets])
        OpenTargets.append(random_value2)

    if len(OpenTargets) >= 6:
        OpenTargets.clear()
        for _ in range(3):
            random_value = random.choice([x for x in range(7) if x != TargetID])  
            OpenTargets.append(random_value)        
        
    if TargetID in OpenTargets:
        OpenTargets.remove(TargetID)  

    
    await p.room.send_xt("REVEAL", OpenTargets)

    if Boss_Health >= 0:
        await p.room.send_xt('Boss_Status', "HIT", Boss_Health)
                              

        
    


PlayerFactions = []

@handlers.handler(XTPacket('TeamRing'))
async def TeamRings(p, Team: int):
    global PlayerFactions       

    p.Team = Team
    
    # Check if the player's Team is already in the PlayerFactions array
    player_found = False
    for i in range(len(PlayerFactions)):
        if PlayerFactions[i][0] == p.id:
            # If the player is found, update their Team
            PlayerFactions[i] = (p.id, Team)
            player_found = True
            break
    
    # If the player is not found, add a new entry
    if not player_found:
        PlayerFactions.append((p.id, Team))    
    
    print(f"PlayerFactions {PlayerFactions}")
    
    for player_id, Team in PlayerFactions:
        await p.room.send_xt('TeamRing', player_id, Team)



Prequel = time.time() 
    
@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)
async def Consistency(p):   
    
    global PlayerFactions
    
    for player_id, Team in PlayerFactions:
        await p.room.send_xt('TeamRing', player_id, Team)
        

    room = {
        330: [(2, 0)],  # Bank
        853: [(2, 1)],  # Hero Lair
        852: [(1, 2)],  # Villain Lair
        805: [(2, 3)],  # Berg
        1208: [(0, 4), (2, 4)],  # Stage // Police Dep.
        100: [(2, 5)],  # Town
        110: [(1, 6), (2, 6)],  # Coffee
        111: [(2, 7)]   # Book
    }

    ## room.id: (Prereq Team ID, Warning Msg ID), ##
    
    global Prequel, minute
    
    Joined = time.time() 
    Delayed = minute * 0

    if p.room.id in room:
        prerequisites = room[p.room.id]
        for prerequisite_id, warning_id in prerequisites:
            if p.Team == prerequisite_id:
                for i in p.server.penguins_by_username.values():
                    if(Joined - Prequel > Delayed):
                        await i.send_xt('Warning', warning_id, i.Team)            
                                  
                            


                            

@handlers.handler(XTPacket('j', 'js'), after= handle_join_server)
@handlers.allow_once
async def handle_get_partysettings(p, *args, **kwargs):    

    p.Team = 0 
    p.endScreen = 0
    
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    
    if cookie is None:
        p.cookie = DefaultPartyCookie
        cookie = ujson.dumps(p.cookie)
        
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    
    p.cookie = ujson.loads(cookie)
    
    await p.send_xt('activefeatures', CookieHandlerId)          

    await send_party_cookie(p)
    
    
@handlers.handler(XTPacket('ReTP'))     ## While In 851
async def updating_position(p, x, y):  
    p.x, p.y = x, y    
    await p.room.send_xt('ReTP', p.id, x, y)
    