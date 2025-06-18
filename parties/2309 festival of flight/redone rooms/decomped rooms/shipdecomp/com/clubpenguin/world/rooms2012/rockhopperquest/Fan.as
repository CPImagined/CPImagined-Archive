//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.rockhopperquest.Fan
    {
        var _fanBlades, _fanTarget, _sail, activated, deactivated, _currentState, _timeOutID;
        function Fan (fanBlades, fanTarget, sail) {
            _fanBlades = fanBlades;
            _fanTarget = fanTarget;
            _sail = sail;
            activated = new org.osflash.signals.Signal();
            deactivated = new org.osflash.signals.Signal();
        }
        function init() {
            _fanBlades.gotoAndStop(IDLE);
            _fanTarget.gotoAndStop(IDLE);
            _sail.gotoAndStop(IDLE);
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
                if (_fanTarget.hitTest(snowBall._x, snowBall._y, true)) {
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
                        _fanBlades.gotoAndStop(FAN_OFF);
                        _sail.gotoAndStop(SAIL_DOWN);
                        _fanTarget.gotoAndStop(FAN_TARGET_HIT);
                        deactivated.dispatch();
                    } else {
                        _fanTarget.gotoAndStop(FAN_TARGET_ON);
                    }
                    break;
                case STATE_ACTIVATED : 
                    _fanBlades.gotoAndStop(FAN_ON);
                    _fanTarget.gotoAndStop(FAN_TARGET_HIT);
                    _sail.gotoAndStop(SAIL_UP);
                    activated.dispatch();
                    break;
                case STATE_IDLE : 
                    clearInterval(_timeOutID);
                    _fanBlades.gotoAndStop(FAN_OFF);
                    _sail.gotoAndStop(SAIL_DOWN);
                    _fanTarget.gotoAndStop(FAN_TARGET_OFF);
                    deactivated.dispatch();
                    break;
            }
        }
        function isOn() {
            return(_currentState == STATE_ACTIVATED);
        }
        static var IDLE = "park";
        static var FAN_ON = "on";
        static var FAN_RUNNING = "rotate";
        static var FAN_OFF = "off";
        static var FAN_TARGET_ON = "up";
        static var FAN_TARGET_HIT = "hit";
        static var FAN_TARGET_OFF = "down";
        static var SAIL_UP = "sailUp";
        static var SAILING = "sail";
        static var SAIL_DOWN = "sailDown";
        static var STATE_IDLE = "stateIdle";
        static var STATE_TARGET_READY = "targetReady";
        static var STATE_ACTIVATED = "activated";
        var ACTIVE_TIMEOUT = 2000;
    }
