//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Loader
    {
        static var eventSource;
        function Loader () {
        }
        static function loadAllMovies(_arg_5, _arg_2, _arg_8) {
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            submovieProgress = new Array();
            loadedMovies = 0;
            if (_arg_8 == undefined) {
                _arg_8 = true;
            }
            if (_arg_2 == undefined) {
                debugTrace("no movieLocations array given!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            } else {
                var _local_3 = _arg_2[0].split("/");
                var _local_4 = "";
                var _local_1 = 0;
                while (_local_1 < (_local_3.length - 1)) {
                    _local_4 = _local_4 + (_local_3[_local_1] + "/");
                    _local_1++;
                }
                debugTrace(("root directory is '" + _local_4) + "'");
                var _local_7 = ((localeOverride == undefined) ? (com.clubpenguin.util.LocaleText.LANG_ID_EN) : (localeOverride));
                var _local_6 = ((localeVersion == undefined) ? (localeVersion) : (localeVersion));
                if (_arg_8) {
                    com.clubpenguin.util.LocaleText.init(_arg_5, _local_7, _local_4, _local_6, true);
                }
            }
            var _local_1 = 0;
            while (_local_1 < _arg_2.length) {
                loadSubmovie(_arg_5, _arg_2[_local_1], _local_1);
                _local_1++;
            }
        }
        static function loadSubmovie(_arg_4, _arg_5, _arg_6) {
            debugTrace("load submovie");
            if (_arg_4 == undefined) {
                debugTrace("cannot load movie, parent movie is undefined!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(undefined);
            }
            if (_arg_5 == undefined) {
                debugTrace("cannot load movie, movie location is undefined!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(undefined);
            }
            var _local_3 = _arg_4.createEmptyMovieClip("loadDataMC" + _arg_6, _arg_4.getNextHighestDepth());
            var _local_1 = new Object();
            var _local_2 = new MovieClipLoader();
            _local_1.onLoadInit = function (_arg_1) {
                com.clubpenguin.util.Loader.handleLoadComplete(_arg_1);
            };
            _local_1.onLoadProgress = function (_arg_1, _arg_2, _arg_3) {
                com.clubpenguin.util.Loader.handleLoadProgress(_arg_1, _arg_2, _arg_3);
            };
            _local_1.onLoadError = function ($targetMC, _arg_1) {
                com.clubpenguin.util.Loader.debugTrace("error loading submovie: " + _arg_1, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            };
            _local_2.addListener(_local_1);
            _local_2.loadClip(_arg_5, _local_3);
            addProgressObject(_local_2.getProgress(_local_3));
        }
        static function handleLoadProgress(_arg_4, _arg_5, _arg_6) {
            var _local_3 = 0;
            var _local_2 = 0;
            var _local_1 = 0;
            while (_local_1 < submovieProgress.length) {
                if (submovieProgress[_local_1]["movieClip"] == _arg_4) {
                    submovieProgress[_local_1].bytesLoaded = _arg_5;
                    submovieProgress[_local_1].bytesTotal = _arg_6;
                }
                _local_2 = _local_2 + submovieProgress[_local_1].bytesLoaded;
                _local_3 = _local_3 + submovieProgress[_local_1].bytesTotal;
                _local_1++;
            }
            var _local_7 = (_local_2 / _local_3) * 100;
            debugTrace(("updated load progress. movie is now " + Math.round(_local_7)) + "% loaded");
        }
        static function handleLoadComplete(_arg_2) {
            debugTrace("submovie loaded OK! are all loaded?");
            if (_arg_2._name != "loadDataMC0") {
                _arg_2.removeMovieClip();
            }
            loadedMovies++;
            if (loadedMovies >= submovieProgress.length) {
                debugTrace("all movies loaded OK!");
                var _local_1 = new Object();
                _local_1.target = com.clubpenguin.util.Loader;
                _local_1.type = EVENT_LOAD_COMPLETED;
                eventSource.dispatchEvent(_local_1);
                debugTrace("dispatched LOAD_COMPLETED event");
            }
        }
        static function addEventListener(_arg_1) {
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            eventSource.addEventListener(EVENT_LOAD_COMPLETED, _arg_1);
        }
        static function removeEventListener(_arg_1) {
            eventSource.removeEventListener(EVENT_LOAD_COMPLETED, _arg_1);
        }
        static function setLocale(_arg_1) {
            localeOverride = _arg_1;
        }
        static function setLocaleVersion(_arg_1) {
            localeVersion = _arg_1;
        }
        static function addProgressObject(_arg_1) {
            submovieProgress.push(_arg_1);
        }
        static function debugTrace(_arg_2, _arg_1) {
            if (_arg_1 == undefined) {
                _arg_1 = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG_LOCALE) {
                com.clubpenguin.util.Reporting.debugTrace("(Loader) " + _arg_2, _arg_1);
            }
        }
        static var EVENT_LOAD_COMPLETED = "onLoadComplete";
        static var EVENT_LOAD_IN_PROGRESS = "onLoadProgress";
        static var loadedMovies = 0;
        static var submovieProgress = new Array();
        static var localeVersion = undefined;
        static var localeOverride = undefined;
    }
