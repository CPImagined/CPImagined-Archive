//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.aprilfools.Escher extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, hideRoomElements, setupNavigationButtons, _SHELL, _destroyDelegate;
        function Escher (stageReference) {
            super();
            _stage = stageReference;
            hideRoomElements();
            _stage.start_x = 375;
            _stage.start_y = 250;
            _stage.invertedPenguins = true;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.boxBtn, 372, 292)]);
            _stage.triggers_mc.boxDimension.triggerFunction = com.clubpenguin.util.Delegate.create(this, exitPortal);
        }
        function exitPortal() {
            _SHELL.sendJoinRoom("boxdimension", 287, 174);
        }
        function init() {
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        static var CLASS_NAME = "Escher";
        static var SCAVENGER_HUNT_ITEM_NUMBER = 5;
    }
