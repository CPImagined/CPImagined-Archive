dynamic class com.clubpenguin.puffleavatar.PuffleAvatar
{
    var _puffleCanMove: Boolean = true;
    var splashCount: Number = 0;
    var _puffleOffsetX: Number = 31;
    var _puffleOffsetY: Number = 2;
    var _ENGINE;
    var _SHELL;
    var _assetLoader;
    var _frameUpdateEnabled;
    var _isShowPuffle;
    var _onPlayerFrameUpdateDelegate;
    var _onPlayerStopMoveDelegate;
    var _onRoomDestroyedDelegate;
    var _playerClip;
    var _playerId;
    var _previousFrame;
    var _puffleClip;
    var _puffleEffectManager;
    var _puffleHat;
    var _puffleHatLoaded;
    var _puffleModel;

    function PuffleAvatar(puffleModel, shellMC, engineMC)
    {
        this._SHELL = shellMC;
        this._ENGINE = engineMC;
        this._frameUpdateEnabled = true;
        this._isShowPuffle = true;
        this.addShellListeners();
        this._puffleModel = puffleModel;
        this._puffleEffectManager = new com.clubpenguin.engine.puffles.effects.PuffleEffectManager();
        this._puffleHat = new com.clubpenguin.puffleavatar.PuffleAvatarHat();
    }

    function addShellListeners()
    {
        this._onPlayerFrameUpdateDelegate = com.clubpenguin.util.Delegate.create(this, this.onUpdatePlayerFrame);
        this._onPlayerStopMoveDelegate = com.clubpenguin.util.Delegate.create(this, this.onPlayerStopMove);
        this._onRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, this.onRoomDestroyed);
        this._SHELL.addListener(this._SHELL.PLAYER_FRAME, this._onPlayerFrameUpdateDelegate);
        this._SHELL.addListener(this._SHELL.PLAYER_MOVE_DONE, this._onPlayerStopMoveDelegate);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._onRoomDestroyedDelegate);
    }

    function removeShellListeners()
    {
        this._SHELL.removeListener(this._SHELL.PLAYER_FRAME, this._onPlayerFrameUpdateDelegate);
        this._SHELL.removeListener(this._SHELL.PLAYER_MOVE_DONE, this._onPlayerStopMoveDelegate);
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._onRoomDestroyedDelegate);
    }

    function destroy()
    {
        this.removePuffleClip();
        this.removeShellListeners();
    }

    function hide()
    {
        if (this.puffleAbleToUpdate()) 
        {
            com.clubpenguin.util.Log.debug("Hiding puffle: " + this._puffleModel.name, com.clubpenguin.util.Log.DEFAULT);
            this._isShowPuffle = false;
            this._puffleClip._visible = false;
        }
    }

    function show()
    {
        if (this.puffleAbleToUpdate()) 
        {
            com.clubpenguin.util.Log.debug("Showing puffle: " + this._puffleModel.name, com.clubpenguin.util.Log.DEFAULT);
            this._isShowPuffle = true;
            this._puffleClip._visible = true;
            this.updatePuffleFrame(this._SHELL.getPlayerObjectById(this._playerId).frame);
            this.updatePuffleClipDepth();
        }
    }

    function isPuffleVisible()
    {
        return this._isShowPuffle;
    }

    function displayPuffleStatsWidget(widgetType, puffleItemId)
    {
        this.stopPuffleUpdates();
        this.updatePuffleClipDepth();
        var __reg2 = new Object();
        __reg2.widgetType = widgetType;
        __reg2.puffleId = this._puffleModel.id;
        __reg2.puffleClipPosition = new flash.geom.Point(this._puffleClip._x, this._puffleClip._y);
        __reg2.puffleItemId = puffleItemId;
        com.clubpenguin.util.Log.info("Opening AS3 module Puffle UI Widget: " + widgetType, com.clubpenguin.util.Log.DEFAULT);
        this._SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_UI_WIDGET, __reg2, {modalBackgroundEnabled: false, hideLoadingDialog: true, blockPuffleNotifications: false});
    }

    function stopPuffleUpdates()
    {
        this._puffleCanMove = false;
    }

    function startPuffleUpdates()
    {
        this._puffleCanMove = true;
    }

    function get puffleCanMove()
    {
        return this._puffleCanMove;
    }

    function hideHat()
    {
        if (this.puffleAbleToUpdate()) 
        {
            if (this._puffleModel.hasHat()) 
            {
                this._puffleHat.hide();
            }
        }
    }

    function showHat()
    {
        if (this.puffleAbleToUpdate()) 
        {
            if (this._puffleModel.hasHat() && this._puffleHatLoaded) 
            {
                this._puffleHat.show();
            }
        }
    }

    function loadPuffleAsset(url, player_id)
    {
        this._playerId = player_id;
        this._playerClip = this._ENGINE.getPlayerMovieClip(this._playerId);
        if (this._puffleClip == undefined || this._puffleClip == null) 
        {
            this._puffleClip = this._ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAvatarClip" + this._puffleModel.id, this._playerClip.getDepth() - 1);
            this._puffleClip._xscale = this._playerClip._xscale;
            this._puffleClip._yscale = this._playerClip._yscale;
            this._puffleClip._x = this._playerClip._x;
            this._puffleClip._y = this._playerClip._y;
            this._assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            this._assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, this.onLoadAssetLoaderComplete));
            this._assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, this.onLoadAssetLoaderInit));
            this._assetLoader.loadClip(url, this._puffleClip, "PuffleAvatar.as loadPuffleAsset()");
        }
        this.show();
        this._puffleClip._xscale = this._playerClip._xscale;
        this._puffleClip._yscale = this._playerClip._yscale;
    }

    function update()
    {
        if (this.puffleAbleToUpdate()) 
        {
            if (this._puffleCanMove) 
            {
                this._puffleClip._x = this._playerClip._x;
                this._puffleClip._y = this._playerClip._y;
                if (this.splashCount > 0) 
                {
                    if (!this.puffleInWater()) 
                    {
                        this.splashCount = 0;
                    }
                }
                if (this._puffleModel.hasHat() && this._puffleHatLoaded) 
                {
                    this._puffleHat.update();
                }
                var __reg2 = this._SHELL.getPlayerObjectById(this._playerId).frame;
                if (!this._SHELL.isMyPlayer(this._playerId) && __reg2 != this._previousFrame) 
                {
                    this.updatePuffleFrame(__reg2);
                    this._previousFrame = __reg2;
                }
                this.updatePuffleClipDepth();
            }
        }
    }

    function puffleAbleToUpdate()
    {
        return this._puffleClip != undefined && this._puffleClip != null;
    }

    function updatePuffleClipDepth()
    {
        if (this._puffleClip != undefined && this._puffleClip != null && this._isShowPuffle) 
        {
            this._puffleClip.swapDepths(this._playerClip.getDepth() - 1);
        }
    }

    function onUpdatePlayerFrame(event)
    {
        if (event.player_id == this._playerId && this._frameUpdateEnabled) 
        {
            this.updatePuffleFrame(event.frame);
        }
    }

    function updatePuffleFrame(frameNumber)
    {
        if (this.puffleAbleToUpdate()) 
        {
            if (this._puffleCanMove) 
            {
                this._puffleClip.gotoAndStop(frameNumber);
                if (this._puffleModel.hasHat() && this._puffleHatLoaded) 
                {
                    this._puffleHat.update();
                }
            }
        }
    }

    function updatePuffleWithPenguin()
    {
        this._puffleClip._xscale = this._playerClip._xscale;
        this._puffleClip._yscale = this._playerClip._yscale;
        this._puffleClip._alpha = this._playerClip._alpha;
    }

    function getPuffleFrame()
    {
        if (this.puffleAbleToUpdate()) 
        {
            return this._puffleClip._currentframe;
        }
    }

    function setFrameUpdateEnabled(enable)
    {
        this._frameUpdateEnabled = enable;
    }

    function onPlayerStopMove(event)
    {
        if (event.player_id == this._playerId) 
        {
            this.update();
        }
    }

    function onLoadAssetLoaderComplete(loadEvent)
    {
        loadEvent.target._visible = false;
    }

    function onLoadAssetLoaderInit(loadEvent)
    {
        loadEvent.target._visible = this._isShowPuffle;
        this._frameUpdateEnabled = true;
        if (this._puffleModel.hasHat()) 
        {
            this._puffleHatLoaded = false;
            this._puffleHat.hatLoadCompleteSignal.addOnce(this.onHatLoadComplete, this);
            this._puffleHat.init(this._puffleClip, this._puffleModel);
        }
        var __reg2 = this._puffleModel.id == this._SHELL.getMyPlayerObject().attachedPuffle.id;
        var __reg3 = this._SHELL.isMyIgloo() && this._SHELL.getIsRoomIgloo();
        var __reg5 = this._ENGINE.isRoomMyBackyard();
        if (__reg2) 
        {
            if (__reg3 || __reg5) 
            {
                this._puffleClip.onRelease = com.clubpenguin.util.Delegate.create(this, this.onPuffleAvatarClicked);
            }
            this.drawPuffleRing();
            this.drawPuffleShadow();
        }
        if (this._puffleModel.getPuffleState() > 0) 
        {
            var __reg4 = com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.getPuffleEffectByTypeId(this._puffleModel.getPuffleState());
            this.loadPuffleEffect(__reg4);
        }
        this._SHELL.updateListeners(this._SHELL.PUFFLE_AVATAR_CLIP_LOADED, this._puffleModel.id);
    }

    function onHatLoadComplete()
    {
        this._puffleHatLoaded = true;
    }

    function drawPuffleRing()
    {
        var __reg4 = this._puffleClip.effectBackground_mc.createEmptyMovieClip("ring", this._puffleClip.effectBackground_mc.getNextHighestDepth());
        var __reg2 = 3381759;
        var __reg3 = 2;
        var __reg5 = 24;
        var __reg6 = 16;
        com.clubpenguin.util.DrawUtil.drawRing(__reg4, new flash.geom.Rectangle(this._puffleOffsetX, this._puffleOffsetY, __reg5, __reg6), __reg2, __reg2, __reg3);
    }

    function drawPuffleShadow()
    {
        var __reg2 = this._puffleClip.effectBackground_mc.createEmptyMovieClip("shadow_mc", this._puffleClip.effectBackground_mc.getNextHighestDepth());
        var __reg4 = 4278190080;
        var __reg5 = 11250603;
        var __reg3 = 1;
        var __reg6 = 20;
        var __reg7 = 11;
        __reg2._alpha = 20;
        com.clubpenguin.util.DrawUtil.drawEllipse(__reg2, new flash.geom.Rectangle(this._puffleOffsetX, this._puffleOffsetY, __reg6, __reg7), __reg4, __reg5, __reg3);
    }

    function onPuffleAvatarClicked()
    {
        if (this._ENGINE.getPlayerMovieClip(this._playerId).is_moving) 
        {
            return;
        }
        var __reg2 = new flash.geom.Point(this._puffleClip._x, this._puffleClip._y);
        var __reg3 = true;
        var __reg4 = this._puffleModel.typeID;
        this._ENGINE.puffleUIWidgetController.displayPuffleWidget(this._puffleModel.id, __reg3, __reg2, __reg4, "radialMenuWidget", null);
    }

    function onRoomDestroyed()
    {
        this.removePuffleClip();
    }

    function removePuffleClip()
    {
        if (this.puffleAbleToUpdate()) 
        {
            this._puffleClip.removeMovieClip();
            this._puffleClip = null;
            com.clubpenguin.util.Log.debug("Removing puffle clip " + this._puffleModel.name + " from the room.", com.clubpenguin.util.Log.DEBUGGING);
        }
    }

    function unloadPuffleHat()
    {
        this._puffleClip.hatForeground_mc.unloadMovie();
        this._puffleClip.hatBackground_mc.unloadMovie();
        this._puffleHat.destroy();
    }

    function loadPuffleEffect(effect)
    {
        this._puffleEffectManager.createEffectInstance(effect, this._puffleClip, 1);
    }

    function removePuffleEffect()
    {
        this._puffleEffectManager.removeEffectInstance();
    }

    function getPuffleClipDepth()
    {
        return this._puffleClip.getDepth();
    }

    function getPuffleClip()
    {
        return this._puffleClip;
    }

    function puffleInWater()
    {
        return _global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(this._puffleClip);
    }

    function set _x(value)
    {
        this._puffleClip._x = value;
    }

    function get _x()
    {
        return this._puffleClip._x;
    }

    function set _y(value)
    {
        this._puffleClip._y = value;
    }

    function get _y()
    {
        return this._puffleClip._y;
    }

    function get _currentframe()
    {
        return this._puffleClip._currentframe;
    }

    function set _currentframe(frame)
    {
        this._puffleClip.gotoAndStop(frame);
        if (this._puffleModel.hasHat()) 
        {
            this._puffleHat.update();
        }
    }

    function get id()
    {
        return this._puffleModel.id;
    }

}
