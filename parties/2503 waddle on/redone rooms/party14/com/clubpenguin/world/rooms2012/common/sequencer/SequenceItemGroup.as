//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup implements com.clubpenguin.world.rooms2012.common.sequencer.ISequenceItemGroup, com.clubpenguin.world.rooms2012.common.sequencer.items.ISequenceItem
    {
        var _sequenceType, _name, _id, _items;
        function SequenceItemGroup (sequenceType, name, delay) {
            _sequenceType = sequenceType;
            if (name) {
                _name = name;
            } else {
                _name = _id;
            }
            _id = com.clubpenguin.world.rooms2012.common.UniqueID.getID("sequenceGroup");
            _items = [];
            if (delay) {
                _delay = delay * 1000;
            }
        }
        function getID() {
            return(_id);
        }
        function getName() {
            return(_name);
        }
        function cancel() {
            _isCancelled = true;
        }
        function update() {
            if (_isCancelled) {
                _items = [];
                return(true);
            }
            if (_items.length <= 0) {
                return(true);
            }
            _isDone = true;
            if (_lastTime < 0) {
                _lastTime = getTimer();
            } else {
                var _local_3 = getTimer();
                _time = _time + (_local_3 - _lastTime);
                _lastTime = _local_3;
            }
            if (_time <= _delay) {
                return(undefined);
            }
            if (_sequenceType == SERIES) {
                if (_items[0].update()) {
                    _items.splice(0, 1);
                }
                if (_items.length > 0) {
                    _isDone = false;
                }
            } else {
                var _local_2 = _items.length - 1;
                while (_local_2 >= 0) {
                    if (!_items[_local_2].update()) {
                        _isDone = false;
                    } else {
                        _items.splice(_local_2, 1);
                    }
                    _local_2--;
                }
            }
            return(_isDone);
        }
        function addItem(item) {
            _items.push(item);
        }
        function isEmpty() {
            return(_items.length <= 0);
        }
        function toString() {
            return(("<sequence>" + _items.toString()) + "</sequence>");
        }
        function toXML() {
            return(null);
        }
        static var SERIES = "series";
        static var PARALLEL = "parallel";
        var _isDone = true;
        var _delay = 0;
        var _lastTime = -1;
        var _time = 0;
        var _isCancelled = false;
    }
