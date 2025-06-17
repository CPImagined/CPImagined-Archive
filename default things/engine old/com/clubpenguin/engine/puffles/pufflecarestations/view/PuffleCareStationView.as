class com.clubpenguin.engine.puffles.pufflecarestations.view.PuffleCareStationView
{
    var _playerMC, _playerId, _ENGINE, _SHELL, _playerVO, onEatAnimationCompleteSignal, _puffleItemID, _pizzaStage;
    function PuffleCareStationView(playerMC, playerId)
    {
        _playerMC = playerMC;
        _playerId = playerId;
        _ENGINE = _global.getCurrentEngine();
        _SHELL = _global.getCurrentShell();
        _playerVO = _SHELL.getPlayerObjectById(_playerId);
        onEatAnimationCompleteSignal = new org.osflash.signals.Signal();
    } // End of the function
    function playEatAnimation(eatAnimationURL, puffleItemID)
    {
        _puffleItemID = puffleItemID;
        _pizzaStage = _ENGINE.getRoomMovieClip();
        var _loc4 = _ENGINE.puffleAvatarController.getPuffleClip(_playerVO.attachedPuffle.id);
        var _loc2 = _ENGINE.getRoomMovieClip().createEmptyMovieClip("eatClip" + _playerId, _loc4.getDepth() + com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_CLIP_DEPTH_PADDING);
        _loc2._x = _playerMC._x;
        _loc2._y = _playerMC._y;
        _loc2._xscale = _playerMC._xscale;
        _loc2._yscale = _playerMC._yscale;
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onEatAnimationLoaded, _loc2));
        _loc3.loadClip(eatAnimationURL, _loc2, "PuffleCareStationView playEatAnimation()");
    } // End of the function
    function onEatAnimationLoaded(event, eatClip)
    {
        _ENGINE.puffleAvatarController.hidePuffle(_playerVO.attachedPuffle.id);
        var isMyPlayer = _SHELL.isMyPlayer(_playerId);
        var scope = this;
        var pizzaStationBackgroundRef = _pizzaStage.background_mc.careStation_mc;
        var pizzaStationPizzaRef = null;
        var pizzaStationSpoutRef = null;
        var timeDelay = com.clubpenguin.engine.puffles.pufflecarestations.view.PuffleCareStationView.START_PIZZA_FUNNEL_FRAME;
        if (isMyPlayer)
        {
            pizzaStationBackgroundRef.gotoAndPlay(1);
            eatClip.puffle.gotoAndStop(1);
            this.sendPuffleCareStationBI();
        } // end if
        eatClip.onEnterFrame = function ()
        {
            if (!isMyPlayer)
            {
                if (pizzaStationBackgroundRef._currentframe >= timeDelay && pizzaStationSpoutRef == null)
                {
                    pizzaStationSpoutRef = pizzaStationBackgroundRef.spout_mc.spoutFire_mc;
                    pizzaStationSpoutRef.gotoAndPlay(1);
                    pizzaStationPizzaRef = pizzaStationBackgroundRef.flyingPizza_mc;
                    pizzaStationPizzaRef.gotoAndPlay(1);
                } // end if
            }
            else
            {
                eatClip.gotoAndStop(1);
                if (pizzaStationBackgroundRef._currentframe >= timeDelay && pizzaStationSpoutRef == null)
                {
                    pizzaStationSpoutRef = pizzaStationBackgroundRef.spout_mc.spoutFire_mc;
                    pizzaStationSpoutRef.gotoAndPlay(1);
                    pizzaStationPizzaRef = pizzaStationBackgroundRef.flyingPizza_mc;
                    pizzaStationPizzaRef.gotoAndPlay(1);
                    eatClip.puffle.gotoAndPlay(1);
                } // end if
            } // end else if
            if (eatClip.puffle._currentframe >= eatClip.puffle._totalframes)
            {
                pizzaStationBackgroundRef = null;
                pizzaStationSpoutRef = null;
                pizzaStationPizzaRef = null;
                eatClip.onEnterFrame = null;
                eatClip.removeMovieClip();
                if (isMyPlayer)
                {
                    var _loc2 = scope._SHELL.getMyPlayerObject().attachedPuffle.id;
                    _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_loc2, "statsBarWidget", scope._puffleItemID);
                } // end if
                _global.getCurrentEngine().puffleAvatarController.showPuffle(_global.getCurrentShell().getPlayerObjectById(scope._playerId).attachedPuffle.id);
                scope.onEatAnimationCompleteSignal.dispatch();
            } // end if
        };
    } // End of the function
    function sendPuffleCareStationBI()
    {
        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PIZZA_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION, _puffleItemID);
    } // End of the function
    static var START_PIZZA_FUNNEL_FRAME = 130;
} // End of Class
