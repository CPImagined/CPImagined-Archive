//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.IceOnDeck
    {
        var _startY, _startX, _mc, _healthStates, _hitPoints, _currentState;
        function IceOnDeck (mc, startX, startY) {
            _startY = startY;
            _startX = startX;
            _mc = mc;
            _healthStates = [ICE_GONE, WATER_4, WATER_3, WATER_2, WATER_1, ICE_BLOCK_5, ICE_BLOCK_4, ICE_BLOCK_3, ICE_BLOCK_2];
            changeState(STATE_IDLE);
        }
        function update() {
        }
        function placeIceOnDeck() {
            changeState(STATE_APPEAR);
            _mc._x = _startX;
            _mc._y = _startY;
        }
        function remove() {
            _hitPoints--;
            if (_hitPoints >= 0) {
                _mc.gotoAndStop(_healthStates[_hitPoints]);
            } else {
                changeState(STATE_DESTROYED);
            }
        }
        function reset() {
            changeState(STATE_IDLE);
        }
        function changeState(newState) {
            if (_currentState == newState) {
                return(undefined);
            }
            _currentState = newState;
            switch (newState) {
                case STATE_IDLE : 
                    _mc.gotoAndStop(ICE_IDLE);
                    _hitPoints = MAX_HIT_POINTS;
                    break;
                case STATE_APPEAR : 
                    _mc.gotoAndStop(ICE_BLOCK_FALL_ON_DECK);
                    break;
                case STATE_DESTROYED : 
                    reset();
                    break;
            }
        }
        static var STATE_IDLE = "stateIdle";
        static var STATE_APPEAR = "appear";
        static var STATE_ICE = "ice";
        static var STATE_WATER = "water";
        static var STATE_DESTROYED = "gone";
        static var ICE_IDLE = "park";
        static var ICE_BLOCK_FALL_ON_DECK = "one";
        static var ICE_BLOCK_2 = "two";
        static var ICE_BLOCK_3 = "three";
        static var ICE_BLOCK_4 = "four";
        static var ICE_BLOCK_5 = "five";
        static var WATER_1 = "six";
        static var WATER_2 = "seven";
        static var WATER_3 = "eight";
        static var WATER_4 = "nine";
        static var ICE_GONE = "ten";
        static var MAX_HIT_POINTS = 8;
        static var RESPAWN_TIMEOUT_MAX = 6000;
    }
