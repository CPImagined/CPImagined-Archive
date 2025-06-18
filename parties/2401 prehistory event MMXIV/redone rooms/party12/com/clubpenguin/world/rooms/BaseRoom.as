//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.BaseRoom
    {
        static var _current;
        var _stage, _SHELL, _ENGINE, _INTERFACE, _destroyFunc, _roomEnvironmentManager;
        function BaseRoom (stageReference) {
            _stage = stageReference;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
            _current = this;
            _destroyFunc = com.clubpenguin.util.Delegate.create(this, onDestroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyFunc);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _roomEnvironmentManager = new com.clubpenguin.world.rooms.common.RoomEnvironmentManager(_stage, _SHELL, _ENGINE);
        }
        static function get current() {
            return(_current);
        }
        function onDestroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyFunc);
            _roomEnvironmentManager.destroy();
            _current = null;
        }
        function getStage() {
            return(_stage);
        }
        function setupEnvironmentTriggers() {
            _roomEnvironmentManager.setupEnvironmentTriggers();
        }
        function localize(globalAssets) {
            var _local_4 = "en";
            if (_SHELL.getLanguageAbbreviation() != undefined) {
                _local_4 = _SHELL.getLanguageAbbreviation();
            }
            var _local_2 = 0;
            while (_local_2 < globalAssets.length) {
                globalAssets[_local_2].gotoAndStop(_local_4);
                _local_2++;
            }
        }
        function setupNavigationButtons(navigationButtons) {
            var _local_2 = 0;
            while (_local_2 < navigationButtons.length) {
                navigationButtons[_local_2]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, navigationButtonClick, navigationButtons, _local_2);
                _local_2++;
            }
        }
        function navigationButtonClick(navigationButtons, whichButton) {
            if (_ENGINE.isMovementEnabled()) {
                disablePuffleActivities();
                var _local_3 = Math.round(navigationButtons[whichButton].navigationX);
                var _local_2 = Math.round(navigationButtons[whichButton].navigationY);
                _ENGINE.sendPlayerMove(_local_3, _local_2);
                com.clubpenguin.util.Log.info(((("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + _local_3) + ", ") + _local_2) + ")");
            }
        }
        function disablePuffleActivities() {
            com.clubpenguin.util.Log.info("[BaseRoom] disablePuffleActivities");
            var _local_2 = _SHELL.getMyPlayerObject();
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, _local_2.player_id);
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2.player_id);
        }
        function showContent(content) {
            var _local_2 = 0;
            while (_local_2 < content.length) {
                content[_local_2]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, showContentClick, content, _local_2);
                _local_2++;
            }
        }
        function showContentClick(content, whichButton) {
            if (content[whichButton].condition) {
                _INTERFACE.showContent(content[whichButton].content, null, null, content[whichButton].data, null);
            } else {
                _INTERFACE.showContent(content[whichButton].elseContent, null, null, content[whichButton].data, null);
            }
        }
        function setupHint(hints) {
            var _local_2 = 0;
            while (_local_2 < hints.length) {
                hints[_local_2]["button"].onRollOver = com.clubpenguin.util.Delegate.create(this, showHint, hints, _local_2);
                hints[_local_2]["button"].onRollOut = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _local_2);
                hints[_local_2]["button"].onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeHint, hints, _local_2);
                _local_2++;
            }
        }
        function showHint(hints, whichButton) {
            _INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
        }
        function closeHint(hints, whichButton) {
            _INTERFACE.closeHint(hints[whichButton].anchor, hints[whichButton].hint);
        }
        function setupTableGame(stage, tableObjects) {
            stage.table_list = [];
            var _local_2 = 0;
            while (_local_2 < tableObjects.length) {
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
        }
        function tableRollOver(tableObjects, whichClip) {
            var _local_4 = 2;
            _INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
            tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_local_4);
        }
        function tableRollOut(tableObjects, whichClip) {
            var _local_2 = 1;
            _INTERFACE.closeHint();
            tableObjects[whichClip].tableClip.game_mc.gotoAndStop(_local_2);
        }
        function tableTrigger(tableObjects, whichClip) {
            _ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
        }
    }
