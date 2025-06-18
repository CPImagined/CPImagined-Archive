class com.clubpenguin.util.LocaleText
{
   static var eventSource;
   static var locale;
   static var localeDataMC;
   static var dataArray;
   static var EVENT_LOAD_COMPLETED = "onLoadComplete";
   static var LANG_ID_DEFAULT = com.clubpenguin.util.LocaleText.LANG_ID_EN;
   static var LANG_ID_LOADERROR = 0;
   static var LANG_ID_EN = 1;
   static var LANG_ID_PT = 2;
   static var LANG_ID_FR = 3;
   static var LANG_ID_ES = 4;
   static var LANG_ID_DE = 5;
   static var LANG_ID_IT = 6;
   static var LANG_ID_ZH = 7;
   static var LANG_ID_JA = 8;
   static var LANG_ID_RU = 9;
   static var LANG_LOC_FILENAME = "locale";
   static var LANG_LOC_FILETYPE = ".swf";
   static var LANG_LOC_DIRECTORY = "lang";
   static var LANG_LOC_EN = "en";
   static var LANG_LOC_FR = "fr";
   static var LANG_LOC_ES = "es";
   static var LANG_LOC_DE = "de";
   static var LANG_LOC_IT = "it";
   static var LANG_LOC_PT = "pt";
   static var LANG_LOC_ZH = "zh";
   static var LANG_LOC_JA = "ja";
   static var LANG_LOC_RU = "ru";
   static var localeID = 0;
   static var ready = false;
   function LocaleText()
   {
   }
   static function init($parent, $languageID, $movieLocation, $versionNumber)
   {
      com.clubpenguin.util.LocaleText.debugTrace("initialise locale text");
      com.clubpenguin.util.LocaleText.ready = false;
      if(com.clubpenguin.util.LocaleText.eventSource == undefined)
      {
         com.clubpenguin.util.LocaleText.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
      }
      if($languageID == undefined)
      {
         $languageID = com.clubpenguin.util.LocaleText.LANG_ID_DEFAULT;
      }
      com.clubpenguin.util.LocaleText.localeID = $languageID;
      var _loc1_ = undefined;
      switch(com.clubpenguin.util.LocaleText.localeID)
      {
         case com.clubpenguin.util.LocaleText.LANG_ID_EN:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_EN;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_EN;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_FR:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_FR;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_FR;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_ES:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_ES;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_ES;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_DE:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_DE;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_DE;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_IT:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_IT;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_IT;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_PT:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_PT;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_PT;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_ZH:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_ZH;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_ZH;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_JA:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_JA;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_JA;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_RU:
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_RU;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_RU;
            break;
         case com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR:
            com.clubpenguin.util.LocaleText.debugTrace("load error occurred! reload using default language",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_EN;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_EN;
            break;
         default:
            com.clubpenguin.util.LocaleText.debugTrace("unknown language id: " + $languageID + ", using default language instead",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
            _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_EN;
            com.clubpenguin.util.LocaleText.locale = com.clubpenguin.util.LocaleText.LANG_LOC_EN;
      }
      if($versionNumber == undefined)
      {
         _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1_ + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
      }
      else
      {
         _loc1_ = com.clubpenguin.util.LocaleText.LANG_LOC_DIRECTORY + "/" + _loc1_ + "/" + com.clubpenguin.util.LocaleText.LANG_LOC_FILENAME + $versionNumber + com.clubpenguin.util.LocaleText.LANG_LOC_FILETYPE;
      }
      com.clubpenguin.util.LocaleText.localeDataMC = $parent.createEmptyMovieClip("localeDataMC",$parent.getNextHighestDepth());
      var _loc2_ = new Object();
      var _loc3_ = new MovieClipLoader();
      if($languageID == com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR)
      {
         _loc2_.onLoadError = function($targetMC, $errorMessage)
         {
            com.clubpenguin.util.LocaleText.debugTrace("load error: " + $errorMessage,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
         };
      }
      else
      {
         _loc2_.onLoadError = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.init($targetMC,com.clubpenguin.util.LocaleText.LANG_ID_LOADERROR);
         };
      }
      if($movieLocation == undefined)
      {
         _loc2_.onLoadInit = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
         };
         com.clubpenguin.util.LocaleText.debugTrace("load filename " + _loc1_);
         _loc3_.addListener(_loc2_);
         _loc3_.loadClip(_loc1_,com.clubpenguin.util.LocaleText.localeDataMC);
      }
      else
      {
         _loc1_ = $movieLocation + _loc1_;
         _loc2_.onLoadProgress = function($targetMC, $loadProgress, $loadTotal)
         {
            com.clubpenguin.util.Loader.handleLoadProgress($targetMC,$loadProgress,$loadTotal);
         };
         _loc2_.onLoadInit = function($targetMC)
         {
            com.clubpenguin.util.LocaleText.handleLoadComplete($targetMC);
            com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
         };
         com.clubpenguin.util.LocaleText.debugTrace("load filename " + _loc1_ + " using Loader class");
         _loc3_.addListener(_loc2_);
         _loc3_.loadClip(_loc1_,com.clubpenguin.util.LocaleText.localeDataMC);
         com.clubpenguin.util.Loader.addProgressObject(_loc3_.getProgress(com.clubpenguin.util.LocaleText.localeDataMC));
      }
   }
   static function handleLoadComplete($data)
   {
      com.clubpenguin.util.LocaleText.debugTrace("locale text loaded OK!");
      com.clubpenguin.util.LocaleText.dataArray = new Array();
      for(var _loc2_ in $data.localeText)
      {
         com.clubpenguin.util.LocaleText.dataArray[$data.localeText[_loc2_].id] = $data.localeText[_loc2_].value;
         com.clubpenguin.util.LocaleText.debugTrace("dataArray[" + $data.localeText[_loc2_].id + "] = " + $data.localeText[_loc2_].value);
      }
      var _loc3_ = new Object();
      _loc3_.target = com.clubpenguin.util.LocaleText;
      _loc3_.type = com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED;
      com.clubpenguin.util.LocaleText.ready = true;
      com.clubpenguin.util.LocaleText.eventSource.dispatchEvent(_loc3_);
      com.clubpenguin.util.LocaleText.debugTrace("dispatched LOAD_COMPLETED event");
   }
   static function addEventListener($listener)
   {
      if(com.clubpenguin.util.LocaleText.eventSource == undefined)
      {
         com.clubpenguin.util.LocaleText.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.LocaleText.eventSource);
      }
      com.clubpenguin.util.LocaleText.eventSource.addEventListener(com.clubpenguin.util.LocaleText.EVENT_LOAD_COMPLETED,$listener);
   }
   function removeEventListener($listener)
   {
      com.clubpenguin.util.LocaleText.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   }
   static function getText($stringID)
   {
      if(!com.clubpenguin.util.LocaleText.ready)
      {
         com.clubpenguin.util.LocaleText.debugTrace("getText called when not ready",com.clubpenguin.util.Reporting.DEBUGLEVEL_WARNING);
         return "[id:" + $stringID + " not ready]";
      }
      if(com.clubpenguin.util.LocaleText.dataArray[$stringID] == undefined)
      {
         com.clubpenguin.util.LocaleText.debugTrace("load error for string: " + $stringID,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return "[id:" + $stringID + " undefined]";
      }
      return com.clubpenguin.util.LocaleText.dataArray[$stringID];
   }
   static function getTextReplaced($stringID, $replacements)
   {
      var _loc2_ = com.clubpenguin.util.LocaleText.getText($stringID);
      var _loc3_ = $replacements.length;
      var _loc1_ = 0;
      while(_loc1_ < _loc3_)
      {
         _loc2_ = _loc2_.split("%" + _loc1_).join($replacements[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
      return _loc2_;
   }
   static function getLocale()
   {
      return com.clubpenguin.util.LocaleText.locale;
   }
   static function getLocaleID()
   {
      return com.clubpenguin.util.LocaleText.localeID;
   }
   static function isReady()
   {
      return com.clubpenguin.util.LocaleText.ready;
   }
   static function attachLocaleClip($stringID, $target)
   {
      var _loc1_ = com.clubpenguin.util.LocaleText.localeDataMC.attachMovie($stringID,$stringID + "_mc",com.clubpenguin.util.LocaleText.localeDataMC.getNextHighestDepth());
      var _loc2_ = new flash.display.BitmapData(_loc1_._width,_loc1_._height,true,0);
      _loc2_.draw(_loc1_,new flash.geom.Matrix(),new flash.geom.ColorTransform(),"normal");
      $target.attachBitmap(_loc2_,$target.getNextHighestDepth());
      _loc1_.removeMovieClip();
   }
   static function debugTrace($message, $priority)
   {
      if($priority == undefined)
      {
         $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG_LOCALE)
      {
         com.clubpenguin.util.Reporting.debugTrace("(LocaleText) " + $message,$priority);
      }
   }
}
