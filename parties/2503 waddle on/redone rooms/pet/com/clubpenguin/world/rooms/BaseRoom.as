//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.BaseRoom
    {
        static var _current, lastRoomInvitationManager;
        var _stage, _SHELL, _ENGINE, _INTERFACE, _destroyFunc, roomEnvironmentManager, _invitationManager, soundManagerReady, _soundManager;
        function BaseRoom (_arg_3) {
            com.clubpenguin.mock.Mock.init();
            _stage = _arg_3;
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
        function set invitationManager(_arg_2) {
            _invitationManager = _arg_2;
            //return(invitationManager);
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
        function hasQuestTarget(_arg_2) {
            if (_stage.questTargets) {
                if (_stage.questTargets[_arg_2]) {
                    return(true);
                }
            }
            return(false);
        }
        function showQuestTarget(_arg_2) {
            _stage.questTargets[_arg_2].gotoAndStop(QUEST_TARGET_SHOW_FRAME);
        }
        function localize(_arg_3) {
            var _local_4 = "en";
            if (_SHELL.getLanguageAbbreviation() != undefined) {
                _local_4 = _SHELL.getLanguageAbbreviation();
            }
            var _local_2 = 0;
            while (_local_2 < _arg_3.length) {
                com.clubpenguin.util.Log.info((("globalAssets[" + _local_2) + "]: ") + _arg_3[_local_2]);
                _arg_3[_local_2].gotoAndStop(_local_4);
                _local_2++;
            }
        }
        function setupNavigationButtons(_arg_3) {
            var _local_2 = 0;
            while (_local_2 < _arg_3.length) {
                com.clubpenguin.util.Log.info((("setupNavigationButtons navigationButtons[" + _local_2) + "]: ") + _arg_3[_local_2]["button"]);
                _arg_3[_local_2]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, navigationButtonClick, _arg_3, _local_2);
                _local_2++;
            }
        }
        function navigationButtonClick(_arg_4, _arg_5) {
            com.clubpenguin.util.Log.info("_ENGINE.isMovementEnabled(): " + _ENGINE.isMovementEnabled());
            if (_ENGINE.isMovementEnabled()) {
                disablePuffleActivities();
                var _local_3 = Math.round(_arg_4[_arg_5].navigationX);
                var _local_2 = Math.round(_arg_4[_arg_5].navigationY);
                _ENGINE.sendPlayerMove(_local_3, _local_2);
                com.clubpenguin.util.Log.info(((("setupNavigationButtons.navigationButtonClick: _ENGINE.sendPlayerMove(" + _local_3) + ", ") + _local_2) + ")");
            }
        }
        function disablePuffleActivities() {
            com.clubpenguin.util.Log.info("[BaseRoom] disablePuffleActivities");
            var _local_3 = _SHELL.getMyPlayerObject();
            var _local_2 = new Object();
            _local_2.playerId = _local_3.player_id;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, _local_3.player_id);
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2);
        }
        function showContent(_arg_3) {
            var _local_2 = 0;
            while (_local_2 < _arg_3.length) {
                com.clubpenguin.util.Log.info((("showContent.content[" + _local_2) + "]: ") + _arg_3[_local_2]["button"]);
                _arg_3[_local_2]["button"].onRelease = com.clubpenguin.util.Delegate.create(this, showContentClick, _arg_3, _local_2);
                _local_2++;
            }
        }
        function showContentClick(_arg_2, _arg_3) {
            com.clubpenguin.util.Log.info("showContent.showContentClick: ");
            if (_arg_2[_arg_3].condition) {
                com.clubpenguin.util.Log.info("\tshowing content: " + _arg_2[_arg_3].content);
                _INTERFACE.showContent(_arg_2[_arg_3].content, null, null, _arg_2[_arg_3].data, null);
            } else {
                com.clubpenguin.util.Log.info("\tshowing elseContent: " + _arg_2[_arg_3].elseContent);
                _INTERFACE.showContent(_arg_2[_arg_3].elseContent, null, null, _arg_2[_arg_3].data, null);
            }
        }
        function setupHint(_arg_3) {
            var _local_2 = 0;
            while (_local_2 < _arg_3.length) {
                com.clubpenguin.util.Log.info((("setupHint.hints[" + _local_2) + "].button: ") + _arg_3[_local_2]["button"]);
                com.clubpenguin.util.Log.info("\t\t\t\t   anchor: " + _arg_3[_local_2].anchor);
                _arg_3[_local_2]["button"].onRollOver = com.clubpenguin.util.Delegate.create(this, showHint, _arg_3, _local_2);
                _arg_3[_local_2]["button"].onRollOut = com.clubpenguin.util.Delegate.create(this, closeHint, _arg_3, _local_2);
                _arg_3[_local_2]["button"].onReleaseOutside = com.clubpenguin.util.Delegate.create(this, closeHint, _arg_3, _local_2);
                _local_2++;
            }
        }
        function showHint(_arg_3, _arg_2) {
            com.clubpenguin.util.Log.info("showHint: " + _arg_3[_arg_2].hint);
            _INTERFACE.showHint(_arg_3[_arg_2].anchor, _arg_3[_arg_2].hint);
        }
        function closeHint(_arg_3, _arg_2) {
            com.clubpenguin.util.Log.info("closeHint: " + _arg_3[_arg_2].hint);
            _INTERFACE.closeHint(_arg_3[_arg_2].anchor, _arg_3[_arg_2].hint);
        }
        function setupTableGame(_arg_4, _arg_3) {
            _arg_4.table_list = [];
            var _local_2 = 0;
            while (_local_2 < _arg_3.length) {
                com.clubpenguin.util.Log.info((("setupTableGame.tableObjects[" + _local_2) + "]: ") + _arg_3[_local_2].tableClip);
                _arg_4.table_list.push(_arg_3[_local_2].tableID);
                _arg_3[_local_2].tableClip.seat_frames = _arg_3[_local_2].seatframes;
                _arg_3[_local_2].tableClip.game_btn.onRelease = com.clubpenguin.util.Delegate.create(this, clickTable, _arg_3, _local_2);
                _arg_3[_local_2].tableClip.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _arg_3, _local_2);
                _arg_3[_local_2].tableClip.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _arg_3, _local_2);
                _arg_3[_local_2].triggerClip.triggerFunction = com.clubpenguin.util.Delegate.create(this, tableTrigger, _arg_3, _local_2);
                _local_2++;
            }
        }
        function clickTable(_arg_5, _arg_4) {
            var _local_3 = Math.round(_arg_5[_arg_4].tableClip._x);
            var _local_2 = Math.round(_arg_5[_arg_4].tableClip._y);
            _ENGINE.sendPlayerMove(_local_3, _local_2);
            com.clubpenguin.util.Log.info(((("setupTableGame.clickTable: _ENGINE.sendPlayerMove(" + _local_3) + ", ") + _local_2) + ")");
        }
        function tableRollOver(_arg_3, _arg_2) {
            var _local_4 = 2;
            com.clubpenguin.util.Log.info("setupTableGame.tableRollOver: " + _arg_3[_arg_2].tableClip);
            _INTERFACE.showHint(_arg_3[_arg_2].tableClip.game_btn, _arg_3[_arg_2].hintName);
            _arg_3[_arg_2].tableClip.game_mc.gotoAndStop(_local_4);
        }
        function tableRollOut(_arg_4, _arg_3) {
            var _local_2 = 1;
            com.clubpenguin.util.Log.info("setupTableGame.tableRollOut: " + _arg_4[_arg_3].tableClip);
            _INTERFACE.closeHint();
            _arg_4[_arg_3].tableClip.game_mc.gotoAndStop(_local_2);
        }
        function tableTrigger(_arg_3, _arg_2) {
            com.clubpenguin.util.Log.info("setupTableGame.tableTrigger: " + _arg_3[_arg_2].tableClip);
            _ENGINE.sendJoinTable(_arg_3[_arg_2].gameName, _arg_3[_arg_2].tableID, _arg_3[_arg_2].is_prompt);
        }
        static var QUEST_TARGET_PARK_FRAME = "park";
        static var QUEST_TARGET_SHOW_FRAME = "show";
    }
