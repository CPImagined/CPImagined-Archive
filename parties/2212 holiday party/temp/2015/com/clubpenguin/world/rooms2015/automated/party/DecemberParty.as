class com.clubpenguin.world.rooms2015.automated.party.DecemberParty
{
   static var _this = com.clubpenguin.world.rooms2015.automated.party.DecemberParty;
   static var _isActive = false;
   static var TEST_STRING = "Party Class Test String";
   function DecemberParty()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty: Entering");
   }
   static function init()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty - INIT");
      com.clubpenguin.party.BaseParty.CLASS_NAME = com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this.CLASS_NAME;
      com.clubpenguin.party.BaseParty.__set__CURRENT_PARTY(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this);
      com.clubpenguin.party.BaseParty.setConditionalPartyIconVisibility();
      com.clubpenguin.party.BaseParty.addListenerForPartySettings(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_SETTINGS_RESPONSE_NAME);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._isActive = true;
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell = _global.getCurrentShell();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower = _global.getCurrentAirtower();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface = _global.getCurrentInterface();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine = _global.getCurrentEngine();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._party = _global.getCurrentParty();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._partycookieUpdateHandlerDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this,com.clubpenguin.world.rooms2015.automated.party.DecemberParty.partycookieUpdateHandler);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower.addListener("partycookie",com.clubpenguin.world.rooms2015.automated.party.DecemberParty._partycookieUpdateHandlerDelegate);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendRequestPartyCookie();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.activateSnowballOverrides();
      com.clubpenguin.world.rooms2015.automated.party.DecemberSounds.init();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower.addListener("partyservice",com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this,com.clubpenguin.world.rooms2015.automated.party.DecemberParty.configurePartySettings));
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty ITEMS OBJECT : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.itemCollectionObject);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty ITEMS OBJECT LIST : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.itemCollectionObject.itemslist);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty ITEMS OBJECT LIST LENGTH : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.itemCollectionObject.itemslist.length);
      var _loc2_ = 0;
      while(_loc2_ < com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.itemCollectionObject.itemslist.length)
      {
         var _loc3_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.itemCollectionObject.itemslist[_loc2_];
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty ITEMS OBJECT ID : " + _loc3_.itemid);
         _loc2_ = _loc2_ + 1;
      }
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.configurePartyJSON();
   }
   static function configurePartyJSON()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.FEATURES_SWF_PATH);
   }
   static function loadPartyFeatures()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.closeContent();
      var _loc1_ = new com.clubpenguin.world.rooms2015.automated.vo.PartyJSON_Parser();
      _loc1_.deserialized.add(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this,com.clubpenguin.world.rooms2015.automated.party.DecemberParty.partyJsonDeserialized,_loc1_.jsonObject));
      _loc1_.deserialize(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_FEATURES);
   }
   static function partyJsonDeserialized(jsonObject)
   {
      if(jsonObject == undefined)
      {
         return undefined;
      }
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_FEATURES = jsonObject;
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._panelPositions = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_FEATURES.featureSettings.panelPositionsX;
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.createPuffleAdoptionVOs();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.createTransformationVOs();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.createQuestVOs();
   }
   static function createPuffleAdoptionVOs()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs = [];
      var _loc3_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_FEATURES.featureSettings.puffleAdoptionList;
      var _loc1_ = 0;
      while(_loc1_ < _loc3_.length)
      {
         var _loc2_ = new com.clubpenguin.world.rooms2015.automated.vo.TemplatedPuffleAdoptionVO();
         _loc2_.__set__puffleType(_loc3_[_loc1_].puffleType);
         _loc2_.__set__puffleId(_loc3_[_loc1_].puffleId);
         _loc2_.__set__unlockDay(_loc3_[_loc1_].adoptDateLock);
         _loc2_.__set__unlockTaskNumber(_loc3_[_loc1_].adoptTaskLock);
         _loc2_.__set__gothere(_loc3_[_loc1_].gothere);
         _loc2_.__set__isMember(_loc3_[_loc1_].adoptMember);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs.push(_loc2_);
         _loc1_ = _loc1_ + 1;
      }
   }
   static function getPuffleAdoptionVOs()
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs.length)
      {
         return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs;
      }
      return null;
   }
   static function getAdoptionVOByIndex(index)
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs.length)
      {
         return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs[index];
      }
      return undefined;
   }
   static function getLengthOfAdoptionVOs()
   {
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs.length;
   }
   static function createTransformationVOs()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs = [];
      var _loc3_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_FEATURES.featureSettings.transformationList;
      var _loc1_ = 0;
      while(_loc1_ < _loc3_.length)
      {
         var _loc2_ = new com.clubpenguin.world.rooms2015.automated.vo.TemplatedTransformationVO();
         _loc2_.__set__transformName(_loc3_[_loc1_].transformName);
         _loc2_.__set__transformId(_loc3_[_loc1_].transformId);
         _loc2_.__set__transformToken(_loc3_[_loc1_].transformToken);
         _loc2_.__set__unlockDay(_loc3_[_loc1_].transformDateLock);
         _loc2_.__set__unlockTaskNumber(_loc3_[_loc1_].transformTaskLock);
         _loc2_.__set__gothere(_loc3_[_loc1_].gothere);
         _loc2_.__set__isMember(_loc3_[_loc1_].transformMember);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs.push(_loc2_);
         _loc1_ = _loc1_ + 1;
      }
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.initPartyAvatars();
   }
   static function getTransformationVOs()
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs.length)
      {
         return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs;
      }
      return null;
   }
   static function getTransformationVOByIndex(index)
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs.length)
      {
         return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[index];
      }
      return undefined;
   }
   static function getLengthOfTransformationVOs()
   {
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs.length;
   }
   static function createQuestVOs()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs = [];
      var _loc3_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_FEATURES.featureSettings.questSettingList;
      var _loc1_ = 0;
      while(_loc1_ < _loc3_.length)
      {
         var _loc2_ = new com.clubpenguin.world.rooms2015.automated.vo.TemplatedQuestTaskVO();
         _loc2_.questTaskIndex = _loc3_[_loc1_].questTaskId;
         _loc2_.taskName = _loc3_[_loc1_].taskName;
         _loc2_.unlockDay = _loc3_[_loc1_].dateLock;
         _loc2_.taskLockNumber = _loc3_[_loc1_].taskLockNumber;
         _loc2_.gothere = _loc3_[_loc1_].gothere;
         var _loc5_ = 0;
         while(_loc5_ < _loc3_[_loc1_].memberItems.length)
         {
            _loc2_.setMemberItemId(_loc3_[_loc1_].memberItems[_loc5_],com.clubpenguin.party.items.PaperItem.TYPE);
            _loc5_ = _loc5_ + 1;
         }
         var _loc4_ = 0;
         while(_loc4_ < _loc3_[_loc1_].nonMemberItems.length)
         {
            _loc2_.setNonMemberItemId(_loc3_[_loc1_].nonMemberItems[_loc4_],com.clubpenguin.party.items.PaperItem.TYPE);
            _loc4_ = _loc4_ + 1;
         }
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs.push(_loc2_);
         _loc1_ = _loc1_ + 1;
      }
   }
   static function getQuestVOByTaskIndex(index)
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs.length)
      {
         var _loc1_ = 0;
         while(_loc1_ < com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs.length)
         {
            if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs[_loc1_].questTaskIndex == index)
            {
               return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs[_loc1_];
            }
            _loc1_ = _loc1_ + 1;
         }
      }
      return undefined;
   }
   static function getQuestVOByIndex(index)
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs.length)
      {
         return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs[index];
      }
      return undefined;
   }
   static function getLengthOfQuestVOs()
   {
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._questTaskVOs.length;
   }
   static function partycookieUpdateHandler()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower.removeListener("partycookie",com.clubpenguin.world.rooms2015.automated.party.DecemberParty._partycookieUpdateHandlerDelegate);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("partycookieUpdateHandler() - partyCookie.msgViewedArray : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().__get__msgViewedArray());
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine.getRoomMovieClip().room.initializePartyCookieDependentAssets();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine.getRoomMovieClip().roomFunctionality.initializePartyCookieDependentAssets();
   }
   static function configurePartySettings()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower.removeListener("partyservice",com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this,com.clubpenguin.world.rooms2015.automated.party.DecemberParty.configurePartySettings));
      var _loc1_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_SERVICE.contestSettings;
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_DAY = Number(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_SERVICE.partySettings.unlockDayIndex);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.TOTAL_PARTY_DAYS = Number(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_SERVICE.partySettings.numOfDaysInParty);
   }
   static function get partyCookie()
   {
      return com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO(com.clubpenguin.party.BaseParty.__get__serverCookie());
   }
   static function get isActive()
   {
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._isActive;
   }
   static function pebug(msg, prefix)
   {
      com.clubpenguin.party.BaseParty.pebug(msg,prefix);
   }
   static function playSound(ui, soundId, volume)
   {
      com.clubpenguin.party.BaseParty.playSound(ui,soundId,volume);
   }
   static function checkForFirstTimeLogin(playerObj)
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.getMyPlayerId() != playerObj.player_id || com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.getRoomObject().room_id == 112)
      {
         return undefined;
      }
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.checkDisplayLoginPrompt();
   }
   static function checkDisplayLoginPrompt()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("checkDisplayLoginPrompt() 1216 - login message index: " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().__get__msgViewedArray()[com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1216_INDEX]);
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("checkDisplayLoginPrompt() 1216 - has player viewed login msg? : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().hasPlayerViewedMessage(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1216_INDEX));
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("checkDisplayLoginPrompt() 1216 - CONSTANTS.PARTY_DAY: " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_DAY);
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_DAY == com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.CHRISTMAS_DAY && !com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().hasPlayerViewedMessage(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1225_INDEX))
      {
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("checkDisplayLoginPrompt() 1225 PROMPT : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_PROMPT_PATH_1225);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_PROMPT_PATH_1225);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendMessageViewed(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1225_INDEX);
      }
      else if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_DAY >= com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.BOXING_DAY && !com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().hasPlayerViewedMessage(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1226_INDEX))
      {
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("checkDisplayLoginPrompt() 1226 PROMPT : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_PROMPT_PATH_1226);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_PROMPT_PATH_1226);
         _global.getCurrentParty().BaseParty.showPartyIcon();
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendMessageViewed(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1226_INDEX);
      }
      else if(!com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().hasPlayerViewedMessage(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1216_INDEX))
      {
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("checkDisplayLoginPrompt() 1216 PROMPT : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_PROMPT_PATH_1216);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_PROMPT_PATH_1216);
         com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendMessageViewed(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1216_INDEX);
      }
   }
   static function get partyIconVisible()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("CHECK PARTY ICON - GET - 1216 - partyIconVisible() : " + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().hasPlayerViewedMessage(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1216_INDEX));
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().hasPlayerViewedMessage(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.LOGIN_MESSAGE_1216_INDEX))
      {
         return true;
      }
      return false;
   }
   static function openPigfarmCatalog(type)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.closeContent();
      var _loc1_ = {catalogType:type};
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PIGFARM_CATALOG,_loc1_,{blockPuffleNotifications:true});
   }
   static function activateFirstTimeUserPartyFunctionality()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendRequestPartyCookie();
   }
   static function activateSnowballOverrides()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine.snowballManager = new com.clubpenguin.world.rooms2015.automated.party.DecemberSnowballManager(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell,com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine,com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface);
   }
   static function sendCoinsEarned(coins)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendCoinsEarned(coins);
   }
   static function showMemberContentOopsMessage()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.OOPS_MESSAGE);
   }
   static function showMemberTransformationOopsMessage()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.TRANSFORMATION_OOPS_MESSAGE);
   }
   static function openRoomPopup(index)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.MESSAGE_PROMPT_PATH_PREFIX + ".room" + String(index));
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().sendMessageViewed(index);
   }
   static function isNextTaskAvailable()
   {
      var _loc1_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.__get__partyCookie().getNextAvailableTask();
      if(_loc1_ == undefined)
      {
         return false;
      }
      var _loc2_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty.getQuestVOByTaskIndex(_loc1_).unlockDay;
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PARTY_DAY < _loc2_ ? false : true;
   }
   static function donateToCFC()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.closeContent();
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.CFC_UI_PATH);
   }
   static function set previousWorldCoinTotal(num)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._previousWorldCoinTotal = num;
   }
   static function get previousWorldCoinTotal()
   {
      if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._previousWorldCoinTotal == undefined)
      {
         return 0;
      }
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._previousWorldCoinTotal;
   }
   static function sendOpenDonationInterfaceBI()
   {
   }
   function awardCoins(total)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.setMyPlayerTotalCoins();
   }
   static function initPartyAvatars()
   {
      var _loc3_ = com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine.avatarManager.model;
      var _loc2_ = 0;
      while(_loc2_ < com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs.length)
      {
         var _loc1_ = _loc3_.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
         if(Number(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[_loc2_].transformId) > 0)
         {
            _loc1_ = _loc3_.createAvatarFromTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID);
            _loc1_.isSpriteTransformed = true;
            _loc1_.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _loc1_.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE;
            _loc1_.hasCustomPlayerCard = true;
            _loc1_.canRevertToDefault = true;
            _loc1_.attachItems = false;
            _loc1_.hasColorVersions = false;
            _loc1_.isMemberOnly = com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[_loc2_].isMember;
            _loc1_.spritePath = com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[_loc2_].transformToken;
            _loc3_.setAvatarTemplate(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[_loc2_].transformId,_loc1_);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   static function sendTransformation(id)
   {
      var _loc1_ = 0;
      while(_loc1_ < com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs.length)
      {
         if(id == com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[_loc1_].transformId)
         {
            if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._transformationVOs[_loc1_].isMember && !com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.isMyPlayerMember())
            {
               com.clubpenguin.world.rooms2015.automated.party.DecemberParty.showMemberTransformationOopsMessage();
               return undefined;
            }
            setTimeout(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._this,com.clubpenguin.world.rooms2015.automated.party.DecemberParty.requestTransformation,id),800);
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.closeContent();
   }
   static function requestTransformation(id)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower.send(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._airtower.PLAY_EXT,"party#" + com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.SET_TRANSFORM,[id],"str",com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.getCurrentServerRoomId());
   }
   static function transformBackToPenguin()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._engine.avatarManager.transformationManager.sendTransformPlayer(0);
   }
   static function get localPlayerAvatarID()
   {
      return com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.getPlayerObjectById(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.getMyPlayerId()).avatarVO.avatar_id;
   }
   static function openAdoptionFlow()
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.CHOOSE_ALIEN_PUFFLE_COLOR_PATH);
   }
   static function sendPuffleAdoption(id)
   {
      var _loc2_ = 0;
      while(_loc2_ < com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs.length)
      {
         if(id == com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs[_loc2_].puffleId)
         {
            if(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs[_loc2_].isMember && !com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.isMyPlayerMember())
            {
               com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.PUFFLE_ADOPT_OOPS_MESSAGE);
               return undefined;
            }
            if(_global.getCurrentShell().isMyPlayerMember() && com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.puffleManager.myPuffles.length >= com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.MAX_PUFFLES)
            {
               com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.$e("PUFFLE ADOPTION --> Max Puffles Reached",{error_code:com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.MAX_PUFFLE_LIMIT});
               return undefined;
            }
            if(!_global.getCurrentShell().isMyPlayerMember() && com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.puffleManager.myPuffles.length >= com.clubpenguin.world.rooms2015.automated.party.DecemberParty.CONSTANTS.MAX_PUFFLES_NON_MEMBER)
            {
               com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.$e("PUFFLE ADOPTION --> Max Puffles Reached for Non-Member Penguin",{error_code:com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.MAX_PUFFLE_LIMIT});
               return undefined;
            }
            com.clubpenguin.world.rooms2015.automated.party.DecemberParty._interface.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION,null,null,{puffleAdoptionType:com.clubpenguin.world.rooms2015.automated.party.DecemberParty._puffleAdoptionVOs[_loc2_].puffleId},true);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   static function sendBI(action, context, msg)
   {
      com.clubpenguin.world.rooms2015.automated.party.DecemberParty.pebug("DecemberParty** SEND BI ** - context :  " + context + " / action :  " + action + " / msg :  " + msg);
      var _loc1_ = String(com.clubpenguin.world.rooms2015.automated.party.DecemberParty._shell.getMyPlayerId());
      com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(action,context,{player_id:_loc1_,message:msg});
   }
}
