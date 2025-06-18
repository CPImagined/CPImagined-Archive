//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.BaseRoom
    {
        var _SHELL, _ENGINE, _INTERFACE, _stage;
        function BaseRoom () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
        }
        function hideRoomElements() {
            trace("hideRoomElements");
            _stage.triggers_mc._visible = false;
            _stage.block_mc._visible = false;
            _stage.snowballBlock._visible = false;
        }
        function localize(globalAssets) {
            var _local_4 = "english";
            if (_SHELL.getLocalizedFrameLabel != undefined) {
                _local_4 = _SHELL.getLocalizedFrameLabel();
            }
            var _local_2 = 0;
            while (_local_2 < globalAssets.length) {
                trace((("globalAssets[" + _local_2) + "]: ") + globalAssets[_local_2]);
                globalAssets[_local_2].gotoAndStop(_local_4);
                _local_2++;
            }
        }
        function setupNavigationButtons(navigationButtons) {
            var _local_2 = 0;
            while (_local_2 < navigationButtons.length) {
                trace((("navigationButtons[" + _local_2) + "]: ") + navigationButtons[_local_2]["button"]);
                navigationButtons[_local_2]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, navigationButtonClick, navigationButtons, _local_2);
                _local_2++;
            }
        }
        function navigationButtonClick(navigationButtons, whichButton) {
            var _local_3 = Math.round(navigationButtons[whichButton].navigationX);
            var _local_2 = Math.round(navigationButtons[whichButton].navigationY);
            _ENGINE.sendPlayerMove(_local_3, _local_2);
            trace(((("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + _local_3) + ", ") + _local_2) + ")");
        }
        function showContent(content) {
            var _local_2 = 0;
            while (_local_2 < content.length) {
                trace((("showContent.content[" + _local_2) + "]: ") + content[_local_2]["button"]);
                content[_local_2]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, showContentClick, content, _local_2);
                _local_2++;
            }
        }
        function showContentClick(content, whichButton) {
            trace("showContent.showContentClick: ");
            if (content[whichButton].condition) {
                trace("\tshowing content: " + content[whichButton].content);
                _INTERFACE.showContent(content[whichButton].content);
            } else {
                trace("\tshowing elseContent: " + content[whichButton].elseContent);
                _INTERFACE.showContent(content[whichButton].elseContent);
            }
        }
        function setupHint(hints) {
            var _local_2 = 0;
            while (_local_2 < hints.length) {
                trace((("setupHint.hints[" + _local_2) + "].button: ") + hints[_local_2]["button"]);
                trace("\t\t\t\t   anchor: " + hints[_local_2].anchor);
                hints[_local_2]["button"].onRollOver = com.clubpenguin.util.Delegate.create(this, showHint, hints, _local_2);
                hints[_local_2]["button"].onRollOut = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _local_2);
                hints[_local_2]["button"].onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _local_2);
                _local_2++;
            }
        }
        function showHint(hints, whichButton) {
            trace("showHint: " + hints[whichButton].hint);
            _INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
        }
        function closeHint(hints, whichButton) {
            trace("closeHint: " + hints[whichButton].hint);
            _INTERFACE.closeHint(hints[whichButton].anchor, hints[whichButton].hint);
        }
        function setupTableGame(stage, tableObjects) {
            stage.table_list = [];
            var _local_2 = 0;
            while (_local_2 < tableObjects.length) {
                trace((("setupTableGame.tableObjects[" + _local_2) + "]: ") + tableObjects[_local_2].tableClip);
                stage.table_list.push(tableObjects[_local_2].tableID);
                tableObjects[_local_2].tableClip.seat_frames = tableObjects[_local_2].seatframes;
                tableObjects[_local_2].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, clickTable, tableObjects, _local_2);
                tableObjects[_local_2].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, tableObjects, _local_2);
                tableObjects[_local_2].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, tableObjects, _local_2);
                tableObjects[_local_2].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, tableTrigger, tableObjects, _local_2);
                _local_2++;
            }
        }
        function clickTable(tableObjects, whichClip) {
            var _local_3 = Math.round(tableObjects[whichClip].tableClip._x);
            var _local_2 = Math.round(tableObjects[whichClip].tableClip._y);
            _ENGINE.sendPlayerMove(_local_3, _local_2);
            trace(((("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + _local_3) + ", ") + _local_2) + ")");
        }
        function tableRollOver(tableObjects, whichClip) {
            var _local_4 = 2;
            trace("setupTableGame.tableRollOver: " + tableObjects[whichClip].tableClip);
            _INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
            tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_local_4);
        }
        function tableRollOut(tableObjects, whichClip) {
            var _local_2 = 1;
            trace("setupTableGame.tableRollOut: " + tableObjects[whichClip].tableClip);
            _INTERFACE.closeHint();
            tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_local_2);
        }
        function tableTrigger(tableObjects, whichClip) {
            trace("setupTableGame.tableTrigger: " + tableObjects[whichClip].tableClip);
            _ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
        }
        function setupScavengerHunt(itemButton, itemID, specialCase) {
            if (_INTERFACE.scavengerHunt.isItemFound(itemID)) {
                itemButton._visible = false;
                specialCase();
            } else {
                itemButton.onRelease = com.clubpenguin.util.Delegate.create(this, itemClicked, itemButton, itemID);
            }
        }
        function itemClicked(itemButton, itemID) {
            itemButton._visible = false;
            _INTERFACE.scavengerHunt.itemFound(itemID);
            _INTERFACE.showContent("scavenger_hunt");
        }
    }
