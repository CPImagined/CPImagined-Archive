//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.Basement extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, setupNavigationButtons, generatorLoopSFX, _INTERFACE;
        function Basement (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 193;
            _stage.start_y = 260;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
			localize([_stage.elevatorFloor]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navElevator_btn, 83, 257), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navLadder_btn, 472, 115)]);
            elevatorWorking = true;
            generatorLoopSFX = new Sound(_stage.switchMC);
            generatorLoopSFX.attachSound("sfx_GeneratorLoop");
            if (elevatorWorking == false) {
                _stage.generator.gotoAndStop(1);
                _stage.powerWire1.gotoAndStop("on");
            } else if (elevatorWorking == true) {
                _stage.generator.play();
                _stage.powerWire8.gotoAndStop("on");
                _stage.elevatorLight.gotoAndStop(30);
                _stage.powerWire1.gotoAndStop("on");
                _stage.powerWire2.gotoAndStop("on");
                _stage.powerWire3.gotoAndStop("on");
                _stage.powerWire4.gotoAndStop("on");
                _stage.foreground_mc.powerWire5.gotoAndStop("on");
                _stage.powerWire7.gotoAndStop("on");
                _stage.switch1_mc.gotoAndStop("on");
                _stage.switch2_mc.gotoAndStop("on");
                _stage.switch3_mc.gotoAndStop("on");
                generatorLoopSFX.start(0, 999);
                switch1Up = (switch2Up = (switch3Up = (generatorOn = true)));
            }
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, attemptToUseElevator);
            _stage.triggers_mc.lobby_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 195, 378);
            _stage.navElevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.navElevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.navElevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.navLadder_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, ladderRollOver);
            _stage.navLadder_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, ladderRollOut);
            _stage.navLadder_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, ladderRollOut);
            _stage.switch1_btn.onRelease = com.clubpenguin.util.Delegate.create(this, switch1clicked);
            _stage.switch2_btn.onRelease = com.clubpenguin.util.Delegate.create(this, switch2clicked);
            _stage.switch3_btn.onRelease = com.clubpenguin.util.Delegate.create(this, switch3clicked);
            com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.checkPointOutBasementPuzzle();
        }
        function elevatorRollOver() {
            trace("Basement.elevatorRollOver");
            if (elevatorWorking == true) {
                trace("Basement.elevatorRollOver: Elevator Working.");
                if (_stage.elevator._currentFrame == 1) {
                    _stage.elevator.gotoAndPlay("open");
                } else if (_stage.elevator._currentFrame == 16) {
                } else {
                    _stage.elevator.gotoAndPlay(30 - (_stage.elevator._currentFrame - 2));
                }
            }
        }
        function elevatorRollOut() {
            if (elevatorWorking == true) {
                if (_stage.elevator._currentFrame > 13) {
                    _stage.elevator.gotoAndPlay("close");
                } else {
                    _stage.elevator.gotoAndPlay(2 + (30 - _stage.elevator._currentFrame));
                }
            }
        }
        function ladderRollOver() {
            _stage.navLadder.gotoAndStop(2);
        }
        function ladderRollOut() {
            _stage.navLadder.gotoAndStop(1);
        }
        function switch1clicked() {
            if (((switch1Up == true) && (switch2Up == true)) && (switch3Up == true)) {
                toggleAllSwitchesOff();
            } else {
                toggleSwitch1();
                toggleSwitch3();
            }
            powerCheck();
        }
        function switch2clicked() {
            if (((switch1Up == true) && (switch2Up == true)) && (switch3Up == true)) {
                toggleAllSwitchesOff();
            } else {
                toggleSwitch2();
                toggleSwitch3();
            }
            powerCheck();
        }
        function switch3clicked() {
            if (((switch1Up == true) && (switch2Up == true)) && (switch3Up == true)) {
                toggleAllSwitchesOff();
            } else {
                toggleSwitch3();
            }
            powerCheck();
        }
        function toggleSwitch1() {
            if ((_stage.switch1_mc._currentFrame == 1) || (_stage.switch1_mc._currentFrame >= 10)) {
                _stage.switch1_mc.gotoAndPlay("up");
                switch1Up = true;
            } else {
                _stage.switch1_mc.gotoAndPlay("down");
                switch1Up = false;
            }
        }
        function toggleSwitch2() {
            if ((_stage.switch2_mc._currentFrame == 1) || (_stage.switch2_mc._currentFrame >= 10)) {
                _stage.switch2_mc.gotoAndPlay("up");
                switch2Up = true;
            } else {
                _stage.switch2_mc.gotoAndPlay("down");
                switch2Up = false;
            }
        }
        function toggleSwitch3() {
            if ((_stage.switch3_mc._currentFrame == 1) || (_stage.switch3_mc._currentFrame >= 10)) {
                _stage.switch3_mc.gotoAndPlay("up");
                switch3Up = true;
            } else {
                _stage.switch3_mc.gotoAndPlay("down");
                switch3Up = false;
            }
        }
        function toggleAllSwitchesOff() {
            toggleSwitch1();
            toggleSwitch2();
            toggleSwitch3();
        }
        function powerCheck() {
            if (!_interactedWithPuzzle) {
                _interactedWithPuzzle = true;
                com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.checkGiveBasementPuzzleHint();
            }
            if (((switch1Up == true) && (switch2Up == true)) && (switch3Up == true)) {
                _stage.powerWire2.gotoAndStop("on");
                _stage.powerWire3.gotoAndStop("on");
                _stage.powerWire4.gotoAndStop("on");
                _stage.foreground_mc.powerWire5.gotoAndStop("on");
                _stage.powerWire7.gotoAndStop("on");
                gameVictory();
            } else if (((switch1Up == false) && (switch2Up == false)) && (switch3Up == true)) {
                _stage.powerWire2.gotoAndStop("on");
                _stage.powerWire3.gotoAndStop("off");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
            } else if (((switch1Up == false) && (switch2Up == true)) && (switch3Up == false)) {
                _stage.powerWire2.gotoAndStop("off");
                _stage.powerWire3.gotoAndStop("off");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
            } else if (((switch1Up == true) && (switch2Up == false)) && (switch3Up == false)) {
                _stage.powerWire2.gotoAndStop("off");
                _stage.powerWire3.gotoAndStop("off");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
            } else if (((switch1Up == false) && (switch2Up == true)) && (switch3Up == true)) {
                _stage.powerWire2.gotoAndStop("on");
                _stage.powerWire3.gotoAndStop("on");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
            } else if (((switch1Up == true) && (switch2Up == true)) && (switch3Up == false)) {
                _stage.powerWire2.gotoAndStop("off");
                _stage.powerWire3.gotoAndStop("off");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
            } else if (((switch1Up == true) && (switch2Up == false)) && (switch3Up == true)) {
                _stage.powerWire2.gotoAndStop("on");
                _stage.powerWire3.gotoAndStop("off");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
            } else {
                _stage.powerWire2.gotoAndStop("off");
                _stage.powerWire3.gotoAndStop("off");
                _stage.powerWire4.gotoAndStop("off");
                _stage.foreground_mc.powerWire5.gotoAndStop("off");
                _stage.powerWire7.gotoAndStop("off");
                checkPowerDown();
            }
        }
        function checkPowerDown() {
            if (generatorOn) {
                generatorLoopSFX.stop();
                generatorOn = false;
                com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.playSound(_stage.switch1_mc, "sfx_GeneratorPowerDown");
            }
        }
        function gameVictory() {
            trace("Game Victory!");
            _stage.generator.play();
            _stage.powerWire8.gotoAndStop("on");
            _stage.bigSpark.gotoAndPlay(2);
            if (_stage.elevatorLight._currentFrame == 1) {
                _stage.elevatorLight.gotoAndPlay(1);
            }
            if (_stage.foreground_mc.ghostPuffle._currentframe == 1) {
                _stage.foreground_mc.ghostPuffle.gotoAndStop("appear");
            }
            com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.playSound(_stage.switch1_mc, "sfx_GeneratorPowerUp");
            generatorLoopSFX.start(0, 99);
        }
        function attemptToUseElevator() {
            trace("Basement.attemptToUseElevator");
            if (elevatorWorking == true) {
                _INTERFACE.showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.ELEVATOR_UI_PATH);
            }
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            com.clubpenguin.world.rooms2014.halloween.party.HalloweenPartyQuestCommunicator.clean();
        }
        static var CLASS_NAME = "Basement";
        var elevatorWorking = false;
        var switch1Up = false;
        var switch2Up = false;
        var switch3Up = false;
        var generatorOn = false;
        var _interactedWithPuzzle = false;
    }
