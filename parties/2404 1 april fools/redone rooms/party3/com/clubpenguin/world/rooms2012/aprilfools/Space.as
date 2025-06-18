//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.Space extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, localize, _ENGINE, setupNavigationButtons, _SHELL, _INTERFACE, _destroyDelegate;
        function Space (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 480;
            _stage.start_y = 360;
            localize([_stage.shop_mc.text_mc]);
            _stage.easeMethod = _ENGINE.mathEaseFloat;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boxBtn, 555, 415)]);
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPortal);
        }
        function exitPortal() {
            _SHELL.sendJoinRoom("boxdimension", 210, 215);
        }
        function init() {
            _stage.scavPuzzle.starBtn.onRollOver = com.clubpenguin.util.Delegate.create(this, frameAdvance, _stage.scavPuzzle);
            _stage.scavPuzzle.starBtn.useHandCursor = false;
            _stage.background_mc.planetBucket.onPress = com.clubpenguin.util.Delegate.create(this, dragNew, "planet");
            _stage.background_mc.starBucket.onPress = com.clubpenguin.util.Delegate.create(this, dragNew, "star");
            _stage.shop_mc.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
            _stage.interface_mc.box_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
        }
        function showPartyCatalog() {
            _INTERFACE.showContent("w.p.catalog.loading", null, _INTERFACE.getFilePath("w.p0412.aprilfools.catalog"));
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function frameAdvance(clip) {
            clip.play();
        }
        function dragNew(clipName) {
            var _local_5 = -500;
            var _local_6 = {_x:_local_5, _y:_local_5};
            var _local_3;
            this[clipName + "Amount"]++;
            var _local_4 = this[clipName + "Amount"];
            _stage.background_mc.swirl.attachMovie(clipName + _local_4, clipName + _local_4, _stage.background_mc.swirl.getNextHighestDepth(), _local_6);
            _local_3 = _stage.background_mc.swirl[clipName + _local_4];
            _local_3.startDrag(true);
            _local_3.onPress = com.clubpenguin.util.Delegate.create(this, finishDrag, _local_3);
        }
        function finishDrag(clip) {
            clip.stopDrag();
            clip.onPress = null;
            clip.onRollOver = com.clubpenguin.util.Delegate.create(this, frameAdvance, clip);
            clip.useHandCursor = false;
        }
        static var CLASS_NAME = "Space";
        static var SCAVENGER_HUNT_ITEM_NUMBER = 3;
        var planetAmount = 0;
        var starAmount = 0;
    }
