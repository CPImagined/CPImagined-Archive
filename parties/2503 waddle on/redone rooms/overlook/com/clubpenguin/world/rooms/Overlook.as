//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Overlook extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _SHELL, tourCannon, _destroyDelegate, _triggerWatcher, _liveEvent, _triggerWatcherInterval, setupNavigationButtons, _INTERFACE, _cannonTrigger, _roomUpdateInterval, _handlePlayerFrameDelegate;
        function Overlook (stageReference) {
            super(stageReference);
            _stage.start_x = 260;
            _stage.start_y = 300;
            localize([]);
            if (!_SHELL) {
                init();
            }
        }
        function handlePlayerExit(player_id) {
            var _local_3 = _stage.cannon_mc.cannonAnimation_mc;
            var _local_2 = 0;
            while (_local_2 < tourCannon.playersOnCannon.length) {
                if (tourCannon.playersOnCannon[_local_2] == player_id) {
                    if ((_local_3._currentframe == 1) || (_local_3._currentframe == 140)) {
                        tourCannon.playCannonAnimation();
                    }
                    tourCannon.playersOnCannon.splice(_local_2, 1);
                    return(undefined);
                }
                _local_2++;
            }
        }
        function init() {
            var _local_2 = com.clubpenguin.util.Delegate.create(this, handlePlayerExit);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _local_2);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureCannon();
			_liveEvent = com.clubpenguin.util.Delegate.create(this, playLiveEvent);
			_global.getCurrentAirtower().addListener("liveevent", _liveEvent);
            //_stage.centre_btn.useHandCursor = false;
			//_stage.balloon_mc.tour_btn.useHandCursor = false;
			//_stage.cannon_mc.cannon_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.centre_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "centre", 374, 371);
			_stage.triggers_mc.tour_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showBalloonOops);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
		function showBalloonOops() {
			showContent("tourBalloonOops")
		}
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cannon_mc.cannon_btn, 263, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.centre_btn, 618, 273), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.balloon_mc.tour_btn, 403, 214)]);
        }
        function configureCannon() {
            tourCannon = new com.clubpenguin.world.rooms.hotel.hotelroof.TourCannon(_stage.cannon_mc);
            _cannonTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.cannon_mc);
            _cannonTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(tourCannon, tourCannon.accessCannon));
            _cannonTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(tourCannon, tourCannon.playersRemovedFromCannon));
            _triggerWatcher.addTrigger(_cannonTrigger);
            if (_SHELL.isItemInMyInventory(428)) {
                _stage.background_mc.cannonStatus_mc.gotoAndStop("available");
            } else {
                _stage.background_mc.cannonStatus_mc.gotoAndStop("unavailable");
            }
        }
		function playLiveEvent() {
     	   _stage.background_mc.thing_mc.gotoAndPlay(2);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
			_global.getCurrentAirtower().removeListener("liveevent", _liveEvent);
        }
        static var CLASS_NAME = "Overlook";
    }
