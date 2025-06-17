class com.clubpenguin.engine.puffles.pufflegoldreveal.controller.PuffleGoldRevealController
{
    var _SHELL, _ENGINE, _INTERFACE;
    function PuffleGoldRevealController(shellMC, engineMC, interfaceMC)
    {
        _SHELL = shellMC;
        _ENGINE = engineMC;
        _INTERFACE = interfaceMC;
    } // End of the function
    function onGoldPuffleReveal(playerId)
    {
        var _loc2 = _SHELL.getPlayerObjectById(playerId);
        var _loc4 = _SHELL.isMyPlayer(playerId);
        if (_loc4 && _SHELL.getCurrentRoomId() == com.clubpenguin.engine.puffles.pufflegoldreveal.controller.PuffleGoldRevealController.CAVE_MINE_ID)
        {
            _ENGINE.disableMouseMovement();
            if (_goldRevealView != null && _showLocalPlayerAnimation == false)
            {
                _goldRevealView.stopAnimation();
                _showLocalPlayerAnimation = true;
            }
            else
            {
                this.startNewGoldRevealAnimation(playerId, _loc2);
            } // end else if
        }
        else if (_goldRevealView == null && _SHELL.getCurrentRoomId() == com.clubpenguin.engine.puffles.pufflegoldreveal.controller.PuffleGoldRevealController.CAVE_MINE_ID)
        {
            this.startNewGoldRevealAnimation(playerId, _loc2);
        } // end else if
    } // End of the function
    function startNewGoldRevealAnimation(playerId, playerVO)
    {
        _goldRevealView = new com.clubpenguin.engine.puffles.pufflegoldreveal.view.PuffleGoldRevealView(_SHELL, _ENGINE, playerId);
        var _loc2 = new Object();
        _loc2.playerId = playerVO.player_id;
        _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc2);
        _goldRevealView.onGoldRevealAnimationCompleteSignal.addOnce(onGoldRevealAnimationComplete, this);
        _goldRevealView.playGoldPuffleRevealAnimation();
    } // End of the function
    function onGoldRevealAnimationComplete(playerVO)
    {
        _goldRevealView = null;
        var _loc2 = new Object();
        _loc2.playerId = playerVO.player_id;
        _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc2);
        if (_showLocalPlayerAnimation)
        {
            this.startNewGoldRevealAnimation(_SHELL.getMyPlayerObject().player_id, _SHELL.getMyPlayerObject());
            _showLocalPlayerAnimation = false;
        } // end if
        var _loc3 = _SHELL.isMyPlayer(playerVO.player_id);
        if (_loc3)
        {
            _ENGINE.enableMouseMovement();
            _INTERFACE.showContent(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_ADOPTION, null, undefined, {puffleAdoptionType: "gold"}, true);
        } // end if
    } // End of the function
    static var CAVE_MINE_ID = 813;
    var _goldRevealView = null;
    var _showLocalPlayerAnimation = false;
} // End of Class
