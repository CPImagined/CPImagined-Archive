//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.pufflegoldberrystation.controller.PuffleGoldBerryStationController
    {
        var _SHELL, _ENGINE, _INTERFACE, _handleRoomDestroyedDelegate, _playerId;
        function PuffleGoldBerryStationController (shellMC, engineMC, interfaceMC) {
            _SHELL = shellMC;
            _ENGINE = engineMC;
            _INTERFACE = interfaceMC;
            _handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _handleRoomDestroyedDelegate);
        }
        function onPuffleGoldBerryStationFeed(playerId, puffleId) {
            var _local_2 = _SHELL.getPlayerObjectById(playerId);
            if ((com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && (_ENGINE.puffleAvatarController.isPuffleVisible(puffleId))) && (_SHELL.getCurrentRoomId() == PET_SHOP_ID)) {
                if (_SHELL.isMyPlayer(playerId)) {
                    _SHELL.sendAS3DisablePuffleTricksHUD();
                }
                _playerId = playerId;
                var _local_7 = _ENGINE.getPlayerMovieClip(playerId);
                var _local_5 = new com.clubpenguin.engine.puffles.pufflegoldberrystation.view.PuffleGoldBerryStationView(_local_7, playerId, puffleId, _SHELL, _ENGINE);
                var _local_3 = _SHELL.getPath(EATING_ANIMATION_URL);
                _local_3 = _local_2.attachedPuffle.getFormattedAssetURL(_local_3);
                var _local_6 = new Object();
                _local_6.playerId = _local_2.player_id;
                _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_6);
                _local_5.onEatGoldBerryAnimationCompleteSignal.addOnce(onEatGoldBerryAnimationDone, this);
                _local_5.playEatAnimation(_local_3);
            }
        }
        function onEatGoldBerryAnimationDone(payloadObject) {
            var _local_3 = new Object();
            _local_3.playerId = payloadObject.playerVO.player_id;
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_3);
            _SHELL.puffleManager.setPuffleState(payloadObject.playerVO.player_id, GOLDEN_STATE, payloadObject.puffleId);
            enableDigSearchAndTricksHUD();
            if ((!_INTERFACE.isGoldNuggetsHUDVisible()) && (_SHELL.isMyPlayer(payloadObject.playerVO.player_id))) {
                var _local_4 = payloadObject.playerVO.currencies[_SHELL.CURRENCY_TYPE_GOLD_NUGGETS];
                var _local_5 = true;
                var _local_6 = _local_4 == 0;
                _INTERFACE.showGoldNuggetsHUD(_local_5, _local_6);
            }
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
        function sendPuffleGoldBerryStationBI() {
        }
        static var GOLDEN_STATE = 1;
        static var PET_SHOP_ID = 310;
        static var EATING_ANIMATION_URL = "w.puffle.sprite.eat";
    }
