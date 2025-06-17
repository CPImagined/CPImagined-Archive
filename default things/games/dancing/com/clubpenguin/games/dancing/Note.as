
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.dancing.Note
    {
        var parentMovie, noteType, noteTime, noteDuration, sentToServer, autoReleased, noteHeight, noteYPos, noteXPos, pressTime, releaseTime, movie;
        function Note (parentMovieClip, type, time, duration) {
            debugTrace(((((("make new note: " + type) + " at ") + time) + " for ") + duration) + "ms", com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            if (duration == undefined) {
                duration = 0;
            }
            parentMovie = parentMovieClip;
            noteType = type;
            noteTime = time;
            noteDuration = duration;
            sentToServer = false;
            autoReleased = false;
            var _local3 = parentMovie[START_MOVIECLIP]._y - parentMovie[TARGET_MOVIECLIP]._y;
            noteHeight = (_local3 * noteDuration) / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
            noteYPos = parentMovie[START_MOVIECLIP]._y;
            switch (noteType) {
                case TYPE_LEFT : 
                    noteXPos = parentMovie[LEFT_TARGET_MOVIECLIP]._x;
                    break;
                case TYPE_RIGHT : 
                    noteXPos = parentMovie[RIGHT_TARGET_MOVIECLIP]._x;
                    break;
                case TYPE_UP : 
                    noteXPos = parentMovie[UP_TARGET_MOVIECLIP]._x;
                    break;
                case TYPE_DOWN : 
                    noteXPos = parentMovie[DOWN_TARGET_MOVIECLIP]._x;
                    break;
                default : 
                    debugTrace(("note type " + noteType) + " is unknown!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    break;
            }
            pressTime = RESULT_NOT_PRESSED;
            releaseTime = RESULT_NOT_PRESSED;
        }
        function update(currentTimeMillis) {
            setNotePosition(currentTimeMillis);
            if (((noteYPos + noteHeight) > parentMovie[END_MOVIECLIP]._y) && (noteYPos < parentMovie[START_MOVIECLIP]._y)) {
                if (movie == undefined) {
                    addNote();
                }
                if (getNotePressResult() == RESULT_NOT_PRESSED) {
                    updateNote();
                } else if (noteDuration > 0) {
                    resizeNote(currentTimeMillis);
                }
            } else if ((getNotePressResult() == RESULT_NOT_PRESSED) && (movie != undefined)) {
                destroy();
                return(false);
            } else {
                destroy();
            }
            return(true);
        }
        function addNote() {
            var _local6 = (("note_" + noteType) + "_") + Math.round(noteTime);
            var _local5 = parentMovie.getNextHighestDepth();
            var _local2;
            if (noteDuration > 0) {
                movie = parentMovie.createEmptyMovieClip(_local6, _local5);
                var _local3;
                var _local4;
                switch (noteType) {
                    case TYPE_LEFT : 
                        _local2 = LEFT_NOTE_MOVIECLIP;
                        _local3 = LEFT_BASE_MOVIECLIP;
                        _local4 = LEFT_STEM_MOVIECLIP;
                        break;
                    case TYPE_RIGHT : 
                        _local2 = RIGHT_NOTE_MOVIECLIP;
                        _local3 = RIGHT_BASE_MOVIECLIP;
                        _local4 = RIGHT_STEM_MOVIECLIP;
                        break;
                    case TYPE_UP : 
                        _local2 = UP_NOTE_MOVIECLIP;
                        _local3 = UP_BASE_MOVIECLIP;
                        _local4 = UP_STEM_MOVIECLIP;
                        break;
                    case TYPE_DOWN : 
                        _local2 = DOWN_NOTE_MOVIECLIP;
                        _local3 = DOWN_BASE_MOVIECLIP;
                        _local4 = DOWN_STEM_MOVIECLIP;
                        break;
                    default : 
                        debugTrace(("note type " + noteType) + " is unknown!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                        break;
                }
                movie.attachMovie(_local3, BASE_MOVIECLIP, 1);
                movie.attachMovie(_local4, STEM_MOVIECLIP, 2);
                movie.attachMovie(_local2, TOP_MOVIECLIP, 3);
                movie[STEM_MOVIECLIP]._height = noteHeight;
                movie[BASE_MOVIECLIP]._y = noteHeight;
                if (noteType == TYPE_DOWN) {
                    movie[STEM_MOVIECLIP]._height = movie[STEM_MOVIECLIP]._height - DOWN_ARROW_YSHIFT;
                    movie[STEM_MOVIECLIP]._y = movie[STEM_MOVIECLIP]._y + DOWN_ARROW_YSHIFT;
                }
            } else {
                switch (noteType) {
                    case TYPE_LEFT : 
                        _local2 = LEFT_NOTE_MOVIECLIP;
                        break;
                    case TYPE_RIGHT : 
                        _local2 = RIGHT_NOTE_MOVIECLIP;
                        break;
                    case TYPE_UP : 
                        _local2 = UP_NOTE_MOVIECLIP;
                        break;
                    case TYPE_DOWN : 
                        _local2 = DOWN_NOTE_MOVIECLIP;
                        break;
                    default : 
                        debugTrace(("note type " + noteType) + " is unknown!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                        break;
                }
                movie = parentMovie.attachMovie(_local2, _local6, _local5);
                debugTrace((((((("make new note movie: " + parentMovie) + " attach ") + _local2) + " as ") + _local6) + " at ") + _local5, com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
            }
        }
        function resizeNote(currentTimeMillis) {
            if (getNoteReleaseResult() == RESULT_NOT_PRESSED) {
                var _local4 = parentMovie[START_MOVIECLIP]._y - parentMovie[TARGET_MOVIECLIP]._y;
                var _local3 = (noteDuration + pressTime) - currentTimeMillis;
                var _local2 = (_local4 * _local3) / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
                if (_local2 >= 0) {
                    movie[STEM_MOVIECLIP]._height = _local2;
                    if (noteType == TYPE_DOWN) {
                        movie[STEM_MOVIECLIP]._height = movie[STEM_MOVIECLIP]._height - DOWN_ARROW_YSHIFT;
                        if (movie[STEM_MOVIECLIP]._height <= DOWN_ARROW_YSHIFT) {
                            movie[STEM_MOVIECLIP]._visible = false;
                            movie[BASE_MOVIECLIP]._visible = false;
                        }
                    }
                    movie[BASE_MOVIECLIP]._y = _local2;
                } else {
                    movie[STEM_MOVIECLIP]._visible = false;
                    movie[BASE_MOVIECLIP]._visible = false;
                    handleNoteReleaseEvent(currentTimeMillis);
                    autoReleased = true;
                }
            }
        }
        function updateNote() {
            movie._x = noteXPos;
            movie._y = noteYPos;
        }
        function destroy() {
            if (movie != undefined) {
                movie.removeMovieClip();
                movie = undefined;
            }
        }
        function setNotePosition(currentTimeMillis) {
            noteYPos = parentMovie[TARGET_MOVIECLIP]._y + getDistanceFromTarget(currentTimeMillis);
        }
        function handleNotePressEvent(timePressedMillis) {
            if (pressTime != RESULT_NOT_PRESSED) {
                return(RESULT_ALREADY_PRESSED);
            } else {
                pressTime = timePressedMillis;
                if (movie == undefined) {
                    debugTrace("note is undefined on note press event!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                } else if (noteDuration == 0) {
                    movie.gotoAndPlay(ANIMATION_HIT);
                } else {
                    movie[TOP_MOVIECLIP].gotoAndPlay(ANIMATION_HOLD);
                    movie[BASE_MOVIECLIP].gotoAndPlay(ANIMATION_HOLD);
                    movie[STEM_MOVIECLIP].gotoAndPlay(ANIMATION_HOLD);
                }
                debugTrace("press distance from target is " + getDistanceFromTarget());
                return(getNotePressResult());
            }
        }
        function getNotePressResult() {
            if (pressTime == RESULT_NOT_PRESSED) {
                return(RESULT_NOT_PRESSED);
            }
            var _local2 = Math.abs(getDistanceFromTarget(pressTime));
            if (_local2 < 5) {
                return(RESULT_PERFECT);
            } else if (_local2 < 10) {
                return(RESULT_GREAT);
            } else if (_local2 < 25) {
                return(RESULT_GOOD);
            } else if (_local2 < 50) {
                return(RESULT_ALMOST);
            } else {
                return(RESULT_BOO);
            }
        }
        function handleNoteReleaseEvent(timeReleasedMillis) {
            if (releaseTime != RESULT_NOT_PRESSED) {
                return(RESULT_ALREADY_PRESSED);
            } else if (pressTime == RESULT_NOT_PRESSED) {
                debugTrace("note not pressed yet - attempting to release on unpressed note!");
                return(RESULT_NOT_PRESSED);
            } else {
                releaseTime = timeReleasedMillis;
                if (movie == undefined) {
                    debugTrace("note is undefined on note release event!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                } else if (noteDuration > 0) {
                    movie[BASE_MOVIECLIP].gotoAndPlay(ANIMATION_FADE);
                    movie[STEM_MOVIECLIP].gotoAndPlay(ANIMATION_FADE);
                    movie[TOP_MOVIECLIP].gotoAndPlay(ANIMATION_FADE);
                }
                debugTrace("release distance from target is " + getReleaseDistanceFromTarget());
                debugTrace("note hold length is " + getNoteHoldLength());
                return(getNoteHoldLength());
            }
        }
        function getNoteReleaseResult() {
            if (releaseTime == RESULT_NOT_PRESSED) {
                return(RESULT_NOT_PRESSED);
            }
            var _local2 = Math.abs(getReleaseDistanceFromTarget(releaseTime));
            if (_local2 < 5) {
                return(RESULT_PERFECT);
            } else if (_local2 < 10) {
                return(RESULT_GREAT);
            } else if (_local2 < 25) {
                return(RESULT_GOOD);
            } else if (_local2 < 50) {
                return(RESULT_ALMOST);
            } else {
                return(RESULT_BOO);
            }
        }
        function getNoteHoldLength() {
            var _local2 = releaseTime - pressTime;
            if (_local2 > noteDuration) {
                _local2 = noteDuration;
            }
            return(_local2);
        }
        function getDistanceFromTarget(currentTimeMillis) {
            if (currentTimeMillis == undefined) {
                currentTimeMillis = pressTime;
            }
            var _local2 = parentMovie[START_MOVIECLIP]._y - parentMovie[TARGET_MOVIECLIP]._y;
            var _local4 = (noteTime - currentTimeMillis) / com.clubpenguin.games.dancing.NoteManager.TIME_ON_SCREEN;
            return(_local2 * _local4);
        }
        function getReleaseDistanceFromTarget(currentTimeMillis) {
            if (currentTimeMillis == undefined) {
                currentTimeMillis = releaseTime;
            }
            return(getDistanceFromTarget(currentTimeMillis - noteDuration));
        }
        function getDuration() {
            return(noteDuration);
        }
        static function debugTrace(message, priority) {
            if (priority == undefined) {
                priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace("(Note) " + message, priority);
            }
        }
        static var TYPE_LEFT = 0;
        static var TYPE_RIGHT = 1;
        static var TYPE_UP = 2;
        static var TYPE_DOWN = 3;
        static var RESULT_PERFECT = 0;
        static var RESULT_GREAT = 1;
        static var RESULT_GOOD = 2;
        static var RESULT_ALMOST = 3;
        static var RESULT_BOO = 4;
        static var RESULT_MISS = 5;
        static var RESULT_NOT_PRESSED = -1;
        static var RESULT_ALREADY_PRESSED = -2;
        static var RESULT_UNKNOWN = -3;
        static var LEFT_NOTE_MOVIECLIP = "notePressLeft";
        static var RIGHT_NOTE_MOVIECLIP = "notePressRight";
        static var UP_NOTE_MOVIECLIP = "notePressUp";
        static var DOWN_NOTE_MOVIECLIP = "notePressDown";
        static var LEFT_BASE_MOVIECLIP = "noteBaseLeft";
        static var RIGHT_BASE_MOVIECLIP = "noteBaseRight";
        static var UP_BASE_MOVIECLIP = "noteBaseUp";
        static var DOWN_BASE_MOVIECLIP = "noteBaseDown";
        static var LEFT_STEM_MOVIECLIP = "noteStemLeft";
        static var RIGHT_STEM_MOVIECLIP = "noteStemRight";
        static var UP_STEM_MOVIECLIP = "noteStemUp";
        static var DOWN_STEM_MOVIECLIP = "noteStemDown";
        static var BASE_MOVIECLIP = "noteBase";
        static var STEM_MOVIECLIP = "noteStem";
        static var TOP_MOVIECLIP = "noteTop";
        static var ANIMATION_HIT = "hit";
        static var ANIMATION_HOLD = "hold";
        static var ANIMATION_FADE = "fade";
        static var LEFT_TARGET_MOVIECLIP = "noteTargetLeft";
        static var RIGHT_TARGET_MOVIECLIP = "noteTargetRight";
        static var UP_TARGET_MOVIECLIP = "noteTargetUp";
        static var DOWN_TARGET_MOVIECLIP = "noteTargetDown";
        static var START_MOVIECLIP = "noteStart";
        static var TARGET_MOVIECLIP = "noteTarget";
        static var END_MOVIECLIP = "noteFade";
        static var DOWN_ARROW_YSHIFT = 6;
    }
