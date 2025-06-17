dynamic class com.clubpenguin.world.rooms.BaseRoom
{
    var _ENGINE;
    var _INTERFACE;
    var _SHELL;
    var _stage;

    function BaseRoom(stageReference)
    {
        this._stage = stageReference;
        this._SHELL = _global.getCurrentShell();
        this._ENGINE = _global.getCurrentEngine();
        this._INTERFACE = _global.getCurrentInterface();
        this.hideRoomElements();
    }

    function hideRoomElements()
    {
        this._stage.triggers_mc._visible = false;
        this._stage.block_mc._visible = false;
        this._stage.snowballBlock._visible = false;
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
            navigationButtons[__reg2].button.onRelease = com.clubpenguin.util.Delegate.create(this, this.navigationButtonClick, navigationButtons, __reg2);
            ++__reg2;
        }
    }

    function navigationButtonClick(navigationButtons, whichButton)
    {
        var __reg3 = Math.round(navigationButtons[whichButton].navigationX);
        var __reg2 = Math.round(navigationButtons[whichButton].navigationY);
        this._ENGINE.sendPlayerMove(__reg3, __reg2);
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
            content[__reg2].button.onRelease = com.clubpenguin.util.Delegate.create(this, this.showContentClick, content, __reg2);
            ++__reg2;
        }
    }

    function showContentClick(content, whichButton)
    {
        if (content[whichButton].condition) 
        {
            this._INTERFACE.showContent(content[whichButton].content, null, null, content[whichButton].data, null);
            return;
        }
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
            hints[__reg2].button.onRollOver = com.clubpenguin.util.Delegate.create(this, this.showHint, hints, __reg2);
            hints[__reg2].button.onRollOut = com.clubpenguin.util.Delegate.create(this, this.closeHint, hints, __reg2);
            hints[__reg2].button.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, this.closeHint, hints, __reg2);
            ++__reg2;
        }
    }

    function showHint(hints, whichButton)
    {
        this._INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
    }

    function closeHint(hints, whichButton)
    {
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
    }

    function tableRollOver(tableObjects, whichClip)
    {
        var __reg4 = 2;
        this._INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(__reg4);
    }

    function tableRollOut(tableObjects, whichClip)
    {
        var __reg2 = 1;
        this._INTERFACE.closeHint();
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(__reg2);
    }

    function tableTrigger(tableObjects, whichClip)
    {
        this._ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
    }

}
