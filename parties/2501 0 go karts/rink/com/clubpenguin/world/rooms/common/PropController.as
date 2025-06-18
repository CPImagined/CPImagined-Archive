//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.PropController
    {
        var _SHELL, _ENGINE, __get__propScale, handleRoomDestroyedDelegate, _joinRoomDelegate, _playerTeleportDelegate, _triggerArea, _updatePlayerFrame, _playersWithProp;
        function PropController () {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            cleanPlayersWithPropList();
            addListeners();
        }
        function set propScale(scale) {
            PROP_SCALE = scale;
            //return(__get__propScale());
        }
        function addListeners() {
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(this, handleRoomDestroyed);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
            _ENGINE.penguinTransformComplete.add(_joinRoomDelegate);
            _playerTeleportDelegate = com.clubpenguin.util.Delegate.create(this, handlePlayerTeleport);
            _SHELL.addListener(_SHELL.PLAYER_TELEPORT, _playerTeleportDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerTeleportDelegate);
        }
        function handlePlayerTeleport(playerObj) {
            var _local_3 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_triggerArea.hitTest(_local_3._x, _local_3._y, true)) {
                addPenguinToProp(playerObj);
            } else if (isPlayerWithProp(playerObj.player_id)) {
                removePenguinFromProp(playerObj.player_id);
            }
        }
        function createPropTrigger(triggerArea, roomTriggerWatcher) {
            _triggerArea = triggerArea;
            var _local_2 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_triggerArea);
            _local_2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, penguinsOnPropTrigger));
            _local_2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, penguinsRemovedFromPropTrigger));
            roomTriggerWatcher.addTrigger(_local_2);
        }
        function get updatePlayerFrame() {
            if (_updatePlayerFrame == undefined) {
                _updatePlayerFrame = new org.osflash.signals.Signal(Number);
            }
            return(_updatePlayerFrame);
        }
        function dispatchUpdatePlayerFrame(player_id) {
            _updatePlayerFrame.dispatch(player_id);
        }
        function get playersWithProp() {
            return(_playersWithProp);
        }
        function cleanPlayersWithPropList() {
            _playersWithProp = new Object();
        }
        function penguinsOnPropTrigger(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                if (!isPlayerWithProp(playerList[_local_2])) {
                    addPenguinToProp(_SHELL.getPlayerObjectById(playerList[_local_2]));
                }
                _local_2++;
            }
        }
        function penguinsRemovedFromPropTrigger(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                removePenguinFromProp(playerList[_local_2]);
                _local_2++;
            }
        }
        function addPenguinToProp(playerObj) {
            var _local_5 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_3 = _local_5[(PROP_FRONT_SWF_NAME + "_") + playerObj.player_id];
            var _local_4 = _local_5[(PROP_BACK_SWF_NAME + "_") + playerObj.player_id];
            if ((_local_3 != undefined) && (_local_4 != undefined)) {
                showprop(_local_3, _local_4, playerObj.player_id);
                return(undefined);
            }
            if (_local_3 == undefined) {
                loadpropPart(PROP_FRONT_SWF_NAME, playerObj);
            }
            if (_local_4 == undefined) {
                loadpropPart(PROP_BACK_SWF_NAME, playerObj);
            }
        }
        function showprop(propFrontMC, propBackMC, player_id) {
            propFrontMC._visible = true;
            propBackMC._visible = true;
            playersWithProp[player_id] = true;
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        function loadpropPart(propPart, playerObj) {
            var _local_4;
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_3 = _local_2.art_mc.getDepth();
            var _local_8 = _local_2.head_mc.getDepth();
            _local_3 = ((propPart == PROP_FRONT_SWF_NAME) ? (Number(_local_8 + 1)) : (Number(_local_3 - 1)));
            _local_4 = _local_2.createEmptyMovieClip((propPart + "_") + playerObj.player_id, _local_3);
            var _local_9 = ((_SHELL.getGlobalContentPath() + PROP_DIRECTORY_PATH) + propPart) + ".swf";
            var _local_6 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_6.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, handleExternalAssetLoaded, playerObj.player_id, _local_4));
            _local_6.loadClip(_local_9, _local_4, "AvatarManager loadAnimations() " + propPart);
        }
        function handleExternalAssetLoaded(event, player_id, propMC) {
            playersWithProp[player_id] = true;
            propMC._xscale = (propMC._yscale = PROP_SCALE);
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        function removePenguinFromProp(player_id) {
            playersWithProp[player_id] = false;
            var _local_3 = _ENGINE.getPlayerMovieClip(player_id);
            _local_3[(PROP_FRONT_SWF_NAME + "_") + player_id]._visible = false;
            _local_3[(PROP_BACK_SWF_NAME + "_") + player_id]._visible = false;
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        function isPlayerWithProp(player_id) {
            return(((_playersWithProp[player_id] == undefined) ? false : (playersWithProp[player_id])));
        }
        function handleJoinRoom(playerObj) {
            if (_triggerArea == undefined) {
                return(undefined);
            }
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_triggerArea.hitTest(_local_2._x, _local_2._y, true)) {
                trace("PropController - handleJoinRoom player on trigger area");
                addPenguinToProp(playerObj);
            }
        }
        function handleRoomDestroyed() {
            cleanPlayersWithPropList();
            _ENGINE.penguinTransformComplete.remove(_joinRoomDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_TELEPORT, _playerTeleportDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerTeleportDelegate);
            _triggerArea = undefined;
        }
        static var PROP_DIRECTORY_PATH = "avatar/props/";
        static var PROP_FRONT_SWF_NAME = "prop_front";
        static var PROP_BACK_SWF_NAME = "prop_back";
        static var PROP_SCALE = 100;
    }
