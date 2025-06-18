class com.clubpenguin.security.Security
{
   function Security()
   {
   }
   static function doSecurityCheck($stageURL, $stageParent)
   {
      if(!com.clubpenguin.security.Security.checkDomain($stageURL,$stageParent))
      {
         return false;
      }
      com.clubpenguin.security.Security.allowDomains();
      return true;
   }
   static function checkDomain($stageURL, $stageParent)
   {
      if(com.clubpenguin.util.Reporting.DEBUG_SECURITY)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Security) checking launch from within club penguin:",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
         com.clubpenguin.util.Reporting.debugTrace("(Security) stageURL = " + $stageURL + ", stageParent = " + $stageParent,com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      }
      var _loc2_ = false;
      if($stageURL.substr(0,4) == "http")
      {
         var _loc4_ = new Array();
         _loc4_ = $stageURL.split("/");
         var _loc3_ = "clubpenguin.com";
         if(_loc4_[2].substr(- _loc3_.length) == _loc3_)
         {
            _loc2_ = true;
         }
      }
      if($stageParent == undefined)
      {
         _loc2_ = false;
      }
      if(!_loc2_)
      {
         _root.loadMovie();
      }
      return _loc2_;
   }
   static function allowDomains()
   {
      if(com.clubpenguin.util.Reporting.DEBUG_SECURITY)
      {
         com.clubpenguin.util.Reporting.debugTrace("(Security) allowing all domains",com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
      }
      var _loc2_ = com.clubpenguin.security.Domains.getAllowedDomains();
      var _loc1_ = 0;
      var _loc3_ = _loc2_.length;
      while(_loc1_ < _loc3_)
      {
         if(com.clubpenguin.util.Reporting.DEBUG_SECURITY)
         {
            com.clubpenguin.util.Reporting.debugTrace("(Security) allowing domain " + _loc2_[_loc1_],com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
         }
         System.security.allowDomain(_loc2_[_loc1_]);
         _loc1_ = _loc1_ + 1;
      }
   }
}
