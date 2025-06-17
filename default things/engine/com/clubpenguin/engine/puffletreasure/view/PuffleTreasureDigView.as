//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffletreasure.view.PuffleTreasureDigView
    {
        var _SHELL, _ENGINE, digAnimationDone, _digClip, _AS3NotificationSent, puffleTreasureVO, playerMC, _almostDoneFrame;
        function PuffleTreasureDigView () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onRoomDestroyed));
            digAnimationDone = new org.osflash.signals.Signal(com.clubpenguin.engine.puffletreasure.view.PuffleTreasureDigView);
        }
        function destroy() {
            _digClip.onEnterFrame = null;
            _digClip.removeMovieClip();
            _SHELL.sendAS3EnablePuffleTricksHUD();
            if ((!_AS3NotificationSent) && (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id))) {
                sendPuffleTreasureVOToAS3();
            }
            _ENGINE.puffleAvatarController.showPuffle(puffleTreasureVO.playerVO.attachedPuffle.id);
        }
        function playDigAnimation(digAnimationURL) {
            var _local_3 = _ENGINE.puffleAvatarController.getPuffleClip(puffleTreasureVO.playerVO.attachedPuffle.id);
            _digClip = _ENGINE.getRoomMovieClip().createEmptyMovieClip("digClip" + puffleTreasureVO.playerVO.attachedPuffle.id, _local_3.getDepth() + 2);
            _digClip._x = playerMC._x;
            _digClip._y = playerMC._y;
            _digClip._xscale = playerMC._xscale;
            _digClip._yscale = playerMC._yscale;
            _digClip._visible = false;
            _AS3NotificationSent = false;
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onDigAnimationLoaded));
            _local_2.loadClip(digAnimationURL, _digClip, "PuffleTreasureDigView playDigAnimation()");
        }
        function onDigAnimationLoaded(event) {
            var treasureAttached = false;
            var scope = this;
            var puffleID = puffleTreasureVO.playerVO.attachedPuffle.id;
            var _local_4 = _ENGINE.puffleAvatarController;
            _local_4.hidePuffle(puffleID);
            _digClip._visible = true;
            _almostDoneFrame = _digClip.puffle._totalframes - FRAMES_FROM_END;
            _digClip.onEnterFrame = function () {
                if ((!treasureAttached) && (scope._digClip.puffle.treasureContainer != undefined)) {
                    var _local_1;
                    if (scope.puffleTreasureVO.isCoins()) {
                        _local_1 = "MoneyBag";
                    } else if (scope.isShowTreasureBoxAnim()) {
                        _local_1 = "TreasureBox";
                    } else if (scope.puffleTreasureVO.isGoldNugget()) {
                        _local_1 = "GoldNugget";
                    } else {
                        _local_1 = "WoodenBox";
                    }
                    var _local_3 = scope._digClip.puffle.treasureContainer.attachMovie(_local_1, _local_1 + scope.puffleTreasureVO.playerVO.player_id, scope._digClip.getDepth() + 1);
                    if (!scope.puffleTreasureVO.isCoins()) {
                        var _local_2 = _local_3.item.holder;
                        var _local_4 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                        _local_2._xscale = (_local_2._yscale = 20);
                        if (scope.puffleTreasureVO.isFood()) {
                            _local_2._x = _local_2._x - 2;
                            _local_2._y = _local_2._y + 2;
                        }
                        _local_4.loadClip(scope.puffleTreasureVO.assetURL, _local_2, "PuffleTreasureDigView onDigAnimationLoaded()");
                    }
                    treasureAttached = true;
                }
                if (scope._digClip.puffle._currentframe == scope._almostDoneFrame) {
                    scope.onDigAnimationNearlyComplete();
                }
                if (scope._digClip.puffle._currentframe >= scope._digClip.puffle._totalframes) {
                    scope._ENGINE.puffleAvatarController.showPuffle(puffleID);
                    scope.digAnimationDone.dispatch(scope);
                    scope._digClip.onEnterFrame = null;
                    scope._digClip.removeMovieClip();
                }
            };
        }
        function onDigAnimationNearlyComplete() {
            if (puffleTreasureVO.isCoins()) {
                var _local_2 = _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PUFFLE_FOUND_COINS, puffleTreasureVO.playerVO);
                _local_2.coinAmountMC.coinAmount.text = String(puffleTreasureVO.quantity);
            }
            if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id)) {
                sendPuffleTreasureVOToAS3();
            }
        }
        function sendPuffleTreasureVOToAS3() {
            var _local_2 = new Object();
            _local_2.puffleId = puffleTreasureVO.puffleId;
            _local_2.treasureType = puffleTreasureVO.treasureType;
            _local_2.treasureId = puffleTreasureVO.treasureId;
            _local_2.quantity = puffleTreasureVO.quantity;
            _SHELL.sendAS3ShowPuffleTreasureNotification(_local_2);
            _AS3NotificationSent = true;
        }
        function onRoomDestroyed() {
            destroy();
        }
        function isShowTreasureBoxAnim() {
            if (puffleTreasureVO.isFurniture()) {
                return(true);
            } else if (puffleTreasureVO.isClothing()) {
                var _local_2 = _SHELL.getInventoryObjectById(puffleTreasureVO.treasureId);
                return(_local_2 && (_local_2.is_member));
            } else {
                return(false);
            }
        }
        var FRAMES_FROM_END = 45;
    }
