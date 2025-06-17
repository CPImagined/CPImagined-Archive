class com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
{
   static var TEMPLATE_COOKIE_HANDLER_NAME = "party";
   static var TEMPLATE_RECEIVE_COMMAND_NAME = "partycookie";
   static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
   static var MESSAGE_VIEWED_COMMAND = "msgviewed";
   static var QC_MESSAGE_VIEWED_COMMAND = "qcmsgviewed";
   static var QUEST_TASK_COMPLETE = "qtaskcomplete";
   static var DECEMBER_PARTY_COINS_EARNED = "qtupdate";
   static var QUEST_LENGTH = 4;
   static var CFC_GLOBAL_TOTAL = "cfcglobaltotal";
   static var CFC_STATION_DONATE = "cfcstationdonate";
   function TemplatePartyCookieVO(cookieId)
   {
      super(cookieId);
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower = _global.getCurrentAirtower();
   }
   function getCookieHandlerName()
   {
      return com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME;
   }
   function getSendCommandName()
   {
      return "ERROR-NO-COOKIE-SEND-COMMAND";
   }
   function getReceiveCommandName()
   {
      return com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_RECEIVE_COMMAND_NAME;
   }
   function get msgViewedArray()
   {
      if(this._jsonObject.msgViewedArray == undefined)
      {
         return [0,0,0,0,0,0,0,0,0,0,0];
      }
      return this._jsonObject.msgViewedArray;
   }
   function get questCommMsgArray()
   {
      if(this._jsonObject.communicatorMsgArray == undefined)
      {
         return [0,0,0,0,0];
      }
      return this._jsonObject.communicatorMsgArray;
   }
   function get questTaskArray()
   {
      if(this._jsonObject.questTaskStatus == undefined)
      {
         return [0,0,0,0,0,0,0,0,0,0];
      }
      return this._jsonObject.questTaskStatus;
   }
   function sendCoinsEarned(coins)
   {
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.DECEMBER_PARTY_COINS_EARNED,[coins],"str",_global.getCurrentShell().getCurrentServerRoomId());
      if(!com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._updateTotalCoinsDelegate)
      {
         com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._updateTotalCoinsDelegate = com.clubpenguin.util.Delegate.create(this,this.updatedCoinsTotal);
         com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.addListener(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.DECEMBER_PARTY_COINS_EARNED,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._updateTotalCoinsDelegate);
      }
   }
   function updatedCoinsTotal(data)
   {
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.removeListener(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.DECEMBER_PARTY_COINS_EARNED,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._updateTotalCoinsDelegate);
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._updateTotalCoinsDelegate = null;
      var _loc2_ = Number(data[1]);
      _global.getCurrentShell().setMyPlayerTotalCoins(_loc2_);
   }
   function sendRequestCFCGlobalTotal()
   {
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.CFC_GLOBAL_TOTAL,[0],"str",_global.getCurrentShell().getCurrentServerRoomId());
   }
   function sendCFCDonation(coinsDonated)
   {
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.CFC_STATION_DONATE,[coinsDonated],"str",_global.getCurrentShell().getCurrentServerRoomId());
   }
   function sendRequestPartyCookie()
   {
      com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_RECEIVE_COMMAND_NAME,[0],"str",_global.getCurrentShell().getCurrentServerRoomId());
   }
   function sendMessageViewed(messageIndex)
   {
      if(messageIndex >= 0 && messageIndex < this.__get__msgViewedArray().length)
      {
         com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.MESSAGE_VIEWED_COMMAND,[messageIndex],"str",_global.getCurrentShell().getCurrentServerRoomId());
      }
      else
      {
         this.traceSetError("sendMessageViewed",messageIndex);
      }
   }
   function sendQCMessageViewed(messageIndex)
   {
      if(messageIndex >= 0 && messageIndex < this.__get__questCommMsgArray().length)
      {
         com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.QC_MESSAGE_VIEWED_COMMAND,[messageIndex],"str",_global.getCurrentShell().getCurrentServerRoomId());
      }
      else
      {
         this.traceSetError("sendQCMessageViewed",messageIndex);
      }
   }
   function sendTaskComplete(taskIndex)
   {
      if(taskIndex >= 0 && taskIndex < this.__get__questTaskArray().length)
      {
         com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.send(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO._airtower.PLAY_EXT,com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.TEMPLATE_COOKIE_HANDLER_NAME + "#" + com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.QUEST_TASK_COMPLETE,[taskIndex],"str",_global.getCurrentShell().getCurrentServerRoomId());
      }
      else
      {
         this.traceSetError("sendTaskComplete",taskIndex);
      }
   }
   function hasPlayerViewedMessage(messageIndex)
   {
      return this.__get__msgViewedArray()[messageIndex] != 1 ? false : true;
   }
   function hasPlayerViewedQCMessage(messageIndex)
   {
      return this.__get__questCommMsgArray()[messageIndex] != 1 ? false : true;
   }
   function hasPlayerCompletedTask(taskIndex)
   {
      return this.__get__questTaskArray()[taskIndex] != 1 ? false : true;
   }
   function getNextAvailableTask()
   {
      var _loc2_ = 0;
      while(_loc2_ < com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.QUEST_LENGTH)
      {
         if(this.__get__questTaskArray()[_loc2_] == 0)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return undefined;
   }
   function traceSetError(propertyName, value)
   {
   }
}
