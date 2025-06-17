class com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, _ENGINE, _INTERFACE;
    function BaseRoom(stageReference)
    {
        _stage = stageReference;
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _INTERFACE = _global.getCurrentInterface();
        this.hideRoomElements();
    } // End of the function
    function hideRoomElements()
    {
        trace ("hideRoomElements");
        _stage.triggers_mc._visible = false;
        _stage.block_mc._visible = false;
        _stage.snowballBlock._visible = false;
    } // End of the function
    function localize(globalAssets)
    {
        var _loc4 = "en";
        if (_SHELL.getLanguageAbbreviation() != undefined)
        {
            _loc4 = _SHELL.getLanguageAbbreviation();
        } // end if
        for (var _loc2 = 0; _loc2 < globalAssets.length; ++_loc2)
        {
            trace ("globalAssets[" + _loc2 + "]: " + globalAssets[_loc2]);
            globalAssets[_loc2].gotoAndStop(_loc4);
        } // end of for
    } // End of the function
    function setupNavigationButtons(navigationButtons)
    {
        for (var _loc2 = 0; _loc2 < navigationButtons.length; ++_loc2)
        {
            trace ("navigationButtons[" + _loc2 + "]: " + navigationButtons[_loc2].button);
            navigationButtons[_loc2].button.onRelease = com.clubpenguin.util.Delegate.create(this, navigationButtonClick, navigationButtons, _loc2);
        } // end of for
    } // End of the function
    function navigationButtonClick(navigationButtons, whichButton)
    {
        var _loc3 = Math.round(navigationButtons[whichButton].navigationX);
        var _loc2 = Math.round(navigationButtons[whichButton].navigationY);
        _ENGINE.sendPlayerMove(_loc3, _loc2);
        trace ("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + _loc3 + ", " + _loc2 + ")");
    } // End of the function
    function showContent(content)
    {
        for (var _loc2 = 0; _loc2 < content.length; ++_loc2)
        {
            trace ("showContent.content[" + _loc2 + "]: " + content[_loc2].button);
            content[_loc2].button.onRelease = com.clubpenguin.util.Delegate.create(this, showContentClick, content, _loc2);
        } // end of for
    } // End of the function
    function showContentClick(content, whichButton)
    {
        trace ("showContent.showContentClick: ");
        if (content[whichButton].condition)
        {
            trace ("\tshowing content: " + content[whichButton].content);
            _INTERFACE.showContent(content[whichButton].content, null, null, content[whichButton].data, null);
        }
        else
        {
            trace ("\tshowing elseContent: " + content[whichButton].elseContent);
            _INTERFACE.showContent(content[whichButton].elseContent, null, null, content[whichButton].data, null);
        } // end else if
    } // End of the function
    function setupHint(hints)
    {
        for (var _loc2 = 0; _loc2 < hints.length; ++_loc2)
        {
            trace ("setupHint.hints[" + _loc2 + "].button: " + hints[_loc2].button);
            trace ("\t\t\t\t   anchor: " + hints[_loc2].anchor);
            hints[_loc2].button.onRollOver = com.clubpenguin.util.Delegate.create(this, showHint, hints, _loc2);
            hints[_loc2].button.onRollOut = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _loc2);
            hints[_loc2].button.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _loc2);
        } // end of for
    } // End of the function
    function showHint(hints, whichButton)
    {
        trace ("showHint: " + hints[whichButton].hint);
        _INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
    } // End of the function
    function closeHint(hints, whichButton)
    {
        trace ("closeHint: " + hints[whichButton].hint);
        _INTERFACE.closeHint(hints[whichButton].anchor, hints[whichButton].hint);
    } // End of the function
    function setupTableGame(stage, tableObjects)
    {
        stage.table_list = [];
        for (var _loc2 = 0; _loc2 < tableObjects.length; ++_loc2)
        {
            trace ("setupTableGame.tableObjects[" + _loc2 + "]: " + tableObjects[_loc2].tableClip);
            stage.table_list.push(tableObjects[_loc2].tableID);
            tableObjects[_loc2].tableClip.seat_frames = tableObjects[_loc2].seatframes;
            tableObjects[_loc2].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, clickTable, tableObjects, _loc2);
            tableObjects[_loc2].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, tableObjects, _loc2);
            tableObjects[_loc2].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, tableObjects, _loc2);
            tableObjects[_loc2].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, tableTrigger, tableObjects, _loc2);
        } // end of for
    } // End of the function
    function clickTable(tableObjects, whichClip)
    {
        var _loc3 = Math.round(tableObjects[whichClip].tableClip._x);
        var _loc2 = Math.round(tableObjects[whichClip].tableClip._y);
        _ENGINE.sendPlayerMove(_loc3, _loc2);
        trace ("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + _loc3 + ", " + _loc2 + ")");
    } // End of the function
    function tableRollOver(tableObjects, whichClip)
    {
        var _loc4 = 2;
        trace ("setupTableGame.tableRollOver: " + tableObjects[whichClip].tableClip);
        _INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_loc4);
    } // End of the function
    function tableRollOut(tableObjects, whichClip)
    {
        var _loc2 = 1;
        trace ("setupTableGame.tableRollOut: " + tableObjects[whichClip].tableClip);
        _INTERFACE.closeHint();
        tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_loc2);
    } // End of the function
    function tableTrigger(tableObjects, whichClip)
    {
        trace ("setupTableGame.tableTrigger: " + tableObjects[whichClip].tableClip);
        _ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
    } // End of the function
} // End of Class
