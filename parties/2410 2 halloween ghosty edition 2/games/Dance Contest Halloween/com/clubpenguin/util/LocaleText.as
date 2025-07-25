﻿
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.LocaleText
    {
        static var eventSource, locale, localeDataMC, dataArray, localeDirectoryURL;
        function LocaleText () {
        }
        static function init($parent, $languageID, $movieLocation, $versionNumber, $useLoader) {
            debugTrace("initialise locale text");
            ready = false;
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            if ($useLoader == undefined) {
                $useLoader = false;
            }
            if ($languageID == undefined) {
                $languageID = getLocaleID();
            }
            localeID = $languageID;
            var _local1 = getLocale(localeID);
            locale = getLocale(localeID);
            if ($versionNumber == undefined) {
                if (localeVersion == undefined) {
                    _local1 = ((((LANG_LOC_DIRECTORY + "/") + _local1) + "/") + LANG_LOC_FILENAME) + LANG_LOC_FILETYPE;
                } else {
                    _local1 = (((((LANG_LOC_DIRECTORY + "/") + _local1) + "/") + LANG_LOC_FILENAME) + localeVersion) + LANG_LOC_FILETYPE;
                }
            } else {
                _local1 = (((((LANG_LOC_DIRECTORY + "/") + _local1) + "/") + LANG_LOC_FILENAME) + $versionNumber) + LANG_LOC_FILETYPE;
            }
            localeDataMC = $parent.createEmptyMovieClip("localeDataMC", $parent.getNextHighestDepth());
            var _local2 = new Object();
            var _local3 = new MovieClipLoader();
            if ($languageID == LANG_ID_LOADERROR) {
                _local2.onLoadError = function ($targetMC, $errorMessage) {
                    com.clubpenguin.util.LocaleText.debugTrace("load error: " + $errorMessage, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                    com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
                };
            } else {
                _local2.onLoadError = function ($targetMC) {
                    com.clubpenguin.util.LocaleText.init($targetMC, com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR);
                };
            }
            if ($movieLocation != undefined) {
                _local1 = $movieLocation + _local1;
            }
            if ($useLoader) {
                _local2.onLoadProgress = function ($targetMC, $loadProgress, $loadTotal) {
                    com.clubpenguin.util.Loader.handleLoadProgress($targetMC, $loadProgress, $loadTotal);
                };
                _local2.onLoadInit = function ($targetMC) {
                    com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
                    com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
                };
                debugTrace(("load filename " + _local1) + " using Loader class");
                _local3.addListener(_local2);
                _local3.loadClip(_local1, localeDataMC);
                com.clubpenguin.util.Loader.addProgressObject(_local3.getProgress(localeDataMC));
            } else {
                _local2.onLoadInit = function ($targetMC) {
                    com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
                };
                debugTrace(("load filename " + _local1) + " standalone");
                _local3.addListener(_local2);
                _local3.loadClip(_local1, localeDataMC);
            }
        }
        static function handleLoadComplete($data) {
            debugTrace("locale text loaded OK!");
            dataArray = new Array();
            for (var _local2 in $data.localeText) {
                dataArray[$data.localeText[_local2].id] = $data.localeText[_local2].value;
                debugTrace((("dataArray[" + $data.localeText[_local2].id) + "] = ") + $data.localeText[_local2].value);
            }
            var _local3 = new Object();
            _local3.target = com.clubpenguin.util.LocaleText;
            _local3.type = EVENT_LOAD_COMPLETED;
            ready = true;
            eventSource.dispatchEvent(_local3);
            debugTrace("dispatched LOAD_COMPLETED event");
        }
        static function addEventListener($listener) {
            if (eventSource == undefined) {
                eventSource = new Object();
                mx.events.EventDispatcher.initialize(eventSource);
            }
            eventSource.addEventListener(EVENT_LOAD_COMPLETED, $listener);
        }
        static function removeEventListener($listener) {
            eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED, $listener);
        }
        static function getText($stringID) {
            if (!ready) {
                debugTrace("getText called when not ready", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                return(("[id:" + $stringID) + " not ready]");
            } else if (dataArray[$stringID] == undefined) {
                debugTrace("load error for string: " + $stringID, com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
                return(("[id:" + $stringID) + " undefined]");
            }
            return(dataArray[$stringID]);
        }
        static function localizeField($field, $stringID, $verticalAlign, $minFontSize) {
            $field.text = getText($stringID);
            com.clubpenguin.text.TextResize.scaleDown($field, $verticalAlign, $minFontSize);
        }
        static function getTextReplaced($stringID, $replacements) {
            var _local2 = getText($stringID);
            var _local3 = $replacements.length;
            var _local1 = 0;
            while (_local1 < _local3) {
                _local2 = _local2.split("%" + _local1).join($replacements[_local1]);
                _local1++;
            }
            return(_local2);
        }
        static function getLocale($localeID) {
            switch ($localeID) {
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
            debugTrace(("unknown language id: " + $localeID) + ", using default language instead", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            return(LANG_LOC_EN);
            return(LANG_LOC_EN);
        }
        static function setLocaleVersion($localeVersion) {
            localeVersion = $localeVersion;
        }
        static function setLocaleID($localeID) {
            localeID = $localeID;
        }
        static function getLocaleID() {
            return(localeID);
        }
        static function isReady() {
            return(ready);
        }
        static function attachLocaleClip($stringID, $target) {
            var _local1 = localeDataMC.attachMovie($stringID, $stringID + "_mc", localeDataMC.getNextHighestDepth());
            var _local2 = new flash.display.BitmapData(_local1._width, _local1._height, true, 0);
            _local2.draw(_local1, new flash.geom.Matrix(), new flash.geom.ColorTransform(), "normal");
            $target.attachBitmap(_local2, $target.getNextHighestDepth());
            _local1.removeMovieClip();
        }
        static function getGameDirectory($url) {
            if ($url == undefined) {
                if (localeDirectoryURL == undefined) {
                    debugTrace("using cached locale directory url that hasn't been set yet!", com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
                }
                return(localeDirectoryURL);
            }
            var _local2 = $url.split("/");
            var _local3 = "";
            var _local1 = 0;
            while (_local1 < (_local2.length - 1)) {
                _local3 = _local3 + (_local2[_local1] + "/");
                _local1++;
            }
            localeDirectoryURL = _local3;
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
