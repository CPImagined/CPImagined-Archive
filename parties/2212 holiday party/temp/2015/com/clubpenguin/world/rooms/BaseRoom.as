class com.clubpenguin.world.rooms.BaseRoom
{
   static var QUEST_TARGET_PARK_FRAME = "park";
   static var QUEST_TARGET_SHOW_FRAME = "show";
   function BaseRoom(stageReference)
   {
      com.clubpenguin.mock.Mock.init();
      this._stage = stageReference;
      this._SHELL = _global.getCurrentShell();
      this._ENGINE = _global.getCurrentEngine();
      this._INTERFACE = _global.getCurrentInterface();
      com.clubpenguin.world.rooms.BaseRoom._current = this;
      this._destroyFunc = com.clubpenguin.util.Delegate.create(this,this.onDestroy);
      this._SHELL.addListener(this._SHELL.ROOM_DESTROYED,this._destroyFunc);
      this._stage.block_mc._visible = false;
      this._stage.triggers_mc._visible = false;
      this.roomEnvironmentManager = new com.clubpenguin.world.rooms.common.RoomEnvironmentManager(this._stage,this._SHELL,this._ENGINE);
      this._invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
      this.soundManagerReady = new org.osflash.signals.Signal();
      this._ENGINE.avatarManager.effectManager.effectsLoaded.addOnce(this.onEffectLibsLoaded,this);
   }
   static function get current()
   {
      return com.clubpenguin.world.rooms.BaseRoom._current;
   }
   function get invitationManager()
   {
      if(!this._invitationManager)
      {
         this._invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
      }
      return this._invitationManager;
   }
   function set invitationManager(invitationManager)
   {
      this._invitationManager = invitationManager;
   }
   function onEffectLibsLoaded()
   {
      this._soundManager = new com.clubpenguin.world.rooms.common.SoundManager(this._stage[com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME]);
      this.soundManagerReady.dispatch();
   }
   function onDestroy()
   {
      this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED,this._destroyFunc);
      this.roomEnvironmentManager.destroy();
      this._soundManager.destroy();
      com.clubpenguin.world.rooms.BaseRoom._current = null;
      if(this._invitationManager)
      {
         this._invitationManager.destroy();
         com.clubpenguin.world.rooms.BaseRoom.lastRoomInvitationManager = this._invitationManager;
      }
   }
   function getStage()
   {
      return this._stage;
   }
   function get soundManager()
   {
      return this._soundManager;
   }
   function setupEnvironmentTriggers()
   {
      this.roomEnvironmentManager.setupEnvironmentTriggers();
   }
   function hasQuestTarget(questTarget)
   {
      if(this._stage.questTargets)
      {
         if(this._stage.questTargets[questTarget])
         {
            return true;
         }
      }
      return false;
   }
   function showQuestTarget(questTarget)
   {
      this._stage.questTargets[questTarget].gotoAndStop(com.clubpenguin.world.rooms.BaseRoom.QUEST_TARGET_SHOW_FRAME);
   }
   function localize(globalAssets)
   {
      var _loc4_ = "en";
      if(this._SHELL.getLanguageAbbreviation() != undefined)
      {
         _loc4_ = this._SHELL.getLanguageAbbreviation();
      }
      var _loc2_ = 0;
      while(_loc2_ < globalAssets.length)
      {
         com.clubpenguin.util.Log.info("globalAssets[" + _loc2_ + "]: " + globalAssets[_loc2_]);
         globalAssets[_loc2_].gotoAndStop(_loc4_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function setupNavigationButtons(navigationButtons)
   {
      var _loc2_ = 0;
      while(_loc2_ < navigationButtons.length)
      {
         com.clubpenguin.util.Log.info("setupNavigationButtons navigationButtons[" + _loc2_ + "]: " + navigationButtons[_loc2_].button);
         navigationButtons[_loc2_].button.onRelease = com.clubpenguin.util.Delegate.create(this,this.navigationButtonClick,navigationButtons,_loc2_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function navigationButtonClick(navigationButtons, whichButton)
   {
      com.clubpenguin.util.Log.info("_ENGINE.isMovementEnabled(): " + this._ENGINE.isMovementEnabled());
      if(this._ENGINE.isMovementEnabled())
      {
         this.disablePuffleActivities();
         var _loc3_ = Math.round(navigationButtons[whichButton].navigationX);
         var _loc2_ = Math.round(navigationButtons[whichButton].navigationY);
         this._ENGINE.sendPlayerMove(_loc3_,_loc2_);
         com.clubpenguin.util.Log.info("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + _loc3_ + ", " + _loc2_ + ")");
      }
   }
   function disablePuffleActivities()
   {
      com.clubpenguin.util.Log.info("[BaseRoom] disablePuffleActivities");
      var _loc3_ = this._SHELL.getMyPlayerObject();
      var _loc2_ = new Object();
      _loc2_.playerId = _loc3_.player_id;
      this._SHELL.updateListeners(this._SHELL.DISABLE_PUFFLE_TREASURE_HUNTING,_loc3_.player_id);
      this._SHELL.updateListeners(this._SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE,_loc2_);
   }
   function showContent(content)
   {
      var _loc2_ = 0;
      while(_loc2_ < content.length)
      {
         com.clubpenguin.util.Log.info("showContent.content[" + _loc2_ + "]: " + content[_loc2_].button);
         content[_loc2_].button.onRelease = com.clubpenguin.util.Delegate.create(this,this.showContentClick,content,_loc2_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function showContentClick(content, whichButton)
   {
      com.clubpenguin.util.Log.info("showContent.showContentClick: ");
      if(content[whichButton].condition)
      {
         com.clubpenguin.util.Log.info("\tshowing content: " + content[whichButton].content);
         this._INTERFACE.showContent(content[whichButton].content,null,null,content[whichButton].data,null);
      }
      else
      {
         com.clubpenguin.util.Log.info("\tshowing elseContent: " + content[whichButton].elseContent);
         this._INTERFACE.showContent(content[whichButton].elseContent,null,null,content[whichButton].data,null);
      }
   }
   function setupHint(hints)
   {
      var _loc2_ = 0;
      while(_loc2_ < hints.length)
      {
         com.clubpenguin.util.Log.info("setupHint.hints[" + _loc2_ + "].button: " + hints[_loc2_].button);
         com.clubpenguin.util.Log.info("\t\t\t\t   anchor: " + hints[_loc2_].anchor);
         hints[_loc2_].button.onRollOver = com.clubpenguin.util.Delegate.create(this,this.showHint,hints,_loc2_);
         hints[_loc2_].button.onRollOut = com.clubpenguin.util.Delegate.create(this,this.closeHint,hints,_loc2_);
         hints[_loc2_].button.onReleaseOutside = com.clubpenguin.util.Delegate.create(this,this.closeHint,hints,_loc2_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function showHint(hints, whichButton)
   {
      com.clubpenguin.util.Log.info("showHint: " + hints[whichButton].hint);
      this._INTERFACE.showHint(hints[whichButton].anchor,hints[whichButton].hint);
   }
   function closeHint(hints, whichButton)
   {
      com.clubpenguin.util.Log.info("closeHint: " + hints[whichButton].hint);
      this._INTERFACE.closeHint(hints[whichButton].anchor,hints[whichButton].hint);
   }
   function setupTableGame(stage, tableObjects)
   {
      stage.table_list = [];
      var _loc2_ = 0;
      while(_loc2_ < tableObjects.length)
      {
         com.clubpenguin.util.Log.info("setupTableGame.tableObjects[" + _loc2_ + "]: " + tableObjects[_loc2_].tableClip);
         stage.table_list.push(tableObjects[_loc2_].tableID);
         tableObjects[_loc2_].tableClip.seat_frames = tableObjects[_loc2_].seatframes;
         tableObjects[_loc2_].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this,this.clickTable,tableObjects,_loc2_);
         tableObjects[_loc2_].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this,this.tableRollOver,tableObjects,_loc2_);
         tableObjects[_loc2_].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this,this.tableRollOut,tableObjects,_loc2_);
         tableObjects[_loc2_].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this,this.tableTrigger,tableObjects,_loc2_);
         _loc2_ = _loc2_ + 1;
      }
   }
   function clickTable(tableObjects, whichClip)
   {
      var _loc3_ = Math.round(tableObjects[whichClip].tableClip._x);
      var _loc2_ = Math.round(tableObjects[whichClip].tableClip._y);
      this._ENGINE.sendPlayerMove(_loc3_,_loc2_);
      com.clubpenguin.util.Log.info("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + _loc3_ + ", " + _loc2_ + ")");
   }
   function tableRollOver(tableObjects, whichClip)
   {
      var _loc4_ = 2;
      com.clubpenguin.util.Log.info("setupTableGame.tableRollOver: " + tableObjects[whichClip].tableClip);
      this._INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn,tableObjects[whichClip].hintName);
      tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_loc4_);
   }
   function tableRollOut(tableObjects, whichClip)
   {
      var _loc2_ = 1;
      com.clubpenguin.util.Log.info("setupTableGame.tableRollOut: " + tableObjects[whichClip].tableClip);
      this._INTERFACE.closeHint();
      tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_loc2_);
   }
   function tableTrigger(tableObjects, whichClip)
   {
      com.clubpenguin.util.Log.info("setupTableGame.tableTrigger: " + tableObjects[whichClip].tableClip);
      this._ENGINE.sendJoinTable(tableObjects[whichClip].gameName,tableObjects[whichClip].tableID,tableObjects[whichClip].is_prompt);
   }
}
