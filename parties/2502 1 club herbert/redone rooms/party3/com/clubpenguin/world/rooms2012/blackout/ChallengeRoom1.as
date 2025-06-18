//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.ChallengeRoom1 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, TELEPORT_POINT_LEFT, TELEPORT_POINT_RIGHT, setupNavigationButtons, localize, _triggerWatcherInterval, _ENGINE, _INTERFACE, roomTracker;
        function ChallengeRoom1 (stageReference) {
            super(stageReference);
            _stage.start_x = 160;
            _stage.start_y = 370;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.BUY_INVENTORY, onInventoryBought);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.paradise_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 282, 82);
            _stage.triggers_mc.exit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 170, 90);
            _stage.triggers_mc.doorOpenLeftTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openDoorOne);
            _stage.triggers_mc.doorOpenRightTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openDoorTwo);
            _stage.triggers_mc.gameTriggerLeft_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchLevelOne);
            _stage.triggers_mc.gameTriggerRight_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchLevelTwo);
            TELEPORT_POINT_LEFT = new flash.geom.Point(300, 265);
            TELEPORT_POINT_RIGHT = new flash.geom.Point(490, 265);
            _stage.triggers_mc.passingTransitionLeft_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_RIGHT, 20);
            _stage.triggers_mc.passingTransitionRight_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_LEFT, -20);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.wall_mc.doorLight_mc.door_btn, 255, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.vent_mc.vent_btn, 80, 370), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.doorLight_mc.door_btn, 666, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gameLeft_mc.game_btn, 140, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gameRight_mc.game_btn, 585, 220)]);
            localize([_stage.sign_mc.text_mc]);
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            if (_local_2.x >= 390) {
                setRoom(2, true);
            } else {
                setRoom(1, true);
            }
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function launchLevelOne() {
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.blackout.Blackout.HACKING_MINIGAME, true, {currentLevel:1, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2012.blackout.Blackout, com.clubpenguin.world.rooms2012.blackout.Blackout.challengeCompleted, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1_PIN_ID, null, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1)});
        }
        function launchLevelTwo() {
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.blackout.Blackout.HACKING_MINIGAME, true, {currentLevel:2, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2012.blackout.Blackout, com.clubpenguin.world.rooms2012.blackout.Blackout.challengeCompleted, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_2_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_2)});
        }
        function onInventoryBought(event) {
            if (event.success) {
                setRoomState();
            }
        }
        function openDoorOne() {
            if (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.GRAPPLING_HOOK_ITEM_ID) || (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_2))) {
                _stage.foreground_mc.switch_mc.gotoAndStop(2);
                _stage.door1_mc.anim_mc.play();
                _stage.wall_mc.doorLight_mc.gotoAndStop(3);
                _stage.block_mc.gotoAndStop(2);
                _stage.triggers_mc.gotoAndStop(2);
            } else {
                _INTERFACE.showContent("w.app.generic.partyinterface");
            }
        }
        function openDoorTwo() {
            if (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.PLASMA_LASER_ITEM_ID) || (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3))) {
                _stage.foreground_mc.laser_mc.play();
                _stage.door_mc.anim_mc.play();
                _stage.foreground_mc.doorLight_mc.gotoAndStop(3);
                _stage.block_mc.gotoAndStop(3);
                _stage.triggers_mc.gotoAndStop(3);
                _stage.foreground_mc.doorLight_mc.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, walkToDoor);
            } else {
                _INTERFACE.showContent("w.app.generic.partyinterface");
            }
        }
        function setRoomState(firstSet) {
            if (firstSet) {
                _stage.gameRight_mc.gotoAndStop(2);
            }
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3)) {
                if (firstSet) {
                    _stage.gameLeft_mc.gotoAndStop(3);
                    _stage.gameRight_mc.gotoAndStop(3);
                }
                _stage.triggers_mc.gotoAndStop(3);
                _stage.block_mc.gotoAndStop(3);
                _stage.wall_mc.doorLight_mc.gotoAndStop(3);
                _stage.foreground_mc.doorLight_mc.gotoAndStop(3);
                _stage.door1_mc.anim_mc.gotoAndStop(28);
                _stage.door_mc.anim_mc.gotoAndStop(27);
                _stage.foreground_mc.doorLight_mc.door_btn.onRelease = com.clubpenguin.util.Delegate.create(this, walkToDoor);
                _stage.foreground_mc.switch_mc.gotoAndStop(3);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_2)) {
                if (firstSet) {
                    _stage.gameLeft_mc.gotoAndStop(3);
                    _stage.gameRight_mc.gotoAndStop(3);
                }
                _stage.triggers_mc.gotoAndStop(2);
                _stage.block_mc.gotoAndStop(2);
                _stage.wall_mc.doorLight_mc.gotoAndStop(3);
                _stage.foreground_mc.doorLight_mc.gotoAndStop(2);
                _stage.door1_mc.anim_mc.gotoAndStop(28);
                _stage.foreground_mc.switch_mc.gotoAndStop(3);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1)) {
                if (firstSet) {
                    _stage.gameLeft_mc.gotoAndStop(3);
                }
                _stage.wall_mc.doorLight_mc.gotoAndStop(2);
            }
            var _local_3 = false;
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeJustCompleted(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_1) && (firstSet)) {
                _stage.gameLeft_mc.gotoAndStop(3);
                _local_3 = true;
            }
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeJustCompleted(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_2) && (firstSet)) {
                _stage.gameRight_mc.gotoAndStop(3);
                _local_3 = true;
            }
            if (_local_3) {
                var _local_4 = new Sound(_stage);
                _local_4.attachSound("monitor_off");
                _local_4.start();
            }
        }
        function teleport(XY, walkOffsetX) {
            if (roomTracker == 2) {
                setRoom(1);
            } else if (roomTracker == 1) {
                setRoom(2);
            }
            if (XY == TELEPORT_POINT_LEFT) {
                setRoom(1);
            } else if (XY == TELEPORT_POINT_RIGHT) {
                setRoom(2);
            }
            var _local_3 = 0;
            _ENGINE.sendPlayerTeleportAndMove(XY.x, XY.y, XY.x + walkOffsetX, XY.y + _local_3);
        }
        function setRoom(roomNum, firstSet) {
            if (firstSet == undefined) {
                firstSet = false;
            }
            switch (roomNum) {
                case 1 : 
                    roomTracker = 1;
                    _stage.foreground_mc.states_mc.gotoAndStop(1);
                    _stage.wall_mc.doorLight_mc.gotoAndStop(2);
                    if (firstSet) {
                        _stage.gameLeft_mc.gotoAndStop(2);
                        _stage.gameRight_mc.gotoAndStop(1);
                    }
                    _stage.vent_mc.gotoAndStop(2);
                    _stage.door_mc.doorLight_mc.gotoAndStop(1);
                    break;
                case 2 : 
                    roomTracker = 2;
                    _stage.foreground_mc.states_mc.gotoAndStop(2);
                    _stage.foreground_mc.doorLight_mc.gotoAndStop(2);
                    _stage.wall_mc.doorLight_mc.gotoAndStop(1);
                    if (firstSet) {
                        _stage.gameLeft_mc.gotoAndStop(1);
                        _stage.gameRight_mc.gotoAndStop(2);
                    }
                    _stage.vent_mc.gotoAndStop(1);
                    break;
            }
            setRoomState(firstSet);
        }
        function walkToDoor() {
            _ENGINE.sendPlayerMove(753, 265);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BUY_INVENTORY, onInventoryBought);
        }
        static var CLASS_NAME = "ChallengeRoom1";
    }
