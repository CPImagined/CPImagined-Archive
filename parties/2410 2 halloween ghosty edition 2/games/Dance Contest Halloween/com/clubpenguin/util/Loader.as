
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.Loader
    {
        static var eventSource;
        function Loader () {
        }
        static function loadAllMovies($parent, $movieLocations, $initLocaleText) {
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            submovieProgress = new Array();
            loadedMovies = 0;
            if ($initLocaleText == undefined) {
                $initLocaleText = true;
            }
            if ($movieLocations == undefined) {
                debugTrace("no movieLocations array given!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            } else {
                var _local3 = $movieLocations[0].split("/");
                var _local4 = "";
                var _local1 = 0;
                while (_local1 < (_local3.length - 1)) {
                    _local4 = _local4 + (_local3[_local1] + "/");
                    _local1++;
                }
                debugTrace(("root directory is '" + _local4) + "'");
                var _local7 = ((localeOverride == undefined) ? (com.clubpenguin.util.LocaleText.LANG_ID_EN) : (localeOverride));
                var _local6 = ((localeVersion == undefined) ? (localeVersion) : (localeVersion));
                if ($initLocaleText) {
                    com.clubpenguin.util.LocaleText.init($parent, _local7, _local4, _local6, true);
                }
            }
            var _local1 = 0;
            while (_local1 < $movieLocations.length) {
                loadSubmovie($parent, $movieLocations[_local1], _local1);
                _local1++;
            }
        }
        static function loadSubmovie($parent, $movieLocation, $movieNum) {
            debugTrace("load submovie");
            if ($parent == undefined) {
                debugTrace("cannot load movie, parent movie is undefined!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(undefined);
            }
            if ($movieLocation == undefined) {
                debugTrace("cannot load movie, movie location is undefined!", com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(undefined);
            }
            var _local3 = $parent.createEmptyMovieClip("loadDataMC" + $movieNum, $parent.getNextHighestDepth());
            var _local1 = new Object();
            var _local2 = new MovieClipLoader();
            _local1.onLoadInit = function ($targetMC) {
                com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
            };
            _local1.onLoadProgress = function ($targetMC, $loadProgress, $loadTotal) {
                com.clubpenguin.util.Loader.handleLoadProgress($targetMC, $loadProgress, $loadTotal);
            };
            _local1.onLoadError = function ($targetMC, $errorMessage) {
                com.clubpenguin.util.Loader.debugTrace("error loading submovie: " + $errorMessage, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            };
            _local2.addListener(_local1);
            _local2.loadClip($movieLocation, _local3);
            addProgressObject(_local2.getProgress(_local3));
        }
        static function handleLoadProgress($mainMovie, $loadProgress, $loadTotal) {
            var _local3 = 0;
            var _local2 = 0;
            var _local1 = 0;
            while (_local1 < submovieProgress.length) {
                if (submovieProgress[_local1]["movieClip"] == $mainMovie) {
                    submovieProgress[_local1].bytesLoaded = $loadProgress;
                    submovieProgress[_local1].bytesTotal = $loadTotal;
                }
                _local2 = _local2 + submovieProgress[_local1].bytesLoaded;
                _local3 = _local3 + submovieProgress[_local1].bytesTotal;
                _local1++;
            }
            var _local7 = (_local2 / _local3) * 100;
            debugTrace(("updated load progress. movie is now " + Math.round(_local7)) + "% loaded");
        }
        static function handleLoadComplete($mainMovie) {
            debugTrace("submovie loaded OK! are all loaded?");
            if ($mainMovie._name != "loadDataMC0") {
                $mainMovie.removeMovieClip();
            }
            loadedMovies++;
            if (loadedMovies >= submovieProgress.length) {
                debugTrace("all movies loaded OK!");
                var _local1 = new Object();
                _local1.target = com.clubpenguin.util.Loader;
                _local1.type = EVENT_LOAD_COMPLETED;
                eventSource.dispatchEvent(_local1);
                debugTrace("dispatched LOAD_COMPLETED event");
            }
        }
        static function addEventListener($listener) {
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            eventSource.addEventListener(EVENT_LOAD_COMPLETED, $listener);
        }
        static function removeEventListener($listener) {
            eventSource.removeEventListener(EVENT_LOAD_COMPLETED, $listener);
        }
        static function setLocale($locale) {
            localeOverride = $locale;
        }
        static function setLocaleVersion($localeVersion) {
            localeVersion = $localeVersion;
        }
        static function addProgressObject($progress) {
            submovieProgress.push($progress);
        }
        static function debugTrace($message, $priority) {
            if ($priority == undefined) {
                $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
            }
            if (com.clubpenguin.util.Reporting.DEBUG_LOCALE) {
                com.clubpenguin.util.Reporting.debugTrace("(Loader) " + $message, $priority);
            }
        }
        static var EVENT_LOAD_COMPLETED = "onLoadComplete";
        static var EVENT_LOAD_IN_PROGRESS = "onLoadProgress";
        static var loadedMovies = 0;
        static var submovieProgress = new Array();
        static var localeVersion = undefined;
        static var localeOverride = undefined;
    }
