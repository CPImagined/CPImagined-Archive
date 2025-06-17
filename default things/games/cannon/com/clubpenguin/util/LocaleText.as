//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.LocaleText
    {
        static var eventSource, locale, localeDataMC, dataArray, localeDirectoryURL;
        function LocaleText () {
        }
        static function init(_arg_6, _arg_4, _arg_7, _arg_8, _arg_5) {
            debugTrace("initialise locale text");
            ready = false;
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            if (_arg_5 == undefined) {
                _arg_5 = false;
            }
            if (_arg_4 == undefined) {
                _arg_4 = getLocaleID();
            }
            localeID = _arg_4;
            var _local_1 = getLocale(localeID);
            locale = getLocale(localeID);
            if (_arg_8 == undefined) {
                if (localeVersion == undefined) {
                    _local_1 = ((((LANG_LOC_DIRECTORY + "/") + _local_1) + "/") + LANG_LOC_FILENAME) + LANG_LOC_FILETYPE;
                } else {
                    _local_1 = (((((LANG_LOC_DIRECTORY + "/") + _local_1) + "/") + LANG_LOC_FILENAME) + localeVersion) + LANG_LOC_FILETYPE;
                }
            } else {
                _local_1 = (((((LANG_LOC_DIRECTORY + "/") + _local_1) + "/") + LANG_LOC_FILENAME) + _arg_8) + LANG_LOC_FILETYPE;
            }
            localeDataMC = _arg_6.createEmptyMovieClip("localeDataMC", _arg_6.getNextHighestDepth());
            var _local_2 = new Object();
            var _local_3 = new MovieClipLoader();
            if (_arg_4 == LANG_ID_LOADERROR) {
                _local_2.onLoadError = function (_arg_2, _arg_1) {
                    com.clubpenguin.util.LocaleText.debugTrace("load error: " + _arg_1, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    com.clubpenguin.util.LocaleText.handleLoadComplete(_arg_2);
                };
            } else {
                _local_2.onLoadError = function (_arg_1) {
                    com.clubpenguin.util.LocaleText.init(_arg_1, com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR);
                };
            }
            if (_arg_7 != undefined) {
                _local_1 = _arg_7 + _local_1;
            }
            if (_arg_5) {
                _local_2.onLoadProgress = function (_arg_1, _arg_2, _arg_3) {
                    com.clubpenguin.util.Loader.handleLoadProgress(_arg_1, _arg_2, _arg_3);
                };
                _local_2.onLoadInit = function (_arg_1) {
                    com.clubpenguin.util.LocaleText.handleLoadComplete(_arg_1);
                    com.clubpenguin.util.Loader.handleLoadComplete(_arg_1);
                };
                debugTrace(("load filename " + _local_1) + " using Loader class");
                _local_3.addListener(_local_2);
                _local_3.loadClip(_local_1, localeDataMC);
                com.clubpenguin.util.Loader.addProgressObject(_local_3.getProgress(localeDataMC));
            } else {
                _local_2.onLoadInit = function (_arg_1) {
                    com.clubpenguin.util.LocaleText.handleLoadComplete(_arg_1);
                };
                debugTrace(("load filename " + _local_1) + " standalone");
                _local_3.addListener(_local_2);
                _local_3.loadClip(_local_1, localeDataMC);
            }
        }
        static function handleLoadComplete(_arg_1) {
            debugTrace("locale text loaded OK!");
            dataArray = new Array();
            for (var _local_2 in _arg_1.localeText) {
                dataArray[_arg_1.localeText[_local_2].id] = _arg_1.localeText[_local_2].value;
                debugTrace((("dataArray[" + _arg_1.localeText[_local_2].id) + "] = ") + _arg_1.localeText[_local_2].value);
            }
            var _local_3 = new Object();
            _local_3.target = com.clubpenguin.util.LocaleText;
            _local_3.type = EVENT_LOAD_COMPLETED;
            ready = true;
            eventSource.dispatchEvent(_local_3);
            debugTrace("dispatched LOAD_COMPLETED event");
        }
        static function addEventListener(_arg_1) {
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            eventSource.addEventListener(EVENT_LOAD_COMPLETED, _arg_1);
        }
        static function removeEventListener(_arg_1) {
            eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED, _arg_1);
        }
        static function getText(_arg_1) {
            if (!ready) {
                debugTrace("getText called when not ready", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                return(("[id:" + _arg_1) + " not ready]");
            }
            if (dataArray[_arg_1] == undefined) {
                debugTrace("load error for string: " + _arg_1, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(("[id:" + _arg_1) + " undefined]");
            }
            return(dataArray[_arg_1]);
        }
        static function localizeField(_arg_1, _arg_3, _arg_4, _arg_2) {
            _arg_1.text = getText(_arg_3);
            com.clubpenguin.text.TextResize.scaleDown(_arg_1, _arg_4, _arg_2);
        }
        static function getTextReplaced(_arg_5, _arg_4) {
            var _local_2 = getText(_arg_5);
            var _local_3 = _arg_4.length;
            var _local_1 = 0;
            while (_local_1 < _local_3) {
                _local_2 = _local_2.split("%" + _local_1).join(_arg_4[_local_1]);
                _local_1++;
            }
            return(_local_2);
        }
        static function getLocale(_arg_1) {
            switch (_arg_1) {
                case LANG_ID_EN : 
                    return(LANG_LOC_EN);
                case LANG_ID_PT : 
                    return(LANG_LOC_PT);
                case LANG_ID_FR : 
                    return(LANG_LOC_FR);
                case LANG_ID_ES : 
                    return(LANG_LOC_ES);
                case LANG_ID_DE : 
                    return(LANG_LOC_DE);
                case LANG_ID_RU : 
                    return(LANG_LOC_RU);
                case LANG_ID_LOADERROR : 
                    debugTrace("load error occurred! reload using default language", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                    return(LANG_LOC_EN);
            }
            debugTrace(("unknown language id: " + _arg_1) + ", using default language instead", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return(LANG_LOC_EN);
        }
        static function setLocaleVersion(_arg_1) {
            localeVersion = _arg_1;
        }
        static function setLocaleID(_arg_1) {
            localeID = _arg_1;
        }
        static function getLocaleID() {
            return(localeID);
        }
        static function isReady() {
            return(ready);
        }
        static function attachLocaleClip(_arg_3, _arg_4) {
            var _local_1 = localeDataMC.attachMovie(_arg_3, _arg_3 + "_mc", localeDataMC.getNextHighestDepth());
            var _local_2 = new flash.display.BitmapData(_local_1._width, _local_1._height, true, 0);
            _local_2.draw(_local_1, new flash.geom.Matrix(), new flash.geom.ColorTransform(), "normal");
            _arg_4.attachBitmap(_local_2, _arg_4.getNextHighestDepth());
            _local_1.removeMovieClip();
        }
        static function getGameDirectory(_arg_4) {
            if (_arg_4 == undefined) {
                if (localeDirectoryURL == undefined) {
                    debugTrace("using cached locale directory url that hasn't been set yet!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                }
                return(localeDirectoryURL);
            }
            var _local_2 = _arg_4.split("/");
            var _local_3 = "";
            var _local_1 = 0;
            while (_local_1 < (_local_2.length - 1)) {
                _local_3 = _local_3 + (_local_2[_local_1] + "/");
                _local_1++;
            }
            localeDirectoryURL = _local_3;
            return(localeDirectoryURL);
        }
        static function debugTrace($message, $priority) {
        }
        static var EVENT_LOAD_COMPLETED = "onLoadComplete";
        static var LANG_ID_LOADERROR = 0;
        static var LANG_ID_EN = 1;
        static var LANG_ID_PT = 2;
        static var LANG_ID_FR = 3;
        static var LANG_ID_ES = 4;
        static var LANG_ID_DE = 5;
        static var LANG_ID_RU = 6;
        static var LANG_ID_DEFAULT = LANG_ID_EN;
        static var LANG_LOC_FILENAME = "locale";
        static var LANG_LOC_FILETYPE = ".swf";
        static var LANG_LOC_DIRECTORY = "lang";
        static var LANG_LOC_EN = "en";
        static var LANG_LOC_PT = "pt";
        static var LANG_LOC_FR = "fr";
        static var LANG_LOC_ES = "es";
        static var LANG_LOC_DE = "de";
        static var LANG_LOC_RU = "ru";
        static var localeVersion = undefined;
        static var localeID = 0;
        static var ready = false;
    }
