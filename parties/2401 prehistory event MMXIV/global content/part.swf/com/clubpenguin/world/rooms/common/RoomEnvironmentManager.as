
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.RoomEnvironmentManager
    {
        var _stageReference, _SHELL, _ENGINE, _roomBehaviorFactory, _playerMoveDoneFunc, _environmentMovieClips;
        function RoomEnvironmentManager (_arg_4, _arg_2, _arg_3) {
            _stageReference = _arg_4;
            _SHELL = _arg_2;
            _ENGINE = _arg_3;
            _roomBehaviorFactory = com.clubpenguin.world.rooms.common.behaviors.RoomBehaviorFactory.getInstance();
            _playerMoveDoneFunc = com.clubpenguin.util.Delegate.create(this, onPlayerMoveDone);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneFunc);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerMoveDoneFunc);
        }
        function setupEnvironmentTriggers() {
            _environmentMovieClips = new Array();
            searchForEnvironmentMovieClips();
        }
        function searchForEnvironmentMovieClips() {
            for (var _local_2 in _stageReference) {
                if (_stageReference[_local_2].environmentType) {
                    _environmentMovieClips.push(_stageReference[_local_2]);
                }
            }
        }
        function checkTriggers(_arg_5) {
            var _local_2 = 0;
            while (_local_2 < _environmentMovieClips.length) {
                var _local_3 = _ENGINE.puffleAvatarController.getPuffleClip(_arg_5.attachedPuffle.id);
                if (_local_3 && (_environmentMovieClips[_local_2].hitTest(_local_3._x, _local_3._y, true))) {
                    var _local_4 = _roomBehaviorFactory.getRoomBehavior(_environmentMovieClips[_local_2].environmentType);
                    _local_4.applyEffect(_arg_5.player_id);
                }
                _local_2++;
            }
        }
        function onPlayerMoveDone(_arg_2) {
            if (_arg_2.attachedPuffle) {
                checkTriggers(_arg_2);
            }
        }
        function checkHitTestWithEnvironmentMC(_arg_3) {
            var _local_2 = 0;
            while (_local_2 < _environmentMovieClips.length) {
                if (_environmentMovieClips[_local_2].hitTest(_arg_3._x, _arg_3._y, true)) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
    }
