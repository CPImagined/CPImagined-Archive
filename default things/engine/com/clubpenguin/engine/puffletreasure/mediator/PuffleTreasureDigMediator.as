//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffletreasure.mediator.PuffleTreasureDigMediator
    {
        var _treasureFound, _SHELL, _ENGINE, _INTERFACE;
        function PuffleTreasureDigMediator (treasureFound) {
            _treasureFound = treasureFound;
            _treasureFound.add(onTreasureFound, this);
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
        }
        function destroy() {
            _treasureFound.remove(onTreasureFound, this);
        }
        function onTreasureFound(puffleTreasureVO) {
            _ENGINE.puffleTricks.cancelCurrentTrick(puffleTreasureVO.puffleId);
            var _local_9 = _ENGINE.getPlayerMovieClip(puffleTreasureVO.playerVO.player_id);
            if (puffleTreasureVO.isCoins()) {
                if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id)) {
                    _SHELL.sendAS3DisablePuffleTricksHUD();
                    var _local_5 = puffleTreasureVO.quantity;
                    if (!isNaN(_local_5)) {
                        var _local_11 = Number(_SHELL.getMyPlayerTotalCoins()) + _local_5;
                        _SHELL.setMyPlayerTotalCoins(_local_11);
                    }
                }
                puffleTreasureVO.assetURL = "";
            } else if (puffleTreasureVO.isFood()) {
                if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id)) {
                    _SHELL.sendAddPuffleCareItem(puffleTreasureVO.treasureId, puffleTreasureVO.quantity, true);
                }
                var _local_10 = _SHELL.getPuffleHatCollection();
                var _local_12 = _local_10.getPuffleHatVO(puffleTreasureVO.treasureId);
                puffleTreasureVO.assetURL = (_SHELL.getGlobalContentPath() + "puffle/care_icons/") + _local_12.assetLinkage;
            } else if (puffleTreasureVO.isFurniture()) {
                puffleTreasureVO.assetURL = ((_SHELL.getGlobalContentPath() + "furniture/icons/") + puffleTreasureVO.treasureId) + ".swf";
            } else if (puffleTreasureVO.isClothing()) {
                if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id) && (!_SHELL.isItemInMyInventory(puffleTreasureVO.treasureId))) {
                    var _local_7 = _SHELL.getInventoryObjectById(puffleTreasureVO.treasureId);
                    if (_local_7) {
                        var _local_8 = _SHELL.getMyInventoryArray();
                        _local_8.push(_local_7);
                    }
                }
                puffleTreasureVO.assetURL = ((_SHELL.getGlobalContentPath() + "clothing/icons/") + puffleTreasureVO.treasureId) + ".swf";
            }
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(puffleTreasureVO.playerVO, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && (_ENGINE.puffleAvatarController.isPuffleVisible(puffleTreasureVO.playerVO.attachedPuffle.id))) {
                var _local_3 = new com.clubpenguin.engine.puffletreasure.view.PuffleTreasureDigView();
                var _local_4 = _SHELL.getPath("w.puffle.sprite.dig");
                _local_4 = puffleTreasureVO.playerVO.attachedPuffle.getFormattedAssetURL(_local_4);
                var _local_6 = new Object();
                _local_6.playerId = puffleTreasureVO.playerVO.player_id;
                _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_6);
                _local_3.digAnimationDone.addOnce(onDigAnimationDone, this);
                _local_3.playerMC = _local_9;
                _local_3.puffleTreasureVO = puffleTreasureVO;
                _local_3.playDigAnimation(_local_4);
            }
        }
        function onDigAnimationDone(view) {
            _SHELL.sendAS3EnablePuffleTricksHUD();
            var _local_2 = new Object();
            _local_2.playerId = view.puffleTreasureVO.playerVO.player_id;
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2);
            if (_SHELL.isMyPlayer(view.puffleTreasureVO.playerVO.player_id)) {
                if (view.puffleTreasureVO.isFirstSuccessfulDig) {
                    _INTERFACE.showContent("w.puffletreasure.dialog.firstsuccessfuldig");
                }
            }
        }
    }
