class com.clubpenguin.shell.PuffleModel
{
   var id = -1;
   var typeID = -1;
   var subTypeID = -1;
   var name = "";
   var _puffleState = 0;
   function PuffleModel()
   {
      this.mood = new com.clubpenguin.shell.PuffleMoodVO();
      this.hat = new com.clubpenguin.shell.puffle.PuffleHatVO();
      this.stats = new com.clubpenguin.shell.PuffleStatsVO();
   }
   function hasHat()
   {
      return this.hat.hatType != com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT ? false : true;
   }
   function updateStats()
   {
   }
   function updatePuffleState(puffleState)
   {
      this._puffleState = puffleState;
   }
   function getPuffleState()
   {
      return this._puffleState;
   }
   function getFormattedAssetURL(assetURL)
   {
      return com.clubpenguin.shell.PuffleModel.formatAssetURL(assetURL,this.color,this.subTypeID);
   }
   function isWildPuffle()
   {
      return this.subTypeID != null && this.subTypeID != undefined && this.subTypeID != -1 && !isNaN(this.subTypeID);
   }
   static function formatAssetURL(assetURL, puffleColor, puffleSubTypeID)
   {
      var _loc2_ = !(isNaN(puffleSubTypeID) || puffleSubTypeID == 0) ? String(puffleSubTypeID) : "";
      assetURL = com.clubpenguin.util.StringUtils.replaceString("%color%",String(puffleColor),assetURL);
      assetURL = com.clubpenguin.util.StringUtils.replaceString("%wildTypeId%",String(_loc2_),assetURL);
      return assetURL;
   }
}
