class com.clubpenguin.puffleavatar.PuffleAvatar
{
    var _SHELL, _ENGINE, _frameUpdateEnabled, _isShowPuffle, _puffleModel, _puffleEffectManager, _puffleHat, _onPlayerFrameUpdateDelegate, _onPlayerStopMoveDelegate, _onRoomDestroyedDelegate, _puffleClip, _playerId, _puffleHatLoaded, _playerClip, _assetLoader, _previousFrame, __get___x, __get___y, __get___currentframe, __set___currentframe, __set___x, __set___y, __get__id, __get__puffleCanMove;
    function PuffleAvatar(puffleModel, shellMC, engineMC)
    {
        _SHELL = shellMC;
        _ENGINE = engineMC;
        _frameUpdateEnabled = true;
        _isShowPuffle = true;
        this.addShellListeners();
        _puffleModel = puffleModel;
        _puffleEffectManager = new com.clubpenguin.engine.puffles.effects.PuffleEffectManager();
        _puffleHat = new com.clubpenguin.puffleavatar.PuffleAvatarHat();
    } // End of the function
    function addShellListeners()
    {
        _onPlayerFrameUpdateDelegate = com.clubpenguin.util.Delegate.create(this, onUpdatePlayerFrame);
        _onPlayerStopMoveDelegate = com.clubpenguin.util.Delegate.create(this, onPlayerStopMove);
        _onRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, onRoomDestroyed);
        _SHELL.addListener(_SHELL.PLAYER_FRAME, _onPlayerFrameUpdateDelegate);
        _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _onPlayerStopMoveDelegate);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _onRoomDestroyedDelegate);
    } // End of the function
    function removeShellListeners()
    {
        _SHELL.removeListener(_SHELL.PLAYER_FRAME, _onPlayerFrameUpdateDelegate);
        _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _onPlayerStopMoveDelegate);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _onRoomDestroyedDelegate);
    } // End of the function
    function destroy()
    {
        this.removePuffleClip();
        this.removeShellListeners();
    } // End of the function
    function hide()
    {
        if (this.puffleAbleToUpdate())
        {
            com.clubpenguin.util.Log.debug("Hiding puffle: " + _puffleModel.name, com.clubpenguin.util.Log.DEFAULT);
            _isShowPuffle = false;
            _puffleClip._visible = false;
        } // end if
    } // End of the function
    function show()
    {
        if (this.puffleAbleToUpdate())
        {
            com.clubpenguin.util.Log.debug("Showing puffle: " + _puffleModel.name, com.clubpenguin.util.Log.DEFAULT);
            _isShowPuffle = true;
            _puffleClip._visible = true;
            this.updatePuffleFrame(_SHELL.getPlayerObjectById(_playerId).frame);
            this.updatePuffleClipDepth();
        } // end if
    } // End of the function
    function isPuffleVisible()
    {
        return (_isShowPuffle);
    } // End of the function
    function displayPuffleStatsWidget(widgetType, puffleItemId)
    {
        this.stopPuffleUpdates();
        this.updatePuffleClipDepth();
        var _loc2 = new Object();
        _loc2.widgetType = widgetType;
        _loc2.puffleId = _puffleModel.id;
        _loc2.puffleClipPosition = new flash.geom.Point(_puffleClip._x, _puffleClip._y);
        _loc2.puffleItemId = puffleItemId;
        com.clubpenguin.util.Log.info("Opening AS3 module Puffle UI Widget: " + widgetType, com.clubpenguin.util.Log.DEFAULT);
        _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_UI_WIDGET, _loc2, {modalBackgroundEnabled: false, hideLoadingDialog: true, blockPuffleNotifications: false});
    } // End of the function
    function stopPuffleUpdates()
    {
        _puffleCanMove = false;
    } // End of the function
    function startPuffleUpdates()
    {
        _puffleCanMove = true;
    } // End of the function
    function get puffleCanMove()
    {
        return (_puffleCanMove);
    } // End of the function
    function hideHat()
    {
        if (this.puffleAbleToUpdate())
        {
            if (_puffleModel.hasHat())
            {
                _puffleHat.hide();
            } // end if
        } // end if
    } // End of the function
    function showHat()
    {
        if (this.puffleAbleToUpdate())
        {
            if (_puffleModel.hasHat() && _puffleHatLoaded)
            {
                _puffleHat.show();
            } // end if
        } // end if
    } // End of the function
    function loadPuffleAsset(url, player_id)
    {
        _playerId = player_id;
        _playerClip = _ENGINE.getPlayerMovieClip(_playerId);
        if (_puffleClip == undefined || _puffleClip == null)
        {
            _puffleClip = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAvatarClip" + _puffleModel.id, _playerClip.getDepth() - 1);
            _puffleClip._xscale = _playerClip._xscale;
            _puffleClip._yscale = _playerClip._yscale;
            _puffleClip._x = _playerClip._x;
            _puffleClip._y = _playerClip._y;
            _assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, onLoadAssetLoaderComplete));
            _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadAssetLoaderInit));
            _assetLoader.loadClip(url, _puffleClip, "PuffleAvatar.as loadPuffleAsset()");
        } // end if
        this.show();
        _puffleClip._xscale = _playerClip._xscale;
        _puffleClip._yscale = _playerClip._yscale;
    } // End of the function
    function update()
    {
        if (this.puffleAbleToUpdate())
        {
            if (_puffleCanMove)
            {
                _puffleClip._x = _playerClip._x;
                _puffleClip._y = _playerClip._y;
                if (splashCount > 0)
                {
                    if (!this.puffleInWater())
                    {
                        splashCount = 0;
                    } // end if
                } // end if
                if (_puffleModel.hasHat() && _puffleHatLoaded)
                {
                    _puffleHat.update();
                } // end if
                var _loc2 = _SHELL.getPlayerObjectById(_playerId).frame;
                if (!_SHELL.isMyPlayer(_playerId) && _loc2 != _previousFrame)
                {
                    this.updatePuffleFrame(_loc2);
                    _previousFrame = _loc2;
                } // end if
                this.updatePuffleClipDepth();
            } // end if
        } // end if
    } // End of the function
    function puffleAbleToUpdate()
    {
        return (_puffleClip != undefined && _puffleClip != null);
    } // End of the function
    function updatePuffleClipDepth()
    {
        if (_puffleClip != undefined && _puffleClip != null && _isShowPuffle)
        {
            _puffleClip.swapDepths(_playerClip.getDepth() - 1);
        } // end if
    } // End of the function
    function onUpdatePlayerFrame(event)
    {
        if (event.player_id == _playerId && _frameUpdateEnabled)
        {
            this.updatePuffleFrame(event.frame);
        } // end if
    } // End of the function
    function updatePuffleFrame(frameNumber)
    {
        if (this.puffleAbleToUpdate())
        {
            if (_puffleCanMove)
            {
                _puffleClip.gotoAndStop(frameNumber);
                if (_puffleModel.hasHat() && _puffleHatLoaded)
                {
                    _puffleHat.update();
                } // end if
            } // end if
        } // end if
    } // End of the function
    function updatePuffleWithPenguin()
    {
        _puffleClip._xscale = _playerClip._xscale;
        _puffleClip._yscale = _playerClip._yscale;
        _puffleClip._alpha = _playerClip._alpha;
    } // End of the function
    function getPuffleFrame()
    {
        if (this.puffleAbleToUpdate())
        {
            return (_puffleClip._currentframe);
        } // end if
    } // End of the function
    function setFrameUpdateEnabled(enable)
    {
        _frameUpdateEnabled = enable;
    } // End of the function
    function onPlayerStopMove(event)
    {
        if (event.player_id == _playerId)
        {
            this.update();
        } // end if
    } // End of the function
    function onLoadAssetLoaderComplete(loadEvent)
    {
        loadEvent.target._visible = false;
    } // End of the function
    function onLoadAssetLoaderInit(loadEvent)
    {
        loadEvent.target._visible = _isShowPuffle;
        _frameUpdateEnabled = true;
        if (_puffleModel.hasHat())
        {
            _puffleHatLoaded = false;
            _puffleHat.hatLoadCompleteSignal.addOnce(onHatLoadComplete, this);
            _puffleHat.init(_puffleClip, _puffleModel);
        } // end if
        var _loc2 = _puffleModel.id == _SHELL.getMyPlayerObject().attachedPuffle.id;
        var _loc3 = _SHELL.isMyIgloo() && _SHELL.getIsRoomIgloo();
        var _loc5 = _ENGINE.isRoomMyBackyard();
        if (_loc2)
        {
            if (_loc3 || _loc5)
            {
                _puffleClip.onRelease = com.clubpenguin.util.Delegate.create(this, onPuffleAvatarClicked);
            } // end if
            this.drawPuffleRing();
            this.drawPuffleShadow();
        } // end if
        if (_puffleModel.getPuffleState() > 0)
        {
            var _loc4 = com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.getPuffleEffectByTypeId(_puffleModel.getPuffleState());
            this.loadPuffleEffect(_loc4);
        } // end if
        _SHELL.updateListeners(_SHELL.PUFFLE_AVATAR_CLIP_LOADED, _puffleModel.id);
    } // End of the function
    function onHatLoadComplete()
    {
        _puffleHatLoaded = true;
    } // End of the function
    function drawPuffleRing()
    {
        var _loc4 = _puffleClip.effectBackground_mc.createEmptyMovieClip("ring", _puffleClip.effectBackground_mc.getNextHighestDepth());
        var _loc2 = 3381759;
        var _loc3 = 2;
        var _loc5 = 24;
        var _loc6 = 16;
        com.clubpenguin.util.DrawUtil.drawRing(_loc4, new flash.geom.Rectangle(_puffleOffsetX, _puffleOffsetY, _loc5, _loc6), _loc2, _loc2, _loc3);
    } // End of the function
    function drawPuffleShadow()
    {
        var _loc2 = _puffleClip.effectBackground_mc.createEmptyMovieClip("shadow_mc", _puffleClip.effectBackground_mc.getNextHighestDepth());
        var _loc4 = 4278190080.000000;
        var _loc5 = 11250603;
        var _loc3 = 1;
        var _loc6 = 20;
        var _loc7 = 11;
        _loc2._alpha = 20;
        com.clubpenguin.util.DrawUtil.drawEllipse(_loc2, new flash.geom.Rectangle(_puffleOffsetX, _puffleOffsetY, _loc6, _loc7), _loc4, _loc5, _loc3);
    } // End of the function
    function onPuffleAvatarClicked()
    {
        if (!_ENGINE.getPlayerMovieClip(_playerId).is_moving)
        {
            var _loc2 = new flash.geom.Point(_puffleClip._x, _puffleClip._y);
            var _loc3 = true;
            var _loc4 = _puffleModel.typeID;
            _ENGINE.puffleUIWidgetController.displayPuffleWidget(_puffleModel.id, _loc3, _loc2, _loc4, "radialMenuWidget", null);
        } // end if
    } // End of the function
    function onRoomDestroyed()
    {
        this.removePuffleClip();
    } // End of the function
    function removePuffleClip()
    {
        if (this.puffleAbleToUpdate())
        {
            _puffleClip.removeMovieClip();
            _puffleClip = null;
            com.clubpenguin.util.Log.debug("Removing puffle clip " + _puffleModel.name + " from the room.", com.clubpenguin.util.Log.DEBUGGING);
        } // end if
    } // End of the function
    function unloadPuffleHat()
    {
        _puffleClip.hatForeground_mc.unloadMovie();
        _puffleClip.hatBackground_mc.unloadMovie();
        _puffleHat.destroy();
    } // End of the function
    function loadPuffleEffect(effect)
    {
        _puffleEffectManager.createEffectInstance(effect, _puffleClip, 1);
    } // End of the function
    function removePuffleEffect()
    {
        _puffleEffectManager.removeEffectInstance();
    } // End of the function
    function getPuffleClipDepth()
    {
        return (_puffleClip.getDepth());
    } // End of the function
    function getPuffleClip()
    {
        return (_puffleClip);
    } // End of the function
    function puffleInWater()
    {
        return (_global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(_puffleClip));
    } // End of the function
    function set _x(value)
    {
        _puffleClip._x = value;
        //return (this._x());
        null;
    } // End of the function
    function get _x()
    {
        return (_puffleClip._x);
    } // End of the function
    function set _y(value)
    {
        _puffleClip._y = value;
        //return (this._y());
        null;
    } // End of the function
    function get _y()
    {
        return (_puffleClip._y);
    } // End of the function
    function get _currentframe()
    {
        return (_puffleClip._currentframe);
    } // End of the function
    function set _currentframe(frame)
    {
        _puffleClip.gotoAndStop(frame);
        if (_puffleModel.hasHat())
        {
            _puffleHat.update();
        } // end if
        //return (this._currentframe());
        null;
    } // End of the function
    function get id()
    {
        return (_puffleModel.id);
    } // End of the function
    var _puffleCanMove = true;
    var splashCount = 0;
    var _puffleOffsetX = 31;
    var _puffleOffsetY = 2;
} // End of Class
