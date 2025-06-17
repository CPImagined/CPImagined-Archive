class com.clubpenguin.engine.puffles.puffletricks.PuffleTricks
{
    var _shell, _engine, _interface, _loaderMap;
    function PuffleTricks(shell, engine, interfacer)
    {
        _shell = shell;
        _engine = engine;
        _interface = interfacer;
        _loaderMap = new Object();
    } // End of the function
    function onPuffleTrickReceivedFromServer(playerId, trickId)
    {
        var _loc2 = com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.getPuffleTricksById(trickId);
        if (_loc2)
        {
            var _loc4 = _shell.getPlayerObjectById(playerId).attachedPuffle;
            if (_loc4)
            {
                var _loc5 = _loc4.id;
                this.cancelCurrentTrick(_loc5);
                var _loc3 = new Object();
                _loc3.playerId = playerId;
                _loc3.puffleId = _loc5;
                _shell.updateListeners(_shell.PUFFLE_PERFORMING_TRICK, _loc3);
                this.playAnimation(playerId, _loc4, _loc2.__get__name());
                _interface.showEmoteBalloon(playerId, _loc2.__get__playerEmoteFrame(), 50);
            } // end if
        } // end if
    } // End of the function
    function cancelCurrentTrick(puffleId)
    {
        if (_loaderMap[puffleId] != undefined && _loaderMap[puffleId] != null)
        {
            _loaderMap[puffleId].cancelAndRemoveAnimation();
        } // end if
    } // End of the function
    function playAnimation(playerId, puffleModel, trickName)
    {
        var _loc3 = puffleModel.id;
        var _loc2 = _shell.getPath(com.clubpenguin.engine.puffles.puffletricks.PuffleTricks.ASSET_PATH);
        _loc2 = puffleModel.getFormattedAssetURL(_loc2);
        _loc2 = com.clubpenguin.util.StringUtils.replaceString("%trick%", trickName, _loc2);
        _loaderMap[_loc3] = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerId, puffleModel.id, _shell, _engine, true);
        _loaderMap[_loc3].addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
        _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
        if (_shell.isMyPlayer(playerId))
        {
            _engine.stopMouse();
            _engine.disableMouseMovement();
        } // end if
        var _loc4 = _shell.getPlayerObjectById(playerId);
        var _loc7 = _engine.puffleAvatarController.getPuffleAvatar(puffleModel.id);
        var _loc8 = com.clubpenguin.util.FrameAnimationUtils.getDirectionFrameByPoint(new flash.geom.Point(_loc4.x, _loc4.y), new flash.geom.Point(_loc7._x + PUFFLE_OFFSET_X, _loc7._y + 30));
        _engine.updatePlayerFrame(playerId, _loc8, true);
        _loaderMap[_loc3].playPuffleAnimation(_loc2);
    } // End of the function
    function onAnimationComplete(event)
    {
        _loaderMap[event.puffleID].removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
        _shell.removeListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
        _loaderMap[event.puffleID] = null;
        if (_shell.isMyPlayer(event.playerID))
        {
            _engine.startMouse();
            _engine.enableMouseMovement();
        } // end if
    } // End of the function
    static var ASSET_PATH = "w.puffle.sprite.tricks";
    var PUFFLE_OFFSET_X = 30;
} // End of Class
