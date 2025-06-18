dynamic class com.clubpenguin.world.rooms.BaseRoom
{
    static var QUEST_TARGET_PARK_FRAME: String = "park";
    static var QUEST_TARGET_SHOW_FRAME: String = "show";
    var _ENGINE;
    var _INTERFACE;
    var _SHELL;
    var _destroyFunc;
    var _invitationManager;
    var _soundManager;
    var _stage;
    var roomEnvironmentManager;
    var soundManagerReady;

    function BaseRoom(stageReference)
    {
        com.clubpenguin.mock.Mock.init();
        this._stage = stageReference;
        this._SHELL = _global.getCurrentShell();
        this._ENGINE = _global.getCurrentEngine();
        this._INTERFACE = _global.getCurrentInterface();
        com.clubpenguin.world.rooms.BaseRoom._current = this;
        this._destroyFunc = com.clubpenguin.util.Delegate.create(this, this.onDestroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyFunc);
        this._stage.block_mc._visible = false;
        this._stage.triggers_mc._visible = false;
        this.roomEnvironmentManager = new com.clubpenguin.world.rooms.common.RoomEnvironmentManager(this._stage, this._SHELL, this._ENGINE);
        this._invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
        this.soundManagerReady = new org.osflash.signals.Signal();
        this._ENGINE.avatarManager.effectManager.effectsLoaded.addOnce(this.onEffectLibsLoaded, this);
    }

    static function get current()
    {
        return com.clubpenguin.world.rooms.BaseRoom._current;
    }

    function get invitationManager()
    {
        if (!this._invitationManager) 
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
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyFunc);
        this.roomEnvironmentManager.destroy();
        this._soundManager.destroy();
        com.clubpenguin.world.rooms.BaseRoom._current = null;
        if (this._invitationManager) 
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
        if (this._stage.questTargets) 
        {
            if (this._stage.questTargets[questTarget]) 
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
        var __reg4 = "en";
        if (this._SHELL.getLanguageAbbreviation() != undefined) 
        {
            __reg4 = this._SHELL.getLanguageAbbreviation();
        }
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= globalAssets.length) 
            {
                return;
            }
            com.clubpenguin.util.Log.info("globalAssets[" + __reg2 + "]: " + globalAssets[__reg2]);
            globalAssets[__reg2].gotoAndStop(__reg4);
            ++__reg2;
        }
    }

    function setupNavigationButtons(navigationButtons)
    {
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= navigationButtons.length) 
            {
                return;
            }
            com.clubpenguin.util.Log.info("setupNavigationButtons navigationButtons[" + __reg2 + "]: " + navigationButtons[__reg2].button);
            navigationButtons[__reg2].button.onRelease = com.clubpenguin.util.Delegate.create(this, this.navigationButtonClick, navigationButtons, __reg2);
            ++__reg2;
        }
    }

    function navigationButtonClick(navigationButtons, whichButton)
    {
        com.clubpenguin.util.Log.info("_ENGINE.isMovementEnabled(): " + this._ENGINE.isMovementEnabled());
        if (this._ENGINE.isMovementEnabled()) 
        {
            this.disablePuffleActivities();
            var __reg3 = Math.round(navigationButtons[whichButton].navigationX);
            var __reg2 = Math.round(navigationButtons[whichButton].navigationY);
            this._ENGINE.sendPlayerMove(__reg3, __reg2);
            com.clubpenguin.util.Log.info("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + __reg3 + ", " + __reg2 + ")");
        }
    }

    function disablePuffleActivities()
    {
        com.clubpenguin.util.Log.info("[BaseRoom] disablePuffleActivities");
        var __reg3 = this._SHELL.getMyPlayerObject();
        var __reg2 = new Object();
        __reg2.playerId = __reg3.player_id;
        this._SHELL.updateListeners(this._SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, __reg3.player_id);
        this._SHELL.updateListeners(this._SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, __reg2);
    }

    function showContent(content)
    {
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= content.length) 
            {
                return;
            }
            com.clubpenguin.util.Log.info("showContent.content[" + __reg2 + "]: " + content[__reg2].button);
            content[__reg2].button.onRelease = com.clubpenguin.util.Delegate.create(this, this.showContentClick, content, __reg2);
            ++__reg2;
        }
    }

    function showContentClick(content, whichButton)
    {
        com.clubpenguin.util.Log.info("showContent.showContentClick: ");
        if (content[whichButton].condition) 
        {
            com.clubpenguin.util.Log.info("\tshowing content: " + content[whichButton].content);
            this._INTERFACE.showContent(content[whichButton].content, null, null, content[whichButton].data, null);
            return;
        }
        com.clubpenguin.util.Log.info("\tshowing elseContent: " + content[whichButton].elseContent);
        this._INTERFACE.showContent(content[whichButton].elseContent, null, null, content[whichButton].data, null);
    }

    function setupHint(hints)
    {
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= hints.length) 
            {
                return;
            }
            com.clubpenguin.util.Log.info("setupHint.hints[" + __reg2 + "].button: " + hints[__reg2].button);
            com.clubpenguin.util.Log.info("\t\t\t\t   anchor: " + hints[__reg2].anchor);
            hints[__reg2].button.onRollOver = com.clubpenguin.util.Delegate.create(this, this.showHint, hints, __reg2);
            hints[__reg2].button.onRollOut = com.clubpenguin.util.Delegate.create(this, this.closeHint, hints, __reg2);
            hints[__reg2].button.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, this.closeHint, hints, __reg2);
            ++__reg2;
        }
    }

    function showHint(hints, whichButton)
    {
        com.clubpenguin.util.Log.info("showHint: " + hints[whichButton].hint);
        this._INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
    }

    function closeHint(hints, whichButton)
    {
        com.clubpenguin.util.Log.info("closeHint: " + hints[whichButton].hint);
        this._INTERFACE.closeHint(hints[whichButton].anchor, hints[whichButton].hint);
    }

    function setupTableGame(stage, tableObjects)
    {
        stage.table_list = [];
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= tableObjects.length) 
            {
                return;
            }
            com.clubpenguin.util.Log.info("setupTableGame.tableObjects[" + __reg2 + "]: " + tableObjects[__reg2].tableClip);
            stage.table_list.push(tableObjects[__reg2].tableID);
            tableObjects[__reg2].tableClip.seat_frames = tableObjects[__reg2].seatframes;
            tableObjects[__reg2].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.clickTable, tableObjects, __reg2);
            tableObjects[__reg2].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.tableRollOver, tableObjects, __reg2);
            tableObjects[__reg2].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.tableRollOut, tableObjects, __reg2);
            tableObjects[__reg2].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.tableTrigger, tableObjects, __reg2);
            ++__reg2;
        }
    }

    function clickTable(tableObjects, whichClip)
    {
        var __reg3 = Math.round(tableObjects[whichClip].tableClip._x);
        var __reg2 = Math.round(tableObjects[whichClip].tableClip._y);
        this._ENGINE.sendPlayerMove(__reg3, __reg2);
        com.clubpenguin.util.Log.info("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + __reg3 + ", " + __reg2 + ")");
    }

    function tableRollOver(tableObjects, whichClip)
    {
        var __reg4 = 2;
        com.clubpenguin.util.Log.info("setupTableGame.tableRollOver: " + tableObjects[whichClip].tableClip);
        this._INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(__reg4);
    }

    function tableRollOut(tableObjects, whichClip)
    {
        var __reg2 = 1;
        com.clubpenguin.util.Log.info("setupTableGame.tableRollOut: " + tableObjects[whichClip].tableClip);
        this._INTERFACE.closeHint();
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(__reg2);
    }

    function tableTrigger(tableObjects, whichClip)
    {
        com.clubpenguin.util.Log.info("setupTableGame.tableTrigger: " + tableObjects[whichClip].tableClip);
        this._ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
    }

}
