class com.clubpenguin.engine.puffles.pufflegoldreveal.view.PuffleGoldRevealView
{
    var _SHELL, _ENGINE, onGoldRevealAnimationCompleteSignal, _playerId, _playerVO, _mineCaveStage, _stopAnimation;
    function PuffleGoldRevealView(shell_mc, engine_mc, playerId)
    {
        _SHELL = shell_mc;
        _ENGINE = engine_mc;
        onGoldRevealAnimationCompleteSignal = new org.osflash.signals.Signal(com.clubpenguin.model.vo.PlayerVO);
        _playerId = playerId;
        _playerVO = _SHELL.getPlayerObjectById(playerId);
    } // End of the function
    function playGoldPuffleRevealAnimation()
    {
        _ENGINE.puffleAvatarController.hidePuffle(_playerVO.attachedPuffle.id);
        _mineCaveStage = _ENGINE.getRoomMovieClip();
        var _loc2 = _SHELL.isMyPlayer(_playerId);
        _stopAnimation = false;
        var scope = this;
        var caveMineBackgroundRef = _mineCaveStage.background_mc.goldRevealBg_mc;
        var caveMineForgroundPuffleRef = _mineCaveStage.goldRevealObjDepth_mc;
        caveMineBackgroundRef.onEnterFrame = function ()
        {
            if (caveMineBackgroundRef._currentFrame == 1)
            {
                caveMineBackgroundRef.gotoAndPlay(2);
                caveMineForgroundPuffleRef.goldRevealObj_mc.gotoAndPlay(2);
            } // end if
            if (caveMineBackgroundRef._currentFrame >= caveMineBackgroundRef._totalFrames || scope.getStopAnimation() == true)
            {
                caveMineBackgroundRef.onEnterFrame = null;
                caveMineBackgroundRef.gotoAndStop(1);
                caveMineForgroundPuffleRef.gotoAndStop(1);
                scope.onGoldRevealAnimationCompleteSignal.dispatch(scope._playerVO);
            } // end if
        };
    } // End of the function
    function stopAnimation()
    {
        _stopAnimation = true;
    } // End of the function
    function getStopAnimation()
    {
        return (_stopAnimation);
    } // End of the function
} // End of Class
