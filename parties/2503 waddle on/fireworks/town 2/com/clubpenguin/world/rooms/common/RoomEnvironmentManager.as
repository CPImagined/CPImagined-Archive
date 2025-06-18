//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.RoomEnvironmentManager
    {
        var _stageReference, _SHELL, _ENGINE, _roomBehaviorFactory, _playerMoveDoneFunc, _environmentMovieClips;
        function RoomEnvironmentManager (stageReference, shellMC, engineMC) {
            _stageReference = stageReference;
            _SHELL = shellMC;
            _ENGINE = engineMC;
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
        function checkTriggers(player_obj) {
            var _local_2 = 0;
            while (_local_2 < _environmentMovieClips.length) {
                var _local_3 = _ENGINE.puffleAvatarController.getPuffleClip(player_obj.attachedPuffle.id);
                if (_local_3 && (_environmentMovieClips[_local_2].hitTest(_local_3._x, _local_3._y, true))) {
                    var _local_4 = _roomBehaviorFactory.getRoomBehavior(_environmentMovieClips[_local_2].environmentType);
                    _local_4.applyEffect(player_obj.player_id);
                }
                _local_2++;
            }
        }
        function onPlayerMoveDone(player_obj) {
            if (player_obj.attachedPuffle) {
                checkTriggers(player_obj);
            }
        }
        function checkHitTestWithEnvironmentMC(targetMC) {
            var _local_2 = 0;
            while (_local_2 < _environmentMovieClips.length) {
                if (_environmentMovieClips[_local_2].hitTest(targetMC._x, targetMC._y, true)) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
    }
