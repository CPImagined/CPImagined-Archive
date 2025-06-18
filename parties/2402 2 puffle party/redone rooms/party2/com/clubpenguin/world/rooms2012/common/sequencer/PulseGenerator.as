//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator
    {
        var _sequencer, _timerType, _timerHolder, _intervalID;
        function PulseGenerator (sequencer, timerType, timerHolder, timerRate) {
            _sequencer = sequencer;
            _timerType = timerType;
            _timerHolder = timerHolder.createEmptyMovieClip("timer", timerHolder.getNextHighestDepth());
            if (timerRate) {
                _timerRate = timerRate;
            }
        }
        function start() {
            if (!_isRunning) {
                switch (_timerType) {
                    case FRAME_BASED : 
                        _timerHolder.onEnterFrame = com.clubpenguin.util.Delegate.create(this, update);
                        break;
                    case TIMER_BASED : 
                        clearInterval(_intervalID);
                        _intervalID = setInterval(this, "update", _timerRate);
                        break;
                }
                _isRunning = true;
            }
        }
        function stop() {
            if (_isRunning) {
                switch (_timerType) {
                    case FRAME_BASED : 
                        _timerHolder.onEnterFrame = null;
                        break;
                    case TIMER_BASED : 
                        clearInterval(_intervalID);
                        break;
                }
                _isRunning = false;
            }
        }
        function update() {
            _sequencer.update();
        }
        static var FRAME_BASED = "frameBased";
        static var TIMER_BASED = "timerBased";
        var _isRunning = false;
        var _timerRate = 40;
    }
