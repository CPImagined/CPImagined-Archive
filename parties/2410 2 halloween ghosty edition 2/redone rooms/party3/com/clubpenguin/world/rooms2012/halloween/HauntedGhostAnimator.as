//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator
    {
        var _SHELL, _mode, _ghostClips, _delayIntervalIds, _handlePlayerFrameDelegate;
        function HauntedGhostAnimator (ghostClips, mode) {
            _SHELL = _global.getCurrentShell();
            _mode = MODE_PLAY_ALL_DELAYED;
            if (((mode != undefined) && (mode >= 0)) && (mode < NUM_MODES)) {
                _mode = mode;
            }
            _ghostClips = ghostClips;
            _delayIntervalIds = new Array();
            var _local_3 = 0;
            while (_local_3 < _ghostClips.length) {
                _delayIntervalIds.push(-1);
                _local_3++;
            }
            if (_mode != MODE_MANUAL) {
                _handlePlayerFrameDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerFrame);
                _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
                _SHELL.addListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
            }
        }
        function playRandomGhost() {
            playGhost(getRandomGhostIndex());
        }
        function playRandomGhostDelayed() {
            playGhostDelayed(getRandomGhostIndex());
        }
        function playAllGhosts() {
            var _local_2 = 0;
            while (_local_2 < _ghostClips.length) {
                playGhost(_local_2);
                _local_2++;
            }
        }
        function playAllGhostsDelayed() {
            var _local_2 = 0;
            while (_local_2 < _ghostClips.length) {
                playGhostDelayed(_local_2);
                _local_2++;
            }
        }
        function playGhost(ghostIndex) {
            _ghostClips[ghostIndex].play();
            if (_delayIntervalIds[ghostIndex] != -1) {
                clearInterval(_delayIntervalIds[ghostIndex]);
                _delayIntervalIds[ghostIndex] = -1;
            }
        }
        function playGhostDelayed(ghostIndex) {
            if (_delayIntervalIds[ghostIndex] == -1) {
                var _local_3 = Math.random();
                var _local_2 = DELAY_MIN_MILLISECONDS + ((DELAY_MAX_MILLISECONDS - DELAY_MIN_MILLISECONDS) * _local_3);
                _delayIntervalIds[ghostIndex] = setInterval(com.clubpenguin.util.Delegate.create(this, playGhost, ghostIndex), _local_2);
            }
        }
        function getRandomGhostIndex() {
            return(Math.floor(Math.random() * _ghostClips.length));
        }
        function handlePlayerFrame(event) {
            var _local_2 = event.player_id;
            var _local_3 = event.frame;
            var _local_4 = _SHELL.getPlayerObjectById(_local_2);
            if (com.clubpenguin.world.rooms2012.halloween.Halloween.isGhost(_local_4) && (_local_3 == DANCE_FRAME)) {
                switch (_mode) {
                    case MODE_PLAY_ONE_IMMEDIATE : 
                        playRandomGhost();
                        break;
                    case MODE_PLAY_ONE_DELAYED : 
                        playRandomGhostDelayed();
                        break;
                    case MODE_PLAY_ALL_IMMEDIATE : 
                        playAllGhosts();
                        break;
                    case MODE_PLAY_ALL_DELAYED : 
                        playAllGhostsDelayed();
                        break;
                    default : 
                        break;
                }
            }
        }
        function destroy() {
            if (_handlePlayerFrameDelegate != undefined) {
                _SHELL.removeListener(_SHELL.PLAYER_FRAME, _handlePlayerFrameDelegate);
                _handlePlayerFrameDelegate = null;
            }
        }
        static var DELAY_MAX_MILLISECONDS = 1300;
        static var DELAY_MIN_MILLISECONDS = 400;
        static var DANCE_FRAME = 26;
        static var MODE_PLAY_ONE_IMMEDIATE = 0;
        static var MODE_PLAY_ALL_IMMEDIATE = 1;
        static var MODE_PLAY_ONE_DELAYED = 2;
        static var MODE_PLAY_ALL_DELAYED = 3;
        static var MODE_MANUAL = 4;
        static var NUM_MODES = 5;
    }
