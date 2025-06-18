//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.october.Party1 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, localize, _currentParty, _pickUpFreeItem, setupNavigationButtons, _checkLaserTagetDelegate, _INTERFACE, _dialog1FinishedDelegate, _dialog2FinishedDelegate, _dialog3FinishedDelegate, _dialog4FinishedDelegate, _dialog5FinishedDelegate, _dialog6FinishedDelegate;
        function Party1 (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 395;
            _stage.start_y = 365;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.customPenguinSize = 120;
            localize([_stage.signCoffee_mc, _stage.signDance_mc, _stage.signClothes_mc]);
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
			_pickUpFreeItem = com.clubpenguin.util.Delegate.create(this, pickUpFreeItem);
            if (_currentParty.partyCookie.hasPlayerCompletedTask(PENULTIMATE_TASK_ID)) {
                hasAlreadySeenIntro = true;
            }
			if(_SHELL.isItemInMyInventory(2179) || _SHELL.isItemInMyInventory(21051)) {
				herbotDefeated = true;
				hasAlreadySeenIntro = true;
				_stage.npcHerbert.gotoAndStop("gone");
                _stage.npcKlutzy.gotoAndStop("gone");
				_stage.cageFront.gotoAndStop("dropped");
				_stage.cageFront.states.gotoAndStop("broken");
				_stage.cageBack.gotoAndStop("dropped");
				_stage.cageBack.states.art.gotoAndStop("broken");
				_stage.cageShadow.gotoAndStop("dropped");
				_stage.herbotIntro.gotoAndStop("gone");
			} else {
				herbotDefeated = false;
				hasAlreadySeenIntro = false;
			};
            _stage.teslaCoil1.gotoAndStop(1);
            _stage.teslaCoil2.gotoAndStop(1);
            _stage.orangeElectricty1.gotoAndStop(1);
            _stage.orangeElectricty2.gotoAndStop(1);
            _stage.orangeElectricty3.gotoAndStop(1);
            _stage.robotDirector.gotoAndStop(1);
            if (herbotDefeated == true) {
                _stage.block_mc.blockSolo.gotoAndStop("off");
				_stage.background_mc.items_mc.gotoAndStop(2);
            } else {
                _stage.block_mc.blockSolo.gotoAndStop("on");
                if (hasAlreadySeenIntro == false) {
                    _stage.DirectorIntro1.gotoAndPlay("action");
                    _stage.block_mc.blockSoloPlayerSnatcher.gotoAndStop("on");
                } else {
                    _stage.herbotIntro.gotoAndStop("gone");
                    _stage.robotStage_mc.gotoAndStop("on");
                    _stage.robotDirector.play();
                    _stage.cageFront.gotoAndStop("dropped");
                    _stage.cageBack.gotoAndStop("dropped");
                    _stage.background_mc.cageShadow.gotoAndStop("dropped");
                    _stage.npcHerbert.gotoAndStop("cageIdle");
                    _stage.npcKlutzy.gotoAndStop("cageIdle");
                    _stage.computerScreen.gotoAndStop("end");
                    _stage.lazerButton_onOff.gotoAndStop("on");
                }
            }
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffee_btn, 695, 315), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.itemPickUp_mc.itemPickUp_btn, 333, 295)]);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 135, 155);
            _stage.triggers_mc.freeItem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, confirmPickUp);
            _checkLaserTagetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkLaserTagetDelegate);
            _stage.snowBlock_mc._visible = false;
            _stage.lazerButton_onOff.lazerButton_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, lazerButtonRollOver);
            _stage.lazerButton_onOff.lazerButton_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, lazerButtonRollOut);
            _stage.lazerButton_onOff.lazerButton_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, lazerButtonRollOut);
            _stage.lazerButton_onOff.lazerButton_btn.onRelease = com.clubpenguin.util.Delegate.create(this, lazerButtonHit);
            _stage.coffee_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, coffeeRollOver);
            _stage.coffee_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, coffeeRollOut);
            _stage.coffee_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, coffeeRollOut);
            _stage.itemPickUp_mc.itemPickUp_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, freeItemRollOver);
            _stage.itemPickUp_mc.itemPickUp_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
            _stage.itemPickUp_mc.itemPickUp_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, freeItemRollOut);
            _stage.robotScare03_mc.herbotGame_OffOn.herbotGame_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, robotGameRollOver);
            _stage.robotScare03_mc.herbotGame_OffOn.herbotGame_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, robotGameRollOut);
            _stage.robotScare03_mc.herbotGame_OffOn.herbotGame_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, robotGameRollOut);
            _stage.robotScare03_mc.herbotGame_OffOn.herbotGame_btn.onRelease = com.clubpenguin.util.Delegate.create(this, robotGameRelease);
            _stage.interface_mc.dialog1.nextArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog1Finished);
            _stage.interface_mc.dialog2.nextArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog2Finished);
            _stage.interface_mc.dialog3.nextArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog3Finished);
            _stage.interface_mc.dialog4.nextArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog4Finished);
            _stage.interface_mc.dialog5.nextFrameArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog5NextFrame);
            _stage.interface_mc.dialog5.nextArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog5Finished);
            _stage.interface_mc.dialog6.nextArrow.onRelease = com.clubpenguin.util.Delegate.create(this, dialog6Finished);
        }
        function coffeeRollOver() {
            _stage.coffeeExit.gotoAndStop(2);
        }
        function coffeeRollOut() {
            _stage.coffeeExit.gotoAndStop(1);
        }
        function freeItemRollOver() {
            _stage.itemPickUp_states.itemPickUp.gotoAndStop(2);
        }
        function freeItemRollOut() {
            _stage.itemPickUp_states.itemPickUp.gotoAndStop(1);
        }
		function confirmPickUp() {
			_INTERFACE.showPrompt("question", "You have found a box of scary bot buddies.\nWould you like to pick it up?", "", pickUpFreeItem());
		}
        function pickUpFreeItem() {
			if(!_SHELL.isItemInMyInventory(21043)) {
				_SHELL.sendBuyInventory(21043);
			};
			if(!_SHELL.isItemInMyInventory(21044)) {
				_SHELL.sendBuyInventory(21044);
			};
			if(!_SHELL.isItemInMyInventory(21045)) {
				_SHELL.sendBuyInventory(21045);
			};
			if(!_SHELL.isItemInMyInventory(21046)) {
				_SHELL.sendBuyInventory(21046);
			};
			if(!_SHELL.isItemInMyInventory(21047)) {
				_SHELL.sendBuyInventory(21047);
			};
			if(!_SHELL.isItemInMyInventory(21048)) {
				_SHELL.sendBuyInventory(21048);
			};
			if(!_SHELL.isItemInMyInventory(21049)) {
				_SHELL.sendBuyInventory(21049);
			};
			if(!_SHELL.isItemInMyInventory(21050)) {
				_SHELL.sendBuyInventory(21050);
			};
        }
        function lazerButtonRollOver() {
            _stage.lazerButton_mc.gotoAndStop("rollOver");
        }
        function lazerButtonRollOut() {
            _stage.lazerButton_mc.gotoAndStop("rollOut");
        }
        function onSnowballLand(snowballInfo) {
            trace(CLASS_NAME + ": handleThrow()");
            if (_stage.lazerButton_onOff.target.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                lazerButtonHit();
                _stage.lazerButton_mc.pushIn.gotoAndPlay("hit");
                snowballInfo.snowballMC._visible = false;
            } else if (_stage.snowBlock_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                snowballInfo.snowballMC._visible = false;
            }
        }
        function lazerButtonHit() {
            _stage.lazerButton_mc.pushIn.gotoAndPlay("hit");
            if ((_stage.laser1._currentframe < 2) || (_stage.laser1._currentframe > 10)) {
                if ((_stage.laser2._currentframe < 2) || (_stage.laser1._currentframe > 10)) {
                    fireLazer();
                }
            }
        }
        function fireLazer() {
            _stage.giantLaser.gotoAndStop("coolDown");
            if (_stage.robotScare03_mc.targetLock._currentframe == 10) {
                _stage.robotDirector.gotoAndStop("STOP");
                _stage.laser2.gotoAndPlay(2);
                _stage.DirectorBotHit.gotoAndPlay("action");
            } else {
                _stage.laser1.gotoAndPlay(2);
            }
        }
        function loadMiniGame() {
            showContent("halloHerbertGame");
        }
        function robotGameRollOver() {
            _stage.robotScare03_mc.robot_mc.gotoAndStop("rollOn");
        }
        function robotGameRollOut() {
            _stage.robotScare03_mc.robot_mc.gotoAndStop("rollOut");
        }
        function robotGameRelease() {
            trace("=== Play Robot Mini Game ===");
            loadMiniGame();
        }
        function taskCompleteRoomUpdate() {
            trace("HERBERT'S LAIR POWER DOWN");
            _stage.DirectorPowerDown.gotoAndPlay("action");
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkLaserTagetDelegate);
        }
        function showClassDialog1() {
            trace("=== SHOW DIALOGUE 1 === ###################");
            showContent("halloHerbertMonologue");
            _dialog1FinishedDelegate = com.clubpenguin.util.Delegate.create(this, dialog1Finished);
            _SHELL.addListener(_SHELL.CONTENT_CLOSED, _dialog1FinishedDelegate);
        }
        function showClassDialog2() {
            trace("=== SHOW DIALOGUE 2 === $$$$$$$$$$$$$$$$$$$$");
            showContent("halloHerbertMonologue2");
            _dialog2FinishedDelegate = com.clubpenguin.util.Delegate.create(this, dialog2Finished);
            _SHELL.addListener(_SHELL.CONTENT_CLOSED, _dialog2FinishedDelegate);
        }
        function showClassDialog3() {
            trace("=== SHOW DIALOGUE 3 === $$$$$$$$$$$$$$$$$$$$");
            showContent("halloHerbot");
            _dialog3FinishedDelegate = com.clubpenguin.util.Delegate.create(this, dialog3Finished);
            _SHELL.addListener(_SHELL.CONTENT_CLOSED, _dialog3FinishedDelegate);
        }
        function showClassDialog4() {
            trace("=== SHOW DIALOGUE 4 === $$$$$$$$$$$$$$$$$$$$");
            showContent("halloHerbertCage");
            _dialog4FinishedDelegate = com.clubpenguin.util.Delegate.create(this, dialog4Finished);
            _SHELL.addListener(_SHELL.CONTENT_CLOSED, _dialog4FinishedDelegate);
        }
        function showClassDialog5() {
            trace("=== SHOW DIALOGUE 5 === $$$$$$$$$$$$$$$$$$$$");
            showContent("halloGaryLair");
            _dialog5FinishedDelegate = com.clubpenguin.util.Delegate.create(this, dialog5Finished);
            _SHELL.addListener(_SHELL.CONTENT_CLOSED, _dialog5FinishedDelegate);
        }
        function showClassDialog6() {
            trace("=== SHOW DIALOGUE 6 === $$$$$$$$$$$$$$$$$$$$");
            showContent("halloHerbertGetaway");
            _dialog6FinishedDelegate = com.clubpenguin.util.Delegate.create(this, dialog6Finished);
            _SHELL.addListener(_SHELL.CONTENT_CLOSED, _dialog6FinishedDelegate);
        }
        function showClassDialog7() {
            trace("=== SHOW DIALOGUE 7 === $$$$$$$$$$$$$$$$$$$$");
            showContent("halloGaryFinal");
            _stage.block_mc.blockSolo.gotoAndStop("off");
        }
        function dialog1Finished() {
            trace("DIALOGUE 1 FINISHED ++++++++++++++++++++++++");
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _dialog1FinishedDelegate);
            _dialog1FinishedDelegate = null;
            _stage.DirectorIntro2.gotoAndPlay("action");
        }
        function dialog2Finished() {
            trace("DIALOGUE 2 FINISHED ************************");
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _dialog2FinishedDelegate);
            _dialog2FinishedDelegate = null;
            _stage.DirectorIntro3.gotoAndPlay("action");
        }
        function dialog3Finished() {
            trace("DIALOGUE 3 FINISHED ************************");
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _dialog3FinishedDelegate);
            _dialog3FinishedDelegate = null;
            _stage.DirectorIntro4.gotoAndPlay("action");
        }
        function dialog4Finished() {
            trace("DIALOGUE 4 FINISHED ************************");
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _dialog4FinishedDelegate);
            _dialog4FinishedDelegate = null;
            _stage.DirectorIntro5.gotoAndPlay("action");
        }
        function dialog5NextFrame() {
            _stage.interface_mc.dialog5.nextFrame();
        }
        function dialog5Finished() {
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _dialog5FinishedDelegate);
            _dialog5FinishedDelegate = null;
            _stage.DirectorIntro6.gotoAndPlay("action");
        }
        function dialog6Finished() {
            _SHELL.removeListener(_SHELL.CONTENT_CLOSED, _dialog6FinishedDelegate);
            _dialog6FinishedDelegate = null;
            _stage.DirectorOutro1.gotoAndPlay("action");
        }
        static var CLASS_NAME = "Party1";
        var hasAlreadySeenIntro = false;
        var herbotDefeated = false;
        var PENULTIMATE_TASK_ID = 8;
        var HERBOT_DEFEATED_TASK_ID = 9;
    }
