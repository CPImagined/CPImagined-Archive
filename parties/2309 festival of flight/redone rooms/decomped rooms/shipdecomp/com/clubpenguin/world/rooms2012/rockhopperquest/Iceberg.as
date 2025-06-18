//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.Iceberg
    {
        var _endX, _startX, _mc, destroyed, _currentState, _lastUpdate, _speed, _respawnTimeout, _hitPoints;
        function Iceberg (mc, startX, endX) {
            _endX = endX;
            _startX = startX;
            _mc = mc;
            destroyed = new org.osflash.signals.Signal();
            changeState(STATE_IDLE);
        }
        function update() {
            if (_currentState == STATE_MOVING_IN) {
                if (_lastUpdate == -1) {
                    _lastUpdate = getTimer();
                    return(undefined);
                }
                var _local_3 = getTimer();
                var _local_2;
                var _local_4 = ((_local_3 - _lastUpdate) / 1000) * _speed;
                _local_2 = _mc._x - _local_4;
                if (_local_2 <= _endX) {
                    _local_2 = _endX;
                    changeState(STATE_ATTACKING);
                }
                _mc._x = _local_2;
                _lastUpdate = getTimer();
            }
        }
        function attack() {
            changeState(STATE_MOVING_IN);
        }
        function isAttacking() {
            return(_currentState == STATE_ATTACKING);
        }
        function takeDamage() {
        }
        function reset() {
            changeState(STATE_IDLE);
        }
        function setSpeed(newSpeed) {
            _speed = newSpeed;
        }
        function changeState(newState) {
            if (_currentState == newState) {
                return(undefined);
            }
            _currentState = newState;
            switch (newState) {
                case STATE_IDLE : 
                    clearInterval(_respawnTimeout);
                    _mc._x = _startX;
                    _lastUpdate = -1;
                    _mc.gotoAndStop(ICEBERG_NONE);
                    _hitPoints = 3;
                    _speed = 0;
                    break;
                case STATE_MOVING_IN : 
                    _mc.gotoAndStop(ICEBERG_LARGE);
                    setSpeed(200);
                    break;
                case STATE_ATTACKING : 
                    _mc.gotoAndStop(ICEBERG_SMASH);
                    changeState(STATE_DESTROYED);
                    break;
                case STATE_DESTROYED : 
                    _lastUpdate = -1;
                    _hitPoints = 3;
                    _speed = 0;
                    _mc._x = _startX;
                    clearInterval(_respawnTimeout);
                    destroyed.dispatch();
                    break;
            }
        }
        static var STATE_IDLE = "stateIdle";
        static var STATE_MOVING_IN = "movingInToPosition";
        static var STATE_ATTACKING = "attacking";
        static var STATE_DESTROYED = "destroyed";
        static var ICEBERG_LARGE = "large";
        static var ICEBERG_MEDIUM = "medium";
        static var ICEBERG_SMALL = "small";
        static var ICEBERG_NONE = "park";
        static var ICEBERG_SMASH = "smash";
        static var RESPAWN_TIMEOUT_MAX = 6000;
    }
