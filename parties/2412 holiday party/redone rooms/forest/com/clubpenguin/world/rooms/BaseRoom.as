//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.BaseRoom
    {
        static var _current, lastRoomInvitationManager;
        var _stage, _SHELL, _ENGINE, _INTERFACE, _destroyFunc, roomEnvironmentManager, _invitationManager, soundManagerReady, _soundManager;
        function BaseRoom (stageReference) {
            com.clubpenguin.mock.Mock.init();
            _stage = stageReference;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
            _current = this;
            _destroyFunc = com.clubpenguin.util.Delegate.create(this, onDestroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyFunc);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            roomEnvironmentManager = new com.clubpenguin.world.rooms.common.RoomEnvironmentManager(_stage, _SHELL, _ENGINE);
            _invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
            soundManagerReady = new org.osflash.signals.Signal();
            _ENGINE.avatarManager.effectManager.effectsLoaded.addOnce(onEffectLibsLoaded, this);
        }
        static function get current() {
            return(_current);
        }
        function get invitationManager() {
            if (!_invitationManager) {
                _invitationManager = com.clubpenguin.world.rooms.common.invitation.InvitationManagerFactory.create();
            }
            return(_invitationManager);
        }
        function set invitationManager(invitationManager) {
            _invitationManager = invitationManager;
            //return(this.invitationManager);
        }
        function onEffectLibsLoaded() {
            _soundManager = new com.clubpenguin.world.rooms.common.SoundManager(_stage[com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME]);
            soundManagerReady.dispatch();
        }
        function onDestroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyFunc);
            roomEnvironmentManager.destroy();
            _soundManager.destroy();
            _current = null;
            if (_invitationManager) {
                _invitationManager.destroy();
                lastRoomInvitationManager = _invitationManager;
            }
        }
        function getStage() {
            return(_stage);
        }
        function get soundManager() {
            return(_soundManager);
        }
        function setupEnvironmentTriggers() {
            roomEnvironmentManager.setupEnvironmentTriggers();
        }
        function hasQuestTarget(questTarget) {
            if (_stage.questTargets) {
                if (_stage.questTargets[questTarget]) {
                    return(true);
                }
            }
            return(false);
        }
        function showQuestTarget(questTarget) {
            _stage.questTargets[questTarget].gotoAndStop(QUEST_TARGET_SHOW_FRAME);
        }
        function localize(globalAssets) {
            var language = "en";
            if (_SHELL.getLanguageAbbreviation() != undefined) {
                language = _SHELL.getLanguageAbbreviation();
            }
            var i = 0;
            while (i < globalAssets.length) {
                com.clubpenguin.util.Log.info((("globalAssets[" + i) + "]: ") + globalAssets[i]);
                globalAssets[i].gotoAndStop(language);
                i++;
            }
        }
        function setupNavigationButtons(navigationButtons) {
            var n = 0;
            while (n < navigationButtons.length) {
                com.clubpenguin.util.Log.info((("setupNavigationButtons navigationButtons[" + n) + "]: ") + navigationButtons[n]["button"]);
                navigationButtons[n]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, navigationButtonClick, navigationButtons, n);
                n++;
            }
        }
        function navigationButtonClick(navigationButtons, whichButton) {
            com.clubpenguin.util.Log.info("_ENGINE.isMovementEnabled(): " + _ENGINE.isMovementEnabled());
            if (_ENGINE.isMovementEnabled()) {
                disablePuffleActivities();
                var x = Math.round(navigationButtons[whichButton].navigationX);
                var y = Math.round(navigationButtons[whichButton].navigationY);
                _ENGINE.sendPlayerMove(x, y);
                com.clubpenguin.util.Log.info(((("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + x) + ", ") + y) + ")");
            }
        }
        function disablePuffleActivities() {
            com.clubpenguin.util.Log.info("[BaseRoom] disablePuffleActivities");
            var playerVO = _SHELL.getMyPlayerObject();
            var data = new Object();
            data.playerId = playerVO.player_id;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, playerVO.player_id);
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, data);
        }
        function showContent(content) {
            var c = 0;
            while (c < content.length) {
                com.clubpenguin.util.Log.info((("showContent.content[" + c) + "]: ") + content[c]["button"]);
                content[c]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, showContentClick, content, c);
                c++;
            }
        }
        function showContentClick(content, whichButton) {
            com.clubpenguin.util.Log.info("showContent.showContentClick: ");
            if (content[whichButton].condition) {
                com.clubpenguin.util.Log.info("\tshowing content: " + content[whichButton].content);
                _INTERFACE.showContent(content[whichButton].content, null, null, content[whichButton].data, null);
            } else {
                com.clubpenguin.util.Log.info("\tshowing elseContent: " + content[whichButton].elseContent);
                _INTERFACE.showContent(content[whichButton].elseContent, null, null, content[whichButton].data, null);
            }
        }
        function setupHint(hints) {
            var h = 0;
            while (h < hints.length) {
                com.clubpenguin.util.Log.info((("setupHint.hints[" + h) + "].button: ") + hints[h]["button"]);
                com.clubpenguin.util.Log.info("\t\t\t\t   anchor: " + hints[h].anchor);
                hints[h]["button"].onRollOver = com.clubpenguin.util.Delegate.create(this, showHint, hints, h);
                hints[h]["button"].onRollOut = com.clubpenguin.util.Delegate.create(this, closeHint, hints, h);
                hints[h]["button"].onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeHint, hints, h);
                h++;
            }
        }
        function showHint(hints, whichButton) {
            com.clubpenguin.util.Log.info("showHint: " + hints[whichButton].hint);
            _INTERFACE.showHint(hints[whichButton].anchor, hints[whichButton].hint);
        }
        function closeHint(hints, whichButton) {
            com.clubpenguin.util.Log.info("closeHint: " + hints[whichButton].hint);
            _INTERFACE.closeHint(hints[whichButton].anchor, hints[whichButton].hint);
        }
        function setupTableGame(stage, tableObjects) {
            stage.table_list = [];
            var t = 0;
            while (t < tableObjects.length) {
                com.clubpenguin.util.Log.info((("setupTableGame.tableObjects[" + t) + "]: ") + tableObjects[t].tableClip);
                stage.table_list.push(tableObjects[t].tableID);
                tableObjects[t].tableClip.seat_frames = tableObjects[t].seatframes;
                tableObjects[t].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, clickTable, tableObjects, t);
                tableObjects[t].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, tableObjects, t);
                tableObjects[t].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, tableObjects, t);
                tableObjects[t].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, tableTrigger, tableObjects, t);
                t++;
            }
        }
        function clickTable(tableObjects, whichClip) {
            var x = Math.round(tableObjects[whichClip].tableClip._x);
            var y = Math.round(tableObjects[whichClip].tableClip._y);
            _ENGINE.sendPlayerMove(x, y);
            com.clubpenguin.util.Log.info(((("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + x) + ", ") + y) + ")");
        }
        function tableRollOver(tableObjects, whichClip) {
            var MOUSE_OVER_FRAME = 2;
            com.clubpenguin.util.Log.info("setupTableGame.tableRollOver: " + tableObjects[whichClip].tableClip);
            _INTERFACE.showHint(tableObjects[whichClip].tableClip.game_btn, tableObjects[whichClip].hintName);
            tableObjects[whichClip].tableClip.game_mc.gotoAndStop(MOUSE_OVER_FRAME);
        }
        function tableRollOut(tableObjects, whichClip) {
            var STATIC_FRAME = 1;
            com.clubpenguin.util.Log.info("setupTableGame.tableRollOut: " + tableObjects[whichClip].tableClip);
            _INTERFACE.closeHint();
            tableObjects[whichClip].tableClip.game_mc.gotoAndStop(STATIC_FRAME);
        }
        function tableTrigger(tableObjects, whichClip) {
            com.clubpenguin.util.Log.info("setupTableGame.tableTrigger: " + tableObjects[whichClip].tableClip);
            _ENGINE.sendJoinTable(tableObjects[whichClip].gameName, tableObjects[whichClip].tableID, tableObjects[whichClip].is_prompt);
        }
        static var QUEST_TARGET_PARK_FRAME = "park";
        static var QUEST_TARGET_SHOW_FRAME = "show";
    }
