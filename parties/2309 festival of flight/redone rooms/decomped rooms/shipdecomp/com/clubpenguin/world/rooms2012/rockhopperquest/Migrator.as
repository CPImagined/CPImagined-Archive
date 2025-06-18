//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.Migrator extends com.clubpenguin.world.rooms.BaseRoom
    {
        static var TRIGGER_JACKHAMMER_FRONT, TRIGGER_JACKHAMMER_BACK, TRIGGER_ROCKET_FRONT, TRIGGER_ROCKET_BACK, TRIGGER_FAN, TRIGGER_EXIT, TRIGGER_TRAPPED_PENGUIN, MC_BLOCK_LAYER, MC_LIGHTHOUSE, MC_FAN_BLADES, MC_FAN_TARGET, MC_SAIL, MC_FLAG_BIG, MC_FLAG_SMALL, MC_ROCKET_FRONT, MC_ROCKET_BACK, MC_JACKHAMMER_BACK, MC_JACKHAMMER_FRONT, MC_OCEAN, MC_LAND, MC_SKY, MC_CLOUDS, MC_CARGO, MC_BRIDGE, MC_BRIDGE_ROPE_BACK, MC_BRIDGE_ROPE_FRONT, MC_ANCHOR, MC_BOW_WATER, MC_SIDE_WATER, MC_FRONT_ICEBERG, MC_ICE_ON_DECK, MC_MAP;
        var _stage, _SHELL, _iceAnimation, _frontIceberg, _playerHasCompletedQuest, _fan, _frontRocket, _backRocket, _frontJackhammer, _backJackhammer, _iceOnDeck, _opcodeJournal, _destroyDelegate, _shipTriggers, _sequencer, _questState, _INTERFACE, _exitRoom, _ENGINE;
        function Migrator (stageReference) {
            super(stageReference);
            _stage.start_x = 450;
            _stage.start_y = 304;
            if (!_SHELL) {
                init();
            }
        }
        function testFunction(num) {
        }
        function updateAnimations() {
            _iceAnimation.update();
            _frontIceberg.update();
        }
        function init() {
            TRIGGER_JACKHAMMER_FRONT = _stage.triggers_mc.jackhammerFrontTrigger;
            TRIGGER_JACKHAMMER_BACK = _stage.triggers_mc.jackhammerBackTrigger;
            TRIGGER_ROCKET_FRONT = _stage.triggers_mc.frontRocketTrigger;
            TRIGGER_ROCKET_BACK = _stage.triggers_mc.backRocketTrigger;
            TRIGGER_FAN = _stage.triggers_mc.fanTrigger;
            TRIGGER_EXIT = _stage.triggers_mc.exitTrigger;
            TRIGGER_TRAPPED_PENGUIN = _stage.triggers_mc.trappedPenguinTrigger;
            MC_BLOCK_LAYER = _stage.block_mc;
            MC_LIGHTHOUSE = _stage.foreground_mc.lighthouse;
            MC_FAN_BLADES = _stage.fan.fanBlades;
            MC_FAN_TARGET = _stage.fan.fanTarget;
            MC_SAIL = _stage.foreground_mc.sail;
            MC_FLAG_BIG = _stage.background_mc.flagBig.flag;
            MC_FLAG_SMALL = _stage.crowsNest.crowsNestBack.flag;
            MC_ROCKET_FRONT = _stage.shipRight.rocketFront;
            MC_ROCKET_BACK = _stage.background_mc.rocketBack;
            MC_JACKHAMMER_BACK = _stage.background_mc.jackHammerLeft;
            MC_JACKHAMMER_FRONT = _stage.shipRight.jackHammerRight;
            MC_OCEAN = _stage.background_mc.ocean;
            MC_LAND = _stage.shipRight.land;
            MC_SKY = _stage.background_mc.sky;
            MC_CLOUDS = _stage.background_mc.clouds;
            MC_CARGO = _stage.box;
            MC_BRIDGE = _stage.shipRight.bridge;
            MC_BRIDGE_ROPE_BACK = _stage.shipRight.bridgeRopeRight;
            MC_BRIDGE_ROPE_FRONT = _stage.bridgeRopeLeft;
            MC_ANCHOR = _stage.shipRight.anchor;
            MC_BOW_WATER = _stage.shipRight.waterFront;
            MC_SIDE_WATER = _stage.shipRight.sideWater;
            MC_FRONT_ICEBERG = _stage.background_mc.frontIceberg;
            MC_ICE_ON_DECK = _stage.iceBlock;
            MC_MAP = _stage.background_mc.shipInside.map;
            _targetsHit = 0;
            if (_SHELL.isItemInMyInventory(BEACON_PIN_ID)) {
                _playerHasCompletedQuest = true;
                MC_MAP.gotoAndStop(MAP_SHOWN);
                MC_MAP.mapButton.onRelease = com.clubpenguin.util.Delegate.create(this, onMapButtonClicked);
            } else {
                _playerHasCompletedQuest = false;
            }
            _fan = new com.clubpenguin.world.rooms2012.rockhopperquest.Fan(MC_FAN_BLADES, MC_FAN_TARGET, MC_SAIL);
            _frontRocket = new com.clubpenguin.world.rooms2012.rockhopperquest.Rocket(MC_ROCKET_FRONT);
            _backRocket = new com.clubpenguin.world.rooms2012.rockhopperquest.Rocket(MC_ROCKET_BACK);
            _frontJackhammer = new com.clubpenguin.world.rooms2012.rockhopperquest.Jackhammer(MC_JACKHAMMER_FRONT);
            _backJackhammer = new com.clubpenguin.world.rooms2012.rockhopperquest.Jackhammer(MC_JACKHAMMER_BACK);
            _frontIceberg = new com.clubpenguin.world.rooms2012.rockhopperquest.Iceberg(MC_FRONT_ICEBERG, 392, 242);
            var _local_3 = _stage.background_mc.ocean.createEmptyMovieClip("iceHolder", _stage.getNextHighestDepth());
            _iceAnimation = new com.clubpenguin.world.rooms2012.rockhopperquest.RandomizedParallaxBackground(_local_3, {x:0, y:20, width:760, height:50}, ["midBerg1", "midBerg2", "midBerg3", "midBerg4"]);
            _iceOnDeck = new com.clubpenguin.world.rooms2012.rockhopperquest.IceOnDeck(MC_ICE_ON_DECK, 627, 205);
            _stage.onEnterFrame = updateAnimations;
            _stage._iceAnimation = _iceAnimation;
            _stage._frontIceberg = _frontIceberg;
            _opcodeJournal = new com.clubpenguin.world.rooms2012.rockhopperquest.OpcodeJournal();
            var _local_4 = _SHELL.getMyPlayerId();
            _opcodeJournal.init(_local_4);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            TRIGGER_EXIT.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
            _shipTriggers = com.clubpenguin.world.rooms.common.TriggerCheck.fetchInstance();
            _shipTriggers.addTrigger(TRIGGER_JACKHAMMER_BACK, com.clubpenguin.util.Delegate.create(_backJackhammer, _backJackhammer.onPenguinTriggerUpdate));
            _shipTriggers.addTrigger(TRIGGER_JACKHAMMER_FRONT, com.clubpenguin.util.Delegate.create(_frontJackhammer, _frontJackhammer.onPenguinTriggerUpdate));
            _shipTriggers.addTrigger(TRIGGER_ROCKET_BACK, com.clubpenguin.util.Delegate.create(_backRocket, _backRocket.onPenguinTriggerUpdate));
            _shipTriggers.addTrigger(TRIGGER_ROCKET_FRONT, com.clubpenguin.util.Delegate.create(_frontRocket, _frontRocket.onPenguinTriggerUpdate));
            _shipTriggers.addTrigger(TRIGGER_FAN, com.clubpenguin.util.Delegate.create(_fan, _fan.onPenguinTriggerUpdate));
            var _local_2 = _shipTriggers.addTrigger(MC_ICE_ON_DECK, com.clubpenguin.util.Delegate.create(this, onPlayerOverIceOnDeck));
            _shipTriggers.defineDancingRequiredRequirement(_local_2, true);
            _shipTriggers.init();
            _fan.init();
            _frontRocket.init();
            _backRocket.init();
            _frontJackhammer.init();
            _backJackhammer.init();
            _fan.activated.add(onSpeedBoosterActivated, this);
            _fan.deactivated.add(onSpeedBoosterDeactivated, this);
            _frontRocket.activated.add(onSpeedBoosterActivated, this);
            _frontRocket.deactivated.add(onSpeedBoosterDeactivated, this);
            _backRocket.activated.add(onSpeedBoosterActivated, this);
            _backRocket.deactivated.add(onSpeedBoosterDeactivated, this);
            _frontIceberg.destroyed.add(onIcebergSmashed, this);
            MC_FLAG_BIG.gotoAndStop(FLAG_IDLE);
            MC_FLAG_SMALL.gotoAndStop(FLAG_IDLE);
            MC_BRIDGE.gotoAndStop(BRIDGE_IDLE);
            MC_BRIDGE_ROPE_BACK.gotoAndStop(BRIDGE_IDLE);
            MC_BRIDGE_ROPE_FRONT.gotoAndStop(BRIDGE_IDLE);
            MC_ANCHOR.gotoAndStop(ANCHOR_IDLE);
            _sequencer = new com.clubpenguin.world.rooms2012.common.sequencer.Sequencer(com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator.FRAME_BASED, _stage, 20);
            _questState = _SHELL.getCurrentRoomId();
            switch (_questState) {
                case QUEST_DAY : 
                    MC_SKY.gotoAndStop(SKY_DAY);
                    MC_CLOUDS.gotoAndStop(SKY_DAY);
                    MC_CARGO.gotoAndStop(NO_CARGO);
                    setupBeaconToTradingPostTrip();
                    _iceAnimation.init(5, 2);
                    break;
                case QUEST_SUNSET : 
                    MC_SKY.gotoAndStop(SKY_SUNSET);
                    MC_CLOUDS.gotoAndStop(SKY_SUNSET);
                    MC_BOW_WATER.gotoAndStop(BOW_WATER_IDLE_2);
                    MC_SIDE_WATER.gotoAndStop(SIDE_WATER_IDLE_2);
                    MC_OCEAN.gotoAndStop(OCEAN_IDLE_2);
                    if (_playerHasCompletedQuest) {
                        MC_CARGO.gotoAndStop(NO_CARGO);
                    } else {
                        MC_CARGO.gotoAndStop(BEACON_CARGO);
                    }
                    setupTradingPostToDinosaurIslandTrip();
                    _iceAnimation.init(5, 3, 2);
                    break;
                case QUEST_NIGHT : 
                    MC_SKY.gotoAndStop(SKY_NIGHT);
                    MC_CLOUDS.gotoAndStop(SKY_NIGHT);
                    MC_BOW_WATER.gotoAndStop(BOW_WATER_IDLE_3);
                    MC_SIDE_WATER.gotoAndStop(SIDE_WATER_IDLE_3);
                    MC_OCEAN.gotoAndStop(OCEAN_IDLE_3);
                    if (_playerHasCompletedQuest) {
                        MC_CARGO.gotoAndStop(NO_CARGO);
                    } else {
                        MC_CARGO.gotoAndStop(GEM_CARGO);
                    }
                    setupDinosaurIslandToVikingIslandTrip();
                    _iceAnimation.init(5, 5, 3);
                    break;
                case QUEST_DAWN : 
                    MC_SKY.gotoAndStop(SKY_DAWN);
                    MC_CLOUDS.gotoAndStop(SKY_DAWN);
                    MC_CARGO.gotoAndStop(NO_CARGO);
                    MC_BOW_WATER.gotoAndStop(BOW_WATER_IDLE_4);
                    MC_SIDE_WATER.gotoAndStop(SIDE_WATER_IDLE_4);
                    MC_OCEAN.gotoAndStop(OCEAN_IDLE_4);
                    setupVikingIslandToBeaconTrip();
                    _iceAnimation.init(5, 2);
                    break;
                default : 
                    MC_SKY.gotoAndStop(SKY_NIGHT);
                    MC_CLOUDS.gotoAndStop(SKY_NIGHT);
                    break;
            }
        }
        function onPlayerOverIceOnDeck(playerID, players) {
            var _local_2 = _SHELL.getPlayerObjectById(playerID);
            if ((((((_local_2.head == 403) || (_local_2.head == 10403)) || (_local_2.head == 429)) || (_local_2.head == 10429)) || (_local_2.head == 674)) || (_local_2.head == 1133)) {
                if ((_local_2.frame == 26) && (_SHELL.getSecretFrame(_local_2.player_id, _local_2.frame) != 26)) {
                    _iceOnDeck.remove();
                }
            }
            if (_local_2.hand == 5084) {
                if ((_local_2.frame == 26) && (_SHELL.getSecretFrame(_local_2.player_id, _local_2.frame) != 26)) {
                    _iceOnDeck.remove();
                }
            }
        }
        function onMapButtonClicked() {
            _INTERFACE.showContent("w.p.note.loading", null, _INTERFACE.getFilePath("w.p0212.rockhopperquest.map.url"));
        }
        function onIcebergSmashed() {
            _iceOnDeck.placeIceOnDeck();
        }
        function removeIceOnDeck() {
            _iceOnDeck.remove();
        }
        function exit() {
            if (_exitIsEnabled) {
                if (_playerHasCompletedQuest) {
                    joinRoom(_exitRoom.name);
                    return(undefined);
                }
                switch (_exitRoom) {
                    case ROOM_BEACH : 
                        _SHELL.sendJoinRoom(_exitRoom.name);
                        break;
                    case ROOM_TRADING_POST : 
                        _INTERFACE.showCutScene("w.p.note.loading", "w.p0212.rockhopperquest.note02.url", null, com.clubpenguin.util.Delegate.create(this, joinRoom, _exitRoom.name));
                        break;
                    case ROOM_DINOSAUR_ISLAND : 
                        _INTERFACE.showCutScene("w.p.note.loading", "w.p0212.rockhopperquest.note03.url", null, com.clubpenguin.util.Delegate.create(this, joinRoom, _exitRoom.name));
                        _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.rockhopperquest.OpcodeJournal.ROCKHOPPER_QUEST_DINOSAUR_ISLAND);
                        break;
                    case ROOM_VIKING_ISLAND : 
                        _INTERFACE.showCutScene("w.p.note.loading", "w.p0212.rockhopperquest.note04.url", null, com.clubpenguin.util.Delegate.create(this, joinRoom, _exitRoom.name));
                        _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.rockhopperquest.OpcodeJournal.ROCKHOPPER_QUEST_SHIPWRECK_ISLAND);
                        _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.rockhopperquest.OpcodeJournal.ROCKHOPPER_QUEST_LAST_ROCKHOPPER_MESSAGE);
                        break;
                }
            }
        }
        function joinRoom(roomName) {
            _SHELL.sendJoinRoom(roomName);
        }
        function setExitRoom(exitRoom) {
            MC_BLOCK_LAYER.gotoAndStop(BLOCK_LAYER_DOCKED);
            _exitRoom = exitRoom;
        }
        function enableSpeedBoost() {
            _speedBoostEnabled = true;
        }
        function disableSpeedBoost() {
            _speedBoostEnabled = false;
        }
        function enableExit() {
            MC_BLOCK_LAYER.gotoAndStop(BLOCK_LAYER_DOCKED);
            _exitIsEnabled = true;
        }
        function disableExit() {
            MC_BLOCK_LAYER.gotoAndStop(BLOCK_LAYER_AT_SEA);
            _exitIsEnabled = false;
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            if (TRIGGER_TRAPPED_PENGUIN.hitTest(_local_2.x, _local_2.y, false)) {
                _ENGINE.sendPlayerTeleportAndMove(450, 334);
            }
        }
        function setupBeaconToTradingPostTrip() {
            _exitRoom = ROOM_BEACH;
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "leavingTheIsland", 8);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_UP], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LIGHTHOUSE, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_IN, start:MC_LIGHTHOUSE._x, end:-580, velocity:120, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_IN, start:MC_LAND._x, end:-870, velocity:250, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_LOW], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableExit"));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "atSea");
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_LIGHTHOUSE, "gotoAndStop", [LIGHTHOUSE_OFF], 3.2));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_frontIceberg, "attack", null, 4));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "arrivingAtTradingPost", TIME_AT_SEA);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableSpeedBoost"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_frontIceberg, "reset"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_LAND, "gotoAndStop", [LAND_TRADING_POST]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_OUT, start:850, end:50, velocity:250, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_y", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_OUT, start:187, end:98, velocity:20, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_SLOW], 3));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "dropAnchor", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "setupExit", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "setExitRoom", [ROOM_TRADING_POST]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "enableExit"));
            _sequencer.endSequence();
            _sequencer.start();
        }
        function setupTradingPostToDinosaurIslandTrip() {
            _exitRoom = ROOM_TRADING_POST;
            MC_LAND.gotoAndStop(LAND_TRADING_POST);
            MC_LIGHTHOUSE.gotoAndStop(LIGHTHOUSE_OFF);
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "leavingTradingPost", 8);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_UP_2]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_UP_2], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.LINEAR_IN, start:MC_LAND._x, end:-870, velocity:250, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_LOW], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableExit"));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "atSea");
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_frontIceberg, "attack", null, 6));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "arrivingAtDinosaurIsland", TIME_AT_SEA);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableSpeedBoost"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_frontIceberg, "reset"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_LAND, "gotoAndStop", [LAND_DINOSAUR_ISLAND]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_OUT, start:850, end:40, velocity:250, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_y", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_OUT, start:187, end:98, velocity:20, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_DOWN_2]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_SLOW], 3));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "dropAnchor", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_DOWN_2]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "setupExit", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "setExitRoom", [ROOM_DINOSAUR_ISLAND]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "enableExit"));
            _sequencer.endSequence();
            _sequencer.start();
        }
        function setupDinosaurIslandToVikingIslandTrip() {
            _exitRoom = ROOM_DINOSAUR_ISLAND;
            MC_LAND.gotoAndStop(LAND_DINOSAUR_ISLAND);
            MC_LIGHTHOUSE.gotoAndStop(LIGHTHOUSE_OFF);
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "leavingDinosaurIsland", 8);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_UP_3]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_UP_3], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.LINEAR_IN, start:MC_LAND._x, end:-870, velocity:250, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_LOW], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableExit"));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "atSea");
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_frontIceberg, "attack", null, 4));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "arrivingAtVikingIsland", TIME_AT_SEA);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableSpeedBoost"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_frontIceberg, "reset"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_LAND, "gotoAndStop", [LAND_VIKING_ISLAND]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.CUBIC_OUT, start:850, end:80, velocity:250}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_DOWN_3]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_SLOW], 3));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "dropAnchor", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_DOWN_3]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "setupExit", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "setExitRoom", [ROOM_VIKING_ISLAND]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "enableExit"));
            _sequencer.endSequence();
            _sequencer.start();
        }
        function setupVikingIslandToBeaconTrip() {
            _exitRoom = ROOM_VIKING_ISLAND;
            MC_LAND.gotoAndStop(LAND_VIKING_ISLAND);
            MC_LIGHTHOUSE.gotoAndStop(LIGHTHOUSE_OFF);
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "leavingVikingIsland", 8);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_UP_4]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_UP]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_UP_4], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.LINEAR_IN, start:MC_LAND._x, end:-870, velocity:250, delay:3}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_LOW], 4));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableExit"));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "arrivingAtBeacon", TIME_AT_SEA);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "disableSpeedBoost"));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_LIGHTHOUSE, "gotoAndStop", [LIGHTHOUSE_IDLE]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_LAND, "gotoAndStop", [LAND_BEACON]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BOW_WATER, "gotoAndStop", [BOW_WATER_DOWN_4]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LIGHTHOUSE, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.LINEAR_IN, start:500, end:-350, velocity:282}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem({target:MC_LAND, prop:"_x", ease:com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.LINEAR_IN, start:900, end:50, velocity:280}));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(_iceAnimation, "setSpeed", [ICE_SPEED_SLOW], 3));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "dropAnchor", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_ANCHOR, "gotoAndStop", [ANCHOR_DOWN_4]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_FRONT, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(MC_BRIDGE_ROPE_BACK, "gotoAndStop", [BRIDGE_DOWN]));
            _sequencer.endSequence();
            _sequencer.beginSequence(com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL, "setupExit", 2);
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "setExitRoom", [ROOM_BEACH]));
            _sequencer.addItem(new com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall(this, "enableExit"));
            _sequencer.endSequence();
            _sequencer.start();
        }
        function onTargetHit() {
            _targetsHit++;
            if (_targetsHit >= TARGET_CHAMP_HITS_REQUIRED) {
                _targetsHit = 0;
                _SHELL.stampEarned(TARGET_CHAMP_STAMP_ID);
            }
        }
        function onSpeedBoosterActivated() {
            if (_exitIsEnabled || (!_speedBoostEnabled)) {
                return(undefined);
            }
            var _local_2 = numberOfBoostersOn();
            if (_local_2 >= 3) {
                MC_FLAG_BIG.gotoAndStop(FLAG_ON);
                MC_FLAG_SMALL.gotoAndStop(FLAG_ON);
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.rockhopperquest.OpcodeJournal.ROCKHOPPER_QUEST_ALL_SHIP_TRIGGERS);
            }
            _lastBoosterLevel = _local_2;
            _iceAnimation.setSpeed(50 * (_local_2 + 1));
        }
        function onSpeedBoosterDeactivated() {
            var _local_2 = numberOfBoostersOn();
            if (_local_2 < 3) {
                if (_lastBoosterLevel == 3) {
                    MC_FLAG_BIG.gotoAndStop(FLAG_OFF);
                    MC_FLAG_SMALL.gotoAndStop(FLAG_OFF);
                }
            }
            _lastBoosterLevel = _local_2;
            if ((!_exitIsEnabled) && (_speedBoostEnabled)) {
                _iceAnimation.setSpeed(50 * (_local_2 + 1));
            }
        }
        function numberOfBoostersOn() {
            var _local_2 = 0;
            if (_fan.isOn()) {
                _local_2++;
            }
            if (_frontRocket.isOn()) {
                _local_2++;
            }
            if (_backRocket.isOn()) {
                _local_2++;
            }
            return(_local_2);
        }
        function handleThrow(ball) {
            if (_fan.checkIfHitBySnowball(ball)) {
                ball._visible = false;
                onTargetHit();
                return(undefined);
            }
            if (_frontRocket.checkIfHitBySnowball(ball)) {
                ball._visible = false;
                onTargetHit();
                return(undefined);
            }
            if (_backRocket.checkIfHitBySnowball(ball)) {
                ball._visible = false;
                onTargetHit();
                return(undefined);
            }
            if (_frontJackhammer.checkIfHitBySnowball(ball)) {
                ball._visible = false;
                onTargetHit();
                return(undefined);
            }
            if (_backJackhammer.checkIfHitBySnowball(ball)) {
                ball._visible = false;
                onTargetHit();
                return(undefined);
            }
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _sequencer.clear();
            _shipTriggers.destroy();
            _stage.onEnterFrame = null;
            delete _stage.onEnterFrame;
        }
        static var TARGET_CHAMP_HITS_REQUIRED = 50;
        static var TARGET_CHAMP_STAMP_ID = 185;
        static var OUT_AT_SEA_STAMP_ID = 292;
        static var BEACON_PIN_ID = "7101";
        static var QUEST_DAY = "851";
        static var QUEST_SUNSET = "853";
        static var QUEST_NIGHT = "855";
        static var QUEST_DAWN = "858";
        static var ROOM_TRADING_POST = {name:"party2", id:852, x:625, y:275};
        static var ROOM_DINOSAUR_ISLAND = {name:"party4", id:854, x:625, y:275};
        static var ROOM_VIKING_ISLAND = {name:"party6", id:856, x:625, y:275};
        static var ROOM_VIKING_CAVE = {name:"party7", id:857, x:625, y:275};
        static var ROOM_BEACH = {name:"beach", id:400, x:625, y:275};
        static var SKY_DAY = "day";
        static var SKY_SUNSET = "sunset";
        static var SKY_NIGHT = "night";
        static var SKY_DAWN = "dawn";
        static var LAND_BEACON = "beacon";
        static var LAND_TRADING_POST = "tradingPost";
        static var LAND_DINOSAUR_ISLAND = "dinosaurIsland";
        static var LAND_VIKING_ISLAND = "vikingIsland";
        static var LIGHTHOUSE_OFF = "off";
        static var LIGHTHOUSE_IDLE = "park";
        static var FLAG_IDLE = "park";
        static var FLAG_ON = "flagUp";
        static var FLAG_RUNNING = "rotate";
        static var FLAG_OFF = "flagDown";
        static var ANCHOR_IDLE = "park";
        static var ANCHOR_UP = "up";
        static var ANCHOR_DOWN = "down";
        static var ANCHOR_UP_2 = "up2";
        static var ANCHOR_DOWN_2 = "down2";
        static var ANCHOR_UP_3 = "up3";
        static var ANCHOR_DOWN_3 = "down3";
        static var ANCHOR_UP_4 = "up4";
        static var ANCHOR_DOWN_4 = "down4";
        static var OCEAN_IDLE = "park";
        static var OCEAN_IDLE_2 = "park2";
        static var OCEAN_IDLE_3 = "park3";
        static var OCEAN_IDLE_4 = "park4";
        static var BOW_WATER_IDLE = "park";
        static var BOW_WATER_UP = "up";
        static var BOW_WATER_DOWN = "down";
        static var BOW_WATER_IDLE_2 = "park2";
        static var BOW_WATER_UP_2 = "up2";
        static var BOW_WATER_DOWN_2 = "down2";
        static var BOW_WATER_IDLE_3 = "park3";
        static var BOW_WATER_UP_3 = "up3";
        static var BOW_WATER_DOWN_3 = "down3";
        static var BOW_WATER_IDLE_4 = "park4";
        static var BOW_WATER_UP_4 = "up4";
        static var BOW_WATER_DOWN_4 = "down4";
        static var SIDE_WATER_IDLE = "park";
        static var SIDE_WATER_UP = "up";
        static var SIDE_WATER_DOWN = "park";
        static var SIDE_WATER_IDLE_2 = "park2";
        static var SIDE_WATER_UP_2 = "up2";
        static var SIDE_WATER_DOWN_2 = "park2";
        static var SIDE_WATER_IDLE_3 = "park3";
        static var SIDE_WATER_UP_3 = "up3";
        static var SIDE_WATER_DOWN_3 = "park3";
        static var SIDE_WATER_IDLE_4 = "park4";
        static var SIDE_WATER_UP_4 = "up4";
        static var SIDE_WATER_DOWN_4 = "park4";
        static var BRIDGE_IDLE = "park";
        static var BRIDGE_UP = "rollUp";
        static var BRIDGE_DOWN = "rollDown";
        static var BRIDGE_SAIL = "sail";
        static var NO_CARGO = "park";
        static var BEACON_CARGO = "beaconCargo";
        static var GEM_CARGO = "gemCargo";
        static var TIME_AT_SEA = 60;
        static var ICE_SPEED_SLOW = 5;
        static var ICE_SPEED_LOW = 50;
        static var BLOCK_LAYER_DOCKED = "docked";
        static var BLOCK_LAYER_AT_SEA = "atsea";
        static var MAP_HIDDEN = "park";
        static var MAP_SHOWN = "map";
        var CLASS_NAME = "Migrator";
        var _stateLookup = {};
        var _lastBoosterLevel = 0;
        var _exitIsEnabled = true;
        var _targetsHit = 0;
        var _speedBoostEnabled = true;
    }
