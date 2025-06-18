//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.october.Beach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _currentParty, _questTaskVO, localize, setupNavigationButtons, _ENGINE, _INTERFACE;
        function Beach (stageReference) {
            super(stageReference);
            _stage.start_x = 475;
            _stage.start_y = 290;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _questTaskVO = _currentParty.getQuestVOByIndex(QUEST_TASK_ID);
            if (_currentParty.CONSTANTS.PARTY_DAY >= _questTaskVO.unlockDay) {
                robotVisible = true;
            }
            if (_currentParty.partyCookie.hasPlayerCompletedTask(QUEST_TASK_ID)) {
                robotDefeated = true;
            }
            if (_currentParty.collectedItem == _currentParty.CONSTANTS.BEARD_TRIMMER) {
                playerHasScareItem = true;
            }
            _penguinIsMember = _global.getCurrentShell().isMyPlayerMember();
            localize([_stage.livingSled, _stage.roboMaker, _stage.garage1, _stage.garage2, _stage.garageSignRobot, _stage.garageSignPenguin, _stage.tombstones3]);
            if (robotVisible == true) {
                _stage.robotStage_mc.gotoAndStop("on");
                _stage.background_mc.shadow_mc.gotoAndStop(2);
            } else {
                _stage.robotDirector.gotoAndStop(1);
            }
            if (robotDefeated == true) {
                _stage.robotStage_mc.robot_mc.robotStates_mc.gotoAndStop("defeated");
                _stage.robotDirector.gotoAndStop(1);
            }
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navBtn_light1, 105, 218), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navBtn_light2, 202, 204)]);
            _stage.robotStage_mc.robot_mc.robotStates_mc.robot_btn_onOff.robot_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, robotRollOver);
            _stage.robotStage_mc.robot_mc.robotStates_mc.robot_btn_onOff.robot_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotStage_mc.robot_mc.robotStates_mc.robot_btn_onOff.robot_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotStage_mc.robot_mc.robotStates_mc.robot_btn_onOff.robot_btn.onRelease = com.clubpenguin.util.Delegate.create(this, robotRelease);
            _stage.robotScare01_mc.robot_mc.robot_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, robotRollOver);
            _stage.robotScare01_mc.robot_mc.robot_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotScare01_mc.robot_mc.robot_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotScare01_mc.robot_mc.robot_btn.onRelease = com.clubpenguin.util.Delegate.create(this, robotRelease);
            _stage.robotScare02_mc.robot_mc.robot_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, robotRollOver);
            _stage.robotScare02_mc.robot_mc.robot_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotScare02_mc.robot_mc.robot_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotScare02_mc.robot_mc.robot_btn.onRelease = com.clubpenguin.util.Delegate.create(this, robotRelease);
            _stage.robotScare03_mc.robot_mc.robot_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, robotRollOver);
            _stage.robotScare03_mc.robot_mc.robot_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotScare03_mc.robot_mc.robot_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, robotRollOut);
            _stage.robotScare03_mc.robot_mc.robot_btn.onRelease = com.clubpenguin.util.Delegate.create(this, robotRelease);
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 200, 170);
            _stage.triggers_mc.guitar_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playguitar);
            _stage.triggers_mc.robo_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, roboTriggerFunction);
            _stage.triggers_mc.penguin_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, penguinTriggerFunction);
            if (_penguinIsMember == true) {
                _stage.triggers_mc.robo_mc.gotoAndStop("on");
                _stage.block_mc.roboBlock_mc.gotoAndStop("off");
                _stage.triggers_mc.penguin_mc.gotoAndStop("on");
                _stage.block_mc.penguinBlock_mc.gotoAndStop("off");
            } else {
                _stage.triggers_mc.robo_mc.gotoAndStop("off");
                _stage.block_mc.roboBlock_mc.gotoAndStop("on");
                _stage.triggers_mc.penguin_mc.gotoAndStop("on");
                _stage.block_mc.penguinBlock_mc.gotoAndStop("off");
            }
            _stage.foreground_mc.navBtn_garage1.onRollOver = com.clubpenguin.util.Delegate.create(this, garage1RollOver);
            _stage.foreground_mc.navBtn_garage1.onRollOut = com.clubpenguin.util.Delegate.create(this, garage1RollOut);
            _stage.foreground_mc.navBtn_garage1.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, garage1RollOut);
            _stage.foreground_mc.navBtn_garage1.onRelease = com.clubpenguin.util.Delegate.create(this, garage1Release);
            _stage.foreground_mc.navBtn_garage2.onRollOver = com.clubpenguin.util.Delegate.create(this, garage2RollOver);
            _stage.foreground_mc.navBtn_garage2.onRollOut = com.clubpenguin.util.Delegate.create(this, garage2RollOut);
            _stage.foreground_mc.navBtn_garage2.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, garage2RollOut);
            _stage.foreground_mc.navBtn_garage2.onRelease = com.clubpenguin.util.Delegate.create(this, garage2Release);
            _stage.navBtn_light1.onRollOver = com.clubpenguin.util.Delegate.create(this, light1DoorRollOver);
            _stage.navBtn_light1.onRollOut = com.clubpenguin.util.Delegate.create(this, light1DoorRollOut);
            _stage.navBtn_light1.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, light1DoorRollOut);
            _stage.navBtn_light2.onRollOver = com.clubpenguin.util.Delegate.create(this, light2DoorRollOver);
            _stage.navBtn_light2.onRollOut = com.clubpenguin.util.Delegate.create(this, light2DoorRollOut);
            _stage.navBtn_light2.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, light2DoorRollOut);
        }
        function garage1RollOver() {
            if (_stage.lock_robot._currentframe != 10) {
                if (_penguinIsMember == true) {
                    _stage.garage1Door.gotoAndStop("open");
                } else {
                    _stage.garage1Door.gotoAndStop("stuck");
                }
            }
        }
        function garage1RollOut() {
            if (_stage.lock_robot._currentframe != 10) {
                if (_penguinIsMember == true) {
                    if (_stage.doorTimer_Robot._currentframe == 1) {
                        _stage.garage1Door.gotoAndStop("close");
                    }
                } else {
                    _stage.garage1Door.gotoAndStop(1);
                }
            }
        }
        function garage1Release() {
            if (_penguinIsMember == true) {
                _ENGINE.sendPlayerMove(298, 193);
                _stage.doorTimer_Robot.gotoAndPlay("start");
            } else {
                _ENGINE.sendPlayerMove(317, 221);
            }
        }
        function garage2RollOver() {
            if (_stage.lock_penguin._currentframe != 10) {
                _stage.garage2Door.gotoAndStop("open");
            }
        }
        function garage2RollOut() {
            if (_stage.lock_penguin._currentframe != 10) {
                if (_stage.doorTimer_Penguin._currentframe == 1) {
                    _stage.garage2Door.gotoAndStop("close");
                }
            }
        }
        function garage2Release() {
            _ENGINE.sendPlayerMove(384, 184);
            _stage.doorTimer_Penguin.gotoAndPlay("start");
        }
        function roboTriggerFunction() {
            if (_penguinIsMember == true) {
                _currentParty.activateEngineOverrides();
                setTimeout(com.clubpenguin.util.Delegate.create(this, startTransformation), 1000);
                if (_stage.garage2Door._currentframe == 10) {
                    _stage.garage2Door.gotoAndStop("close");
                }
                _stage.lock_robot.gotoAndStop("lock");
                _stage.lock_penguin.gotoAndStop("lock");
                _stage.director_robot.gotoAndPlay("start");
            } else {
                _currentParty.showMemberContentOopsMessage();
            }
        }
        function startTransformation() {
            if (isTransforming) {
                return(undefined);
            }
            isTransforming = true;
            _currentParty.sendTransformation(_currentParty.getTransformationVOs()[0].transformId);
        }
        function deactivateEngineOverrides() {
            isTransforming = false;
            _currentParty.deactivateEngineOverrides();
        }
        function penguinTriggerFunction() {
            if (_stage.garage1Door._currentframe == 10) {
                _stage.garage1Door.gotoAndStop("close");
            }
            _currentParty.activateEngineOverrides();
            setTimeout(com.clubpenguin.util.Delegate.create(this, transformBack), 1000);
            _stage.lock_robot.gotoAndStop("lock");
            _stage.lock_penguin.gotoAndStop("lock");
            _stage.director_penguin.gotoAndPlay("start");
        }
        function transformBack() {
            if (isTransforming) {
                return(undefined);
            }
            isTransforming = true;
            _currentParty.transformBackToPenguin();
        }
        function light1DoorRollOver(contentID) {
            _stage.doorB_mc.gotoAndStop(2);
        }
        function light1DoorRollOut(contentID) {
            _stage.doorB_mc.gotoAndStop(1);
        }
        function light2DoorRollOver(contentID) {
            _stage.doorA_mc.gotoAndStop(2);
        }
        function light2DoorRollOut(contentID) {
            _stage.doorA_mc.gotoAndStop(1);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function playguitar() {
        }
        function robotRollOver() {
            _stage.robotStage_mc.robot_mc.gotoAndStop("rollOver");
            _stage.robotStage_mc.stage_mc.gotoAndStop("rollOver");
            _stage.robotScare01_mc.gotoAndStop("rollOver");
            _stage.robotScare02_mc.gotoAndStop("rollOver");
            _stage.robotScare03_mc.gotoAndStop("rollOver");
            if (robotDefeated == true) {
                _stage.robotStage_mc.robot_mc.robotStates_mc.robotAction_mc.gears.play();
            }
        }
        function robotRollOut() {
            _stage.robotStage_mc.robot_mc.gotoAndStop("rollOut");
            _stage.robotStage_mc.stage_mc.gotoAndStop("rollOut");
            _stage.robotScare01_mc.gotoAndStop("rollOut");
            _stage.robotScare02_mc.gotoAndStop("rollOut");
            _stage.robotScare03_mc.gotoAndStop("rollOut");
            if (robotDefeated == true) {
                _stage.robotStage_mc.robot_mc.robotStates_mc.robotAction_mc.gears.stop();
            }
        }
        function robotRelease() {
            if (robotDefeated == false) {
                if (playerHasScareItem == true) {
                    robotDefeated = true;
                    _stage.robotStage_mc.robot_mc.robotStates_mc.robot_btn_onOff.gotoAndStop("off");
                    _stage.robotStage_mc.scaryItem.gotoAndPlay("appear");
                    _stage.robotStage_mc.robotScares.gotoAndStop("scaresOff");
                    _stage.robotStage_mc.itemQueued.gotoAndStop("itemPresented");
                    _stage.robotDirector.gotoAndStop("STOP");
                    if (_stage.robotStage_mc.robot_mc.robotStates_mc.robotAction_mc._currentframe == 1) {
                        _stage.robotStage_mc.robotScares.gotoAndStop("synced");
                        _stage.robotStage_mc.itemQueued.gotoAndStop("synced");
                    }
                } else {
                    _currentParty.showRobotInstructionsPopup(QUEST_TASK_ID);
                }
            } else {
                showMiniGame();
            }
            _currentParty.sendBI("Sensei", "npc", CLASS_NAME);
        }
        function showMiniGame() {
            _currentParty.loadMiniGame(_questTaskVO.questTaskIndex);
        }
        function taskCompleteRoomUpdate() {
            robotPowerDown();
        }
        function robotPowerDown() {
            _stage.robotStage_mc.robot_mc.robotStates_mc.gotoAndStop("powerDown");
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Beach";
        var _penguinIsMember = false;
        var isTransforming = false;
        var robotVisible = false;
        var robotDefeated = false;
        var playerHasScareItem = false;
        static var QUEST_TASK_ID = 5;
    }
