class com.clubpenguin.engine.puffles.pufflegoldberrystation.view.PuffleGoldBerryStationView
{
    var _SHELL, _ENGINE, _playerVO, _playerMC, _playerId, _puffleId, onEatGoldBerryAnimationCompleteSignal, petStage, _removeRoomListener;
    function PuffleGoldBerryStationView(playerMC, playerId, puffleId, shell_mc, engine_mc)
    {
        _SHELL = shell_mc;
        _ENGINE = engine_mc;
        _playerVO = _SHELL.getPlayerObjectById(playerId);
        _playerMC = playerMC;
        _playerId = playerId;
        _puffleId = puffleId;
        onEatGoldBerryAnimationCompleteSignal = new org.osflash.signals.Signal(Object);
    } // End of the function
    function playEatAnimation(eatAnimationURL)
    {
        petStage = _ENGINE.getRoomMovieClip();
        var _loc4 = _ENGINE.puffleAvatarController.getPuffleClip(_playerVO.attachedPuffle.id);
        var _loc2 = _ENGINE.getRoomMovieClip().createEmptyMovieClip("eatClip" + _playerId, _loc4.getDepth() + com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_CLIP_DEPTH_PADDING);
        _loc2._x = _playerMC._x;
        _loc2._y = _playerMC._y;
        _loc2._xscale = _playerMC._xscale;
        _loc2._yscale = _playerMC._yscale;
        var _loc3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
        _loc3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onEatGoldBerryAnimationLoaded, _loc2));
        _loc3.loadClip(eatAnimationURL, _loc2, "PuffleGoldBerryStationView playEatAnimation()");
    } // End of the function
    function onEatGoldBerryAnimationLoaded(event, eatClip)
    {
        _ENGINE.puffleAvatarController.hidePuffle(_playerVO.attachedPuffle.id);
        var isMyPlayer = _SHELL.isMyPlayer(_playerId);
        var scope = this;
        var petGoldBerryMachineBackgroundRef = petStage.background_mc;
        var petGoldBerryMachineBerryRef = null;
        var petGoldBerryMachineSpoutRef = null;
        var timeDelay = com.clubpenguin.engine.puffles.pufflegoldberrystation.view.PuffleGoldBerryStationView.START_GOLD_BERRY_FUNNEL_FRAME;
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, onEatGoldBerryAnimationDone, this);
        _removeRoomListener = false;
        if (isMyPlayer)
        {
            petGoldBerryMachineBackgroundRef.goldberrymachine_mc.gotoAndPlay(1);
            eatClip.puffle.gotoAndStop(1);
        } // end if
        eatClip.onEnterFrame = function ()
        {
            if (!isMyPlayer)
            {
                if (petGoldBerryMachineBackgroundRef.goldberrymachine_mc._currentframe >= timeDelay && petGoldBerryMachineSpoutRef == null)
                {
                    petGoldBerryMachineSpoutRef = petGoldBerryMachineBackgroundRef.spout_mc.spoutFire_mc;
                    petGoldBerryMachineSpoutRef.gotoAndPlay(1);
                    petGoldBerryMachineBerryRef = petGoldBerryMachineBackgroundRef.flyingBerry_mc;
                    petGoldBerryMachineBerryRef.gotoAndPlay(1);
                } // end if
            }
            else
            {
                eatClip.gotoAndStop(1);
                if (petGoldBerryMachineBackgroundRef.goldberrymachine_mc._currentframe >= timeDelay && petGoldBerryMachineSpoutRef == null)
                {
                    petGoldBerryMachineSpoutRef = petGoldBerryMachineBackgroundRef.spout_mc.spoutFire_mc;
                    petGoldBerryMachineSpoutRef.gotoAndPlay(1);
                    petGoldBerryMachineBerryRef = petGoldBerryMachineBackgroundRef.flyingBerry_mc;
                    petGoldBerryMachineBerryRef.gotoAndPlay(1);
                    eatClip.puffle.gotoAndPlay(1);
                } // end if
            } // end else if
            if (eatClip.puffle._currentframe >= eatClip.puffle._totalframes)
            {
                petGoldBerryMachineBackgroundRef = null;
                petGoldBerryMachineSpoutRef = null;
                petGoldBerryMachineBerryRef = null;
                eatClip.onEnterFrame = null;
                eatClip.removeMovieClip();
                _global.getCurrentEngine().puffleAvatarController.showPuffle(scope._puffleId);
                var _loc2 = new Object();
                _loc2.playerVO = scope._playerVO;
                _loc2.puffleId = scope._puffleId;
                scope.onEatGoldBerryAnimationCompleteSignal.dispatch(_loc2);
                scope._removeRoomListener = true;
            } // end if
        };
    } // End of the function
    function onEatGoldBerryAnimationDone()
    {
        if (!_removeRoomListener)
        {
            var _loc2 = new Object();
            _loc2.playerId = _playerId;
            _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc2);
            _SHELL.puffleManager.setPuffleState(_playerId, com.clubpenguin.engine.puffles.pufflegoldberrystation.view.PuffleGoldBerryStationView.GOLDEN_STATE, _puffleId);
        } // end if
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, onEatGoldBerryAnimationDone, this);
    } // End of the function
    static var START_GOLD_BERRY_FUNNEL_FRAME = 68;
    static var GOLDEN_STATE = 1;
} // End of Class
