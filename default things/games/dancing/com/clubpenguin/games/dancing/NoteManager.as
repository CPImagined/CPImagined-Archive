
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.NoteManager
    {
        var movie, noteData;
        function NoteManager (movieClip) {
            movie = movieClip;
            movie._visible = false;
        }
        function init($noteTypes, $noteTimes, $noteLengths, $timeOnScreen) {
            if ($timeOnScreen != undefined) {
                TIME_ON_SCREEN = $timeOnScreen;
            }
            if ($noteTypes.length != $noteTimes.length) {
                debugTrace("note manager data arrays are different sizes!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(undefined);
            }
            noteData = new Array();
            var _local2;
            for (var _local6 in $noteTypes) {
                _local2 = Math.floor($noteTimes[_local6] / NOTE_ARRAY_SUBDIVISION_MILLIS);
                if (noteData[_local2] == undefined) {
                    noteData[_local2] = new Array();
                }
                debugTrace("add new note to subarray " + _local2, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                noteData[_local2].push(new com.clubpenguin.games.dancing.Note(movie, $noteTypes[_local6], $noteTimes[_local6], $noteLengths[_local6]));
            }
            movie._visible = true;
        }
        function update(elapsedTime) {
            var _local4 = new Array();
            var _local5 = Math.floor(elapsedTime / NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
            var _local8 = 3;
            var _local9;
            var _local2 = _local5;
            while (_local2 < (_local5 + _local8)) {
                debugTrace("update subarray " + _local2, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                for (var _local7 in noteData[_local2]) {
                    var _local3 = noteData[_local2][_local7].update(elapsedTime);
                    if (_local3 == false) {
                        _local4.push(noteData[_local2][_local7]);
                    }
                }
                _local2++;
            }
            return(_local4);
        }
        function destroy() {
            for (var _local3 in noteData) {
                for (var _local2 in noteData[_local3]) {
                    noteData[_local3][_local2].destroy();
                }
            }
        }
        function hide() {
            movie._visible = false;
        }
        function getClosestValidNote(noteType, elapsedTime) {
            var _local7 = Math.floor(elapsedTime / NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
            var _local10 = 3;
            var _local3;
            var _local5;
            var _local4;
            var _local2 = _local7;
            while (_local2 < (_local7 + _local10)) {
                for (var _local9 in noteData[_local2]) {
                    if (noteData[_local2][_local9].noteType == noteType) {
                        if (noteData[_local2][_local9].getNotePressResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED) {
                            _local4 = Math.abs(noteData[_local2][_local9].getDistanceFromTarget(elapsedTime));
                            debugTrace(((((("current note is noteData[" + _local2) + "][") + _local9) + "], ") + "distance is ") + _local4, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                            if ((_local3 == undefined) || (_local4 < _local5)) {
                                debugTrace("new closest note found!", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                                _local3 = noteData[_local2][_local9];
                                _local5 = Math.abs(_local3.getDistanceFromTarget(elapsedTime));
                            }
                        }
                    }
                }
                _local2++;
            }
            return(_local3);
        }
        function handleNotePress($noteType, $elapsedTime, $closestNote) {
            var _local2;
            if ($closestNote == undefined) {
                _local2 = getClosestValidNote($noteType, $elapsedTime);
            } else {
                _local2 = $closestNote;
            }
            if (_local2 == undefined) {
                return(com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN);
            } else {
                var _local3 = Math.abs(_local2.getDistanceFromTarget($elapsedTime));
                if (_local3 < MAX_DISTANCE_FROM_TARGET) {
                    return(_local2.handleNotePressEvent($elapsedTime));
                } else {
                    debugTrace("note was missed! distance = " + _local3);
                    return(com.clubpenguin.games.dancing.Note.RESULT_MISS);
                }
            }
        }
        function handleNoteRelease(noteType, elapsedTime) {
            var _local7 = Math.floor(elapsedTime / NOTE_ARRAY_SUBDIVISION_MILLIS) - 1;
            var _local10 = 3;
            var _local3;
            var _local5;
            var _local4;
            var _local2 = _local7;
            while (_local2 < (_local7 + _local10)) {
                for (var _local9 in noteData[_local2]) {
                    if (noteData[_local2][_local9].noteType == noteType) {
                        if (((noteData[_local2][_local9].getDuration() > 0) && (noteData[_local2][_local9].getNotePressResult() != com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)) && (noteData[_local2][_local9].getNoteReleaseResult() == com.clubpenguin.games.dancing.Note.RESULT_NOT_PRESSED)) {
                            _local4 = Math.abs(noteData[_local2][_local9].getReleaseDistanceFromTarget(elapsedTime));
                            debugTrace(((((("current note is noteData[" + _local2) + "][") + _local9) + "], ") + "distance is ") + _local4, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                            if ((_local3 == undefined) || (_local4 < _local5)) {
                                debugTrace("new closest note found!", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                                _local3 = noteData[_local2][_local9];
                                _local5 = Math.abs(_local3.getReleaseDistanceFromTarget(elapsedTime));
                            }
                        }
                    }
                }
                _local2++;
            }
            if (_local3 == undefined) {
                return(com.clubpenguin.games.dancing.Note.RESULT_UNKNOWN);
            } else if (_local5 < MAX_DISTANCE_FROM_TARGET) {
                return(_local3.handleNoteReleaseEvent(elapsedTime));
            } else {
                debugTrace("note release was missed! distance = " + _local5);
                return(com.clubpenguin.games.dancing.Note.RESULT_MISS);
            }
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace("(NoteManager) " + message, priority);
            }
        }
        static var NOTE_ARRAY_SUBDIVISION_MILLIS = 10000;
        static var TIME_ON_SCREEN = 3500;
        static var MAX_DISTANCE_FROM_TARGET = 100;
    }
