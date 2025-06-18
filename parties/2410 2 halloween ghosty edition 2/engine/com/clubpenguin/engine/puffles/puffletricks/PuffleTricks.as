//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.puffletricks.PuffleTricks
    {
        var _shell, _engine, _interface, _loaderMap;
        function PuffleTricks (shell, engine, interfacer) {
            _shell = shell;
            _engine = engine;
            _interface = interfacer;
            _loaderMap = new Object();
        }
        function onPuffleTrickReceivedFromServer(playerId, trickId) {
            var _local_2 = com.clubpenguin.engine.puffles.puffletricks.PuffleTricksEnum.getPuffleTricksById(trickId);
            if (_local_2) {
                var _local_4 = _shell.getPlayerObjectById(playerId).attachedPuffle;
                if (_local_4) {
                    var _local_5 = _local_4.id;
                    cancelCurrentTrick(_local_5);
                    var _local_3 = new Object();
                    _local_3.playerId = playerId;
                    _local_3.puffleId = _local_5;
                    _shell.updateListeners(_shell.PUFFLE_PERFORMING_TRICK, _local_3);
                    playAnimation(playerId, _local_4, _local_2.name);
                    _interface.showEmoteBalloon(playerId, _local_2.playerEmoteFrame, 50);
                }
            }
        }
        function cancelCurrentTrick(puffleId) {
            if ((_loaderMap[puffleId] != undefined) && (_loaderMap[puffleId] != null)) {
                _loaderMap[puffleId].cancelAndRemoveAnimation();
            }
        }
        function playAnimation(playerId, puffleModel, trickName) {
            var _local_3 = puffleModel.id;
            var _local_2 = _shell.getPath(ASSET_PATH);
            _local_2 = puffleModel.getFormattedAssetURL(_local_2);
            _local_2 = com.clubpenguin.util.StringUtils.replaceString("%trick%", trickName, _local_2);
            _loaderMap[_local_3] = new com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader(playerId, puffleModel.id, _shell, _engine, true);
            _loaderMap[_local_3].addEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
            _shell.addListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
            if (_shell.isMyPlayer(playerId)) {
                _engine.stopMouse();
                _engine.disableMouseMovement();
            }
            var _local_4 = _shell.getPlayerObjectById(playerId);
            var _local_7 = _engine.puffleAvatarController.getPuffleAvatar(puffleModel.id);
            var _local_8 = com.clubpenguin.util.FrameAnimationUtils.getDirectionFrameByPoint(new flash.geom.Point(_local_4.x, _local_4.y), new flash.geom.Point(_local_7._x + PUFFLE_OFFSET_X, _local_7._y + 30));
            _engine.updatePlayerFrame(playerId, _local_8, true);
            _loaderMap[_local_3].playPuffleAnimation(_local_2);
        }
        function onAnimationComplete(event) {
            _loaderMap[event.puffleID].removeEventListener(com.clubpenguin.engine.puffles.animations.PuffleAnimationLoader.PUFFLE_ANIMATION_EVENT, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
            _shell.removeListener(_shell.ROOM_DESTROYED, com.clubpenguin.util.Delegate.create(this, onAnimationComplete));
            _loaderMap[event.puffleID] = null;
            if (_shell.isMyPlayer(event.playerID)) {
                _engine.startMouse();
                _engine.enableMouseMovement();
            }
        }
        static var ASSET_PATH = "w.puffle.sprite.tricks";
        var PUFFLE_OFFSET_X = 30;
    }
