//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.october.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, _currentParty, _questTaskVO, setupNavigationButtons, _INTERFACE;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 510;
            _stage.start_y = 360;
            localize([_stage.signPark_mc, _stage.signPet_mc, _stage.signHotel_mc, _stage.signMall_mc, _stage.signPizza_mc]);
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
            if (_currentParty.collectedItem == _currentParty.CONSTANTS.CLOWN) {
                playerHasScareItem = true;
            }
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
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 25, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.park_btn, 65, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pet_btn, 175, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hotel_btn, 295, 240), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.mall01_btn, 385, 223), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.mall02_btn, 495, 223), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pizza_btn, 556, 241), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 725, 300), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 620, 277), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tickets_btn, 439, 212)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.park_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.tickets_btn.useHandCursor = false;
            _stage.background_mc.cannon_btn.useHandCursor = false;
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.manhole_mc.manhole_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.pet_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, petRollOver);
            _stage.pet_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, petRollOut);
            _stage.pet_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, petRollOut);
            _stage.hotel_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, hotelRollOver);
            _stage.hotel_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hotelRollOut);
            _stage.hotel_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, hotelRollOut);
            _stage.mall01_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mall01RollOver);
            _stage.mall01_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mall01RollOut);
            _stage.mall01_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mall01RollOut);
            _stage.mall02_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mall02RollOver);
            _stage.mall02_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mall02RollOut);
            _stage.mall02_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, mall02RollOut);
            _stage.pizza_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, pizzaRollOver);
            _stage.pizza_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, pizzaRollOut);
            _stage.pizza_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, pizzaRollOut);
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
            _stage.testBtn_powerDown.onRelease = com.clubpenguin.util.Delegate.create(this, robotPowerDown);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 655, 141);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 390, 175);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.mall01_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 135, 360);
            _stage.triggers_mc.mall02_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 135, 360);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 365, 195);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 65, 315);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
        }
        function manholeRollOver() {
            _stage.manhole_mc.gotoAndPlay(2);
        }
        function manholeRollOut() {
            _stage.manhole_mc.gotoAndPlay(9);
        }
        function petRollOver() {
            _stage.doorPet_mc.gotoAndStop(2);
        }
        function petRollOut() {
            _stage.doorPet_mc.gotoAndStop(1);
        }
        function hotelRollOver() {
            _stage.doorHotel_mc.gotoAndStop(2);
        }
        function hotelRollOut() {
            _stage.doorHotel_mc.gotoAndStop(1);
        }
        function mall01RollOver() {
            _stage.doorMall01_mc.gotoAndStop(2);
        }
        function mall01RollOut() {
            _stage.doorMall01_mc.gotoAndStop(1);
        }
        function mall02RollOver() {
            _stage.doorMall02_mc.gotoAndStop(2);
        }
        function mall02RollOut() {
            _stage.doorMall02_mc.gotoAndStop(1);
        }
        function pizzaRollOver() {
            _stage.doorPizza_mc.gotoAndStop(2);
        }
        function pizzaRollOut() {
            _stage.doorPizza_mc.gotoAndStop(1);
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
            _currentParty.sendBI("Rookie", "npc", CLASS_NAME);
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
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            if (name == "cave") {
                _SHELL.stampEarned(UNDERGROUND_STAMP_ID);
            }
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Plaza";
        var UNDERGROUND_STAMP_ID = 10;
        var robotVisible = false;
        var robotDefeated = false;
        var playerHasScareItem = false;
        static var QUEST_TASK_ID = 7;
    }
