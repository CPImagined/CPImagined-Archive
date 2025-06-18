//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.GameTimer
    {
        var movie, startTime, endTime, currentTime, timerID, mask_mc, mask_width, mask_x, mask_y, mask_radius_inner, mask_radius_outer, mask_start_angle, callbackFunc, callbackValue, totalTime;
        function GameTimer (ref_movie) {
            if (DEBUG_LOGGING) {
                debugTrace("ref_movie = " + ref_movie);
            }
            if (ref_movie) {
                movie = ref_movie;
                init();
            } else if (DEBUG_LOGGING) {
                debugTrace("Fatal: GameTimer -- Empty movie reference passed to constructor");
            }
        }
        function init() {
            startTime = getTimer();
            endTime = VAR_NOT_SET;
            currentTime = VAR_NOT_SET;
            timerID = VAR_NOT_SET;
            mask_mc = movie.hands_mc.createEmptyMovieClip("timer_mask", 1);
            mask_width = movie.hands_mc._width;
            mask_x = mask_width / 2;
            mask_y = mask_width / 2;
            mask_radius_inner = 0;
            mask_radius_outer = mask_width;
            mask_start_angle = -0.25;
            if (DEBUG_LOGGING) {
                debugTrace("init: mask_width = " + mask_width);
                debugTrace("init: mask_mc = " + mask_mc);
                debugTrace("init: movie = " + movie);
            }
        }
        function destroy(Void) {
            movie.removeMovieClip();
            stop();
        }
        function start(Void) {
            if (timerID == VAR_NOT_SET) {
                timerID = setInterval(com.clubpenguin.util.Delegate.create(this, tick), TIMER_SECOND);
                if (DEBUG_LOGGING) {
                    debugTrace("start: timerID = " + timerID);
                }
            } else if (DEBUG_LOGGING) {
                debugTrace(("start: Warning: trying to start a running timer ( timerID = " + timerID) + ")");
            }
        }
        function stop(Void) {
            if (DEBUG_LOGGING) {
                debugTrace("stop: timerID = " + timerID);
            }
            if (timerID != VAR_NOT_SET) {
                clearInterval(timerID);
                timerID = VAR_NOT_SET;
                if (DEBUG_LOGGING) {
                    debugTrace("stop: timerID has been stopped");
                }
            } else if (DEBUG_LOGGING) {
                debugTrace(("stop: Warning: trying to stop a stopped timer ( timerID = " + timerID) + ")");
            }
        }
        function setCallback(scope, func, funcValue) {
            if (func && (typeof(func) == "function")) {
                callbackFunc = com.clubpenguin.util.Delegate.create(scope, func);
                callbackValue = funcValue;
            } else if (DEBUG_LOGGING) {
                debugTrace(("setCallback: func is not a function (" + typeof(func)) + ")");
            }
        }
        function setTime(seconds) {
            if (seconds) {
                currentTime = seconds;
                if (DEBUG_LOGGING) {
                    debugTrace("setTime: seconds = " + seconds);
                }
                if (currentTime < 0) {
                    currentTime = Math.abs(seconds);
                } else if (currentTime > MAX_STEPS) {
                    currentTime = MAX_STEPS;
                }
                totalTime = currentTime;
                drawMask();
                movie.timer_txt.text = currentTime;
                movie.hands_mc.setMask(mask_mc);
                if (DEBUG_LOGGING) {
                }
            }
        }
        function setCurrentTime(seconds) {
            if (seconds) {
                currentTime = seconds;
                if (DEBUG_LOGGING) {
                    debugTrace("setTime: seconds = " + seconds);
                }
                if (currentTime < 0) {
                    currentTime = Math.abs(seconds);
                } else if (currentTime > MAX_STEPS) {
                    currentTime = MAX_STEPS;
                }
                drawMask();
                movie.timer_txt.text = currentTime;
                movie.hands_mc.setMask(mask_mc);
                if (DEBUG_LOGGING) {
                }
            }
        }
        function getTime(Void) {
            if (!currentTime) {
                currentTime = 0;
            }
            return(currentTime);
        }
        function tick(Void) {
            if (DEBUG_LOGGING) {
            }
            if ((--currentTime) <= 0) {
                clearInterval(timerID);
                currentTime = 0;
                callbackFunc(callbackValue);
                if (DEBUG_LOGGING) {
                    if (DEBUG_LOGGING) {
                        debugTrace("tick: TIME'S UP!");
                    }
                }
            }
            drawMask();
            movie.timer_txt.text = currentTime;
            return(currentTime);
        }
        function setPosition(newX, newY) {
            if (newX && (newY)) {
                movie._x = newX;
                movie._y = newY;
            }
        }
        function setSize(newWidth, newHeight) {
            if (newWidth && (newHeight)) {
                movie._width = newWidth;
                movie._height = newHeight;
            }
        }
        function drawMask(Void) {
            var _local_9 = (360 - ((totalTime - currentTime) * (360 / totalTime))) / 360;
            var _local_6 = _local_9 / DRAW_STEPS;
            var _local_3;
            var _local_2;
            var _local_7;
            var _local_5 = mask_x + (Math.cos(mask_start_angle * twoPI) * mask_radius_inner);
            var _local_4 = mask_y + (Math.sin(mask_start_angle * twoPI) * mask_radius_inner);
            var _local_8 = {x:_local_5, y:_local_4};
            mask_mc.clear();
            mask_mc.beginFill(255, 75);
            mask_mc.moveTo(_local_8.x, _local_8.y);
            _local_2 = 1;
            while (_local_2 <= DRAW_STEPS) {
                _local_3 = (mask_start_angle + (_local_2 * _local_6)) * twoPI;
                _local_5 = mask_x + (Math.cos(_local_3) * mask_radius_inner);
                _local_4 = mask_y + (Math.sin(_local_3) * mask_radius_inner);
                mask_mc.lineTo(_local_5, _local_4);
                _local_2++;
            }
            _local_7 = mask_start_angle + _local_9;
            _local_2 = 0;
            while (_local_2 <= DRAW_STEPS) {
                _local_3 = (_local_7 - (_local_2 * _local_6)) * twoPI;
                _local_5 = mask_x + (Math.cos(_local_3) * mask_radius_outer);
                _local_4 = mask_y + (Math.sin(_local_3) * mask_radius_outer);
                mask_mc.lineTo(_local_5, _local_4);
                _local_2++;
            }
            mask_mc.lineTo(_local_8.x, _local_8.y);
            mask_mc.endFill();
        }
        function debugTrace(message) {
            if (DEBUG_LOGGING) {
            }
        }
        static var DEBUG_LOGGING = false;
        static var twoPI = (Math.PI*2);
        static var MAX_STEPS = 360;
        static var DRAW_STEPS = 36;
        static var TIMER_SECOND = 1000;
        static var VAR_NOT_SET = -1;
    }
