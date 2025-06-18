//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.destructibles.DestructibleGroup
    {
        var _destructibles, _soundManager, _shell, _engine, _enabled, _roomDestroyedDelegate, _snowballLandDelegate, _playerFrameDelegate, _delayedRobotHitCheckID, __get__soundManager;
        function DestructibleGroup (destructibles, soundManager) {
            _destructibles = destructibles.slice();
            _soundManager = soundManager;
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _enabled = true;
            _roomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _snowballLandDelegate = com.clubpenguin.util.Delegate.create(this, handleSnowballLand);
            _playerFrameDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerFrame);
            _shell.addListener(_shell.BALL_LAND, _snowballLandDelegate);
            _shell.addListener(_shell.ROOM_DESTROYED, _roomDestroyedDelegate);
            _shell.addListener(_shell.PLAYER_FRAME, _playerFrameDelegate);
            var _local_3 = 0;
            while (_local_3 < _destructibles.length) {
                _destructibles[_local_3].soundManager = soundManager;
                _local_3++;
            }
        }
        function handleSnowballLand(snowballInfo) {
            if (!_enabled) {
                return(undefined);
            }
            var _local_2 = 0;
            while (_local_2 < _destructibles.length) {
                if (_destructibles[_local_2].checkTriggerHit(snowballInfo)) {
                    trace(("DestructibleGroup destructible[" + _destructibles[_local_2]._trigger) + "] is hit by snowball");
                    break;
                }
                _local_2++;
            }
        }
        function handlePlayerFrame(event) {
            if (!_enabled) {
                return(undefined);
            }
            clearTimeout(_delayedRobotHitCheckID);
            var _local_2 = event.player_id;
            var _local_3 = event.frame;
            var _local_4 = _shell.getPlayerObjectById(_local_2);
            if ((_local_3 == _shell.DANCE_FRAME) && (com.clubpenguin.world.rooms2013.superhero.SuperHeroParty.instance.isRobotEquipped(_local_2))) {
                _delayedRobotHitCheckID = setTimeout(com.clubpenguin.util.Delegate.create(this, delayedRobotHitCheck, _local_4), ROBOT_HIT_CHECK_DELAY);
            }
        }
        function delayedRobotHitCheck(player) {
            var _local_2 = 0;
            while (_local_2 < _destructibles.length) {
                if (_destructibles[_local_2].checkAreaOfEffectHit(ROBOT_X_OFFSET + player.x, ROBOT_Y_OFFSET + player.y, AREA_OF_EFFECT_RADIUS)) {
                    trace(("DestructibleGroup destructible[" + _destructibles[_local_2]._trigger) + "] is hit by area of effect");
                }
                _local_2++;
            }
        }
        function addDestructible(destructible) {
            _destructibles.push(destructible);
        }
        function addDestructiblesArray(destructibles) {
            var _local_2 = 0;
            while (_local_2 < destructibles.length) {
                addDestructible(destructibles[_local_2]);
                _local_2++;
            }
        }
        function removeDestructible(destructible) {
            var _local_2 = 0;
            while (_local_2 < _destructibles.length) {
                if (_destructibles[_local_2] == destructible) {
                    _destructibles.splice(_local_2, 1);
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function removeAllDestructibles() {
            _destructibles = [];
        }
        function get destructibles() {
            return(_destructibles.splice());
        }
        function getNumberDestroyed() {
            var _local_3;
            var _local_2 = 0;
            while (_local_2 < _destructibles.length) {
                if (_destructibles[_local_2].isDestroyed) {
                    _local_3++;
                }
                _local_2++;
            }
            return(_local_3);
        }
        function set soundManager(manager) {
            if (manager != null) {
                _soundManager = manager;
            } else {
                _soundManager = new com.clubpenguin.world.rooms.common.destructibles.DestructibleSoundManager();
            }
            //return(__get__soundManager());
        }
        function enable() {
            _enabled = true;
        }
        function disable() {
            _enabled = false;
        }
        function destroy() {
            _shell.removeListener(_shell.ROOM_DESTROYED, _roomDestroyedDelegate);
            _shell.removeListener(_shell.BALL_LAND, _snowballLandDelegate);
            _shell.removeListener(_shell.PLAYER_FRAME, _playerFrameDelegate);
            clearTimeout(_delayedRobotHitCheckID);
        }
        static var AREA_OF_EFFECT_RADIUS = 50;
        static var ROBOT_HIT_CHECK_DELAY = 900;
        static var ROBOT_X_OFFSET = 89;
        static var ROBOT_Y_OFFSET = 0;
    }
