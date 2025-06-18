//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _destroyDelegate, _soundsArray, _triggerWatcher, wem, _patioWaterTrigger, _engineWaterTrigger, _helicopterWaterTrigger, _triggerWatcherInterval, _barrelSFXArray, _concreteSFXArray, _fireHydrantSFXArray, _glassSFXArray, _metalHollowSFXArray, _metalPoleSFXArray, _plasticHardSFXArray, _signSparkSFXArray, _woodSFXArray, _destructibles, _INTERFACE, _ENGINE;
        function Dock (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 205;
            _stage.start_y = 285;
            if (!_SHELL) {
                init();
            }
            localize([_stage.background_mc.fireDoor.fireSign.signText, _stage.garage.garageSign.deactivatedMsg.bitmapMsg, _stage.garage.garageSign.activatedMsg.bitmapMsg]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.village_btn, 340, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.boss_btn, 563, 189), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.town_btn, 715, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dock_mc.boat_btn, 147, 406), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.garage_btn, 100, 215), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.engineChair1_btn, 517, 315), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.engineChair2_btn, 567, 295)]);
            _stage.village_btn.useHandCursor = false;
            _stage.town_btn.useHandCursor = false;
            _stage.engineChair1_btn.useHandCursor = false;
            _stage.engineChair2_btn.useHandCursor = false;
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.interface_mc.hero_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty, com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.launchCatalog);
            _stage.dockPost.hydrocatalog_mc.hydrocatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
            _stage.dock_mc.boat_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHintRollOver);
            _stage.dock_mc.boat_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHydroHintRollOut);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 565, 205);
			_stage.triggers_mc.boss_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 340, 315);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 665, 350);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 95, 320);
            _stage.triggers_mc.hydro_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchHydroGame);
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            configureDestructibles();
            _soundsArray = new Array("explosion1", "explosion2");
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(45);
            wem.setupRainAnimationHeight(70);
            wem.setupSnowAnimationHeight(70);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _patioWaterTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.patioWater_mc);
            _patioWaterTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startWaterPatio));
            _patioWaterTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopWaterPatio));
            _triggerWatcher.addTrigger(_patioWaterTrigger);
            _engineWaterTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.engineWater_mc);
            _engineWaterTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startWaterEngine));
            _engineWaterTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopWaterEngine));
            _triggerWatcher.addTrigger(_engineWaterTrigger);
            _helicopterWaterTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.helicopterWater_mc);
            _helicopterWaterTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startWaterHelicopter));
            _helicopterWaterTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopWaterHelicopter));
            _triggerWatcher.addTrigger(_helicopterWaterTrigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _stage.destructibleTriggers_mc._visible = false;
            _stage.garage.helicopter.helicopterAnimation.gotoAndStop(1);
        }
        function configureSounds() {
            _barrelSFXArray = new Array("impactBarrelExplosion");
            _concreteSFXArray = new Array("impactConcrete");
            _fireHydrantSFXArray = new Array("impactFireHydrant");
            _glassSFXArray = new Array("impactGlass");
            _metalHollowSFXArray = new Array("impactMetalHollow");
            _metalPoleSFXArray = new Array("impactMetalPole");
            _plasticHardSFXArray = new Array("impactPlasticHard");
            _signSparkSFXArray = new Array("impactSignSpark");
            _woodSFXArray = new Array("impactWood");
        }
        function configureDestructibles() {
            var _local_2 = [];
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.hydrant_mc, _stage.destructibleTriggers_mc.hydrantTrigger_mc, _fireHydrantSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.garage.helicopter.helicopterAnimation.helicopterBody, _stage.destructibleTriggers_mc.helicopterTrigger_mc, _metalHollowSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.fireDoor.window1, _stage.destructibleTriggers_mc.window1Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.fireDoor.window2, _stage.destructibleTriggers_mc.window2Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.fireDoor.fireSign, _stage.destructibleTriggers_mc.fireSignTrigger_mc, _signSparkSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.streetlight, _stage.destructibleTriggers_mc.streetlightTrigger_mc, _metalPoleSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window3, _stage.destructibleTriggers_mc.window3Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window4, _stage.destructibleTriggers_mc.window4Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window5, _stage.destructibleTriggers_mc.window5Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window6, _stage.destructibleTriggers_mc.window6Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window7, _stage.destructibleTriggers_mc.window7Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window8, _stage.destructibleTriggers_mc.window8Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window9, _stage.destructibleTriggers_mc.window9Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window10, _stage.destructibleTriggers_mc.window10Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window11, _stage.destructibleTriggers_mc.window11Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window12, _stage.destructibleTriggers_mc.window12Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window13, _stage.destructibleTriggers_mc.window13Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window14, _stage.destructibleTriggers_mc.window14Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window15, _stage.destructibleTriggers_mc.window15Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window16, _stage.destructibleTriggers_mc.window16Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window17, _stage.destructibleTriggers_mc.window17Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.window18, _stage.destructibleTriggers_mc.window18Trigger_mc, _glassSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.theDoor, _stage.destructibleTriggers_mc.burningDoorTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.pillar1, _stage.destructibleTriggers_mc.pillar1Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.burningBuilding.pillar2, _stage.destructibleTriggers_mc.pillar2Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.garage.garageSide, _stage.destructibleTriggers_mc.garageSideTrigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.garageFront, _stage.destructibleTriggers_mc.garageFrontTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.fireDoor.shutter, _stage.destructibleTriggers_mc.shutterTrigger_mc, _metalPoleSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.fireDoor, _stage.destructibleTriggers_mc.fireDoorTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.trash, _stage.destructibleTriggers_mc.trashTrigger_mc, _barrelSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.engineFront, _stage.destructibleTriggers_mc.engineFrontTrigger_mc, _metalHollowSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.engineBack.tire, _stage.destructibleTriggers_mc.tireBackTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.engineFront.tire, _stage.destructibleTriggers_mc.tireFrontTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.dock_mc.boat_mc.boathover_mc.boatDmg, _stage.destructibleTriggers_mc.boatTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.dock_mc.dockDmg, _stage.destructibleTriggers_mc.dockTrigger_mc, _woodSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.hose, _stage.destructibleTriggers_mc.hoseTrigger_mc, _plasticHardSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.patio.stairs, _stage.destructibleTriggers_mc.stairsTrigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.patio, _stage.destructibleTriggers_mc.patioTrigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground1, _stage.destructibleTriggers_mc.ground1Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground2, _stage.destructibleTriggers_mc.ground2Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground3, _stage.destructibleTriggers_mc.ground3Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground4, _stage.destructibleTriggers_mc.ground4Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground5, _stage.destructibleTriggers_mc.ground5Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground6, _stage.destructibleTriggers_mc.ground6Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground7, _stage.destructibleTriggers_mc.ground7Trigger_mc, _concreteSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.engineTop, _stage.destructibleTriggers_mc.engineTopTrigger_mc, _metalHollowSFXArray));
            _local_2.push(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.engineBack, _stage.destructibleTriggers_mc.engineBackTrigger_mc, _metalHollowSFXArray));
            _destructibles = new com.clubpenguin.world.rooms.common.destructibles.DestructibleGroup(_local_2, new com.clubpenguin.world.rooms.common.destructibles.DestructibleSoundManager(_stage));
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function showHydroHintRollOver() {
            trace("show hint");
            _INTERFACE.showHint(_stage.hinthydro_mc, "hydro_hint");
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(2);
        }
        function hideHydroHintRollOut() {
            trace("hide hint");
            _INTERFACE.closeHint();
            _stage.dock_mc.boat_mc.boathover_mc.gotoAndStop(1);
        }
        function launchHydroGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function startWaterPatio() {
            _stage.patio.waterJet.gotoAndStop("start");
        }
        function stopWaterPatio() {
            _stage.patio.waterJet.gotoAndStop("end");
        }
        function startWaterEngine() {
            _stage.engineBackAndTop.waterJet.gotoAndStop("start");
        }
        function stopWaterEngine() {
            _stage.engineBackAndTop.waterJet.gotoAndStop("end");
        }
        function startWaterHelicopter() {
            _stage.garage.garageSign.gotoAndStop("activated");
            if ((_stage.garage.helicopter.helicopterAnimation._currentframe == 1) || (_stage.garage.helicopter.helicopterAnimation._currentframe >= 110)) {
                _stage.garage.helicopter.helicopterAnimation.gotoAndPlay("fly");
            } else {
                _stage.garage.helicopter.helicopterAnimation.gotoAndPlay(110 - _stage.garage.helicopter.helicopterAnimation._currentFrame);
            }
        }
        function stopWaterHelicopter() {
            _stage.garage.garageSign.gotoAndStop("deactivated");
            _stage.garage.helicopter.helicopterAnimation.gotoAndPlay(110 - _stage.garage.helicopter.helicopterAnimation._currentFrame);
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Dock";
    }
