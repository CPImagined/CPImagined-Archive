
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleManager
    {
        var _puffleHatCollection, pufflesForPlayerLoaded, _myPuffles, _roomPuffles;
        function PuffleManager (shell, airtower) {
            _shell = shell;
            _airtower = airtower;
            _puffleHatCollection = _shell.getPuffleHatCollection();
        }
        function init() {
            pufflesForPlayerLoaded = new org.osflash.signals.Signal();
            attachListeners();
        }
        function attachListeners() {
            _airtower.addListener(_airtower.GET_MY_PLAYER_PUFFLES, handleGetMyPuffles, this);
            _airtower.addListener(_airtower.GET_PLAYER_PUFFLES, handleGetPufflesByPlayerId, this);
            _airtower.addListener(_airtower.ADD_A_PUFFLE, handleAddPuffleResponse, this);
            _airtower.addListener(_airtower.ADOPT_PUFFLE, onAdoptPuffleResponse, this);
            _airtower.addListener(_airtower.PUFFLE_FRAME, handleSendPuffleFrame, this);
            _airtower.addListener(_airtower.PUFFLE_MOVE, handleSendPuffleMove, this);
            _airtower.addListener(_airtower.INTERACTION_PLAY, handleSendPlayInteraction, this);
            _airtower.addListener(_airtower.INTERACTION_REST, handleSendRestInteraction, this);
            _airtower.addListener(_airtower.INTERACTION_FEED, handleSendFeedInteraction, this);
            _airtower.addListener(_airtower.PUFFLE_INIT_INTERACTION_PLAY, handleSendPuffleInitPlayInteraction, this);
            _airtower.addListener(_airtower.PUFFLE_INIT_INTERACTION_REST, handleSendPuffleInitRestInteraction, this);
            _airtower.addListener(_airtower.PLAY_PUFFLE, handleSendPufflePlay, this);
            _airtower.addListener(_airtower.ADOPT_PUFFLE, handleAdoptPuffle, this);
            _airtower.addListener(_airtower.REST_PUFFLE, handleSendPuffleRest, this);
            _airtower.addListener(_airtower.BATH_PUFFLE, handleSendPuffleBath, this);
			_airtower.addListener(_airtower.FEED_PUFFLE, handleSendPuffleFood, this);
			
            _airtower.addListener(_airtower.BUBBLE_GUM_PUFFLE, handlePuffleBubbleGum, this);
            _airtower.addListener(_airtower.WALK_PUFFLE, handleSendPuffleWalk, this);
			_airtower.addListener(_airtower.TREAT_PUFFLE, handleSendPuffleTreat, this);
            _airtower.addListener(_airtower.SWAP_PUFFLE, handleSendChangePuffleRoom, this);
            _airtower.addListener(_airtower.WALK_SWAP_PUFFLE, handleWalkSwapPuffle, this);
            _airtower.addListener(_airtower.RETURN_PUFFLE, handleReturnPuffle, this);
            _airtower.addListener(_airtower.PUFFLE_VISITOR_HAT_UPDATE, handleVisitorHatUpdate, this);
            _shell.addListener(_shell.FURNITURE_INTERACTIVE_TYPES, handleFurnitureInteractiveTypes, this);
            _shell.addListener(_shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, cleanUpRoomPuffles));
        }
        function handleFurnitureInteractiveTypes(rules) {
            for (var _local2 in rules) {
            }
            var _local4 = rules.playInteractionAllowed || false;
            var _local3 = rules.restInteractionAllowed || false;
            var _local5 = rules.feedInteractionAllowed || false;
            com.clubpenguin.shell.RoomPuffle.setAllowPlayInteraction(_local4);
            com.clubpenguin.shell.RoomPuffle.setAllowRestInteraction(_local3);
            com.clubpenguin.shell.RoomPuffle.setAllowFeedInteraction(_local5);
        }
        function getMyPuffles() {
            if (!_pufflesFetched) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.GET_MY_PLAYER_PUFFLES, [], "str", _shell.getCurrentServerRoomId());
                return(undefined);
            }
            _shell.$e("[SHELL] PuffleManager.getMyPuffles() -> Puffles already fetched! cant get them again");
        }
        function handleGetMyPuffles(obj) {
            var _local6 = obj.shift();
            var _local4;
            var _local2;
            var _local5;
            _myPuffles = new Array();
            for (_local5 in obj) {
                _local4 = obj[_local5].split("|");
                _local2 = makePuffleModelFromCrumb(_local4);
                if (isNaN(_local2.id)) {
                } else {
                    _myPuffles.push(_local2);
                }
            }
            _pufflesFetched = true;
        }
        function getPufflesByPlayerId(player_id, roomType) {
            if (!isNaN(player_id)) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.GET_PLAYER_PUFFLES, [player_id, roomType], "str", _shell.getCurrentServerRoomId());
            } else {
                _shell.$e("[SHELL] PuffleManager.getPufflesByPlayerId() -> player id is not a valid number! player_id: " + player_id);
            }
            return(pufflesForPlayerLoaded);
        }
        function handleGetPufflesByPlayerId(obj) {
            for (var _local6 in obj) {
            }
            var _local11 = obj.shift();
            var _local10 = obj.shift();
            if (_roomPuffles != undefined) {
                cleanUpRoomPuffles();
            }
            _roomPuffles = new Array();
            if (_local10 > 0) {
                var _local2;
                var _local4;
                var _local5;
                for (_local5 in obj) {
                    _local2 = obj[_local5].split("|");
                    if (_local2[0].length > 0) {
                        _local4 = makeRoomPuffleFromCrumb(_local2);
                        _roomPuffles.push(_local4);
                    }
                }
                if (_pendingWalkPuffleID != undefined) {
                    sendStartPuffleWalk(_pendingWalkPuffleID, _pendingAdoptionAnimation);
                }
                var _local8 = getPlayerLocationString();
                var _local7 = _shell.getMyPlayerObject();
                var _local9 = false;
                if ((_local8 == "igloo") && (_local7.getIglooPuffleCount)) {
                    _local9 = true;
                    _local7.getIglooPuffleCount = false;
                }
                if ((_local8 == "backyard") && (_local7.getBackyardPuffleCount)) {
                    _local9 = true;
                    _local7.getBackyardPuffleCount = false;
                }
            }
            pufflesForPlayerLoaded.dispatch();
        }
        function handleAddPuffleResponse(obj) {
            var _local3;
            var _local8;
            var _local6;
            var _local2;
            _local3 = obj;
            _local8 = _local3[0];
            _local6 = _local3[1].split("|");
            _local2 = makeRoomPuffleFromCrumb(_local6);
            if ((_roomPuffles == null) || (_roomPuffles == undefined)) {
                _roomPuffles = new Array();
            }
            _roomPuffles.push(_local2);
            var _local7 = _local2.model.id;
            var _local11 = _local2.model.typeID;
            var _local15 = _local2.model.subTypeID;
            var _local10 = _local2.model.__get__isWalking();
            var _local5 = _local2.model.__get__x();
            var _local4 = _local2.model.__get__y();
            var _local13 = _local2.model.stats;
            var _local9 = _local2.model["color"];
            _shell.updateListeners(_shell.ADD_PUFFLE, {id:_local7, typeID:_local11, subTypeID:_local15, isWalking:_local10, x:_local5, y:_local4, stats:_local13, color:_local9});
        }
        function isMyPuffleById(id) {
            var _local3 = _myPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_myPuffles[_local2].id == id) {
                    return(true);
                }
                _local2++;
            }
            return(false);
        }
        function getRoomPuffleById(id) {
            var _local3 = _roomPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_roomPuffles[_local2].model.id == id) {
                    return(_roomPuffles[_local2]);
                }
                _local2++;
            }
            return(undefined);
        }
        function removeRoomPuffleById(id) {
            var _local3 = _roomPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_roomPuffles[_local2].model.id == id) {
                    clearRoomPuffle(_roomPuffles[_local2]);
                    _roomPuffles.splice(_local2, 1);
                    break;
                }
                _local2++;
            }
        }
        function getMyPuffleById(id) {
            var _local3 = _myPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_myPuffles[_local2].id == id) {
                    return(_myPuffles[_local2]);
                }
                _local2++;
            }
            return(undefined);
        }
        function removeMyPuffleById(id) {
            var _local3 = _myPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_myPuffles[_local2].id == id) {
                    _myPuffles.splice(_local2, 1);
                    break;
                }
                _local2++;
            }
        }
        function getPuffleModelIdBySubtype(id) {
            var _local3 = _myPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_myPuffles[_local2].subTypeID == id) {
                    return(_myPuffles[_local2].id);
                }
                _local2++;
            }
            return(undefined);
        }
        function initForRoom() {
            var _local3 = _roomPuffles;
            var _local14 = _local3.length;
            var _local2 = 0;
            while (_local2 < _local14) {
                var _local6 = _local3[_local2].model.id;
                var _local9 = _local3[_local2].model.typeID;
                var _local13 = _local3[_local2].model.subTypeID;
                var _local8 = _local3[_local2].model.isWalking;
                var _local5 = _local3[_local2].model.x;
                var _local4 = _local3[_local2].model.y;
                var _local11 = _local3[_local2].model.stats;
                var _local7 = _local3[_local2].model["color"];
                _shell.updateListeners(_shell.ADD_PUFFLE, {id:_local6, typeID:_local9, subTypeID:_local13, isWalking:_local8, x:_local5, y:_local4, stats:_local11, color:_local7});
                _local2++;
            }
        }
        function checkOpenPuffleCare() {
            if (_puffleIDToShowInCare != null) {
                var _local2 = new Object();
                _local2.puffle_id = _puffleIDToShowInCare;
                setPuffleIDToShowInCare(null);
                _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_CARE, _local2, {blockPuffleNotifications:true});
            }
        }
        function getPuffleIDToShowInCare() {
            return(_puffleIDToShowInCare);
        }
        function startRoomPuffleBrains() {
            var _local3 = _roomPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                _roomPuffles[_local2].startBrain();
                _local2++;
            }
        }
        function stopRoomPuffleBrains() {
            var _local3 = _roomPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                _roomPuffles[_local2].stopBrain();
                _local2++;
            }
        }
		function sendAdoptPuffle(typeID, puffleName) {
			if (myPuffleCount >= MAX_PUFFLES) {
				_shell.updateListeners(_shell.ADOPT_PUFFLE, {success:false});
				return(false);
			}
			if (isNaN(typeID)) {
				_shell.$e("[SHELL] PuffleManager.sendAdoptPuffle() -> Puffle type was not a real number! puffle_type: " + typeID);
				return(false);
			}
			if (!_shell.isValidString(puffleName)) {
				_shell.$e("[SHELL] PuffleManager.sendAdoptPuffle() -> Puffle name was not a real string! puffleName: " + puffleName);
				return(false);
			}
			_airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.ADOPT_PUFFLE, [typeID, puffleName], "str", _shell.getCurrentServerRoomId());
		}
        function handlePuffleRequestFrame(event) {
            var _local2 = event.id;
            var _local3 = event.frame;
            if (isNaN(_local2)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Puffle id is not a real number: " + _local2);
                return(undefined);
            }
            if (isNaN(_local3)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Frame is undefined!: " + _local3);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.PUFFLE_FRAME, [_local2, _local3], "str", _shell.getCurrentServerRoomId());
        }
        function handleSendPuffleFrame(event) {
            var _local6 = event[0];
            var _local2 = Number(event[1]);
            var _local3 = Number(event[2]);
            if (isNaN(_local2)) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle ID is not a real number: " + _local2);
                return(undefined);
            }
            if (isNaN(_local3)) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle frame is not a real number. puffle_frame: " + _local3);
                return(undefined);
            }
            var _local5 = getRoomPuffleById(_local2);
            _local5.model.__set__frame(_local3);
        }
        function handlePuffleRequestMove(puffle) {
            _shell.updateListeners(_shell.REQUEST_PUFFLE_MOVE, {id:puffle.model.id});
        }
        function sendPuffleMove(id, xpos, ypos) {
            if (_shell.getPlayersInRoomCount() > 1) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.PUFFLE_MOVE, [id, xpos, ypos], "str", _shell.getCurrentServerRoomId());
            } else {
                var _local2 = getRoomPuffleById(id);
                _local2.moveTo(xpos, ypos);
            }
        }
        function handleSendPuffleMove(arr) {
            var _local8 = arr[0];
            var _local2 = arr[1].split("|");
            var _local4 = Number(_local2[0]);
            var _local6 = Number(_local2[1]);
            var _local5 = Number(_local2[2]);
            var _local3 = getRoomPuffleById(_local4);
            if (_local3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleMove() -> Puffle was undefined! id: " + _local4);
                return(undefined);
            }
            _local3.moveTo(_local6, _local5);
        }
        function sendSwapPuffle(puffleID) {
            var _local3;
            if (_global.getCurrentEngine().isInAnIgloo()) {
                _local3 = _shell.BACKYARD_PATH;
            } else if (_global.getCurrentEngine().isRoomMyBackyard()) {
                _local3 = _shell.IGLOO_PATH;
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.SWAP_PUFFLE, [puffleID, _local3], "str", _shell.getCurrentServerRoomId());
        }
        function sendStartPuffleWalk(puffleID, showAdoptionAnimation) {
            var _local2 = getRoomPuffleById(puffleID);
            var _local5 = _local2.isWalkable();
            _pendingAdoptionAnimation = showAdoptionAnimation;
            if (_local2 != undefined) {
                _pendingWalkPuffleID = undefined;
                _shell.getMyPlayerObject().justAdoptedAPuffle = showAdoptionAnimation;
                _local2.requestStartWalk(showAdoptionAnimation);
            } else if (_pendingWalkPuffleID != puffleID) {
            }
        }
        function sendStartPuffleWalkOutsideIgloo(id) {
            var _local3 = getMyPuffleById(id);
            var _local2 = makeRoomPuffleFromPuffleModel(_local3);
            handlePuffleRequestStartWalk(_local2);
        }
        function makeRoomPuffleFromPuffleModel(puffleModel) {
            var _local2 = new com.clubpenguin.shell.RoomPuffleModel();
            _local2.id = puffleModel.id;
            _local2.typeID = puffleModel.typeID;
            _local2.subTypeID = puffleModel.subTypeID;
            _local2.name = puffleModel.name;
            _local2.hat = puffleModel.hat;
            _local2.stats = puffleModel.stats;
            _local2["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(puffleModel.typeID);
            var _local4 = new com.clubpenguin.shell.RoomPuffle(_shell, _local2);
            _local4.__set__isMine(true);
            if (_roomPuffles == undefined) {
                _roomPuffles = new Array();
            }
            _roomPuffles.push(_local4);
            return(_local4);
        }
        function onAdoptPuffleResponse(response) {
            var _local2;
            var _local3;
            var _local4;
            _local2 = response[2].split("|");
            _local3 = makePuffleModelFromCrumb(_local2);
            _myPuffles.push(_local3);
            _local4 = makeRoomPuffleFromCrumb(_local2);
            _local4.__set__isWalking(false);
            if ((_roomPuffles == undefined) || (_roomPuffles == null)) {
                _roomPuffles = new Array();
            }
            _roomPuffles.push(_local4);
            _pendingWalkPuffleID = _local3.id;
			_shell.updateListeners(_shell.ADOPT_PUFFLE, {success:true});
        }
        function handlePuffleRequestStartWalk(roomPuffle) {
            if (isNaN(roomPuffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle Id is not a real number. id: " + roomPuffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(roomPuffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle was not found in the room! id: " + roomPuffle.model.id);
                return(undefined);
            }
            if (inIglooOrBackyard()) {
                var _local3 = _shell.getMyPlayerObject();
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                    _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_SWAP_PUFFLE, [roomPuffle.model.id], "str", _shell.getCurrentServerRoomId());
                } else {
                    _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [roomPuffle.model.id, START_WALK], "str", _shell.getCurrentServerRoomId());
                }
            } else {
                stopAllPufflesWalking();
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [roomPuffle.model.id, START_WALK], "str", _shell.getCurrentServerRoomId());
            }
        }
        function inIglooOrBackyard() {
            var _local3 = _shell.getIsRoomIgloo();
            var _local4 = _global.getCurrentEngine().isRoomMyBackyard();
            return(_local3 || (_local4));
        }
        function handleWalkSwapPuffle(event) {
            var _local2 = parsePuffleEventForWalking(event);
            var _local3 = new Object();
            _local3.playerObject = _local2.playerObject;
            _local3.puffleId = _local2.playerObject.attachedPuffle.id;
            _local3.isWalking = false;
            _local3.puffleHatVO = _local2.playerObject.attachedPuffle.hat;
            updateRoomPuffle(_local2);
            updateRoomPuffle(_local3);
            detachPuffle(_local2);
            attachPuffle(_local2);
        }
        function handlePuffleRequestStopWalk(puffle) {
            if (isNaN(puffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStopWalk() -> No puffles were found that were being walked! id: " + puffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(puffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStopWalk() -> Puffle was not found in the room! id: " + puffle.model.id);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [puffle.model.id, STOP_WALK], "str", _shell.getCurrentServerRoomId());
        }
        function handleSendPuffleWalk(event) {
            var _local2 = parsePuffleEventForWalking(event);
            clearGoldenState(_local2.playerObject);
            updateRoomPuffle(_local2);
            if (_local2.isWalking) {
                attachPuffle(_local2);
            } else {
                detachPuffle(_local2);
            }
        }
        function parsePuffleEventForWalking(event) {
            var _local2 = new Object();
            _local2.playerId = Number(event[1]);
            _local2.puffleId = Number(event[2]);
            _local2.puffleTypeId = Number(event[3]);
            _local2.puffleSubTypeId = Number(event[4]);
            _local2.isWalking = Boolean(Number(event[5]));
            _local2.careItemID = Number(event[6]);
            _local2.playerObject = _shell.getPlayerObjectById(_local2.playerId);
            _local2.puffleHatVO = _puffleHatCollection.getPuffleHatVO(_local2.careItemID);
            return(_local2);
        }
        function updateRoomPuffle(puffleData) {
            var _local3 = getRoomPuffleById(puffleData.puffleId);
            if ((_local3 != undefined) && (_local3 != null)) {
                _local3.__set__isWalking(puffleData.isWalking);
                _local3.model.hat = puffleData.puffleHatVO;
            } else if ((_global.getCurrentEngine().isRoomMyBackyard() || (_shell.isMyIgloo())) && (_shell.isMyPlayer(puffleData.playerObject.player_id))) {
                var _local5 = makeRoomPuffleFromPuffleModel(puffleData.playerObject.attachedPuffle);
                addRoomPuffleListeners(_local5);
                _shell.updateListeners(_shell.ADD_PUFFLE, {roomPuffleModel:_local5.model});
            }
        }
        function attachPuffle(puffleData) {
            var _local6;
            var _local4 = puffleData.playerObject;
            if (_shell.isMyPlayer(puffleData.playerId)) {
                _currentWalkingId = puffleData.puffleId;
                _local6 = getMyPuffleById(puffleData.puffleId);
                displayPuffleTricksDialogue(_local4);
                loadPuffleTreasureInfographic(_local4);
            } else {
                var _local10 = puffleData.puffleId;
                var _local16 = puffleData.puffleTypeId;
                var _local17 = puffleData.puffleSubTypeId;
                var _local7 = null;
                var _local15 = null;
                var _local11 = null;
                var _local14 = null;
                var _local13 = null;
                var _local9 = null;
                var _local12 = puffleData.careItemID;
                var _local3 = new Array();
                _local3.push(_local10);
                _local3.push(_local16);
                _local3.push(_local17);
                _local3.push(_local7);
                _local3.push(_local15);
                _local3.push(_local11);
                _local3.push(_local14);
                _local3.push(_local13);
                _local3.push(_local9);
                _local3.push(_local12);
                _local6 = makePuffleModelFromCrumb(_local3);
            }
            _local4.attachedPuffle = _local6;
            _global.getCurrentEngine().puffleAvatarController.attachPuffle(_local4);
            _shell.updateListeners(_shell.UPDATE_PLAYER, _local4);
            if (_shell.isMyPlayer(puffleData.playerId)) {
                if (_local4.justAdoptedAPuffle) {
                    _local4.justAdoptedAPuffle = false;
                    var _local8 = new com.clubpenguin.engine.puffles.animations.AdoptionAnimation(_shell, _global.getCurrentEngine());
                    _local8.playAnimation(_local4.player_id);
                }
                _shell.saveMyWalkingPuffleSavedObject();
            }
        }
        function loadPuffleTreasureInfographic(playerObject) {
            if (inIglooOrBackyard()) {
                if (!playerObject.hasSeenPuffleTreasureInfographic) {
                    playerObject.hasSeenPuffleTreasureInfographic = true;
                    _shell.sendAS3LoadPuffleTreasureInfographic();
                }
            }
        }
        function displayPuffleTricksDialogue(playerObject) {
            if (inIglooOrBackyard()) {
                if (playerObject.hasWalkedPuffleFirstTime && (!playerObject.hasWalkedPuffleSecondTime)) {
                    playerObject.hasWalkedPuffleSecondTime = true;
                    _global.getCurrentInterface().showContent(_PHPromptPath);
                }
                if (!playerObject.hasWalkedPuffleFirstTime) {
                    playerObject.hasWalkedPuffleFirstTime = true;
                }
            }
        }
        function detachPuffle(puffleData) {
            if (_shell.isMyPlayer(puffleData.playerId)) {
                _currentWalkingId = undefined;
                var _local4 = new Object();
                _local4.message = puffleData.playerObject.attachedPuffle["color"];
                _local4['interface'] = getPlayerLocationString();
                _shell.clearMyWalkingPuffleSavedObject();
            }
            _global.getCurrentEngine().puffleAvatarController.detachPuffle(puffleData.playerObject.attachedPuffle.id);
            puffleData.playerObject.attachedPuffle = null;
            _shell.updateListeners(_shell.UPDATE_PLAYER, puffleData.playerObject);
        }
        function clearGoldenState(playerObject) {
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(playerObject, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local3 = playerObject.attachedPuffle.id;
                setPuffleState(playerObject.player_id, DEFAULT_STATE, _local3);
            }
        }
        function handleReturnPuffle(responseData) {
            var _local4 = responseData[1];
            var _local2 = _shell.getMyPlayerObject();
            if (_local4 == _local2.attachedPuffle.id) {
                var _local3 = new Object();
                _local3.playerId = _local2.player_id;
                _local3.playerObject = _local2;
                detachPuffle(_local3);
            }
        }
        function getPlayerLocationString() {
            var _local2 = "";
            if (_global.getCurrentEngine().isInAnIgloo()) {
                _local2 = "igloo";
            } else if (_global.getCurrentEngine().isRoomMyBackyard()) {
                _local2 = "backyard";
            }
            return(_local2);
        }
        function stopAllPufflesWalking() {
            if (_currentWalkingId != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [_currentWalkingId, 0], "str", _shell.getCurrentServerRoomId());
            }
            if (_roomPuffles != undefined) {
                var _local3 = _roomPuffles.length;
                var _local2 = 0;
                while (_local2 < _local3) {
                    if (_roomPuffles[_local2].isMine) {
                        _roomPuffles[_local2].requestStopWalk();
                    }
                    _local2++;
                }
            }
        }
        function handleSendChangePuffleRoom(event) {
            var _local3 = Number(event[1]);
            var _local4 = String(event[2]);
            switch (_local4) {
                case _shell.IGLOO_PATH : 
                    if (!_global.getCurrentEngine().isInAnIgloo()) {
                        _shell.updateListeners(_shell.SWAP_PUFFLE, {id:_local3});
                        removeRoomPuffleById(_local3);
                    }
                    break;
                case _shell.BACKYARD_PATH : 
                    if (!_global.getCurrentEngine().isRoomMyBackyard()) {
                        _shell.updateListeners(_shell.SWAP_PUFFLE, {id:_local3});
                        removeRoomPuffleById(_local3);
                    }
                    break;
                default : 
                    break;
            }
        }
        function playPufflePlayAnim(id, playTypeID) {
            var _local2 = getRoomPuffleById(id);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.PuffleManager -> playPufflePlayAnim() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local2.play(playTypeID);
        }
        function playPuffleGumAnim(id) {
            var _local2 = getRoomPuffleById(id);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.PuffleManager -> playPufflePlayAnim() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local2.treat(com.clubpenguin.shell.RoomPuffle.TREAT_GUM);
        }
        function handlePuffleRequestPlay(puffle) {
            if (isNaN(puffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.sendPufflePlay() -> Puffle Id is not a real number. id: " + puffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(puffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.sendPufflePlay() -> Puffle was not found in the room! id: " + puffle.model.id);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.PLAY_PUFFLE, [puffle.model.id], "str", _shell.getCurrentServerRoomId());
        }
        function handleSendPufflePlay(event) {
            var _local7 = event[0];
            var _local5 = event[1].split("|");
            var _local6 = event[2];
            var _local3 = _local5[0];
            var _local2 = getRoomPuffleById(_local3);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.PuffleManager -> handleSendPufflePlay() -> Puffle was not found in the room! id: " + _local3);
                return(undefined);
            }
			var newStats = new com.clubpenguin.shell.PuffleStatsVO(Number(_local2[1]), Number(_local2[2]), Number(_local2[3]), Number(_local2[4]));
			_local3.model.stats = newStats;
            _local2.play(_local6);
        }
        function handleAdoptPuffle(event) {
            var _local2 = Number(event[1]);
            _shell.setMyPlayerTotalCoins(_local2);
        }
        function requestPuffleRest(puffleID) {
            var _local2 = getRoomPuffleById(puffleID);
            _local2.requestRest();
        }
        function handlePuffleRequestRest(puffle) {
            if (isNaN(puffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.sendPuffleRest() -> Puffle Id is not a real number. id: " + puffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(puffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.sendPuffleRest() -> Puffle was not found in the room! id: " + puffle.model.id);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.REST_PUFFLE, [puffle.model.id], "str", _shell.getCurrentServerRoomId());
        }
        function handleSendPuffleRest(event) {
            var _local6 = event[0];
            var _local4 = event[2].split("|");
            var _local3 = _local4[0];
            var _local2 = getRoomPuffleById(_local3);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleRest() -> Puffle was not found in the room! id: " + _local3);
                return(undefined);
            }
            _local2.rest();
        }
        function handlePuffleRequestBath(puffle) {
            if (isNaN(puffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.sendPuffleBath() -> Puffle Id is not a real number. id: " + puffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(puffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.sendPuffleBath() -> Puffle was not found in the room! id: " + puffle.model.id);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.BATH_PUFFLE, [puffle.model.id], "str", _shell.getCurrentServerRoomId());
        }
        function handleSendPuffleBath(event) {
            var _local7 = event[0];
            var _local6 = Number(event[1]);
            var _local5 = event[2].split("|");
            var _local8 = Number(event[3]);
            var _local3 = _local5[0];
            var _local2 = getRoomPuffleById(_local3);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleBath() -> Puffle was not found in the room! id: " + _local3);
                return(undefined);
            }
            _local2.bath();
            if (_shell.isMyIgloo()) {
                _shell.setMyPlayerTotalCoins(_local6);
            }
        }
        function handlePuffleRequestFeed(puffle) {
            if (isNaN(puffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.sendPuffleFood() -> Puffle Id is not a real number. id: " + puffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(puffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.sendPuffleFood() -> Puffle was not found in the room! id: " + puffle.model.id);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.FEED_PUFFLE, [puffle.model.id], "str", _shell.getCurrentServerRoomId());
        }
        function handlePuffleBubbleGum(event) {
            var _local2 = Number(event[1]);
            var _local3 = getRoomPuffleById(_local2);
            playPuffleGumAnim(_local2);
        }
        function hatAdded(puffleID, careItemID) {
            var _local4 = _puffleHatCollection.getPuffleHatVO(careItemID);
            var _local3 = getMyPuffleById(puffleID);
            _local3.hat = null;
            _local3.hat = com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO();
            _local3.hat = _local4;
            var _local6 = _global.getCurrentEngine();
            var _local7 = _local6.puffleManager;
            _local7.hatAdded(puffleID);
            if (puffleID == _shell.getMyPlayerObject().attachedPuffle.id) {
                _local6.puffleAvatarController.loadHat(puffleID, _local4);
            }
        }
        function hatRemoved(puffleID, careItemID) {
            var _local4 = getMyPuffleById(puffleID);
            _local4.hat = null;
            _local4.hat = com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO();
            var _local5 = _global.getCurrentEngine();
            var _local6 = _local5.puffleManager;
            _local6.hatRemoved(puffleID);
            if (puffleID == _shell.getMyPlayerObject().attachedPuffle.id) {
                _local5.puffleAvatarController.unloadHat(puffleID);
            }
        }
        function handleVisitorHatUpdate(event) {
            var _local3 = Number(event[1]);
            var _local5 = Number(event[2]);
            var _local7 = getRoomPuffleById(_local3);
            var _local8 = _local7.model;
            var _local6 = _puffleHatCollection.getPuffleHatVO(_local5);
            _local8.hat = _local6;
            var _local9 = _global.getCurrentEngine();
            var _local4 = _local9.puffleManager;
            if (_local5 == com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO().id) {
                _local4.hatRemoved(_local3);
            } else {
                _local4.visitorHatAdded(_local3);
            }
        }
        function handlePuffleRequestInteraction(event) {
            var _local4;
            switch (event.interactionType) {
                case com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY : 
                    _local4 = _shell.INTERACTIVE_PLAY;
                    break;
                case com.clubpenguin.shell.RoomPuffle.INTERACTION_REST : 
                    _local4 = _shell.INTERACTIVE_REST;
                    break;
                case com.clubpenguin.shell.RoomPuffle.INTERACTION_FEED : 
                    _local4 = _shell.INTERACTIVE_FEED;
                    break;
            }
            _shell.updateListeners(_shell.REQUEST_PUFFLE_INTERACTION, {id:event.id, interactionType:_local4});
        }
        function sendPuffleInteraction(success, puffleID, interactionType, xpos, ypos) {
            if (success) {
                var _local3 = getRoomPuffleById(puffleID);
                if (_local3 == undefined) {
                    return(undefined);
                }
                var _local4;
                if (_local3.__get__selfInteract()) {
                    if (_local3.__get__isWalking()) {
                        return(undefined);
                    }
                    if (interactionType == _shell.INTERACTIVE_PLAY) {
                        _local4 = _airtower.PUFFLE_INIT_INTERACTION_PLAY;
                    } else if (interactionType == _shell.INTERACTIVE_REST) {
                        _local4 = _airtower.PUFFLE_INIT_INTERACTION_REST;
                    } else {
                        _shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect self initiated interaction type! interactionType: " + interactionType);
                        return(undefined);
                    }
                } else if (interactionType == _shell.INTERACTIVE_PLAY) {
                    _local4 = _airtower.INTERACTION_PLAY;
                } else if (interactionType == _shell.INTERACTIVE_REST) {
                    _local4 = _airtower.INTERACTION_REST;
                } else if (interactionType == _shell.INTERACTIVE_FEED) {
                    _local4 = _airtower.INTERACTION_FEED;
                } else {
                    _shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect interaction type! interactionType: " + interactionType);
                    return(undefined);
                }
                if (_local4 == undefined) {
                    return(undefined);
                }
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _local4, [puffleID, xpos, ypos], "str", _shell.getCurrentServerRoomId());
            } else {
                var _local3 = getRoomPuffleById(puffleID);
                if (_local3 == undefined) {
                    return(undefined);
                }
                if (_local3.__get__selfInteract()) {
                    _local3.cancelSelfInteraction();
                    return(undefined);
                }
                if (interactionType == _shell.INTERACTIVE_PLAY) {
                    _local3.forceNormalPlay();
                } else if (interactionType == _shell.INTERACTIVE_REST) {
                    _local3.forceNormalRest();
                } else if (interactionType == _shell.INTERACTIVE_FEED) {
                    _local3.forceNormalFeed();
                }
            }
        }
		        function handleSendPuffleFood(event) {
            var _local10 = event[0];
            var _local6 = Number(event[1]);
            var _local2 = event[2].split("|");
            var _local11 = event[3];
            var _local3 = _local2[0];
            var _local4 = getRoomPuffleById(_local3);
            if (_local4 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleFood() -> Puffle was not found in the room! id: " + _local3);
                return(undefined);
            }
            _local4.feed();
			var newStats = new com.clubpenguin.shell.PuffleStatsVO(Number(_local2[1]), Number(_local2[2]), Number(_local2[3]), Number(_local2[4]));
			_local3.model.stats = newStats;
            if (_shell.isMyIgloo()) {
                _shell.setMyPlayerTotalCoins(_local6);
            }
        }
		
        function handleSendPuffleInitPlayInteraction(event) {
            var _local2 = event[1].split("|");
            var _local7 = Number(_local2[0]);
            var _local5 = Number(_local2[1]);
            var _local4 = Number(_local2[2]);
            var _local3 = getRoomPuffleById(_local7);
            if (_local3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInitPlayInteraction() -> Puffle was not found in the room! id: " + _local7);
                return(undefined);
            }
            var _local6 = false;
            _local3.startInteraction(_local6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local7, interactionType:_shell.INTERACTIVE_PLAY, x:_local5, y:_local4});
        }
        function handleSendPuffleInitRestInteraction(event) {
            var _local2 = event[1].split("|");
            var _local7 = Number(_local2[0]);
            var _local5 = Number(_local2[1]);
            var _local4 = Number(_local2[2]);
            var _local3 = getRoomPuffleById(_local7);
            if (_local3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInitRestInteraction() -> Puffle was not found in the room! id: " + _local7);
                return(undefined);
            }
            var _local6 = false;
            _local3.startInteraction(_local6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local7, interactionType:_shell.INTERACTIVE_REST, x:_local5, y:_local4});
        }
        function handleSendPlayInteraction(event) {
            var _local12 = event[0];
            var _local2 = event[1].split("|");
            var _local7 = Number(_local2[0]);
            var _local5 = Number(_local2[5]);
            var _local4 = Number(_local2[6]);
            var _local3 = getRoomPuffleById(_local7);
            if (_local3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _local7);
                return(undefined);
            }
            var _local6 = true;
            _local3.startInteraction(_local6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local7, interactionType:_shell.INTERACTIVE_PLAY, x:_local5, y:_local4});
        }
        function handleSendRestInteraction(event) {
            var _local12 = event[0];
            var _local2 = event[1].split("|");
            var _local7 = Number(_local2[0]);
            var _local5 = Number(_local2[5]);
            var _local4 = Number(_local2[6]);
            var _local3 = getRoomPuffleById(_local7);
            if (_local3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _local7);
                return(undefined);
            }
            var _local6 = true;
            _local3.startInteraction(_local6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local7, interactionType:_shell.INTERACTIVE_REST, x:_local5, y:_local4});
        }
        function handleSendFeedInteraction(event) {
            var _local13 = event[0];
            var _local7 = Number(event[1]);
            var _local2 = event[2].split("|");
            var _local9 = Number(_local2[0]);
            var _local6 = Number(_local2[3]);
            var _local5 = Number(_local2[4]);
            var _local3 = getRoomPuffleById(_local9);
            if (_shell.isMyIgloo()) {
                _shell.setMyPlayerTotalCoins(_local7);
            }
            if (_local3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _local9);
                return(undefined);
            }
            var _local8 = true;
            _local3.startInteraction(_local8);
			
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local9, interactionType:_shell.INTERACTIVE_FEED, x:_local6, y:_local5});
        }
        function setPuffleInteractionCompleteById(id) {
            var _local2 = getRoomPuffleById(id);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.setPuffleInteractionCompleteById() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local2.stopInteraction();
        }
        function disablePuffleInteractionByID(id) {
            var _local2 = getRoomPuffleById(id);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.disablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local2.__set__interactionEnabled(false);
        }
        function enablePuffleInteractionByID(id) {
            var _local2 = getRoomPuffleById(id);
            if (_local2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.enablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local2.__set__interactionEnabled(true);
        }
        function makePuffleModelFromCrumb(arr) {
            var _local2 = -1;
            _local2++;
            var _local16 = Number(arr[_local2]);
            _local2++;
            var _local10 = Number(arr[_local2]);
            _local2++;
            var _local19 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (Number(arr[_local2])) : null);
            _local2++;
            var _local13 = arr[_local2];
            _local2++;
            var _local11 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (new Date(Number(arr[_local2]) * 1000)) : null);
            _local2++;
            var _local6 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (Number(arr[_local2])) : null);
            _local2++;
            var _local8 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (Number(arr[_local2])) : null);
            _local2++;
            var _local7 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (Number(arr[_local2])) : null);
            _local2++;
            var _local5 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (Number(arr[_local2])) : null);
            _local2++;
            var _local17 = Number(arr[_local2]);
            var _local14 = _puffleHatCollection.getPuffleHatVO(_local17);
            var _local12 = null;
            _local2++;
            var _local15 = (((arr[_local2] != undefined) && (arr[_local2] != null)) ? (Number(arr[_local2])) : (DEFAULT_STATE));
            var _local9 = null;
            if (_local11 != null) {
                var _local18 = new Date();
                _local9 = Math.floor(((((_local18.getTime() - _local11.getTime()) / 1000) / 60) / 60) / 24);
            }
            if ((((_local6 != null) && (_local8 != null)) && (_local7 != null)) && (_local5 != null)) {
                _local12 = new com.clubpenguin.shell.PuffleStatsVO(_local6, _local8, _local7, _local5);
            }
            var _local4 = new com.clubpenguin.shell.PuffleModel();
            _local4.id = _local16;
            _local4.typeID = _local10;
            _local4.subTypeID = _local19;
            _local4.name = _local13;
            _local4.hat = _local14;
            _local4.stats = _local12;
            _local4.ageInDays = _local9;
            _local4["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(_local10);
            _local4.updatePuffleState(_local15);
            return(_local4);
        }
        function makeRoomPuffleFromCrumb(arr) {
            var _local3 = 0;
            var _local6 = Number(arr[_local3++]);
            var _local7 = Number(arr[_local3++]);
            var _local18 = Number(arr[_local3++]);
            var _local8 = arr[_local3++];
            var _local20 = Number(arr[_local3++]);
            var _local11 = Number(arr[_local3++]);
            var _local17 = Number(arr[_local3++]);
            var _local15 = Number(arr[_local3++]);
            var _local10 = Number(arr[_local3++]);
            var _local16 = Number(arr[_local3++]);
            var _local13 = Number(arr[_local3++]);
            var _local12 = Number(arr[_local3++]);
            var _local14 = Boolean(Number(arr[_local3++]));
            var _local9 = _puffleHatCollection.getPuffleHatVO(_local16);
            var _local19 = new com.clubpenguin.shell.PuffleStatsVO(_local11, _local17, _local15, _local10);
            var _local2 = new com.clubpenguin.shell.RoomPuffleModel();
            _local2.id = _local6;
            _local2.typeID = _local7;
            _local2.subTypeID = _local18;
            _local2.name = _local8;
            _local2.__set__x(_local13);
            _local2.__set__y(_local12);
            _local2.__set__isWalking(_local14);
            _local2.hat = _local9;
            _local2.stats = _local19;
            _local2["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(_local7);
            var _local5 = new com.clubpenguin.shell.RoomPuffle(_shell, _local2);
            _local5.__set__isMine(isMyPuffleById(_local6));
            if (((_local2.typeID == com.clubpenguin.shell.PuffleType.RAINBOW.getTypeId()) || (_local2.typeID == com.clubpenguin.shell.PuffleType.GOLD.getTypeId())) || (_local2.isWildPuffle())) {
                _local5.__set__interactionEnabled(false);
            }
            addRoomPuffleListeners(_local5);
            return(_local5);
        }
        function addRoomPuffleListeners(roomPuffle) {
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, handlePuffleRequestMove, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, handlePuffleRequestFrame, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY, handlePuffleRequestPlay, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED, handlePuffleRequestFeed, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH, handlePuffleRequestBath, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_REST, handlePuffleRequestRest, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK, handlePuffleRequestStartWalk, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK, handlePuffleRequestStopWalk, this);
            roomPuffle.addEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION, handlePuffleRequestInteraction, this);
        }
        function getIndexInRoomById(id) {
            var _local3 = _roomPuffles.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_roomPuffles[_local2].model.id == id) {
                    return(_local2);
                }
                _local2++;
            }
            return(-1);
        }
        function clearRoomPuffle(roomPuffle) {
            var _local3 = roomPuffle.model.id;
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_MOVE, handlePuffleRequestMove, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FRAME, handlePuffleRequestFrame, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_PLAY, handlePuffleRequestPlay, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_FEED, handlePuffleRequestFeed, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_BATH, handlePuffleRequestBath, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_REST, handlePuffleRequestRest, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_START_WALK, handlePuffleRequestStartWalk, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_STOP_WALK, handlePuffleRequestStopWalk, this);
            roomPuffle.removeEventListener(com.clubpenguin.shell.RoomPuffle.REQUEST_INTERACTION, handlePuffleRequestInteraction, this);
            roomPuffle.cleanUp();
            _shell.updateListeners(_shell.REMOVE_PUFFLE, {id:_local3});
        }
        function cleanUpRoomPuffles() {
            if (_roomPuffles == undefined) {
                return(undefined);
            }
            var _local2 = 0;
            var _local3 = _roomPuffles.length;
            while (_local2 < _local3) {
                clearRoomPuffle(_roomPuffles[_local2]);
                _local2++;
            }
            _roomPuffles = undefined;
        }
        function get myPuffleCount() {
            if (_myPuffles == undefined) {
                return(0);
            }
            return(_myPuffles.length);
        }
        function get myPuffles() {
            return(_myPuffles.concat());
        }
        function isItemAPuffle(itemID) {
            var _local1 = itemID - PUFFLE_INVENTORY_ID;
            return(((_local1 >= 0) && (_local1 < com.clubpenguin.shell.PuffleType.PUFFLE_COLOR_TYPE_LIST.length)) || (itemID == RAINBOW_PUFFLE_ID));
        }
        function createMoodVO(data) {
            var _local1 = new com.clubpenguin.shell.PuffleMoodVO();
            _local1.superHappy = Boolean(data.superHappy);
            _local1.happy = Boolean(data.happy);
            _local1.sad = Boolean(data.sad);
            _local1.angry = Boolean(data.angry);
            _local1.tired = Boolean(data.tired);
            _local1.hungry = Boolean(data.hungry);
            _local1.dirty = Boolean(data.dirty);
            return(_local1);
        }
        function receivedPuffleMoodFromAS3(data) {
            var _local2 = createMoodVO(data);
            var _local4 = Number(data.puffleID);
            var _local5 = getRoomPuffleById(_local4);
            if (_local5) {
                _local5.model.mood = _local2;
            }
            var _local3 = getMyPuffleById(_local4);
            if (_local3) {
                _local3.mood = _local2;
            }
        }
        function receivedMyPuffleAddedFromAS3(data) {
            var _local4 = Number(data.puffleID);
            if (!getMyPuffleById(_local4)) {
                var _local2 = new com.clubpenguin.shell.PuffleModel();
                _local2.id = _local4;
                _local2.typeID = Number(data.typeID);
                _local2.subTypeID = Number(data.subTypeID);
                _local2.name = data.name;
                _local2.mood = createMoodVO(data);
                _local2["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(_local2.typeID);
                if (_myPuffles == undefined) {
                    _myPuffles = new Array();
                }
                _myPuffles.push(_local2);
            }
        }
        function handleSendPuffleTreat(event) {
            var _local7 = Number(event[1]);
            var _local2 = event[2].split("|");
            var _local6 = event[3];
            var _local3 = _local2[0];
            var _local4 = getRoomPuffleById(_local3);
            if (_local4 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleTreat() -> Puffle was not found in the room! id: " + _local3);
                return(undefined);
            }
            _local4.treat(_local6);
			var newStats = new com.clubpenguin.shell.PuffleStatsVO(Number(_local2[1]), Number(_local2[2]), Number(_local2[3]), Number(_local2[4]));
			_local4.model.stats = newStats;
            if (_shell.isMyIgloo()) {
                _shell.setMyPlayerTotalCoins(_local7);
            }
        }
        function receivedMyPuffleRemovedFromAS3(puffleID) {
            removeRoomPuffleById(puffleID);
            removeMyPuffleById(puffleID);
        }
        function getCurrentWalkingId() {
            return(_currentWalkingId);
        }
        function setCurrentWalkingId(puffleId) {
            _currentWalkingId = puffleId;
        }
        function setPuffleIDToShowInCare(id) {
            _puffleIDToShowInCare = id;
        }
        function setPuffleState(playerId, puffleState, puffleID) {
            if (isNaN(puffleState)) {
                return(undefined);
            }
            var _local3 = _shell.getPlayerObjectById(playerId);
            _local3.attachedPuffle.updatePuffleState(puffleState);
            var _local5 = com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.getPuffleEffectByTypeId(puffleState);
            _global.getCurrentEngine().puffleAvatarController.addPuffleEffect(puffleID, _local5);
        }
        function showPuffleByPlayerId(playerId) {
            var _local3 = _shell.getPlayerObjectById(playerId);
            _global.getCurrentEngine().puffleAvatarController.showPuffle(_local3.attachedPuffle.id);
        }
        static var MAX_PUFFLES = 75;
        static var PUFFLE_INVENTORY_ID = 750;
        static var WHITE_PUFFLE_ID = 757;
        static var RAINBOW_PUFFLE_ID = 5230;
        static var RAINBOW_TYPE = 10;
        static var GOLD_TYPE = 11;
        static var DEFAULT_STATE = 0;
        static var GOLDEN_STATE = 1;
        static var START_WALK = 1;
        static var STOP_WALK = 0;
        var _pufflesFetched = false;
        var _currentWalkingId = undefined;
        var _airtower = null;
        var _shell = null;
        var _pendingWalkPuffleID = undefined;
        var _pendingAdoptionAnimation = false;
        var _puffleIDToShowInCare = null;
        var _PHPromptPath = "w.closeup.ph.puffletricks";
    }
