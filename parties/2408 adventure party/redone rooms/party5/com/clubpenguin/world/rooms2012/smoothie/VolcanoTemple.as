//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.VolcanoTemple extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _hasWatermelonTriggered, _destroyDelegate, _SHELL, _triggerWatcher, _veggie1Trigger, _veggie2Trigger, _veggie3Trigger, _switch12Trigger, _switch21Trigger, _switch23Trigger, _switch32Trigger, _switch34Trigger, _switch43Trigger, _seed1Trigger, _seed2Trigger, _seed3Trigger, _seed4Trigger, _seed5Trigger, _seed6Trigger, _watermelonTrigger, _triggerWatcherInterval;
        function VolcanoTemple (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 95;
            _stage.start_y = 100;
            _stage.isSmallPenguin = true;
            _hasWatermelonTriggered = false;
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _veggie1Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.veggie1_mc);
            _veggie1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateCage, 1));
            _triggerWatcher.addTrigger(_veggie1Trigger);
            _veggie2Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.veggie2_mc);
            _veggie2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateCage, 2));
            _triggerWatcher.addTrigger(_veggie2Trigger);
            _veggie3Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.veggie3_mc);
            _veggie3Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateCage, 3));
            _triggerWatcher.addTrigger(_veggie3Trigger);
            _switch12Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.room_1_trigger);
            _switch12Trigger.isLocalPlayerOnly();
            _switch12Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, changeRoom1));
            _triggerWatcher.addTrigger(_switch12Trigger);
            _switch21Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.room_2_trigger_A);
            _switch21Trigger.isLocalPlayerOnly();
            _switch21Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, changeRoom2));
            _triggerWatcher.addTrigger(_switch21Trigger);
            _switch23Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.room_2_trigger_B);
            _switch23Trigger.isLocalPlayerOnly();
            _switch23Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, changeRoom2));
            _triggerWatcher.addTrigger(_switch23Trigger);
            _switch32Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.room_3_trigger_A);
            _switch32Trigger.isLocalPlayerOnly();
            _switch32Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, changeRoom3a));
            _triggerWatcher.addTrigger(_switch32Trigger);
            _switch34Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.switch34_mc);
            _switch34Trigger.isLocalPlayerOnly();
            _switch34Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, changeRoom3b));
            _triggerWatcher.addTrigger(_switch34Trigger);
            _switch43Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.switch43_mc);
            _switch43Trigger.isLocalPlayerOnly();
            _switch43Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, changeRoom4));
            _triggerWatcher.addTrigger(_switch43Trigger);
            _seed1Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.seed1_mc);
            _seed1Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, activateSeed1));
            _triggerWatcher.addTrigger(_seed1Trigger);
            _seed2Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.seed2_mc);
            _seed2Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, activateSeed2));
            _triggerWatcher.addTrigger(_seed2Trigger);
            _seed3Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.seed3_mc);
            _seed3Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, activateSeed3));
            _triggerWatcher.addTrigger(_seed3Trigger);
            _seed4Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.seed4_mc);
            _seed4Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, activateSeed4));
            _triggerWatcher.addTrigger(_seed4Trigger);
            _seed5Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.seed5_mc);
            _seed5Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, activateSeed5));
            _triggerWatcher.addTrigger(_seed5Trigger);
            _seed6Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.seed6_mc);
            _seed6Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, activateSeed6));
            _triggerWatcher.addTrigger(_seed6Trigger);
            _watermelonTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.watermelon_mc);
            _watermelonTrigger.isLocalPlayerOnly();
            _watermelonTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, activateWatermelon));
            _triggerWatcher.addTrigger(_watermelonTrigger);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 385, 325);
            _stage.triggers_mc.treasureRoom_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party3", 200, 400);
            setRoom(1);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function changeRoom1() {
            setRoom(1);
        }
        function changeRoom2() {
            setRoom(2);
        }
        function changeRoom3a() {
            setRoom(3);
        }
        function changeRoom3b() {
            setRoom(3);
            turnOnAllTargetLights();
        }
        function changeRoom4() {
            setRoom(4);
            _stage.foreground_mc.roomShadows_mc.gotoAndStop(2);
        }
        function setRoom(roomNum) {
            trace("set room " + roomNum);
            switch (roomNum) {
                case 1 : 
                    _stage.foreground_mc.gotoAndStop("room1");
                    _stage.cageFront_mc.gotoAndStop(1);
                    _stage.room2_mc.gotoAndStop(1);
                    break;
                case 2 : 
                    _stage.foreground_mc.gotoAndStop(2);
                    _stage.cageFront_mc.gotoAndStop(2);
                    _stage.room2_mc.gotoAndStop(2);
                    break;
                case 3 : 
                    _stage.foreground_mc.gotoAndStop("room3");
                    _stage.cageFront_mc.gotoAndStop(1);
                    _stage.room2_mc.gotoAndStop(1);
                    _stage.room4_mc.gotoAndStop(1);
                    _stage.torch1_mc.gotoAndStop(2);
                    _stage.watermelon_mc.gotoAndStop(1);
                    break;
                case 4 : 
                    _stage.foreground_mc.gotoAndStop("room4");
                    _stage.room4_mc.gotoAndStop(2);
                    _stage.watermelon_mc.gotoAndStop(1);
                    break;
            }
        }
        function activateCage(floorBtn) {
            if (_stage.cageFront_mc.cage_mc._currentframe == 1) {
                _stage.cageFront_mc.cage_mc.play();
                _stage.room2_mc.cage_mc.play();
                _stage.block_mc.play();
                switch (floorBtn) {
                    case 1 : 
                        _stage.background_mc.veggie1_mc.play();
                        break;
                    case 2 : 
                        _stage.background_mc.veggie2_mc.play();
                        break;
                    case 3 : 
                        _stage.background_mc.veggie3_mc.play();
                        break;
                }
            }
        }
        function activateSeed1() {
            if (_stage.foreground_mc.seeds_mc.seed1_mc._currentframe == 1) {
                _stage.foreground_mc.seeds_mc.seed1_mc.play();
            }
        }
        function activateSeed2() {
            if (_stage.foreground_mc.seeds_mc.seed2_mc._currentframe == 1) {
                _stage.foreground_mc.seeds_mc.seed2_mc.play();
            }
        }
        function activateSeed3() {
            if (_stage.foreground_mc.seeds_mc.seed3_mc._currentframe == 1) {
                _stage.foreground_mc.seeds_mc.seed3_mc.play();
            }
        }
        function activateSeed4() {
            if (_stage.foreground_mc.seeds_mc.seed4_mc._currentframe == 1) {
                _stage.foreground_mc.seeds_mc.seed4_mc.play();
            }
        }
        function activateSeed5() {
            if (_stage.foreground_mc.seeds_mc.seed5_mc._currentframe == 1) {
                _stage.foreground_mc.seeds_mc.seed5_mc.play();
            }
        }
        function activateSeed6() {
            if (_stage.foreground_mc.seeds_mc.seed6_mc._currentframe == 1) {
                _stage.foreground_mc.seeds_mc.seed6_mc.play();
            }
        }
        function activateWatermelon() {
            if (_hasWatermelonTriggered) {
                _stage.foreground_mc.roomShadowsWatermelon_mc.gotoAndStop(21);
                return(undefined);
            }
            _hasWatermelonTriggered = true;
            if (_stage.watermelon_mc._currentframe == 1) {
                trace(_stage.watermelon_mc._currentframe);
                _stage.watermelon_mc.gotoAndPlay(2);
                _stage.foreground_mc.roomShadowsWatermelon_mc.gotoAndPlay(2);
                _stage.background_mc.floorPanel_mc.play();
            }
        }
        function handleThrow(mc) {
            if (_stage.triggers_mc.target1_mc.hitTest(mc._x, mc._y, true)) {
                if (_stage.target1_mc._currentframe == 1) {
                    _stage.target1_mc.play();
                    if (_stage.foreground_mc.roomShadows_mc._currentframe == 1) {
                        _stage.foreground_mc.roomShadows_mc.gotoAndStop(2);
                        _stage.torch2_mc.gotoAndStop(2);
                    }
                }
                mc._visible = false;
                return(undefined);
            }
            if (_stage.triggers_mc.target2_mc.hitTest(mc._x, mc._y, true)) {
                if (_stage.target2_mc._currentframe == 1) {
                    _stage.target2_mc.play();
                    if (_stage.foreground_mc.roomShadows_mc._currentframe == 2) {
                        _stage.foreground_mc.roomShadows_mc.gotoAndStop(3);
                        _stage.torch1_mc.gotoAndStop(1);
                        _stage.torch3_mc.gotoAndStop(2);
                        _stage.torch4_mc.gotoAndStop(2);
                    }
                }
                mc._visible = false;
                return(undefined);
            }
            if (_stage.triggers_mc.target3_mc.hitTest(mc._x, mc._y, true)) {
                if (_stage.target3_mc._currentframe == 1) {
                    _stage.target3_mc.play();
                    if (_stage.foreground_mc.roomShadows_mc._currentframe == 3) {
                        _stage.foreground_mc.roomShadows_mc.gotoAndStop(4);
                        _stage.torch2_mc.gotoAndStop(1);
                        _stage.background_mc.torch5_mc.gotoAndStop(2);
                    }
                }
                mc._visible = false;
                return(undefined);
            }
            if (_stage.triggers_mc.target4_mc.hitTest(mc._x, mc._y, true)) {
                if (_stage.target4_mc._currentframe == 1) {
                    _stage.target4_mc.play();
                    if (_stage.foreground_mc.roomShadows_mc._currentframe == 4) {
                        _stage.foreground_mc.roomShadows_mc.gotoAndStop(5);
                        _stage.torch3_mc.gotoAndStop(1);
                        _stage.torch4_mc.gotoAndStop(1);
                        _stage.torch6_mc.gotoAndStop(2);
                    }
                }
                mc._visible = false;
                return(undefined);
            }
            if (_stage.triggers_mc.target5_mc.hitTest(mc._x, mc._y, true)) {
                if (_stage.target5_mc._currentframe == 1) {
                    _stage.target5_mc.play();
                    if (_stage.foreground_mc.roomShadows_mc._currentframe == 5) {
                        _stage.foreground_mc.roomShadows_mc.gotoAndStop(6);
                        _stage.background_mc.torch5_mc.gotoAndStop(1);
                        _stage.background_mc.torch7_mc.gotoAndStop(2);
                    }
                }
                mc._visible = false;
                return(undefined);
            }
            if (_stage.triggers_mc.target6_mc.hitTest(mc._x, mc._y, true)) {
                if (_stage.target6_mc._currentframe == 1) {
                    _stage.target6_mc.play();
                    if (_stage.foreground_mc.roomShadows_mc._currentframe == 6) {
                        turnOnAllTargetLights();
                    }
                }
                mc._visible = false;
                return(undefined);
            }
        }
        function turnOnAllTargetLights() {
            _stage.foreground_mc.roomShadows_mc.gotoAndStop(7);
            _stage.torch1_mc.gotoAndStop(2);
            _stage.torch2_mc.gotoAndStop(2);
            _stage.torch3_mc.gotoAndStop(2);
            _stage.torch4_mc.gotoAndStop(2);
            _stage.background_mc.torch5_mc.gotoAndStop(2);
            _stage.torch6_mc.gotoAndStop(2);
            _stage.background_mc.torch7_mc.gotoAndStop(2);
            _stage.foreground_mc.torch8_mc.gotoAndStop(2);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "VolcanoTemple";
    }
