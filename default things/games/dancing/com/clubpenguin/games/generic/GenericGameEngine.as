
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.games.generic.GenericGameEngine
    {
        var movie, localeTextListener, debugText;
        function GenericGameEngine (movieClip) {
            movie = movieClip;
            if (movieClip == undefined) {
                debugTrace("(GenericGameEngine) no movieclip passed to constructor", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            }
            debugTrace("(GenericGameEngine) about to create localeText listener, is currently set as " + localeTextListener);
            localeTextListener = new Object();
            localeTextListener.onLoadComplete = com.clubpenguin.util.Delegate.create(this, localeLoadHandler);
            com.clubpenguin.util.LocaleText.addEventListener(localeTextListener);
            var _local4 = com.clubpenguin.util.LocaleText.getGameDirectory(movieClip._url);
            com.clubpenguin.util.LocaleText.init(movieClip, undefined, _local4, undefined, false);
            if (com.clubpenguin.util.Reporting.DEBUG_FPS) {
                var _local2 = new TextFormat();
                _local2.size = 10;
                movie.createTextField("debugText", 10, 10, 10, 200, 20);
                debugText.setTextFormat(_local2);
                frameTimer = getTimer();
                debugFrameTicks = 0;
                debugFrameTicksLast = 0;
                setInterval(this, "updateFPS", 1000);
            }
        }
        function init() {
        }
        function update() {
        }
        function localeLoadHandler() {
            debugTrace("(GenericGameEngine) load complete handler called");
            com.clubpenguin.util.LocaleText.removeEventListener(localeTextListener);
            localeTextListener = undefined;
            debugTrace("(GenericGameEngine) localeText listener removed");
            var _local3 = _global.getCurrentShell();
            _local3.hideLoading();
            debugTrace("(GenericGameEngine) load screen removed");
            init();
        }
        function enterFrameHandler() {
            if (com.clubpenguin.util.Reporting.DEBUG_FPS) {
                debugFrameTicks++;
            }
            if (getTimer() > (frameTimer + fpsFrameTime)) {
                frameTimer = frameTimer + fpsFrameTime;
                update();
            }
        }
        function getPenguinColour() {
            var _local3 = 11193582 /* 0xAACCEE */;
            var _local2 = _global.getCurrentShell();
            if (_local2.getMyPlayerHex != undefined) {
                _local3 = _local2.getMyPlayerHex();
            }
            return(_local3);
        }
        function isMember() {
            var _local2 = false;
            var _local3 = _global.getCurrentShell();
            if (_local3.isMyPlayerMember != undefined) {
                _local2 = _local3.isMyPlayerMember();
            }
            return(_local2);
        }
        function updateFPS() {
            var _local2 = debugFrameTicks - debugFrameTicksLast;
            var _local3 = ((("fps: " + _local2) + " (target = ") + fpsTarget) + ") - FPS ";
            _local3 = _local3 + ((_local2 > fpsTarget) ? "OK" : "WARNING!");
            movie.debugText.text = _local3;
            debugFrameTicksLast = debugFrameTicks;
        }
        function setFPS(newFPS) {
            fpsTarget = newFPS;
            fpsFrameTime = 1000 / fpsTarget;
        }
        static function debugTrace(message, priority) {
            if (com.clubpenguin.util.Reporting.DEBUG) {
                com.clubpenguin.util.Reporting.debugTrace(message, priority);
            }
        }
        static var DEFAULT_FPS = 20;
        static var fpsTarget = DEFAULT_FPS;
        static var fpsFrameTime = 1000 / fpsTarget;
        var frameTimer = 0;
        var debugFrameTicks = 0;
        var debugFrameTicksLast = 0;
    }
