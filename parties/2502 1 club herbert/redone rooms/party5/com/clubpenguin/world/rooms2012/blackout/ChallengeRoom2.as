//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.blackout.ChallengeRoom2 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, TELEPORT_POINT_LEFT, TELEPORT_POINT_RIGHT, TELEPORT_POINT_UP, TELEPORT_POINT_DOWN, setupNavigationButtons, _ENGINE, _INTERFACE;
        function ChallengeRoom2 (stageReference) {
            super(stageReference);
            _stage.start_x = 95;
            _stage.start_y = 160;
            _stage.customPenguinSize = 90;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.addListener(_SHELL.BUY_INVENTORY, onInventoryBought);
            _stage.triggers_mc.hq_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 675, 280);
            _stage.triggers_mc.vault_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 650, 335);
            _stage.triggers_mc.openDoorOneTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openDoorOne);
            _stage.triggers_mc.openDoorTwoTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openDoorTwo);
            _stage.triggers_mc.gameTriggerA_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchLevelThree);
            _stage.triggers_mc.gameTriggerB_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchLevelFour);
            _stage.triggers_mc.gameTriggerC_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchLevelFive);
            TELEPORT_POINT_LEFT = new flash.geom.Point(325, 150);
            TELEPORT_POINT_RIGHT = new flash.geom.Point(440, 150);
            TELEPORT_POINT_UP = new flash.geom.Point(600, 210);
            TELEPORT_POINT_DOWN = new flash.geom.Point(600, 260);
            _stage.triggers_mc.passingTransitionLeft_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, useDoorOne);
            _stage.triggers_mc.passingTransitionRight_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_LEFT, -25, 0);
            _stage.triggers_mc.passingTransitionDown_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, teleport, TELEPORT_POINT_UP, 0, -65);
            _stage.triggers_mc.passingTransitionUp_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, useDoorTwo);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.upWall_mc.vent_btn, 10, 135), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.downWall_mc.vent_btn, 50, 350), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.challege3_btn, 260, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.doorLightB_mc.door_btn, 600, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gameThree_mc.game_btn, 175, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gameFour_mc.game_btn, 540, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gameFive_mc.game_btn, 380, 375)]);
            initRoom();
            setRoomState();
        }
        function initRoom() {
            var _local_2 = _SHELL.getMyPlayerObject();
            if (_local_2.y < 240) {
                if (_local_2.x < 380) {
                    setRoom(1);
                } else {
                    setRoom(2);
                }
            } else {
                setRoom(3);
            }
            _local_2 = null;
        }
        function setRoomState() {
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)) {
                doorOneIsOpen();
                doorToChallenge4IsOpen = true;
                doorTwoIsGreen();
                doorToChallenge5IsOpen = true;
                _stage.block_mc.gotoAndStop(3);
                _stage.triggers_mc.gotoAndStop(3);
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4)) {
                doorOneIsOpen();
                doorToChallenge4IsOpen = true;
                _stage.block_mc.gotoAndStop(2);
                _stage.triggers_mc.gotoAndStop(2);
            }
            updateGames();
        }
        function updateGames() {
            if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)) {
                if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeJustCompleted(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)) {
                    _stage.gameFive_mc.gotoAndStop(4);
                    _stage.gameFour_mc.gotoAndStop(4);
                    _stage.gameThree_mc.gotoAndStop(4);
                } else {
                    _stage.gameFive_mc.gotoAndStop(5);
                    _stage.gameFour_mc.gotoAndStop(5);
                    _stage.gameThree_mc.gotoAndStop(5);
                }
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4)) {
                if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeJustCompleted(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4)) {
                    _stage.gameFour_mc.gotoAndStop(4);
                    _stage.gameThree_mc.gotoAndStop(4);
                } else {
                    _stage.gameFour_mc.gotoAndStop(5);
                    _stage.gameThree_mc.gotoAndStop(5);
                }
            } else if (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3)) {
                if (com.clubpenguin.world.rooms2012.blackout.Blackout.isChallengeJustCompleted(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3)) {
                    _stage.gameThree_mc.gotoAndStop(4);
                } else {
                    _stage.gameThree_mc.gotoAndStop(5);
                }
            }
        }
        function launchLevelThree() {
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.blackout.Blackout.HACKING_MINIGAME, true, {currentLevel:3, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2012.blackout.Blackout, com.clubpenguin.world.rooms2012.blackout.Blackout.challengeCompleted, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_2_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3)});
        }
        function launchLevelFour() {
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.blackout.Blackout.HACKING_MINIGAME, true, {currentLevel:4, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2012.blackout.Blackout, com.clubpenguin.world.rooms2012.blackout.Blackout.challengeCompleted, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_3_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4)});
        }
        function launchLevelFive() {
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.blackout.Blackout.HACKING_MINIGAME, true, {currentLevel:5, onGameCompleteCB:com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2012.blackout.Blackout, com.clubpenguin.world.rooms2012.blackout.Blackout.challengeCompleted, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_4_PIN_ID, com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5)});
        }
        function doorOneIsOpen() {
            _stage.wallA_mc.doorLeft_mc.gotoAndStop(3);
            _stage.door1_mc.gotoAndStop(3);
            _stage.foreground_mc.doorLightA_mc.gotoAndStop(4);
        }
        function doorOneIsGreen() {
            _stage.wallA_mc.doorLeft_mc.gotoAndStop(2);
            _stage.door1_mc.gotoAndStop(2);
            _stage.foreground_mc.doorLightA_mc.gotoAndStop(4);
        }
        function doorTwoIsGreen() {
            _stage.foreground_mc.doorLightB_mc.gotoAndStop(4);
        }
        function openDoorOne() {
            if (!doorToChallenge4IsOpen) {
                if (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.LASER_DEFLECTOR_ITEM_ID)) {
                    doorOneIsGreen();
                    _stage.block_mc.gotoAndStop(2);
                    _stage.triggers_mc.gotoAndStop(2);
                    doorToChallenge4IsOpen = true;
                } else {
                    _INTERFACE.showContent("w.app.generic.partyinterface");
                }
            }
        }
        function openDoorTwo() {
            if (!doorToChallenge5IsOpen) {
                if (_INTERFACE.isItemOnPlayer(com.clubpenguin.world.rooms2012.blackout.Blackout.SMOKE_GOGGLES_ITEM_ID) || (com.clubpenguin.world.rooms2012.blackout.Blackout.playerHasCompletedChallege(com.clubpenguin.world.rooms2012.blackout.Blackout.CHALLENGE_5))) {
                    doorTwoIsGreen();
                    _stage.wallB_mc.doorC_mc.gotoAndStop(2);
                    _stage.block_mc.gotoAndStop(3);
                    _stage.triggers_mc.gotoAndStop(3);
                    doorToChallenge5IsOpen = true;
                } else {
                    _INTERFACE.showContent("w.app.generic.partyinterface");
                }
            }
        }
        function useDoorOne() {
            doorOneIsOpen();
            teleport(TELEPORT_POINT_RIGHT, 25, 0);
        }
        function useDoorTwo() {
            teleport(TELEPORT_POINT_DOWN, 0, 100);
        }
        function teleport(XY, walkOffsetX, walkOffsetY) {
            if (XY == TELEPORT_POINT_LEFT) {
                setRoom(1);
            } else if ((XY == TELEPORT_POINT_RIGHT) || (XY == TELEPORT_POINT_UP)) {
                setRoom(2);
            } else if (XY == TELEPORT_POINT_DOWN) {
                setRoom(3);
            }
            _ENGINE.sendPlayerTeleportAndMove(XY.x, XY.y, XY.x + walkOffsetX, XY.y + walkOffsetY);
        }
        function setRoom(roomNum) {
            _stage.foreground_mc.states_mc.gotoAndStop(roomNum);
            _stage.foreground_mc.states_mc.gotoAndStop(roomNum);
            _stage.upWall_mc.gotoAndStop(roomNum);
            _stage.downWall_mc.gotoAndStop(roomNum);
            _stage.gameThree_mc.gotoAndStop(roomNum);
            _stage.gameFour_mc.gotoAndStop(roomNum);
            _stage.gameFive_mc.gotoAndStop(roomNum);
            updateGames();
            if (!doorToChallenge4IsOpen) {
                _stage.foreground_mc.doorLightA_mc.gotoAndStop(roomNum);
                _stage.challege3_btn.enabled = true;
            }
            if (doorToChallenge5IsOpen || (roomNum == 3)) {
                _stage.foreground_mc.doorLightB_mc.gotoAndStop(3);
                _stage.wallB_mc.doorC_mc.gotoAndStop(2);
            } else {
                _stage.foreground_mc.doorLightB_mc.gotoAndStop(roomNum);
                _stage.wallB_mc.doorC_mc.gotoAndStop(1);
            }
        }
        function onInventoryBought(event) {
            if (event.success) {
                setRoomState();
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BUY_INVENTORY, onInventoryBought);
        }
        static var CLASS_NAME = "ChallengeRoom2";
        var doorToChallenge4IsOpen = false;
        var doorToChallenge5IsOpen = false;
    }
