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
            for (var n in _stageReference) {
                if (_stageReference[n].environmentType) {
                    _environmentMovieClips.push(_stageReference[n]);
                }
            }
        }
        function checkTriggers(player_obj) {
            var i = 0;
            while (i < _environmentMovieClips.length) {
                var puffleClip = _ENGINE.puffleAvatarController.getPuffleClip(player_obj.attachedPuffle.id);
                if (puffleClip && (_environmentMovieClips[i].hitTest(puffleClip._x, puffleClip._y, true))) {
                    var roomBehavior = _roomBehaviorFactory.getRoomBehavior(_environmentMovieClips[i].environmentType);
                    roomBehavior.applyEffect(player_obj.player_id);
                }
                i++;
            }
        }
        function onPlayerMoveDone(player_obj) {
            if (player_obj.attachedPuffle) {
                checkTriggers(player_obj);
            }
        }
        function checkHitTestWithEnvironmentMC(targetMC) {
            var i = 0;
            while (i < _environmentMovieClips.length) {
                if (_environmentMovieClips[i].hitTest(targetMC._x, targetMC._y, true)) {
                    return(true);
                }
                i++;
            }
            return(false);
        }
    }
