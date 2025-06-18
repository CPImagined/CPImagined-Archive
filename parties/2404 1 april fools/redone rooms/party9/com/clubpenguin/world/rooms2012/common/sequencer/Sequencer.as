//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.common.sequencer.Sequencer
    {
        var _queue, _pulse, _sequenceIsOpen, _sequencerType, _openSequence, _currentGroup;
        function Sequencer (timerType, enterFrameMC, timerRate, sequencerType) {
            _queue = [];
            if (timerType == com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator.FRAME_BASED) {
                _pulse = new com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator(this, timerType, enterFrameMC, timerRate);
            } else if (timerType == com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator.TIMER_BASED) {
                _pulse = new com.clubpenguin.world.rooms2012.common.sequencer.PulseGenerator(this, timerType, null, timerRate);
            }
            _sequenceIsOpen = false;
            if (sequencerType) {
                _sequencerType = sequencerType;
            } else {
                _sequencerType = com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.SERIES;
            }
        }
        function beginSequence(sequenceType, name, delay) {
            if (_sequenceIsOpen) {
                endSequence();
            }
            _openSequence = new com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup(sequenceType, name, delay);
            _sequenceIsOpen = true;
            return(_openSequence);
        }
        function endSequence() {
            if (!_openSequence) {
                return(undefined);
            }
            if (_openSequence.isEmpty()) {
                _openSequence = null;
            } else {
                _queue.push(_openSequence);
            }
            _sequenceIsOpen = false;
        }
        function clear() {
            _pulse.stop();
            _currentGroup = null;
            _queue = [];
            _sequenceIsOpen = false;
            _isRunning = false;
        }
        function start() {
            if (_isRunning) {
                return(undefined);
            }
            if (_sequenceIsOpen) {
                endSequence();
            }
            _currentGroup = _queue[0];
            _isRunning = true;
            _pulse.start();
            update();
        }
        function addItem(item) {
            if (_sequenceIsOpen) {
                _openSequence.addItem(item);
            }
        }
        function update() {
            if (_sequencerType == com.clubpenguin.world.rooms2012.common.sequencer.SequenceItemGroup.PARALLEL) {
                var _local_4 = [];
                var _local_2 = 0;
                while (_local_2 < _queue.length) {
                    if (_queue[_local_2].update()) {
                        _local_4.push(_local_2);
                    }
                    _local_2++;
                }
                var _local_3 = _local_4.length - 1;
                while (_local_3 >= 0) {
                    _queue.splice(_local_4[_local_3], 1);
                    _local_3--;
                }
                if (_queue.length <= 0) {
                    this.clear();
                }
                return(undefined);
            }
            if (_currentGroup.update()) {
                _queue.splice(0, 1);
                if (_queue.length <= 0) {
                    this.clear();
                } else {
                    _currentGroup = _queue[0];
                }
            }
        }
        var _isRunning = false;
    }
