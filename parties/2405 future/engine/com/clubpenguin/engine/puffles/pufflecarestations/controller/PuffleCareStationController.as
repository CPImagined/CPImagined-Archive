//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.pufflecarestations.controller.PuffleCareStationController
    {
        var _SHELL, _ENGINE, _handleRoomDestroyedDelegate, _playerId;
        function PuffleCareStationController (shellMC, engineMC) {
            _SHELL = shellMC;
            _ENGINE = engineMC;
            _handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
        }
        function onPuffleCareStationFeed(playerId, puffleItemID) {
            var _local_2 = _SHELL.getPlayerObjectById(playerId);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && (_ENGINE.puffleAvatarController.isPuffleVisible(_local_2.attachedPuffle.id))) {
                if ((_SHELL.getCurrentRoomId() == PIZZA_ROOM) || (_SHELL.getCurrentRoomId() == PARTY_PIZZA)) {
                    if (_SHELL.isMyPlayer(playerId)) {
                        _SHELL.sendAS3DisablePuffleTricksHUD();
                    }
                    _playerId = playerId;
                    var _local_7 = _ENGINE.getPlayerMovieClip(playerId);
                    var _local_4 = new com.clubpenguin.engine.puffles.pufflecarestations.view.PuffleCareStationView(_local_7, _local_2.player_id);
                    var _local_3 = _SHELL.getPath(EATING_ANIMATION_URL);
                    _local_3 = _local_2.attachedPuffle.getFormattedAssetURL(_local_3);
                }
                var _local_5 = new Object();
                _local_5.playerId = _local_2.player_id;
                _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_5);
                _local_4.onEatAnimationCompleteSignal.addOnce(onEatAnimationDone, this);
                _local_4.playEatAnimation(_local_3, puffleItemID);
            }
        }
        function onPuffleFullStatsAnimation(playerId) {
            var _local_2 = new com.clubpenguin.engine.puffles.animations.FullStatsAnimation(_SHELL, _ENGINE);
            _local_2.playFullStatsAnimation(playerId);
        }
        function enableDigSearchAndTricksHUD() {
            var _local_2 = new Object();
            _local_2.playerId = _playerId;
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2);
            if (_SHELL.isMyPlayer(_playerId)) {
                _SHELL.sendAS3EnablePuffleTricksHUD();
            }
        }
        function handleRoomDestroyed() {
            enableDigSearchAndTricksHUD();
        }
        function onEatAnimationDone() {
            enableDigSearchAndTricksHUD();
        }
        static var EATING_ANIMATION_URL = "w.puffle.sprite.eat";
        static var PLAY_SHORT = "_short.swf";
        static var PIZZA_ROOM = 330;
        static var PARTY_PIZZA = 864;
    }
