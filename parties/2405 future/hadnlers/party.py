import ujson, random, asyncio, time, pytz

from houdini import handlers, PenguinStringCompiler
from houdini.data.penguin import Penguin
from houdini.handlers import XTPacket
from houdini.data.room import Room
from houdini.handlers.play.navigation import handle_join_player_room, handle_join_room, handle_join_server
from datetime import datetime, timedelta

from houdini.handlers.play.igloo import get_layout_like_count
from houdini.data.igloo import  IglooFurniture, Igloo

## https://toolbox.solero.me/cparchives/wiki/Future_Party.html

CookieHandlerId = 20140501              ## Indentations versus Spaces ##

CookieHandlerName = "future"
PartyCacheCurrent = "future2023" 


def TotalDayParty(): #this is the number of days already passed in the party
    return 14


## MODIFIERS ##

C = 0  ## Add Asteroid Pts
WAVE_DURATION_DEFAULT = 5 * 60 * 1000 # in milliseconds

## Boss ## 
Health = 100 ## Boss : Max 100
Always_On = 0


## COUNTER
b_interval = 2 * 60 ## Boss Battle Duration (10 Minutes in Seconds)
c_duration = 5 * 60 * 1000 ## Counter Duration (5 Minutes in Milliseconds)

###########################################

DefaultPartyCookie = {
    'msgViewedArray': [0, 0, 0, 0, 0],
    'defeatProtobot': 0,
    "robos": [{"id": i, "colorId": 0} for i in range(3)],
    'asteroidPoints': 0 + C   
}


ItemCost = {
   ## NON-MEMBER
   3207: 0, ## Space Cadet Jetpack
   5442: 100,  ## Bubble Ray Gun
   1869: 100, ## Final Frontier Helm
   1871: 150, ## Asteroid Head 
   1870: 150, ## Zaryax VI
   5443: 100, ## Cybernetic Arm
   1868: 100, ## The Transmitter
   1872: 100, ## Cyborg Hat   
   1874: 0, ## Protobot Helmet
   ## MEMBER
   24099: 350, ## Planet Zeta Costume
   24097: 250, ## Final Frontier Suit
   24093: 500, ## Asteroid Costume
   24094: 850, ## UFO Costume
   24096: 250, ## Star Out Costume
   24095: 300, ## Planet Costume
   24098: 350, ## We Come in Peace Costume
   24100: 0 ## Protobot Costume
}

party_settings = {
    
    "protobotStartDay": 7,
    
    "roboColors": [{"id": i, "color": 0} for i in range(3)],
    
    "partySettings":{"partyIglooItems":[73],"unlockDayIndex": TotalDayParty(),"numOfDaysInParty":14},   
    
    "futurePartyRewards": [
                           {"unlockday":0,"memberItemId":24097,"nonmemberItemId":1869},                          
                           {"unlockday":0,"memberItemId":24093,"nonmemberItemId":1871},
                           {"unlockday":0,"memberItemId":24099,"nonmemberItemId":5442},                           
                           {"unlockday":0,"memberItemId":24094,"nonmemberItemId":1870},
                           {"unlockday":4,"memberItemId":24096,"nonmemberItemId":5443},
                           {"unlockday":4,"memberItemId":24095,"nonmemberItemId":1868},
                           {"unlockday":4,"memberItemId":24098,"nonmemberItemId":1872},
                           {"unlockday":7,"memberItemId":24100,"nonmemberItemId":1874}],
    
    "secondWeekItems": [24100,1874]  ## PROTOBOT ITEMS
}    


## countdown
c_begin = datetime.now()
c_elapsed = 0

## battle stuff
BossBeaten = 0
Room1Ongoing = 0
Room2Ongoing = 0  					

num = 10

Duration2 = -10000

wave1 = 0

PrevT = 0   ## Previous 
params = 0
new_params = 0
Initial = 0

wave2 = 0
WaveDuration = -10000

PrevStarTime1 = 0
PrevStarTime2 = 0
b_duration = (int(b_interval * 1000) + 15)		## Boss	| Modified in AS2



async def handle_countdown(server):
    global c_elapsed, c_duration, c_begin, b_interval, BossBeaten, Room2Ongoing

    
    while True:
        c_now = datetime.now()
        
        if c_elapsed >= c_duration:         
            c_elapsed = c_duration              
            server.logger.info(f"countdown halted for {b_interval} seconds")
            await asyncio.sleep(b_interval)  
            BossBeaten = 0
            Room2Ongoing = 0
            c_elapsed = 0
            c_begin = datetime.now()
            server.logger.info(f"restarted on {c_begin}")
            
             
        else:                  
            c_elapsed = (c_now - c_begin).total_seconds() * 1000
            await asyncio.sleep(1)  
                                        

@handlers.handler(XTPacket(CookieHandlerName, 'fpprotobotcountdown'))    ## Server-Synchronized
async def retrieve_global_countdown(p):  
    global c_duration, c_elapsed   
    c_remaining = max(0, c_duration - c_elapsed)                   
    p.logger.info(f"commences in {int(c_remaining / 1000)} seconds")
    
    await p.send_xt('fpprotobotcountdown', c_remaining, c_duration)


        


@handlers.handler(XTPacket(CookieHandlerName, 'partycookie'))
async def handle_party_cookie(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    await p.send_packet('partycookie', cookie)
    

async def update_party_cookie(p, cookie):
    await p.server.redis.hset(PartyCacheCurrent, p.id, ujson.dumps(cookie))
    newPartyCookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    newPartyCookie = newPartyCookie.decode('utf-8')
    await p.send_packet('partycookie', newPartyCookie)
    
 
 
@handlers.handler(XTPacket(CookieHandlerName, 'fptransform'))
async def handle_transformation(p, transform_id: int):
    p.avatar = transform_id
    await p.room.send_xt('spts', p.id, transform_id)


@handlers.handler(XTPacket(CookieHandlerName, 'fpmsgviewed'))
async def handle_msg_viewed(p, message_index: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['msgViewedArray'][message_index] = 1
    
    await update_party_cookie(p, cookie)  


@handlers.handler(XTPacket(CookieHandlerName, 'fppaint'))
async def handle_mech_paints(p, roboId: int, colorId: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    cookie['robos'][roboId]['colorId'] = colorId
    
    await update_party_cookie(p, cookie) 
    

@handlers.handler(XTPacket(CookieHandlerName, 'fphit'))  
async def gain_pts(p, A, asteroid_id: int):  
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
    
    global PrevT, Health, params, new_params, wave2, WaveDuration, WAVE_DURATION_DEFAULT    
    
    Asteroid = [
        [0, 10],
        [1, [10, 10, 10]],
        [2, 10],
        [3, 10]
    ]
    
    Asteroid[1][1].extend([10] * (30 - len(Asteroid[1][1]))) # Extend with zeros to ensure it has at least 22 elements

    end = 0
    appended = 0
    deducted = 0
    
    ## i: Small = 0 | Big = 1 | MicroBots = 2 | Boss = 3 |
    
    if A == "undefined":
        cookie['asteroidPoints'] += 10   ## MicroBots
        p.server.logger.info(f"Added 10 Points")
    
    if A != "undefined":
        for i in Asteroid:
            if i[0] == int(A):
                if isinstance(i[1], list):
                    cookie['asteroidPoints'] += i[1][asteroid_id]
                    p.server.logger.info(f"Added {i[1][asteroid_id]} Points")
                    break  
                else:
                    cookie['asteroidPoints'] += i[1]  # Handle the case when A[1] is an integer
                    p.server.logger.info(f"Added {i[1]} Points")
                    break  
          
        if int(A) == 3:  ## Boss
            Time = time.time()
            
            Health -= 1.7
            params = Health                  
                    
            p.server.logger.info(f"Health now {int(params)}")
            
            if 94 <= int(params) <= 96:              
                await p.room.send_xt('fpattack', random.randint(1, 6)) 
                
            if Time - PrevT >= 9:  ## Seconds            
                PrevT = Time
                await p.room.send_xt('fpattack', random.randint(1, 6)) 
                         
        if int(A) == 1:  ## Asteroids            
            
            p.server.logger.info(f"params {params}") 
            
            if new_params == 0:
                new_params = ",".join([f"{value}|40" for value in params.split(",")])
            
            asteroid_ids = [int(item.split('|')[0]) for item in new_params.split(",")]
            health_values = [int(item.split('|')[1]) for item in new_params.split(",")]         
        
            if asteroid_id not in asteroid_ids:                
                
                asteroid_ids.append(asteroid_id)
                health_values.append(20)
                globals()[f"asteroid{len(asteroid_ids)-1}"] = asteroid_id
                globals()[f"health{len(asteroid_ids)-1}"] = 20
                p.server.logger.info("APPENDED")                
                
                appended = 1                         
                              
        
            for i in range(len(asteroid_ids)):              
                if asteroid_ids[i] == asteroid_id and globals()[f"health{i}"] < 0:
                    globals()[f"health{i}"] = 20 
                    new_params = ",".join([f"{globals()[f'asteroid{i}']}|{globals()[f'health{i}']}" for i in range(len(asteroid_ids))])
                    await p.room.send_xt('fphit', A, asteroid_id, new_params, end)  
                
                if asteroid_ids[i] == asteroid_id and globals()[f"health{i}"] != 0:
                    globals()[f"health{i}"] -= 10  
                    deducted = 1                                                                        
                    
                    health_values[i] = globals()[f"health{i}"]
                    p.server.logger.info(f"Asteroid {asteroid_ids[i]} now has health {health_values[i]}")
                    
                    if asteroid_ids[i] == 0 and health_values[i] == 0:
                        cookie['asteroidPoints'] += 100
                        p.server.logger.info(f"Added 100 Points")

                    if asteroid_ids[i] in [1,2] and health_values[i] == 0:
                        cookie['asteroidPoints'] += 80
                        p.server.logger.info(f"Added 80 Points")

                    if ((3 <= asteroid_ids[i] <= 22)) and health_values[i] == 0:
                        cookie['asteroidPoints'] += 50
                        p.server.logger.info(f"Added 50 Points")
            
            
            if (all(globals()[f'health{i}'] == 0 for i in range(len(asteroid_ids)))) and appended == 0 and deducted == 1:
                end = 1              
              
                   
            new_params = ",".join([f"{globals()[f'asteroid{i}']}|{globals()[f'health{i}']}" for i in range(len(asteroid_ids))])
            p.server.logger.info(f"new params: {new_params}")
                        
            
    if A == "undefined":
            await p.room.send_xt('fphit', A, asteroid_id)
    
    if A != "undefined": 
                   
        if int(A) not in [3,1]:   
                await p.room.send_xt('fphit', A, asteroid_id)  
    
        if int(A) == 3:   
            await p.room.send_xt('fphit', A, asteroid_id, params)  
        
        if int(A) == 1:
            await p.room.send_xt('fphit', A, asteroid_id, new_params, end)  
    
    await update_party_cookie(p, cookie)



    


@handlers.handler(XTPacket('j', 'crl'), after=handle_join_room)   
async def handle_waves(p):
    
    global num, params, new_params
    global WaveDuration, Duration2
    global wave1, wave2
    
    if p.room.id == 859:                               
        await update_wave(p)
        await handle_elapsed_waves(wave1)                   
        await begin_wave(p, wave1, num, Duration2, params)
                      
    if p.room.id == 860:                                        
        await update_wave(p)
        await handle_elapsed_waves(wave2)     

        max_i = 100
        
        for i in range(max_i):
            var_name = f"health{i}"
            if var_name in globals():
                del globals()[var_name]

        for i in range(max_i):
            var_name = f"asteroid{i}"
            if var_name in globals():
                del globals()[var_name]
        
        if wave2 == 1:                    
            params = ",".join(str(random.choice([0, 1, 2, 6, 14, 22])) for _ in range(3))        
            new_params = 0
            asteroid_ids = [int(item) for item in params.split(",")]
            
            health_values = [40, 30, 20]
            
            for i in range(len(asteroid_ids)):
                globals()[f"asteroid{i}"] = asteroid_ids[i]
                globals()[f"health{i}"] = health_values[i]                                 
                    
        if wave2 == 3 and TotalDayParty() >= party_settings["protobotStartDay"]:  
            params = Health        
        
        await begin_wave(p, wave2, num, WaveDuration, params)
        
    
async def begin_wave(p, wave, num, duration, params):
    p.server.logger.info(f"Room : {p.room.id} WaveType : {wave} WaveNum : {num} of Duration {int(duration)}, params {params}") 
    await p.room.send_xt('fpwave', wave, num, int(duration), params)    


async def update_wave(p):
    
    global num, Health
    global c_elapsed, c_duration, Always_On
    global wave1, wave2, params
    global Room1Ongoing, Room2Ongoing, BossBeaten
        
               
    room = [[859, 0], [860, [1, 2, 3]]]
       
    for i in room:
        if i[0] == p.room.id:
            params = 0                                   
            
            if isinstance(i[1], list) and 3 in i[1]:  ## COUNTDOWN              
                if Room2Ongoing == 0 or (c_elapsed == c_duration or Always_On == 1):
                    if (((c_elapsed == c_duration) or Always_On == 1) and BossBeaten == 0) and TotalDayParty() >= party_settings["protobotStartDay"]:        
                        wave2 = 3
                        Health = 100
                        p.server.logger.info("Boss Initiated")
                        num += 1 
                        break
                    else:   
                        wave2 = 2  
                        num += 1 
                        break       
            
            else:
                if Room1Ongoing == 0:
                    wave1 = 0
                    num += 1 
                    break


async def handle_elapsed_waves(wave):    
    
    global PrevStarTime1, WaveDuration
    global PrevStarTime2, Duration2
    global b_duration, WAVE_DURATION_DEFAULT
    global Room1Ongoing, Room2Ongoing, BossBeaten
    global wave1, wave2
    global c_elapsed, c_duration, Always_On
                              
    if wave > 0:
        JoinTime1 = time.time() 
        Deductee = (JoinTime1 - PrevStarTime1) * 1000 
        if (WaveDuration - Deductee) < 0 or (c_elapsed == c_duration or Always_On == 1) or BossBeaten == 1:
            if wave != 3:        
                BossBeaten = 0
                WaveDuration = WAVE_DURATION_DEFAULT
                PrevStarTime1 = time.time()                
            elif wave == 3:
                WaveDuration = b_duration        ## Milliseconds
                PrevStarTime1 = time.time()    
            Room2Ongoing = 1         
        else:
            WaveDuration -= Deductee      ## Party10              
        
    if wave == 0:    
        JoinTime2 = time.time()  
        Deductee = (JoinTime2 - PrevStarTime2) * 1000
        if (Duration2 - Deductee)  < 0:
            Duration2 = WAVE_DURATION_DEFAULT    
            PrevStarTime2 = time.time()   
            Room1Ongoing = 1
        else:       
            Duration2 -= Deductee         ## Party9

                                            

@handlers.handler(XTPacket(CookieHandlerName, 'fpusepoints'))
async def use_asteroid_pts(p, item_id: int):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie) 
    
    if int(cookie['asteroidPoints']) <= 0 or int(cookie['asteroidPoints']) < ItemCost[item_id]: return False   
    
    cookie['asteroidPoints'] -= ItemCost[item_id]
    
    await p.add_inventory(p.server.items[item_id], cost=0)           
    
    await update_party_cookie(p, cookie)  
                       
 

@handlers.handler(XTPacket(CookieHandlerName, 'fpdefeatprotobot'))
async def win(p):
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    cookie = ujson.loads(cookie)
        
    global Room2Ongoing, BossBeaten    
    
    BossBeaten = 1
    Room2Ongoing = 0
    
    cookie['defeatProtobot'] = 1    
    cookie['asteroidPoints'] += 150
    
    await update_party_cookie(p, cookie) 
    
    
 
@handlers.handler(XTPacket('j', 'js'), after=handle_join_server)
@handlers.allow_once
async def handle_partysettings(p):
    await p.send_xt('activefeatures', CookieHandlerId)
    cookie = await p.server.redis.hget(PartyCacheCurrent, p.id)
    if cookie is None:
        cookie = ujson.dumps(DefaultPartyCookie)
        await p.server.redis.hset(PartyCacheCurrent, p.id, cookie)
    else:
        cookie = cookie.decode('utf-8')
    otherCookie = ujson.loads(cookie)
    if otherCookie['msgViewedArray'][0] == 0:
        await p.send_xt('jr', "851")
    await p.send_packet('partycookie', cookie)
    party_settings_json = ujson.dumps(party_settings)        
    await p.send_partypacket('partyservice', party_settings_json)
        
        

@handlers.boot
async def on_server_boot(server):
    server.show_countdown = asyncio.create_task(handle_countdown(server))  
    server.logger.info("countdown started")


@handlers.handler(XTPacket('g', 'gri'))
async def get_open_igloos(p):
    async def get_igloo_string(igloo):
        owner_name = p.server.penguins_by_id[igloo.penguin_id].safe_name
        like_count = p.server.cache.get(f'layout_like_count.{igloo.id}')
        like_count = await get_layout_like_count(igloo.id) if like_count is None else like_count
        p.server.cache.set(f'layout_like_count.{igloo.id}', like_count)
        igloo_population = len(igloo.penguins_by_id)
        return f'{igloo.penguin_id}|{owner_name}|{like_count}|{igloo_population}|{int(igloo.locked)}'
        
    async def igloo_is_spacebase():
        igloos = []
        for penguin_id, igloo in p.server.open_igloos_by_penguin_id.items():
            if penguin_id == p.id:
                continue
                
            furniture = await IglooFurniture.query.where((IglooFurniture.igloo_id == igloo.id) & (Igloo.id == 73)).gino.first()
            if furniture is not None:
                igloos.append(igloo)
        return igloos

    open_igloos = [await get_igloo_string(igloo) for igloo in await igloo_is_spacebase()]
    local_room_population = 0

    own_layout_like_count = p.server.cache.get(f'layout_like_count.{p.igloo}')
    own_layout_like_count = 0 if p.igloo is None else await get_layout_like_count(p.igloo) \
        if own_layout_like_count is None else own_layout_like_count
    p.server.cache.set(f'layout_like_count.{p.igloo}', own_layout_like_count)
	
    own_layout_like_count = 0 if p.igloo is None else await get_layout_like_count(p.igloo)
    await p.send_xt('gri', own_layout_like_count, local_room_population, *open_igloos)