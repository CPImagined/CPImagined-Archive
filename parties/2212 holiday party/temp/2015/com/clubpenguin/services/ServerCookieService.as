class com.clubpenguin.services.ServerCookieService
{
   function ServerCookieService()
   {
      this.init();
   }
   function init()
   {
      this._airtowerListeners = {};
      if(this._airtower != null)
      {
         this.removeAirtowerListeners();
      }
      this._airtower = _global.getCurrentAirtower();
      this._shell = _global.getCurrentShell();
      this._cookies = {};
   }
   function registerCookieVO(cookieId, cookieVO)
   {
      if(this._cookies[cookieId] != null)
      {
         return false;
      }
      this._cookies[cookieId] = cookieVO;
      if(this._airtowerListeners[cookieVO.getReceiveCommandName()] != true)
      {
         this._airtowerListeners[cookieVO.getReceiveCommandName()] = true;
         this._airtower.addListener(cookieVO.getReceiveCommandName(),com.clubpenguin.util.Delegate.create(this,this.onServerCookieReceived,cookieId),this);
      }
      return true;
   }
   function getCookieVO(cookieId)
   {
      return this._cookies[cookieId];
   }
   function requestCookieFromServer(cookieId)
   {
      var _loc2_ = this.getCookieVO(cookieId);
      if(_loc2_ != null)
      {
         this._airtower.send(this._airtower.PLAY_EXT,_loc2_.getCookieHandlerName() + "#" + _loc2_.getReceiveCommandName(),[],"str",this._shell.getCurrentServerRoomId());
      }
   }
   function sendCookieToServer(cookieId)
   {
      var _loc2_ = this.getCookieVO(cookieId);
      if(_loc2_ != null)
      {
         this._airtower.send(this._airtower.PLAY_EXT,_loc2_.getCookieHandlerName() + "#" + _loc2_.getSendCommandName(),[_loc2_.serialize()],"str",this._shell.getCurrentServerRoomId());
      }
   }
   function onServerCookieReceived(data, cookieId)
   {
      var _loc4_ = data[0];
      var _loc3_ = data[1];
      var _loc2_ = this._cookies[cookieId];
      if(_loc2_ != null)
      {
         _loc2_.deserialize(_loc3_);
      }
   }
   function removeAirtowerListeners()
   {
      for(var _loc2_ in this._airtowerListeners)
      {
         this._airtower.removeListener(_loc2_,this.onServerCookieReceived);
      }
   }
}
