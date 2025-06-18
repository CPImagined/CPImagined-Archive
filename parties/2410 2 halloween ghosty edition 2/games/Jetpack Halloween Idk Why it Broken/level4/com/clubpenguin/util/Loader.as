class com.clubpenguin.util.Loader
{
   static var eventSource;
   static var EVENT_LOAD_COMPLETED = "onLoadComplete";
   static var EVENT_LOAD_IN_PROGRESS = "onLoadProgress";
   static var loadedMovies = 0;
   static var submovieProgress = new Array();
   static var localeVersion = undefined;
   static var localeOverride = undefined;
   function Loader()
   {
   }
   static function loadAllMovies($parent, $movieLocations, $initLocaleText)
   {
      if(com.clubpenguin.util.Loader.eventSource == undefined)
      {
         com.clubpenguin.util.Loader.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.Loader.eventSource);
      }
      com.clubpenguin.util.Loader.submovieProgress = new Array();
      com.clubpenguin.util.Loader.loadedMovies = 0;
      if($initLocaleText == undefined)
      {
         $initLocaleText = true;
      }
      if($movieLocations == undefined)
      {
         com.clubpenguin.util.Loader.debugTrace("no movieLocations array given!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      }
      else
      {
         var _loc2_ = $movieLocations[0].split("/");
         var _loc4_ = "";
         var _loc1_ = 0;
         while(_loc1_ < _loc2_.length - 1)
         {
            _loc4_ += _loc2_[_loc1_] + "/";
            _loc1_ += 1;
         }
         com.clubpenguin.util.Loader.debugTrace("root directory is \'" + _loc4_ + "\'");
         var _loc6_ = com.clubpenguin.util.Loader.localeOverride == undefined ? com.clubpenguin.util.LocaleText.LANG_ID_EN : com.clubpenguin.util.Loader.localeOverride;
         var _loc7_ = com.clubpenguin.util.Loader.localeVersion == undefined ? com.clubpenguin.util.Loader.localeVersion : com.clubpenguin.util.Loader.localeVersion;
         if($initLocaleText)
         {
            com.clubpenguin.util.LocaleText.init($parent,_loc6_,_loc4_,_loc7_,true);
         }
      }
      _loc1_ = 0;
      while(_loc1_ < $movieLocations.length)
      {
         com.clubpenguin.util.Loader.loadSubmovie($parent,$movieLocations[_loc1_],_loc1_);
         _loc1_ += 1;
      }
   }
   static function loadSubmovie($parent, $movieLocation, $movieNum)
   {
      com.clubpenguin.util.Loader.debugTrace("load submovie");
      if($parent == undefined)
      {
         com.clubpenguin.util.Loader.debugTrace("cannot load movie, parent movie is undefined!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return undefined;
      }
      if($movieLocation == undefined)
      {
         com.clubpenguin.util.Loader.debugTrace("cannot load movie, movie location is undefined!",com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
         return undefined;
      }
      var _loc3_ = $parent.createEmptyMovieClip("loadDataMC" + $movieNum,$parent.getNextHighestDepth());
      var _loc1_ = new Object();
      var _loc2_ = new MovieClipLoader();
      _loc1_.onLoadInit = function($targetMC)
      {
         com.clubpenguin.util.Loader.handleLoadComplete($targetMC);
      };
      _loc1_.onLoadProgress = function($targetMC, $loadProgress, $loadTotal)
      {
         com.clubpenguin.util.Loader.handleLoadProgress($targetMC,$loadProgress,$loadTotal);
      };
      _loc1_.onLoadError = function($targetMC, $errorMessage)
      {
         com.clubpenguin.util.Loader.debugTrace("error loading submovie: " + $errorMessage,com.clubpenguin.util.Reporting.DEBUGLEVEL_ERROR);
      };
      _loc2_.addListener(_loc1_);
      _loc2_.loadClip($movieLocation,_loc3_);
      com.clubpenguin.util.Loader.addProgressObject(_loc2_.getProgress(_loc3_));
   }
   static function handleLoadProgress($mainMovie, $loadProgress, $loadTotal)
   {
      var _loc2_ = 0;
      var _loc3_ = 0;
      var _loc1_ = 0;
      while(_loc1_ < com.clubpenguin.util.Loader.submovieProgress.length)
      {
         if(com.clubpenguin.util.Loader.submovieProgress[_loc1_].movieClip == $mainMovie)
         {
            com.clubpenguin.util.Loader.submovieProgress[_loc1_].bytesLoaded = $loadProgress;
            com.clubpenguin.util.Loader.submovieProgress[_loc1_].bytesTotal = $loadTotal;
         }
         _loc3_ += com.clubpenguin.util.Loader.submovieProgress[_loc1_].bytesLoaded;
         _loc2_ += com.clubpenguin.util.Loader.submovieProgress[_loc1_].bytesTotal;
         _loc1_ += 1;
      }
      var _loc7_ = _loc3_ / _loc2_ * 100;
      com.clubpenguin.util.Loader.debugTrace("updated load progress. movie is now " + Math.round(_loc7_) + "% loaded");
   }
   static function handleLoadComplete($mainMovie)
   {
      com.clubpenguin.util.Loader.debugTrace("submovie loaded OK! are all loaded?");
      if($mainMovie._name != "loadDataMC0")
      {
         $mainMovie.removeMovieClip();
      }
      com.clubpenguin.util.Loader.loadedMovies++;
      if(com.clubpenguin.util.Loader.loadedMovies >= com.clubpenguin.util.Loader.submovieProgress.length)
      {
         com.clubpenguin.util.Loader.debugTrace("all movies loaded OK!");
         var _loc1_ = new Object();
         _loc1_.target = com.clubpenguin.util.Loader;
         _loc1_.type = com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED;
         com.clubpenguin.util.Loader.eventSource.dispatchEvent(_loc1_);
         com.clubpenguin.util.Loader.debugTrace("dispatched LOAD_COMPLETED event");
      }
   }
   static function addEventListener($listener)
   {
      if(com.clubpenguin.util.Loader.eventSource == undefined)
      {
         com.clubpenguin.util.Loader.eventSource = new Object();
         mx.events.EventDispatcher.initialize(com.clubpenguin.util.Loader.eventSource);
      }
      com.clubpenguin.util.Loader.eventSource.addEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   }
   static function removeEventListener($listener)
   {
      com.clubpenguin.util.Loader.eventSource.removeEventListener(com.clubpenguin.util.Loader.EVENT_LOAD_COMPLETED,$listener);
   }
   static function setLocale($locale)
   {
      com.clubpenguin.util.Loader.localeOverride = $locale;
   }
   static function setLocaleVersion($localeVersion)
   {
      com.clubpenguin.util.Loader.localeVersion = $localeVersion;
   }
   static function addProgressObject($progress)
   {
      com.clubpenguin.util.Loader.submovieProgress.push($progress);
   }
   static function debugTrace($message, $priority)
   {
      if($priority == undefined)
      {
         $priority = com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE;
      }
      if(com.clubpenguin.util.Reporting.DEBUG_LOCALE)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Loader) " + $message,$priority);
      }
   }
}
