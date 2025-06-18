//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Town extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, localize, _destroyDelegate, setupNavigationButtons, _abductionDelegate, aliendAbduction, _INTERFACE;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 270;
            _stage.start_y = 350;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            localize([_stage.background_mc.coffeeshop_mc.coffeeshopsign_mc, _stage.background_mc.nightclub_mc.nightclubsign_mc, _stage.background_mc.giftshop_mc.giftshopsign_mc, _stage.coinsForChange_mc.text_mc]);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 658, 239);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 51, 204);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 575, 195);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 115, 280);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 355, 180);
			_stage.triggers_mc.welcome_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party12", 197, 301);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffee_btn, 212, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dance_btn, 374, 248), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shop_btn, 540, 264)]);
            _abductionDelegate = com.clubpenguin.util.Delegate.create(this, abductPenguin);
            _global.getCurrentAirtower().addListener("beamup", _abductionDelegate);
        }
        function abductPenguin(data) {
            var _local_4 = data[1];
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_local_4);
            _stage.attachMovie("TractorBeam", "tractorBeam_mc", _stage.getNextHighestDepth());
            _stage.tractorBeam_mc.swapDepths(_local_3);
            _stage.tractorBeam_mc._x = _local_3._x;
            _stage.tractorBeam_mc._y = _local_3._y - 1;
            aliendAbduction = new com.clubpenguin.world.rooms.aliens.AlienAbduction();
            aliendAbduction.abductPlayer(_local_4, _stage, this);
        }
        function abductedPlayerGoToUFO(player_id) {
            _stage.tractorBeam_mc.removeMovieClip();
            if (_SHELL.isMyPlayer(player_id)) {
                _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
                _abductionDelegate = null;
                _SHELL.sendJoinRoom("ufo", 380, 320);
            }
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener("beamup", _abductionDelegate);
            _abductionDelegate = null;
        }
        static var CLASS_NAME = "Town";
    }
