//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.puffleavatar.PuffleAvatarController
    {
        var _SHELL, _ENGINE, _puffleAvatarMap;
        function PuffleAvatarController (shellMC, engineMC) {
            _SHELL = shellMC;
            _ENGINE = engineMC;
            _puffleAvatarMap = new Object();
            _SHELL.addListener(_SHELL.REMOVE_PLAYER, com.clubpenguin.util.Delegate.create(this, onRemovePlayer));
        }
        function attachPuffle(playerObject) {
            if ((playerObject.attachedPuffle != undefined) && (playerObject.attachedPuffle != null)) {
                var _local_2 = playerObject.attachedPuffle;
                var _local_3 = _SHELL.getPath("w.puffle.sprite.walk");
                _local_3 = _local_2.getFormattedAssetURL(_local_3);
                var _local_4;
                if ((_puffleAvatarMap[_local_2.id] == undefined) || (_puffleAvatarMap[_local_2.id] == null)) {
                    _local_4 = new com.clubpenguin.puffleavatar.PuffleAvatar(_local_2, _SHELL, _ENGINE);
                    _puffleAvatarMap[_local_2.id] = _local_4;
                } else {
                    _local_4 = _puffleAvatarMap[_local_2.id];
                }
                _local_4.loadPuffleAsset(_local_3, playerObject.player_id);
            }
        }
        function update() {
            for (var _local_2 in _puffleAvatarMap) {
                _puffleAvatarMap[_local_2].update();
            }
        }
        function detachPuffle(puffleId) {
            destroyPuffleAvatar(puffleId);
        }
        function getPuffleClip(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                return(_puffleAvatarMap[puffleId].getPuffleClip());
            } else {
                return(null);
            }
        }
        function getPuffleAvatar(puffleId) {
            return(_puffleAvatarMap[puffleId]);
        }
        function displayPuffleWidget(puffleId, widgetType, puffleItemId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].displayPuffleStatsWidget(widgetType, puffleItemId);
            }
        }
        function hidePuffle(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].hide();
            }
        }
        function showPuffle(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].show();
            }
        }
        function hideHat(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].hideHat();
            }
        }
        function showHat(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].showHat();
            }
        }
        function loadHat(puffleId, puffleHatVO) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].loadPuffleHat(puffleHatVO);
            }
        }
        function unloadHat(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].unloadPuffleHat();
            }
        }
        function isPuffleVisible(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                return(_puffleAvatarMap[puffleId].isPuffleVisible());
            } else {
                return(false);
            }
        }
        function getPuffleCanMove(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                return(_puffleAvatarMap[puffleId].puffleCanMove);
            } else {
                return(false);
            }
        }
        function updatePuffleFrame(puffleId, frameNumber) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].updatePuffleFrame(frameNumber);
            }
        }
        function getPuffleFrame(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                return(_puffleAvatarMap[puffleId].getPuffleFrame());
            } else {
                return(null);
            }
        }
        function setFrameUpdateEnabled(puffleId, enable) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].setFrameUpdateEnabled(enable);
            }
        }
        function addPuffleEffect(puffleId, effect) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].loadPuffleEffect(effect);
            }
        }
        function onRemovePlayer(playerId) {
            var _local_2 = _SHELL.getPlayerObjectById(playerId);
            if ((_local_2.attachedPuffle != undefined) && (_local_2.attachedPuffle != null)) {
                destroyPuffleAvatar(_local_2.attachedPuffle.id);
            }
        }
        function puffleAvatarExists(puffleId) {
            return((_puffleAvatarMap[puffleId] != undefined) && (_puffleAvatarMap[puffleId] != null));
        }
        function destroyPuffleAvatar(puffleId) {
            if (puffleAvatarExists(puffleId)) {
                _puffleAvatarMap[puffleId].destroy();
                _puffleAvatarMap[puffleId] = null;
            }
        }
    }
