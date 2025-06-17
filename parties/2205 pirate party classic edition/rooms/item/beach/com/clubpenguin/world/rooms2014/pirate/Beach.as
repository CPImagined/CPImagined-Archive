//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Beach extends com.clubpenguin.world.rooms.BasePartyRoom
    {
        var _stage, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate, wem;
        function Beach (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 200;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.light_btn, 190, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_btn, 568, 195), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lighthouseDoor_mc.light_btn, 190, 210)]);
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 230, 180);
			_stage.triggers_mc.chest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, chest);
        }
		function chest() {
            _INTERFACE.showContent("piratechestbeach");
        }
        function bucketAnimate() {
            _stage.bucket_mc.play();
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            var _local_3 = _SHELL.getMascotOptions();
            if (_local_3.migrator_active) {
                _stage.background_mc.background2_mc.ship_mc._visible = true;
                _stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "ship", 440, 300);
            } else {
                _stage.background_mc.background2_mc.ship_mc._visible = false;
            }
            wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(_SHELL, _stage.background_mc);
            wem.setupFireAnimationHeight(45);
            wem.setupRainAnimationHeight(70);
            wem.setupSnowAnimationHeight(70);
            wem.setupRainAnimationSpeed(0.4);
            wem.setupSnowAnimationSpeed(0.8);
            wem.setupRainDelayTime(2);
            wem.setupSnowDelayTime(2);
            wem.startWeatherEffectCheck();
			showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.party_cat_btn, true, "party_catalogue", "")]);
            _stage.lighthouseDoor_mc.light_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, rollOverDoor);
            _stage.lighthouseDoor_mc.light_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, rollOutDoor);
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function initializePartyCookieDependentAssets() {
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function rollOverDoor() {
            _stage.lighthouseDoor_mc.gotoAndStop(2);
        }
        function rollOutDoor() {
            _stage.lighthouseDoor_mc.gotoAndStop(1);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            wem.destroy();
        }
        static var CLASS_NAME = "Beach";
    }
