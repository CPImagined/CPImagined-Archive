//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.puffleavatar.PuffleAvatar
    {
        var _SHELL, _ENGINE, _frameUpdateEnabled, _isShowPuffle, _puffleModel, _puffleEffectManager, _puffleHat, _onPlayerFrameUpdateDelegate, _onPlayerStopMoveDelegate, _onRoomDestroyedDelegate, _puffleClip, _playerId, _puffleHatLoaded, _playerClip, _assetLoader, _previousFrame;
        function PuffleAvatar (_arg_4, _arg_2, _arg_3) {
            _SHELL = _arg_2;
            _ENGINE = _arg_3;
            _frameUpdateEnabled = true;
            _isShowPuffle = true;
            addShellListeners();
            _puffleModel = _arg_4;
            _puffleEffectManager = new com.clubpenguin.engine.puffles.effects.PuffleEffectManager();
            _puffleHat = new com.clubpenguin.puffleavatar.PuffleAvatarHat();
        }
        function addShellListeners() {
            _onPlayerFrameUpdateDelegate = com.clubpenguin.util.Delegate.create(this, onUpdatePlayerFrame);
            _onPlayerStopMoveDelegate = com.clubpenguin.util.Delegate.create(this, onPlayerStopMove);
            _onRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, onRoomDestroyed);
            _SHELL.addListener(_SHELL.PLAYER_FRAME, _onPlayerFrameUpdateDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _onPlayerStopMoveDelegate);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _onRoomDestroyedDelegate);
        }
        function removeShellListeners() {
            _SHELL.removeListener(_SHELL.PLAYER_FRAME, _onPlayerFrameUpdateDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _onPlayerStopMoveDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _onRoomDestroyedDelegate);
        }
        function destroy() {
            removePuffleClip();
            removeShellListeners();
        }
        function hide() {
            if (puffleAbleToUpdate()) {
                com.clubpenguin.util.Log.debug("Hiding puffle: " + _puffleModel.name, com.clubpenguin.util.Log.DEFAULT);
                _isShowPuffle = false;
                _puffleClip._visible = false;
            }
        }
        function show() {
            if (puffleAbleToUpdate()) {
                com.clubpenguin.util.Log.debug("Showing puffle: " + _puffleModel.name, com.clubpenguin.util.Log.DEFAULT);
                _isShowPuffle = true;
                _puffleClip._visible = true;
                updatePuffleFrame(_SHELL.getPlayerObjectById(_playerId).frame);
                updatePuffleClipDepth();
            }
        }
        function isPuffleVisible() {
            return(_isShowPuffle);
        }
        function displayPuffleStatsWidget(_arg_3, _arg_7) {
            stopPuffleUpdates();
            updatePuffleClipDepth();
            var _local_2 = new Object();
            _local_2.widgetType = _arg_3;
            _local_2.puffleId = _puffleModel.id;
            _local_2.puffleClipPosition = new flash.geom.Point(_puffleClip._x, _puffleClip._y);
            _local_2.puffleItemId = _arg_7;
            com.clubpenguin.util.Log.info("Opening AS3 module Puffle UI Widget: " + _arg_3, com.clubpenguin.util.Log.DEFAULT);
            _SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_UI_WIDGET, _local_2, {modalBackgroundEnabled:false, hideLoadingDialog:true, blockPuffleNotifications:false});
        }
        function stopPuffleUpdates() {
            _puffleCanMove = false;
        }
        function startPuffleUpdates() {
            _puffleCanMove = true;
        }
        function get puffleCanMove() {
            return(_puffleCanMove);
        }
        function hideHat() {
            if (puffleAbleToUpdate()) {
                if (_puffleModel.hasHat()) {
                    _puffleHat.hide();
                }
            }
        }
        function showHat() {
            if (puffleAbleToUpdate()) {
                if (_puffleModel.hasHat() && (_puffleHatLoaded)) {
                    _puffleHat.show();
                }
            }
        }
        function loadPuffleAsset(_arg_3, _arg_2) {
            _playerId = _arg_2;
            _playerClip = _ENGINE.getPlayerMovieClip(_playerId);
            if ((_puffleClip == undefined) || (_puffleClip == null)) {
                _puffleClip = _ENGINE.getRoomMovieClip().createEmptyMovieClip("puffleAvatarClip" + _puffleModel.id, _playerClip.getDepth() - 1);
                _puffleClip._xscale = _playerClip._xscale;
                _puffleClip._yscale = _playerClip._yscale;
                _puffleClip._x = _playerClip._x;
                _puffleClip._y = _playerClip._y;
                _assetLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, onLoadAssetLoaderComplete));
                _assetLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadAssetLoaderInit));
                _assetLoader.loadClip(_arg_3, _puffleClip, "PuffleAvatar.as loadPuffleAsset()");
            }
            this.show();
            _puffleClip._xscale = _playerClip._xscale;
            _puffleClip._yscale = _playerClip._yscale;
        }
        function update() {
            if (puffleAbleToUpdate()) {
                if (_puffleCanMove) {
                    _puffleClip._x = _playerClip._x;
                    _puffleClip._y = _playerClip._y;
                    if (splashCount > 0) {
                        if (!puffleInWater()) {
                            splashCount = 0;
                        }
                    }
                    if (_puffleModel.hasHat() && (_puffleHatLoaded)) {
                        _puffleHat.update();
                    }
                    var _local_2 = _SHELL.getPlayerObjectById(_playerId).frame;
                    if ((!_SHELL.isMyPlayer(_playerId)) && (_local_2 != _previousFrame)) {
                        updatePuffleFrame(_local_2);
                        _previousFrame = _local_2;
                    }
                    updatePuffleClipDepth();
                }
            }
        }
        function puffleAbleToUpdate() {
            return((_puffleClip != undefined) && (_puffleClip != null));
        }
        function updatePuffleClipDepth() {
            if (((_puffleClip != undefined) && (_puffleClip != null)) && (_isShowPuffle)) {
                _puffleClip.swapDepths(_playerClip.getDepth() - 1);
            }
        }
        function onUpdatePlayerFrame(_arg_2) {
            if ((_arg_2.player_id == _playerId) && (_frameUpdateEnabled)) {
                updatePuffleFrame(_arg_2.frame);
            }
        }
        function updatePuffleFrame(_arg_2) {
            if (puffleAbleToUpdate()) {
                if (_puffleCanMove) {
                    _puffleClip.gotoAndStop(_arg_2);
                    if (_puffleModel.hasHat() && (_puffleHatLoaded)) {
                        _puffleHat.update();
                    }
                }
            }
        }
        function updatePuffleWithPenguin() {
            _puffleClip._xscale = _playerClip._xscale;
            _puffleClip._yscale = _playerClip._yscale;
            _puffleClip._alpha = _playerClip._alpha;
        }
        function getPuffleFrame() {
            if (puffleAbleToUpdate()) {
                return(_puffleClip._currentframe);
            }
        }
        function setFrameUpdateEnabled(_arg_2) {
            _frameUpdateEnabled = _arg_2;
        }
        function onPlayerStopMove(_arg_2) {
            if (_arg_2.player_id == _playerId) {
                update();
            }
        }
        function onLoadAssetLoaderComplete(_arg_1) {
            _arg_1.target._visible = false;
        }
        function onLoadAssetLoaderInit(_arg_6) {
            _arg_6.target._visible = _isShowPuffle;
            _frameUpdateEnabled = true;
            if (_puffleModel.hasHat()) {
                _puffleHatLoaded = false;
                _puffleHat.hatLoadCompleteSignal.addOnce(onHatLoadComplete, this);
                _puffleHat.init(_puffleClip, _puffleModel);
            }
            var _local_2 = _puffleModel.id == _SHELL.getMyPlayerObject().attachedPuffle.id;
            var _local_3 = _SHELL.isMyIgloo() && (_SHELL.getIsRoomIgloo());
            var _local_5 = _ENGINE.isRoomMyBackyard();
            if (_local_2) {
                if (_local_3 || (_local_5)) {
                    _puffleClip.onRelease = com.clubpenguin.util.Delegate.create(this, onPuffleAvatarClicked);
                }
                drawPuffleRing();
                drawPuffleShadow();
            }
            if (_puffleModel.getPuffleState() > 0) {
                var _local_4 = com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.getPuffleEffectByTypeId(_puffleModel.getPuffleState());
                loadPuffleEffect(_local_4);
            }
            _SHELL.updateListeners(_SHELL.PUFFLE_AVATAR_CLIP_LOADED, _puffleModel.id);
        }
        function onHatLoadComplete() {
            _puffleHatLoaded = true;
        }
        function drawPuffleRing() {
            var _local_4 = _puffleClip.effectBackground_mc.createEmptyMovieClip("ring", _puffleClip.effectBackground_mc.getNextHighestDepth());
            var _local_2 = 3381759 /* 0x3399FF */;
            var _local_3 = 2;
            var _local_5 = 24;
            var _local_6 = 16;
            com.clubpenguin.util.DrawUtil.drawRing(_local_4, new flash.geom.Rectangle(_puffleOffsetX, _puffleOffsetY, _local_5, _local_6), _local_2, _local_2, _local_3);
        }
        function drawPuffleShadow() {
            var _local_2 = _puffleClip.effectBackground_mc.createEmptyMovieClip("shadow_mc", _puffleClip.effectBackground_mc.getNextHighestDepth());
            var _local_4 = 4278190080;
            var _local_5 = 11250603 /* 0xABABAB */;
            var _local_3 = 1;
            var _local_6 = 20;
            var _local_7 = 11;
            _local_2._alpha = 20;
            com.clubpenguin.util.DrawUtil.drawEllipse(_local_2, new flash.geom.Rectangle(_puffleOffsetX, _puffleOffsetY, _local_6, _local_7), _local_4, _local_5, _local_3);
        }
        function onPuffleAvatarClicked() {
            if (!_ENGINE.getPlayerMovieClip(_playerId).is_moving) {
                var _local_2 = new flash.geom.Point(_puffleClip._x, _puffleClip._y);
                var _local_3 = true;
                var _local_4 = _puffleModel.typeID;
                _ENGINE.puffleUIWidgetController.displayPuffleWidget(_puffleModel.id, _local_3, _local_2, _local_4, "radialMenuWidget", null);
            }
        }
        function onRoomDestroyed() {
            removePuffleClip();
        }
        function removePuffleClip() {
            if (puffleAbleToUpdate()) {
                _puffleClip.removeMovieClip();
                _puffleClip = null;
                com.clubpenguin.util.Log.debug(("Removing puffle clip " + _puffleModel.name) + " from the room.", com.clubpenguin.util.Log.DEBUGGING);
            }
        }
        function unloadPuffleHat() {
            _puffleClip.hatForeground_mc.unloadMovie();
            _puffleClip.hatBackground_mc.unloadMovie();
            _puffleHat.destroy();
        }
        function loadPuffleEffect(_arg_2) {
            _puffleEffectManager.createEffectInstance(_arg_2, _puffleClip, 1);
        }
        function removePuffleEffect() {
            _puffleEffectManager.removeEffectInstance();
        }
        function getPuffleClipDepth() {
            return(_puffleClip.getDepth());
        }
        function getPuffleClip() {
            return(_puffleClip);
        }
        function puffleInWater() {
            return(_global.getCurrentRoom().roomEnvironmentManager.checkHitTestWithEnvironmentMC(_puffleClip));
        }
        function set _x(_arg_2) {
            _puffleClip._x = _arg_2;
            //return(_x);
        }
        function get _x() {
            return(_puffleClip._x);
        }
        function set _y(_arg_2) {
            _puffleClip._y = _arg_2;
            //return(_y);
        }
        function get _y() {
            return(_puffleClip._y);
        }
        function get _currentframe() {
            return(_puffleClip._currentframe);
        }
        function set _currentframe(_arg_2) {
            _puffleClip.gotoAndStop(_arg_2);
            if (_puffleModel.hasHat()) {
                _puffleHat.update();
            }
            //return(_currentframe);
        }
        function get id() {
            return(_puffleModel.id);
        }
        var _puffleCanMove = true;
        var splashCount = 0;
        var _puffleOffsetX = 31;
        var _puffleOffsetY = 2;
    }
