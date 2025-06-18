//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.Desert extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, localize, setupNavigationButtons, savedPlayerX, _SHELL, _currentPlayerClip, _ENGINE, _xMatchDelegate, _destroyDelegate, _INTERFACE;
        function Desert (stageReference) {
            super();
            trace("Desert()");
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 115;
            _stage.start_y = 290;
            localize([_stage.shop_mc.text_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boxTint.boxBtn, 37, 306)]);
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPortal);
            savedPlayerX = _stage.start_x;
        }
        function exitPortal() {
            trace("Desert: exitPortal()");
            _SHELL.sendJoinRoom("boxdimension", 370, 130);
        }
        function init() {
            trace("Desert: init()");
            var _local_2 = _SHELL.getMyPlayerObject();
            _currentPlayerClip = _ENGINE.getPlayerMovieClip(_local_2.player_id);
            _xMatchDelegate = com.clubpenguin.util.Delegate.create(this, xMatch);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _stage.onEnterFrame = _xMatchDelegate;
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.shop_mc.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
            _stage.interface_mc.box_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _stage.onEnterFrame = null;
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function showPartyCatalog() {
            _INTERFACE.showContent("w.p.catalog.loading", null, _INTERFACE.getFilePath("w.p0412.aprilfools.catalog"));
        }
        function xMatch() {
            trace("Desert: xMatch()");
            var _local_2 = _currentPlayerClip._x;
            _stage.background_mc.sunMoon.gotoAndStop(_local_2);
            _stage.background_mc.night.gotoAndStop(_local_2);
            _stage.boxTint.gotoAndStop(_local_2);
            _stage.cactusOne.gotoAndStop(_local_2);
            _stage.cactusTwo.gotoAndStop(_local_2);
            savedPlayerX = _local_2;
        }
        static var CLASS_NAME = "Desert";
        static var SCAVENGER_HUNT_ITEM_NUMBER = 1;
    }
