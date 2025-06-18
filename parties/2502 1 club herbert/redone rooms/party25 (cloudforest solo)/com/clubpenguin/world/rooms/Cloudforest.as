//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Cloudforest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _INTERFACE, _destroyDelegate, _ghostCheckDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Cloudforest (stageReference) {
            super(stageReference);
            _stage.start_x = 315;
            _stage.start_y = 125;
            if (!_SHELL) {
                _INTERFACE = _global.getCurrentInterface();
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.background_mc.exit_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exitMouseOver);
            _stage.background_mc.exit_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exitMouseOff);
            _stage.background_mc.exit_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exitMouseOff);
            _stage.triggers_mc.exit_trigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, promptMap);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.exit_btn, 408, 327)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
			_ghostCheckDelegate = com.clubpenguin.util.Delegate.create(this, checkSkipHit);
            _SHELL.addListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
        }
		function checkSkipHit(snowballInfo) {
            var _local_5 = _SHELL.getPlayerObjectById(snowballInfo.player_id);
            if (!com.clubpenguin.world.rooms2012.halloween.Halloween.isGhostHunter(_local_5) || !_stage.skipSnowball) {
                return(undefined);
            };
            if (_stage.skip_mc.hitTest(snowballInfo.x, snowballInfo.y, true)) {
                if (snowballInfo.player_id == _SHELL.getMyPlayerId()) {
                    _stage.skip_mc.gotoAndStop(3);
                    snowballInfo.snowballMC._visible = false;
                    return(undefined);
                };
            };
        }
        function promptMap() {
            _INTERFACE.showContent("map");
        }
        function exitMouseOver() {
            _stage.background_mc.backgroundchunk1.cloudplatform_mc.waterfallHighlight_mc.gotoAndStop(2);
            _stage.background_mc.backgroundchunk1.rainbowArrow_mc.gotoAndStop(2);
        }
        function exitMouseOff() {
            _stage.background_mc.backgroundchunk1.cloudplatform_mc.waterfallHighlight_mc.gotoAndStop(1);
            _stage.background_mc.backgroundchunk1.rainbowArrow_mc.gotoAndStop(1);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_SHELL.removeListener(_SHELL.BALL_LAND, _ghostCheckDelegate);
        }
        static var CLASS_NAME = "Cloudforest";
        var _canAdoptPuffle = true;
    }
