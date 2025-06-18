//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.CovePond extends com.clubpenguin.world.rooms.Cove
    {
        var _stage, localize, _SHELL, _destroyDelegate, _INTERFACE, _currentTime, _secondCheckIntervalID, _ct_minutes;
        function CovePond (stageReference) {
            super(stageReference);
            _stage = stageReference;
            _stage.start_x = 420;
            _stage.start_y = 240;
            localize([_stage.covehut_mc.surfsign_states]);
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
            if (_SHELL.getPenguinStandardTime != undefined) {
                _currentTime = _SHELL.getPenguinStandardTime();
            } else {
                _currentTime = new Date();
            }
            _secondCheckIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, secondCheck), ONE_SECOND);
            secondCheck();
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_secondCheckIntervalID);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function secondCheck() {
            _currentTime.setTime(_currentTime.getTime() + ONE_SECOND);
            if (_ct_minutes != _currentTime.getMinutes()) {
                _stage.bigFish.play();
                _ct_minutes = _currentTime.getMinutes();
            }
        }
        static var CLASS_NAME = "CovePond";
        static var ONE_SECOND = 1000;
    }
