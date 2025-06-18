//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.items.TweenItem implements com.clubpenguin.world.rooms2012.common.sequencer.items.ISequenceItem
    {
        var _obj, _tweenedProperty, _easeFunc, _delay, _beginVal, _finishVal, _extra1, _extra2, _duration, _newVal, _change, _id;
        function TweenItem (vo) {
            if (vo.target == null) {
                throw new Error("TweenItem :: target is null or undefined");
            } else {
                _obj = vo.target;
            }
            if ((vo.prop == null) || (vo.prop == "")) {
                throw new Error("TweenItem :: prop is null, undefined or blank");
            } else {
                _tweenedProperty = vo.prop;
            }
            if (typeof(vo.ease) != "string") {
                throw new Error("TweenItem :: ease parameter must be a string");
            } else {
                _easeFunc = vo.ease;
            }
            if (isNaN(vo.delay) || (vo.delay < 0)) {
                _delay = 0;
            } else {
                _delay = vo.delay * 1000;
            }
            if (isNaN(vo.start)) {
                throw new Error("TweenItem :: start value is not a number");
            } else {
                _beginVal = vo.start;
            }
            if (isNaN(vo.end)) {
                throw new Error("TweenItem :: end value is not a number");
            } else {
                _finishVal = vo.end;
            }
            if (isNaN(vo.extra1)) {
                _extra1 = 0;
            } else {
                _extra1 = vo.extra1;
            }
            if (isNaN(vo.extra2)) {
                _extra2 = 0;
            } else {
                _extra2 = vo.extra2;
            }
            if (!isNaN(vo.velocity)) {
                _duration = Math.round(((_beginVal - _finishVal) / vo.velocity) * 1000);
            } else if (isNaN(vo.time)) {
                throw new Error("TweenItem :: time is not a number");
            } else {
                _duration = vo.time * 1000;
            }
            _newVal = _beginVal;
            _change = _finishVal - _beginVal;
            _id = com.clubpenguin.world.rooms2012.common.UniqueID.getID("TweenItem");
        }
        function getDuration() {
            return(_duration / 1000);
        }
        function getDurationWithDelay() {
            return((_duration / 1000) + (_delay / 1000));
        }
        function update() {
            if (_change == 0) {
                _obj[_tweenedProperty] = _finishVal;
                return(true);
            }
            var _local_2;
            if (_lastTime < 0) {
                _lastTime = getTimer();
            } else {
                _local_2 = getTimer();
                _time = _time + (_local_2 - _lastTime);
                _lastTime = _local_2;
            }
            if (_time >= (_duration + _delay)) {
                _newVal = _finishVal;
                _obj[_tweenedProperty] = _newVal;
                reset();
                return(true);
            }
            if (_time > _delay) {
                _newVal = getNewVal(_time - _delay);
                _obj[_tweenedProperty] = _newVal;
                return(_newVal == _finishVal);
            }
            return(false);
        }
        function reset() {
            _lastTime = -1;
            _time = 0;
        }
        function getNewVal(p_time) {
            return(Math.round(com.clubpenguin.world.rooms2012.common.sequencer.easing.Easing.getVal(_easeFunc, p_time, _beginVal, _change, _duration, _extra1, _extra2) * 1000) / 1000);
        }
        function toString() {
            return("<TweenItem />");
        }
        function getID() {
            return(_id);
        }
        function getName() {
            return(null);
        }
        function toXML() {
            return(null);
        }
        var _lastTime = -1;
        var _time = 0;
    }
