class com.clubpenguin.engine.puffletreasure.view.PuffleTreasureDigView
{
    var _SHELL, _ENGINE, digAnimationDone, _digClip, _AS3NotificationSent, puffleTreasureVO, playerMC, _almostDoneFrame;
    function PuffleTreasureDigView()
    {
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onRoomDestroyed));
        digAnimationDone = new org.osflash.signals.Signal(com.clubpenguin.engine.puffletreasure.view.PuffleTreasureDigView);
    } // End of the function
    function destroy()
    {
        _digClip.onEnterFrame = null;
        _digClip.removeMovieClip();
        _SHELL.sendAS3EnablePuffleTricksHUD();
        if (!_AS3NotificationSent && _SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id))
        {
            this.sendPuffleTreasureVOToAS3();
        } // end if
        _ENGINE.puffleAvatarController.showPuffle(puffleTreasureVO.playerVO.attachedPuffle.id);
    } // End of the function
    function playDigAnimation(digAnimationURL)
    {
        var _loc3 = _ENGINE.puffleAvatarController.getPuffleClip(puffleTreasureVO.playerVO.attachedPuffle.id);
        _digClip = _ENGINE.getRoomMovieClip().createEmptyMovieClip("digClip" + puffleTreasureVO.playerVO.attachedPuffle.id, _loc3.getDepth() + 2);
        _digClip._x = playerMC._x;
        _digClip._y = playerMC._y;
        _digClip._xscale = playerMC._xscale;
        _digClip._yscale = playerMC._yscale;
        _digClip._visible = false;
        _AS3NotificationSent = false;
        var _loc2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onDigAnimationLoaded));
        _loc2.loadClip(digAnimationURL, _digClip, "PuffleTreasureDigView playDigAnimation()");
    } // End of the function
    function onDigAnimationLoaded(event)
    {
        var treasureAttached = false;
        var scope = this;
        var puffleID = puffleTreasureVO.playerVO.attachedPuffle.id;
        var _loc4 = _ENGINE.puffleAvatarController;
        _loc4.hidePuffle(puffleID);
        _digClip._visible = true;
        _almostDoneFrame = _digClip.puffle._totalframes - FRAMES_FROM_END;
        _digClip.onEnterFrame = function ()
        {
            if (!treasureAttached && scope._digClip.puffle.treasureContainer != undefined)
            {
                var _loc1;
                if (scope.puffleTreasureVO.isCoins())
                {
                    _loc1 = "MoneyBag";
                }
                else if (scope.isShowTreasureBoxAnim())
                {
                    _loc1 = "TreasureBox";
                }
                else if (scope.puffleTreasureVO.isGoldNugget())
                {
                    _loc1 = "GoldNugget";
                }
                else
                {
                    _loc1 = "WoodenBox";
                } // end else if
                var _loc3 = scope._digClip.puffle.treasureContainer.attachMovie(_loc1, _loc1 + scope.puffleTreasureVO.playerVO.player_id, scope._digClip.getDepth() + 1);
                if (!scope.puffleTreasureVO.isCoins())
                {
                    var _loc2 = _loc3.item.holder;
                    var _loc4 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                    _loc2._xscale = _loc2._yscale = 20;
                    if (scope.puffleTreasureVO.isFood())
                    {
                        _loc2._x = _loc2._x - 2;
                        _loc2._y = _loc2._y + 2;
                    } // end if
                    _loc4.loadClip(scope.puffleTreasureVO.assetURL, _loc2, "PuffleTreasureDigView onDigAnimationLoaded()");
                } // end if
                treasureAttached = true;
            } // end if
            if (scope._digClip.puffle._currentframe == scope._almostDoneFrame)
            {
                scope.onDigAnimationNearlyComplete();
            } // end if
            if (scope._digClip.puffle._currentframe >= scope._digClip.puffle._totalframes)
            {
                scope._ENGINE.puffleAvatarController.showPuffle(puffleID);
                scope.digAnimationDone.dispatch(scope);
                scope._digClip.onEnterFrame = null;
                scope._digClip.removeMovieClip();
            } // end if
        };
    } // End of the function
    function onDigAnimationNearlyComplete()
    {
        if (puffleTreasureVO.isCoins())
        {
            var _loc2 = _ENGINE.avatarManager.effectManager.playEffectForPlayer(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.PUFFLE_FOUND_COINS, puffleTreasureVO.playerVO);
            _loc2.coinAmountMC.coinAmount.text = String(puffleTreasureVO.quantity);
        } // end if
        if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id))
        {
            this.sendPuffleTreasureVOToAS3();
        } // end if
    } // End of the function
    function sendPuffleTreasureVOToAS3()
    {
        var _loc2 = new Object();
        _loc2.puffleId = puffleTreasureVO.puffleId;
        _loc2.treasureType = puffleTreasureVO.treasureType;
        _loc2.treasureId = puffleTreasureVO.treasureId;
        _loc2.quantity = puffleTreasureVO.quantity;
        _SHELL.sendAS3ShowPuffleTreasureNotification(_loc2);
        _AS3NotificationSent = true;
    } // End of the function
    function onRoomDestroyed()
    {
        this.destroy();
    } // End of the function
    function isShowTreasureBoxAnim()
    {
        if (puffleTreasureVO.isFurniture())
        {
            return (true);
        }
        else if (puffleTreasureVO.isClothing())
        {
            var _loc2 = _SHELL.getInventoryObjectById(puffleTreasureVO.treasureId);
            return (_loc2 && _loc2.is_member);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    var FRAMES_FROM_END = 45;
} // End of Class
