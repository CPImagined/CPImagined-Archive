//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.Forts extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, setupNavigationButtons, _liveEvent, IS_24_HOUR_CLOCK, _now, _soundsArray, _secondCheckIntervalID, _destroyDelegate, _checkClockTagetDelegate, showContent, wem, _barrelSFXArray, _clockSpringSFXArray, _concreteSFXArray, _dumpsterSFXArray, _fireHydrantSFXArray, _glassSFXArray, _metalHollowSFXArray, _metalPoleSFXArray, _plasticHardSFXArray, _signSparkSFXArray, _woodSFXArray, _destructibles, _ct_minutes, _ct_hours, _pm_trigger, _ct_day, _today, _INTERFACE;
        function Forts (stageReference) {
            super(stageReference);
            _stage.start_x = 380;
            _stage.start_y = 285;
            if (!_SHELL) {
                init();
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            localize([_stage.clocktower.clocktext, _stage.fragileFront.sign.signText, _stage.fragileFront.sign.signTextDestroyed, _stage.background_mc.lightUpSign.signText, _stage.pricelessEntrance.sign.signText.inner]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rink_btn, 304, 172)]);
            IS_24_HOUR_CLOCK = _SHELL.getLanguageAbbreviation() == "de";
            if (IS_24_HOUR_CLOCK) {
                _stage.clocktower.clock_txt._x = _stage.clocktower.clock_txt._x + 15;
            }
            if (_SHELL.getPenguinStandardTime != undefined) {
                _now = _SHELL.getPenguinStandardTime();
            } else {
                _now = new Date();
            }
            _soundsArray = new Array("explosion1", "explosion2");
            configureDestructibles();
            clearInterval(_secondCheckIntervalID);
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, clockTimer), ONE_SECOND);
            clockTimer();
            _stage.background_mc.town_btn.useHandCursor = false;
            _stage.background_mc.rink_btn.useHandCursor = false;
            _stage.background_mc.plaza_btn.useHandCursor = false;
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 660, 325);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 380, 135);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 85, 330);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _checkClockTagetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.clock_btn, true, "clock_help", "")]);
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playLiveEvent);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(25);
            wem.setupRainAnimationHeight(35);
            wem.setupSnowAnimationHeight(35);
            wem.setupRainAnimationSpeed(0.3);
            wem.setupSnowAnimationSpeed(0.6);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
            _stage.destructibleTriggers_mc._visible = false;
            _stage.interface_mc.hero_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.superhero.SuperHeroParty, com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.launchCatalog);
        }
        function configureSounds() {
            _barrelSFXArray = new Array("impactBarrelExplosion");
            _clockSpringSFXArray = new Array("impactClockSpring");
            _concreteSFXArray = new Array("impactConcrete");
            _dumpsterSFXArray = new Array("impactDumpster");
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
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.hydrant_mc, _stage.destructibleTriggers_mc.hydrantTrigger_mc, _fireHydrantSFXArray));
            _local_2[0].addExplosionClip(_stage.hydrant_mc.destroyed);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileFront.front.window1, _stage.destructibleTriggers_mc.window1Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileFront.front.window2, _stage.destructibleTriggers_mc.window2Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileFront.break1, _stage.destructibleTriggers_mc.fragileBreak1Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileFront.break2, _stage.destructibleTriggers_mc.fragileBreak2Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileFront.cup, _stage.destructibleTriggers_mc.cupTrigger_mc, _plasticHardSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileFront.sign, _stage.destructibleTriggers_mc.fragileSignTrigger_mc, _woodSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.fragileBack, _stage.destructibleTriggers_mc.fragileDoorTrigger_mc, _plasticHardSFXArray));
            _local_2[0].addExplosionClip(_stage.fragileBack);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.dumpster, _stage.destructibleTriggers_mc.dumpsterTrigger_mc, _dumpsterSFXArray));
            _local_2[0].addExplosionClip(_stage.dumpster.destroyed);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window3, _stage.destructibleTriggers_mc.window3Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window4, _stage.destructibleTriggers_mc.window4Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window5, _stage.destructibleTriggers_mc.window5Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window6, _stage.destructibleTriggers_mc.window6Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window7, _stage.destructibleTriggers_mc.window7Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window8, _stage.destructibleTriggers_mc.window8Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront.window9, _stage.destructibleTriggers_mc.window9Trigger_mc, _glassSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessEntrance.clock, _stage.destructibleTriggers_mc.pricelessClockTrigger_mc, _clockSpringSFXArray));
            _local_2[0].addExplosionClip(_stage.pricelessEntrance.clock.destroyed);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessEntrance.sign, _stage.destructibleTriggers_mc.pricelessSignTrigger_mc, _plasticHardSFXArray));
            _local_2[0].addExplosionClip(_stage.pricelessEntrance.signExplosion_mc);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessBack.pillar, _stage.destructibleTriggers_mc.pillar1Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessFront, _stage.destructibleTriggers_mc.pricelessDoorTrigger_mc, _plasticHardSFXArray));
            _local_2[0].addExplosionClip(_stage.pricelessBack.destroyedBack);
            _local_2[0].addExplosionClip(_stage.pricelessBack.door);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.pricelessEntrance.pillar, _stage.destructibleTriggers_mc.pillar2Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.back1, _stage.destructibleTriggers_mc.backBuilding1Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.back2, _stage.destructibleTriggers_mc.backBuilding2Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.back3, _stage.destructibleTriggers_mc.backBuilding3Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.back4, _stage.destructibleTriggers_mc.backBuilding4Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.back5, _stage.destructibleTriggers_mc.backBuilding5Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.back6, _stage.destructibleTriggers_mc.backBuilding6Trigger_mc, _concreteSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.streetLight1, _stage.destructibleTriggers_mc.streetlight1Trigger_mc, _metalPoleSFXArray));
            _local_2[0].addExplosionClip(_stage.streetLight1.destroyed);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.streetLight2, _stage.destructibleTriggers_mc.streetlight2Trigger_mc, _metalPoleSFXArray));
            _local_2[0].addExplosionClip(_stage.streetLight2.destroyed);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.lightUpSign, _stage.destructibleTriggers_mc.stadiumSignTrigger_mc, _plasticHardSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.busStopSign, _stage.destructibleTriggers_mc.busStopSignTrigger_mc, _metalPoleSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.papersTrigger_mc, _stage.destructibleTriggers_mc.papersTrigger_mc, _plasticHardSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.car1, _stage.destructibleTriggers_mc.car1Trigger_mc, _metalHollowSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.car2, _stage.destructibleTriggers_mc.car2Trigger_mc, _metalHollowSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.trash, _stage.destructibleTriggers_mc.trashTrigger_mc, _barrelSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground1, _stage.destructibleTriggers_mc.ground1Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion1);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground2, _stage.destructibleTriggers_mc.ground2Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion2);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground3, _stage.destructibleTriggers_mc.ground3Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion3);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground4, _stage.destructibleTriggers_mc.ground4Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion4);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground5, _stage.destructibleTriggers_mc.ground5Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion5);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground6, _stage.destructibleTriggers_mc.ground6Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion6);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground7, _stage.destructibleTriggers_mc.ground7Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion7);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground8, _stage.destructibleTriggers_mc.ground8Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion8);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground9, _stage.destructibleTriggers_mc.ground9Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion9);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.background_mc.ground10, _stage.destructibleTriggers_mc.ground10Trigger_mc, _concreteSFXArray));
            _local_2[0].addExplosionClip(_stage.groundExplosion10);
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.bump1, _stage.destructibleTriggers_mc.bump1Trigger_mc, _barrelSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.bump2, _stage.destructibleTriggers_mc.bump2Trigger_mc, _barrelSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.bump3, _stage.destructibleTriggers_mc.bump3Trigger_mc, _barrelSFXArray));
            _local_2.unshift(new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.bump4, _stage.destructibleTriggers_mc.bump4Trigger_mc, _barrelSFXArray));
            var _local_6 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.booth.windowLeft, _stage.destructibleTriggers_mc.telephoneBoothLeftTrigger_mc, _glassSFXArray);
            _local_6.addExplosionClip(_stage.booth.poofLeft);
            var _local_7 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.booth.windowRight, _stage.destructibleTriggers_mc.telephoneBoothRightTrigger_mc, _glassSFXArray);
            _local_7.addExplosionClip(_stage.booth.poofRight);
            var _local_3 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.booth, _stage.destructibleTriggers_mc.telephoneBoothBackTrigger_mc, _glassSFXArray);
            _local_3.addExplosionClip(_stage.booth.poof);
            _local_6.addLink(_local_3);
            _local_7.addLink(_local_3);
            _local_2.unshift(_local_6);
            _local_2.unshift(_local_7);
            _local_2.unshift(_local_3);
            var _local_9 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.busStop.sideGlass, _stage.destructibleTriggers_mc.busStopRightTrigger_mc, _glassSFXArray);
            _local_9.addExplosionClip(_stage.busStop.rightExplosion_mc);
            var _local_5 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.busStop.topGlass, _stage.destructibleTriggers_mc.busStopTopTrigger_mc, _glassSFXArray);
            var _local_4 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.busStop.bottomGlass, _stage.destructibleTriggers_mc.busStopBottomTrigger_mc, _glassSFXArray);
            var _local_8 = new com.clubpenguin.world.rooms.common.destructibles.DestructibleController(_stage.busBench, _stage.destructibleTriggers_mc.bustStopBenchTrigger_mc, _woodSFXArray);
            _local_5.addExplosionClip(_stage.busStop.topLeftExplosion_mc);
            _local_5.addExplosionClip(_stage.busStop.topRightExplosion_mc);
            _local_4.addExplosionClip(_stage.busStop.bottomLeftExplosion_mc);
            _local_4.addExplosionClip(_stage.busStop.bottomRightExplosion_mc);
            _local_4.addLink(_local_8);
            _local_2.unshift(_local_5);
            _local_2.unshift(_local_4);
            _local_2.unshift(_local_9);
            _local_2.unshift(_local_8);
            _destructibles = new com.clubpenguin.world.rooms.common.destructibles.DestructibleGroup(_local_2, new com.clubpenguin.world.rooms.common.destructibles.DestructibleSoundManager(_stage));
        }
        function clockTimer() {
            var _local_6 = 0;
            var _local_5 = 11;
            var _local_2 = 12;
            _now.setTime(_now.getTime() + ONE_SECOND);
            if (_ct_minutes != _now.getMinutes()) {
                _ct_minutes = _now.getMinutes();
                if (_ct_hours != _now.getMinutes()) {
                    _ct_hours = _now.getHours();
                    if (_ct_hours > _local_5) {
                        _pm_trigger = true;
                        if ((_ct_hours > _local_2) && (!IS_24_HOUR_CLOCK)) {
                            _ct_hours = _ct_hours - _local_2;
                        }
                    } else {
                        _pm_trigger = false;
                        if ((_ct_hours == _local_6) && (!IS_24_HOUR_CLOCK)) {
                            _ct_hours = _local_2;
                        }
                    }
                    if (!IS_24_HOUR_CLOCK) {
                        if (_pm_trigger) {
                            _stage.clocktower.am_pm.text = "PM";
                        } else {
                            _stage.clocktower.am_pm.text = "AM";
                        }
                    } else {
                        _stage.clocktower.am_pm.text = "";
                    }
                    if (_ct_day != _now.getDay()) {
                        var _local_4;
                        _ct_day = _now.getDay();
                        _local_4 = _daysOfTheWeek[_ct_day];
                        _today = _SHELL.getLocalizedString(_local_4);
                    }
                }
                _stage.pricelessEntrance.clock.day_mc.label_txt.text = _today.toUpperCase();
                if (IS_24_HOUR_CLOCK) {
                    var _local_3 = new TextFormat();
                    _local_3.size = 10;
                    _stage.clocktower.day_txt.setTextFormat(_local_3);
                }
                if (_ct_minutes < 10) {
                    _stage.clocktower.clock_txt.text = (_ct_hours + ":0") + _ct_minutes;
                } else {
                    _stage.clocktower.clock_txt.text = (_ct_hours + ":") + _ct_minutes;
                }
            }
        }
        function onSnowballLand(snowballInfo) {
            if (_stage.clocktower.tower.target.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                _stage.clocktower.tower.play();
                snowballInfo.snowballMC._visible = false;
                _clockTargetHits++;
                if (_clockTargetHits >= TARGET_STAMP_THRESHOLD) {
                    _clockTargetHits = 0;
                    _SHELL.stampEarned(TARGET_STAMP_ID);
                }
            }
        }
		function playLiveEvent() {
     	   _stage.stuff_mc.gotoAndStop(2);
     	   _global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        function showCatalog(catalogName) {
            _INTERFACE.showContent(catalogName);
        }
        function destroy() {
            clearInterval(_secondCheckIntervalID);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.BALL_LAND, _checkClockTagetDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
            wem.destroy();
        }
        static var CLASS_NAME = "Forts";
        static var ONE_SECOND = 1000;
        static var TARGET_STAMP_ID = 13;
        static var TARGET_STAMP_THRESHOLD = 10;
        var _daysOfTheWeek = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];
        var _clockTargetHits = 0;
    }
