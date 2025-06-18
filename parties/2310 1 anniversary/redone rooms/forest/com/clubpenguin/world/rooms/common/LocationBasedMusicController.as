//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.LocationBasedMusicController
    {
        var _SHELL, _interactiveMusic, _triggers, _visuals, _musicCheckDelegate, _handleRoomDestroyedDelegate;
        function LocationBasedMusicController (SHELL, interactiveMusic, triggers, visuals) {
            trace("LocationBasedMusicController()");
            if ((interactiveMusic.tracksAmount != triggers.length) or (interactiveMusic.tracksAmount != visuals.length)) {
                trace((("\tERROR interactiveMusic.tracksAmount != triggers.length: " + interactiveMusic.tracksAmount) + " != ") + triggers.length);
                trace("\tor");
                trace((("\tERROR interactiveMusic.tracksAmount != visuals.length: " + interactiveMusic.tracksAmount) + " != ") + visuals.length);
            }
            _SHELL = SHELL;
            _interactiveMusic = interactiveMusic;
            _triggers = triggers;
            _visuals = visuals;
            var _local_2 = 0;
            while (_local_2 < interactiveMusic.tracksAmount) {
                _penguinsOnTrigger[_local_2] = 0;
                _songsPlaying[_local_2] = false;
                _local_2++;
            }
            _musicCheckDelegate = com.clubpenguin.util.Delegate.create(this, musicTriggerCheck);
            _handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
            setupListeners();
            musicTriggerCheck();
        }
        function setupListeners() {
            trace("LocationBasedMusicController: setupListeners()");
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _musicCheckDelegate);
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, _musicCheckDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
        }
        function handleRoomDestroyed() {
            trace("LocationBasedMusicController: handleRoomDestroyed()");
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _musicCheckDelegate);
            _SHELL.removeListener(_SHELL.REMOVE_PLAYER, _musicCheckDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
        }
        function musicTriggerCheck() {
            trace("LocationBasedMusicController: removePlayerFromTriggerCheck()");
            var _local_4 = _SHELL.getPlayerList();
            var _local_3 = 0;
            while (_local_3 < _interactiveMusic.tracksAmount) {
                _penguinsOnTrigger[_local_3] = 0;
                var _local_2 = 0;
                while (_local_2 < _local_4.length) {
                    if (_triggers[_local_3].hitTest(_local_4[_local_2].x, _local_4[_local_2].y, true)) {
                        _penguinsOnTrigger[_local_3] = _penguinsOnTrigger[_local_3] + 1;
                        break;
                    }
                    _local_2++;
                }
                _local_3++;
            }
            songCheck();
        }
        function songCheck() {
            trace("LocationBasedMusicController: songCheck()");
            var _local_2 = 0;
            while (_local_2 < _interactiveMusic.tracksAmount) {
                if ((!_songsPlaying[_local_2]) and (_penguinsOnTrigger[_local_2] > 0)) {
                    _songsPlaying[_local_2] = true;
                    _visuals[_local_2].gotoAndStop("play");
                    _interactiveMusic.unMuteTrack(_local_2);
                } else if (_songsPlaying[_local_2] and (_penguinsOnTrigger[_local_2] == 0)) {
                    _songsPlaying[_local_2] = false;
                    _visuals[_local_2].gotoAndStop("park");
                    _interactiveMusic.muteTrack(_local_2);
                }
                _local_2++;
            }
        }
        var COUNTER_INDEX = 0;
        var _penguinsOnTrigger = [];
        var _songsPlaying = [];
    }
