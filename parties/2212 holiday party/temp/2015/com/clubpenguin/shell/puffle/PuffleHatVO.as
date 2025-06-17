class com.clubpenguin.shell.puffle.PuffleHatVO
{
   static var HAT_DATA_DELIMITER = "@";
   static var EMPTY_HAT_ID = 0;
   static var HAT = "_hat";
   static var FRONT = "_front";
   static var BACK = "_back";
   static var SWF = ".swf";
   function PuffleHatVO()
   {
   }
   function getAS2AssetPath()
   {
      var _loc2_ = this.assetLinkage.indexOf("/") + 1;
      var _loc4_ = this.assetLinkage.indexOf(".");
      var _loc3_ = this.assetLinkage.substring(_loc2_,_loc4_);
      return _loc3_;
   }
   function setHatFrontAsset()
   {
      var _loc2_ = this.getAS2AssetPath() + com.clubpenguin.shell.puffle.PuffleHatVO.HAT + com.clubpenguin.shell.puffle.PuffleHatVO.FRONT;
      _loc2_ = _loc2_.toLowerCase();
      _loc2_ += com.clubpenguin.shell.puffle.PuffleHatVO.SWF;
      this.hatFrontAsset = _loc2_;
   }
   function setHatBackAsset()
   {
      var _loc2_ = this.getAS2AssetPath() + com.clubpenguin.shell.puffle.PuffleHatVO.HAT + com.clubpenguin.shell.puffle.PuffleHatVO.BACK;
      _loc2_ = _loc2_.toLowerCase();
      _loc2_ += com.clubpenguin.shell.puffle.PuffleHatVO.SWF;
      this.hatBackAsset = _loc2_;
   }
   static function getEmptyHatVO()
   {
      var _loc1_ = new com.clubpenguin.shell.puffle.PuffleHatVO();
      _loc1_.id = com.clubpenguin.shell.puffle.PuffleHatVO.EMPTY_HAT_ID;
      _loc1_.name = "";
      _loc1_.label = "";
      _loc1_.assetLinkage = "";
      _loc1_.hatType = com.clubpenguin.shell.puffle.PuffleHatEnum.EMPTY_HAT;
      return _loc1_;
   }
   function outputHatVO()
   {
   }
}
