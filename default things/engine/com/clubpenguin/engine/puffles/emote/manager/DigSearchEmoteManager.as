//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.emote.manager.DigSearchEmoteManager
    {
        var _SHELL, _ENGINE, _isPuffleDigSearchEmoteEnabled, _autoReenable, _myPlayerObject;
        function DigSearchEmoteManager () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _isPuffleDigSearchEmoteEnabled = true;
            _autoReenable = true;
            _myPlayerObject = _SHELL.getMyPlayerObject();
            _SHELL.addListener(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onEnablePuffleDigSearchEmote));
            _SHELL.addListener(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onDisablePuffleDigSearchEmote));
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onEnablePuffleDigSearchEmote));
            _SHELL.removeListener(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, com.clubpenguin.util.Delegate.create(this, onDisablePuffleDigSearchEmote));
        }
        function displayPuffleEmote(playerObject) {
            if (!_SHELL.isMyPlayer(playerObject.player_id)) {
                return(undefined);
            }
            if (playerObject.isUsingSlide) {
                return(undefined);
            }
            if (_isPuffleDigSearchEmoteEnabled && (_ENGINE.puffleAvatarController.isPuffleVisible(playerObject.attachedPuffle.id))) {
                var _local_5 = _ENGINE.puffleAvatarController.getPuffleClip(playerObject.attachedPuffle.id);
                if (_global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(_local_5)) {
                    return(undefined);
                }
                var _local_7 = _SHELL.randBetween(1, 100);
                if (_local_7 <= RANDOM_PERCENTAGE_FOR_SHOWING_EMOTE) {
                    var _local_4 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.DIG_SEARCH_EMOTICON_PATH;
                    if (playerObject.attachedPuffle.getPuffleState() == 1) {
                        _local_4 = com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.GOLD_NUGGET_SEARCH_EMOTICON_PATH;
                    }
                    var _local_8 = _SHELL.getPath(_local_4);
                    _ENGINE.puffleEmoteManager.showEmote(playerObject.attachedPuffle.id, _local_5, com.clubpenguin.engine.puffles.emote.PuffleEmoteConstants.DIG_SEARCH_EMOTE_STATE, _local_8);
                }
            } else if (_autoReenable) {
                var _local_6 = new Object();
                _local_6.playerId = playerObject.player_id;
                onEnablePuffleDigSearchEmote(_local_6);
            }
        }
        function onEnablePuffleDigSearchEmote(data) {
            com.clubpenguin.util.Log.debug("onEnablePuffleDigSearchEmote()");
            if (!_SHELL.isMyPlayer(data.playerId)) {
                return(undefined);
            }
            if ((data.autoReenable != undefined) && (data.autoReenable != null)) {
                _autoReenable = data.autoReenable;
            }
            if (_autoReenable) {
                _isPuffleDigSearchEmoteEnabled = true;
            }
        }
        function onDisablePuffleDigSearchEmote(data) {
            com.clubpenguin.util.Log.debug("onDisablePuffleDigSearchEmote()");
            if (!_SHELL.isMyPlayer(data.playerId)) {
                return(undefined);
            }
            if ((data.autoReenable != undefined) && (data.autoReenable != null)) {
                _autoReenable = data.autoReenable;
            }
            _isPuffleDigSearchEmoteEnabled = false;
            if (!com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_myPlayerObject, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _ENGINE.puffleEmoteManager.removeEmote(_myPlayerObject.attachedPuffle.id);
            }
        }
        static var RANDOM_PERCENTAGE_FOR_SHOWING_EMOTE = 25;
    }
