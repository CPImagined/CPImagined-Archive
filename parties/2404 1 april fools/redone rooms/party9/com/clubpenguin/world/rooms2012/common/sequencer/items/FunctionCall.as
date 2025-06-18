//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.items.FunctionCall implements com.clubpenguin.world.rooms2012.common.sequencer.items.ISequenceItem
    {
        var _obj, _func, _args, _id;
        function FunctionCall (obj, func, args, delay) {
            _obj = obj;
            _func = func;
            _args = args;
            _id = com.clubpenguin.world.rooms2012.common.UniqueID.getID("FunctionCall");
            if (delay) {
                _delay = delay * 1000;
            }
        }
        function getID() {
            return(null);
        }
        function getName() {
            return(null);
        }
        function update() {
            if (_lastTime < 0) {
                _lastTime = getTimer();
            } else {
                var _local_2 = getTimer();
                _time = _time + (_local_2 - _lastTime);
                _lastTime = _local_2;
            }
            if (_time <= _delay) {
                return(undefined);
            }
            if (_args != null) {
                _obj[_func].apply(_obj, _args);
            } else {
                _obj[_func].apply(_obj);
            }
            return(true);
        }
        function toString() {
            if (_args) {
                return(((((("<Function obj=\"" + _obj) + "\" function=\"") + _func) + "\" _args=\"") + _args) + "\" />");
            }
            return(((("<Function obj=\"" + _obj) + "\" function=\"") + _func) + "\" />");
        }
        function toXML() {
            return(null);
        }
        var _lastTime = -1;
        var _time = 0;
        var _delay = 0;
    }
