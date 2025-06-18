//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.Rocket
    {
        var _rocket, activated, deactivated, _currentState, _timeOutID;
        function Rocket (rocket) {
            _rocket = rocket;
            activated = new org.osflash.signals.Signal();
            deactivated = new org.osflash.signals.Signal();
        }
        function init() {
            _rocket.gotoAndStop(IDLE);
        }
        function onPenguinTriggerUpdate(playerID, listOfPlayersOnTrigger) {
            if (listOfPlayersOnTrigger.length == 0) {
                changeState(STATE_IDLE);
            } else {
                changeState(STATE_TARGET_READY);
            }
        }
        function checkIfHitBySnowball(snowBall) {
            if ((_currentState == STATE_TARGET_READY) || (_currentState == STATE_ACTIVATED)) {
                if (_rocket.targetArm.target.hitTest(snowBall._x, snowBall._y, true)) {
                    startTimeout();
                    changeState(STATE_ACTIVATED);
                    return(true);
                }
            }
            return(false);
        }
        function startTimeout() {
            clearInterval(_timeOutID);
            _timeOutID = setInterval(this, "onTimeout", ACTIVE_TIMEOUT);
        }
        function onTimeout() {
            clearInterval(_timeOutID);
            changeState(STATE_TARGET_READY);
        }
        function changeState(newState) {
            if (_currentState == newState) {
                return(undefined);
            }
            var _local_3 = _currentState;
            _currentState = newState;
            switch (newState) {
                case STATE_TARGET_READY : 
                    if (_local_3 == STATE_ACTIVATED) {
                        _rocket.gotoAndStop(ROCKETS_TARGET_HIT);
                        deactivated.dispatch();
                    } else {
                        _rocket.gotoAndStop(ROCKETS_TARGET_UP);
                    }
                    break;
                case STATE_ACTIVATED : 
                    _rocket.gotoAndStop(ROCKETS_ON);
                    activated.dispatch();
                    break;
                case STATE_IDLE : 
                    clearInterval(_timeOutID);
                    _rocket.gotoAndStop(ROCKETS_OFF);
                    deactivated.dispatch();
                    break;
            }
        }
        function isOn() {
            return(_currentState == STATE_ACTIVATED);
        }
        static var STATE_IDLE = "stateIdle";
        static var STATE_TARGET_READY = "targetReady";
        static var STATE_ACTIVATED = "activated";
        static var IDLE = "park";
        static var ROCKETS_TARGET_UP = "targetUp";
        static var ROCKETS_TARGET_HIT = "hit";
        static var ROCKETS_ON = "on";
        static var ROCKETS_OFF = "off";
        var ACTIVE_TIMEOUT = 5000;
    }
