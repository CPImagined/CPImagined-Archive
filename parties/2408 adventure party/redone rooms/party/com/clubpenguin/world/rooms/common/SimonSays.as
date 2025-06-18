//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SimonSays
    {
        var _fireOnComplete, _simon, _repeaters, _indicators, _pattern, _simonLength, _hintRepeatIntervalID, _interruptRepeatIntervalID, _noteDelayIntervalID, _patternMax, _noteMax, _currentHintNote;
        function SimonSays (fireOnComplete, simon, repeaters, indicators, pattern) {
            _fireOnComplete = fireOnComplete;
            _simon = simon;
            _repeaters = repeaters;
            _indicators = indicators;
            _pattern = pattern;
            if (_simon.length != _repeaters.length) {
            } else {
                _simonLength = _simon.length;
            }
            init();
        }
        function destroy() {
            clearInterval(_hintRepeatIntervalID);
            clearInterval(_interruptRepeatIntervalID);
            clearInterval(_noteDelayIntervalID);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        function init() {
            _patternMax = _pattern.patterns.length;
            _noteMax = _pattern.lengths[_currentPatternID];
            var _local_2 = 0;
            while (_local_2 < _simonLength) {
                _repeaters[_local_2].onPress = com.clubpenguin.util.Delegate.create(this, repeaterClick, _local_2);
                _local_2++;
            }
            clearInterval(_hintRepeatIntervalID);
            _hintRepeatIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, hint), INITIAL_HINT_DELAY);
        }
        function hint() {
            _currentHintNote = _pattern.patterns[_currentPatternID][_currentHintNoteID];
            _simon[_currentHintNote].gotoAndPlay(PLAY_FRAME);
            _currentHintNoteID++;
            if (_currentHintNoteID == _noteMax) {
                _currentHintNoteID = 0;
                resolveIntervals(false, true, false, false);
            } else {
                resolveIntervals(true, false, false, false);
            }
        }
        function resolveIntervals(noteDelay, hintRepeatDelay, interruptDelay, finale) {
            clearInterval(_noteDelayIntervalID);
            clearInterval(_hintRepeatIntervalID);
            clearInterval(_interruptRepeatIntervalID);
            if (noteDelay) {
                _noteDelayIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, hint), NOTE_DELAY);
            } else if (hintRepeatDelay) {
                _hintRepeatIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, hint), REPEATING_HINT_DELAY);
            } else if (interruptDelay) {
                _interruptRepeatIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, hint), INTERRUPT_DELAY);
            } else if (finale) {
                _noteDelayIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, playFinale), NOTE_DELAY);
            }
        }
        function playFinale() {
            _finalePlaying = true;
            _currentHintNote = _pattern.patterns[_currentPatternID][_currentHintNoteID];
            _simon[_currentHintNote].gotoAndPlay(PLAY_FRAME);
            _repeaters[_currentHintNote].gotoAndPlay(PLAY_FRAME);
            _currentHintNoteID++;
            if (_currentHintNoteID == _noteMax) {
                _fireOnComplete();
                _finalePlaying = false;
                resolveIntervals(false, false, false, false);
            } else {
                resolveIntervals(false, false, false, true);
            }
        }
        function repeaterClick(whichRepeater) {
            if (_finalePlaying) {
                return(undefined);
            }
            _repeaters[whichRepeater].gotoAndPlay(PLAY_FRAME);
            _currentHintNoteID = 0;
            resolveIntervals(false, false, true, false);
            if (!_challengeCompleted) {
                var _local_2 = _pattern.patterns[_currentPatternID][_currentNoteID];
                if (whichRepeater == _local_2) {
                    noteAdvance();
                } else {
                    patternReset();
                }
            }
        }
        function patternReset() {
            _currentNoteID = 0;
            resolveIntervals(true, false, false, false);
            var _local_2 = 0;
            while (_local_2 < _noteMax) {
                _simon[_local_2].gotoAndPlay(INCORRECT_FRAME);
                _indicators[_local_2].gotoAndStop(PARK_FRAME);
                _local_2++;
            }
        }
        function noteAdvance() {
            _indicators[_currentNoteID].gotoAndStop(ON_FRAME);
            _currentNoteID++;
            if (_currentNoteID == _noteMax) {
                _currentNoteID = 0;
                patternAdvance();
            }
        }
        function patternAdvance() {
            var _local_2 = 0;
            while (_local_2 < _noteMax) {
                _indicators[_local_2].gotoAndStop(SUCCESS_FRAME);
                _local_2++;
            }
            _currentPatternID++;
            _noteMax = _pattern.lengths[_currentPatternID];
            resolveIntervals(true, false, false, false);
            if (_currentPatternID == _patternMax) {
                challengeComplete();
            }
        }
        function challengeComplete() {
            _currentPatternID--;
            _noteMax = _pattern.lengths[_currentPatternID];
            _challengeCompleted = true;
            resolveIntervals(false, false, false, true);
        }
        static var CLASS_NAME = "SimonSays";
        static var PARK_FRAME = "park";
        static var PLAY_FRAME = "play";
        static var ON_FRAME = "on";
        static var SUCCESS_FRAME = "success";
        static var INCORRECT_FRAME = "incorrect";
        static var INITIAL_HINT_DELAY = 5000;
        static var REPEATING_HINT_DELAY = 4000;
        static var INTERRUPT_DELAY = 3000;
        static var NOTE_DELAY = 750;
        var _challengeCompleted = false;
        var _currentPatternID = 0;
        var _currentNoteID = 0;
        var _currentHintNoteID = 0;
        var _finalePlaying = false;
    }
