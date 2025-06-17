class com.clubpenguin.party.BaseParty
{
   static var OBJECT_UNDEFINED = "****[ERROR:Object Undefined]**** ";
   static var CLASS_NAME = "BaseParty";
   static var PARTY_SETTINGS_RESPONSE_NAME = "partyservice";
   static var _this = com.clubpenguin.party.BaseParty;
   static var _firstTimeLogin = false;
   function BaseParty()
   {
   }
   static function init(cookieVO)
   {
      com.clubpenguin.party.BaseParty.pebug("BASE PARTY - INIT !!!");
      com.clubpenguin.party.BaseParty._shell = _global.getCurrentShell();
      com.clubpenguin.party.BaseParty._airtower = _global.getCurrentAirtower();
      com.clubpenguin.party.BaseParty._interface = _global.getCurrentInterface();
      com.clubpenguin.party.BaseParty._engine = _global.getCurrentEngine();
      com.clubpenguin.party.BaseParty._party = _global.getCurrentParty();
      com.clubpenguin.party.BaseParty.initServerCookie(cookieVO);
      com.clubpenguin.party.BaseParty.addListenerForPartySettings(com.clubpenguin.party.BaseParty.PARTY_SETTINGS_RESPONSE_NAME);
   }
   static function initServerCookie(cookieVO)
   {
      com.clubpenguin.party.BaseParty._serverCookieService = com.clubpenguin.party.BaseParty._shell.getServerCookieService();
      com.clubpenguin.party.BaseParty._serverCookie = cookieVO;
      com.clubpenguin.party.BaseParty._serverCookieService.registerCookieVO(com.clubpenguin.party.BaseParty._serverCookie.getID(),com.clubpenguin.party.BaseParty._serverCookie);
   }
   static function get serverCookie()
   {
      return com.clubpenguin.party.BaseParty._serverCookie;
   }
   static function pebug(msg, prefix)
   {
      if(undefined == prefix)
      {
         prefix = com.clubpenguin.party.BaseParty.CLASS_NAME;
      }
      com.clubpenguin.util.Log.debug(prefix + "::" + msg,com.clubpenguin.util.Log.PARTY);
   }
   static function addListenerForPartySettings(listenerName)
   {
      com.clubpenguin.party.BaseParty._airtower.addListener(listenerName,com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._this,com.clubpenguin.party.BaseParty.handleUpdatePartySettings));
   }
   static function handleUpdatePartySettings(data)
   {
      com.clubpenguin.party.BaseParty.pebug("BaseParty.handleUpdatePartySettings");
      var _loc1_ = com.clubpenguin.util.JSONParser.parse(data[1]);
      com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE = _loc1_;
      com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().configurePartySettings();
      com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_DAY = com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex;
   }
   static function playSound(ui, soundId, volume)
   {
      if(volume == undefined)
      {
         volume = 100;
      }
      var _loc1_ = new Sound(ui);
      _loc1_.attachSound(soundId);
      _loc1_.setVolume(volume);
      _loc1_.start();
   }
   static function soundButton(ui, soundId, callback, timeout)
   {
      com.clubpenguin.party.BaseParty._this.playSound(ui,soundId);
      setTimeout(callback,timeout);
   }
   static function setConditionalPartyIconVisibility()
   {
      if(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible != undefined)
      {
         com.clubpenguin.party.BaseParty.activatePartyIconOverrides();
      }
      else
      {
         com.clubpenguin.party.BaseParty.pebug("setConditionalPartyIconVisibility(): The current party does not have a getter called partyIconVisible(), please define.",com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
      }
   }
   static function checkForFirstTimeLogin(playerObj)
   {
      com.clubpenguin.party.BaseParty.pebug("Check for first time login");
      com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().checkForFirstTimeLogin(playerObj);
   }
   static function showPartyMap()
   {
      com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_MAP_PATH);
   }
   static function openQuestUI()
   {
      com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.QUEST_UI_PATH);
   }
   static function showIglooList()
   {
      com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_LIST_PATH);
   }
   static function showIglooPrompt()
   {
      com.clubpenguin.party.BaseParty._interface.showContent(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_PROMPT_PATH);
   }
   static function get updatePlayerFrame()
   {
      if(com.clubpenguin.party.BaseParty._updatePlayerFrame == undefined)
      {
         com.clubpenguin.party.BaseParty._updatePlayerFrame = new org.osflash.signals.Signal(Number);
      }
      return com.clubpenguin.party.BaseParty._updatePlayerFrame;
   }
   static function dispatchUpdatePlayerFrame(player_id)
   {
      com.clubpenguin.party.BaseParty.pebug("dispatchUpdatePlayerFrame");
      com.clubpenguin.party.BaseParty._updatePlayerFrame.dispatch(player_id);
   }
   static function handleWearButtonClicked()
   {
      if(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().handleWearButtonClicked != undefined)
      {
         com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().handleWearButtonClicked();
      }
      else
      {
         _global.getCurrentInterface().closeContent();
      }
   }
   static function set CURRENT_PARTY(party)
   {
      com.clubpenguin.party.BaseParty._currentParty = party;
   }
   static function get CURRENT_PARTY()
   {
      if(com.clubpenguin.party.BaseParty._currentParty != undefined)
      {
         return com.clubpenguin.party.BaseParty._currentParty;
      }
      com.clubpenguin.party.BaseParty.pebug("CURRENT_PARTY is undefined - make sure your main party class sets this value in its init function. Returning BaseParty.",com.clubpenguin.party.BaseParty.OBJECT_UNDEFINED);
      return com.clubpenguin.party.BaseParty._this;
   }
   static function get partySettings()
   {
      return com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.PARTY_SERVICE;
   }
   static function get interfaceOverrides()
   {
      if(com.clubpenguin.party.BaseParty._interfaceOverrides == null)
      {
         com.clubpenguin.party.BaseParty._interfaceOverrides = new com.clubpenguin.party.Party_InterfaceOverrides();
      }
      return com.clubpenguin.party.BaseParty._interfaceOverrides;
   }
   static function get isPartyRoom()
   {
      var _loc1_ = com.clubpenguin.party.BaseParty._shell.getRoomObject().room_id;
      if(_loc1_ != undefined && _loc1_ >= com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.FIRST_PARTY_ROOM_ID && _loc1_ <= com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.LAST_PARTY_ROOM_ID)
      {
         return true;
      }
      return false;
   }
   static function get itemForSaleOnIglooList()
   {
      return com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().itemOnIglooList;
   }
   static function get partyIglooListItems()
   {
      return com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().CONSTANTS.IGLOO_LIST_ITEMS;
   }
   static function showPartyIcon(firstTimeLogin)
   {
      if(firstTimeLogin != undefined && firstTimeLogin == true)
      {
         com.clubpenguin.party.BaseParty._firstTimeLogin = true;
      }
      com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = true;
      if(com.clubpenguin.party.BaseParty._firstTimeLogin == true)
      {
         com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().activateFirstTimeUserPartyFunctionality();
      }
      com.clubpenguin.party.BaseParty.pebug("SHOW PARTY ICON");
   }
   static function hidePartyIcon()
   {
      com.clubpenguin.party.BaseParty.pebug("HIDE PARTY ICON");
      com.clubpenguin.party.BaseParty.pebug("\t\t_interface : " + com.clubpenguin.party.BaseParty._interface);
      com.clubpenguin.party.BaseParty.pebug("\t\t_interface.PARTY_ICON : " + com.clubpenguin.party.BaseParty._interface.PARTY_ICON);
      com.clubpenguin.party.BaseParty._interface.PARTY_ICON._visible = false;
   }
   static function partyIconState()
   {
      com.clubpenguin.party.BaseParty.pebug("PARTY ICON STATE - show it? :  " + com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible);
      if(com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible || com.clubpenguin.party.BaseParty._firstTimeLogin)
      {
         com.clubpenguin.party.BaseParty.showPartyIcon();
         com.clubpenguin.party.BaseParty.pebug(" - showPartyIcon()",com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible);
      }
      else
      {
         com.clubpenguin.party.BaseParty.hidePartyIcon();
         com.clubpenguin.party.BaseParty.pebug(" - hidePartyIcon()",com.clubpenguin.party.BaseParty.__get__CURRENT_PARTY().partyIconVisible);
      }
   }
   static function activatePartyIconOverrides()
   {
      com.clubpenguin.party.BaseParty.pebug("Activate interface overrides");
      com.clubpenguin.party.BaseParty._interface.showPartyIcon = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface,com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.showPartyIcon);
      com.clubpenguin.party.BaseParty._interface.onPartyIconLoad = com.clubpenguin.util.Delegate.create(com.clubpenguin.party.BaseParty._interface,com.clubpenguin.party.BaseParty._party.BaseParty.interfaceOverrides.onPartyIconLoad);
   }
   static function sendBIIglooVisit(isPartyIgloo, itemId)
   {
      var _loc2_ = "party_igloo_visit";
      var _loc3_ = String("iglooID_" + itemId);
      var _loc1_ = new Object();
      _loc1_.message = !isPartyIgloo ? "party_item_missing" : "party_item_present";
      com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_loc3_,_loc2_,_loc1_);
   }
   static function sendGoThereBI(room)
   {
   }
   static function sendOpenQuestBI()
   {
   }
   static function sendScrollQuestBI()
   {
   }
   static function sendTaskCompleteBI(taskID, messageString)
   {
   }
}
