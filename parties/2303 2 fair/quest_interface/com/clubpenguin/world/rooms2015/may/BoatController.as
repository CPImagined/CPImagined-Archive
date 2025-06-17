//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.BoatController
    {
        static var _SHELL, _ENGINE, handleRoomDestroyedDelegate, _joinRoomDelegate, _playerTeleportDelegate, _triggerArea, _updatePlayerFrame, _playersOnBoats;
        function BoatController () {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] CREATING BOAT CONTROLLER ");
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
        }
        static function addListeners() {
            cleanPlayersOnBoatList();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            handleRoomDestroyedDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.may.BoatController, handleRoomDestroyed);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.may.BoatController, handleJoinRoom);
            _ENGINE.penguinTransformComplete.add(_joinRoomDelegate);
            _playerTeleportDelegate = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.may.BoatController, handlePlayerTeleport);
            _SHELL.addListener(_SHELL.PLAYER_TELEPORT, _playerTeleportDelegate);
            _SHELL.addListener(_SHELL.PLAYER_MOVE_DONE, _playerTeleportDelegate);
        }
        static function handlePlayerTeleport(playerObj) {
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_triggerArea.hitTest(_local_2._x, _local_2._y, true)) {
                addPenguinToBoat(playerObj);
            } else if (isPlayerOnBoat(playerObj.player_id)) {
                removePenguinFromBoat(playerObj.player_id);
            }
        }
        static function createWaterTrigger(watertriggerArea, roomTriggerWatcher) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] createWaterTrigger -watertriggerArea : " + watertriggerArea);
            _triggerArea = watertriggerArea;
            var _local_1 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_triggerArea);
            _local_1.playersAdded.add(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.may.BoatController, penguinsOnWaterTrigger));
            _local_1.playersRemoved.add(com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.may.BoatController, penguinsRemovedFromWaterTrigger));
            roomTriggerWatcher.addTrigger(_local_1);
        }
        static function get updatePlayerFrame() {
            if (_updatePlayerFrame == undefined) {
                _updatePlayerFrame = new org.osflash.signals.Signal(Number);
            }
            return(_updatePlayerFrame);
        }
        static function dispatchUpdatePlayerFrame(player_id) {
            _updatePlayerFrame.dispatch(player_id);
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] dispatchUpdatePlayerFrame player_id " + player_id);
        }
        static function get playersOnBoats() {
            return(_playersOnBoats);
        }
        static function cleanPlayersOnBoatList() {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] cleanPlayersOnBoatList");
            _playersOnBoats = new Object();
        }
        static function penguinsOnWaterTrigger(playerList) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] penguinsOnWaterTrigger playerList " + playerList);
            var _local_1 = 0;
            while (_local_1 < playerList.length) {
                if (!isPlayerOnBoat(playerList[_local_1])) {
                    addPenguinToBoat(_SHELL.getPlayerObjectById(playerList[_local_1]));
                }
                _local_1++;
            }
        }
        static function penguinsRemovedFromWaterTrigger(playerList) {
            var _local_1 = 0;
            while (_local_1 < playerList.length) {
                removePenguinFromBoat(playerList[_local_1]);
                _local_1++;
            }
        }
        static function addPenguinToBoat(playerObj) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] addPenguinToBoat player " + playerObj.player_id);
            var _local_4 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_2 = _local_4[(BOAT_FRONT_SWF_NAME + "_") + playerObj.player_id];
            var _local_3 = _local_4[(BOAT_BACK_SWF_NAME + "_") + playerObj.player_id];
            if ((_local_2 != undefined) && (_local_3 != undefined)) {
                showBoat(_local_2, _local_3, playerObj.player_id);
                return(undefined);
            }
            if (_local_2 == undefined) {
                loadBoatPart(BOAT_FRONT_SWF_NAME, playerObj);
            }
            if (_local_3 == undefined) {
                loadBoatPart(BOAT_BACK_SWF_NAME, playerObj);
            }
        }
        static function showBoat(boatFrontMC, boatBackMC, player_id) {
            boatFrontMC._visible = true;
            boatBackMC._visible = true;
            playersOnBoats[player_id] = true;
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        static function loadBoatPart(boatPart, playerObj) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] loadBoatPart boatPart " + boatPart);
            var _local_4;
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            var _local_3 = _local_2.art_mc.getDepth();
            var _local_7 = _local_2.head_mc.getDepth();
            _local_3 = ((boatPart == BOAT_FRONT_SWF_NAME) ? (Number(_local_7 + 1)) : (Number(_local_3 - 1)));
            _local_4 = _local_2.createEmptyMovieClip((boatPart + "_") + playerObj.player_id, _local_3);
            var _local_8 = ((_SHELL.getGlobalContentPath() + "rooms/effects/") + boatPart) + ".swf";
            var _local_5 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_5.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2015.may.BoatController, handleExternalAssetLoaded, playerObj.player_id, _local_4));
            _local_5.loadClip(_local_8, _local_4, "AvatarManager loadAnimations() " + boatPart);
        }
        static function handleExternalAssetLoaded(event, player_id, boatMC) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] handleExternalAssetLoaded player_id " + player_id);
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] handleExternalAssetLoaded boatMC " + boatMC);
            playersOnBoats[player_id] = true;
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("Is player herbert? " + _SHELL.isPlayerASpecificMascot(player_id, "Herbert"));
            if (_SHELL.isPlayerASpecificMascot(player_id, "Herbert")) {
                boatMC._xscale = (boatMC._yscale = HERBERT_BOAT_SCALE);
            } else {
                boatMC._xscale = (boatMC._yscale = BOAT_SCALE);
            }
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        static function removePenguinFromBoat(player_id) {
            playersOnBoats[player_id] = false;
            var _local_2 = _ENGINE.getPlayerMovieClip(player_id);
            _local_2[(BOAT_FRONT_SWF_NAME + "_") + player_id]._visible = false;
            _local_2[(BOAT_BACK_SWF_NAME + "_") + player_id]._visible = false;
            _ENGINE.updatePlayer(_SHELL.getPlayerObjectById(player_id));
        }
        static function isPlayerOnBoat(player_id) {
            return(((_playersOnBoats[player_id] == undefined) ? false : (playersOnBoats[player_id])));
        }
        static function handleJoinRoom(playerObj) {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] handleJoinRoom - _triggerArea : " + _triggerArea);
            if (_triggerArea == undefined) {
                return(undefined);
            }
            var _local_1 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            if (_triggerArea.hitTest(_local_1._x, _local_1._y, true)) {
                addPenguinToBoat(playerObj);
            }
        }
        static function handleRoomDestroyed() {
            com.clubpenguin.world.rooms2015.may.party.MayParty.pebug("[BoatController] handleRoomDestroyed ");
            cleanPlayersOnBoatList();
            _ENGINE.penguinTransformComplete.remove(_joinRoomDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_TELEPORT, _playerTeleportDelegate);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, handleRoomDestroyedDelegate);
            _SHELL.removeListener(_SHELL.PLAYER_MOVE_DONE, _playerTeleportDelegate);
            _triggerArea = undefined;
        }
        static var BOAT_FRONT_SWF_NAME = "boatfront";
        static var BOAT_BACK_SWF_NAME = "boatback";
        static var BOAT_SCALE = 75;
        static var HERBERT_BOAT_SCALE = 160;
    }
