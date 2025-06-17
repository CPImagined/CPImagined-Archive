//Created by Action Script Viewer - https://www.buraks.com/asv
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
            _airtower.addListener(_airtower.BUBBLE_GUM_PUFFLE, handlePuffleBubbleGum, this);
            _airtower.addListener(_airtower.WALK_PUFFLE, handleSendPuffleWalk, this);
            _airtower.addListener(_airtower.SWAP_PUFFLE, handleSendChangePuffleRoom, this);
            _airtower.addListener(_airtower.WALK_SWAP_PUFFLE, handleWalkSwapPuffle, this);
            _airtower.addListener(_airtower.RETURN_PUFFLE, handleReturnPuffle, this);
            _airtower.addListener(_airtower.PUFFLE_VISITOR_HAT_UPDATE, handleVisitorHatUpdate, this);
            _shell.addListener(_shell.FURNITURE_INTERACTIVE_TYPES, handleFurnitureInteractiveTypes, this);
            _shell.addListener(_shell.JOIN_ROOM, com.clubpenguin.util.Delegate.create(this, cleanUpRoomPuffles));
        }
        function handleFurnitureInteractiveTypes(rules) {
            trace(newline);
            trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            trace("handleFurnitureInteractiveTypes");
            for (var _local_2 in rules) {
                trace((("prop: " + _local_2) + "  ") + rules[_local_2]);
            }
            trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            var _local_4 = rules.playInteractionAllowed || false;
            var _local_3 = rules.restInteractionAllowed || false;
            var _local_5 = rules.feedInteractionAllowed || false;
            com.clubpenguin.shell.RoomPuffle.setAllowPlayInteraction(_local_4);
            com.clubpenguin.shell.RoomPuffle.setAllowRestInteraction(_local_3);
            com.clubpenguin.shell.RoomPuffle.setAllowFeedInteraction(_local_5);
        }
        function getMyPuffles() {
            if (!_pufflesFetched) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.GET_MY_PLAYER_PUFFLES, [], "str", _shell.getCurrentServerRoomId());
                return(undefined);
            }
            _shell.$e("[SHELL] PuffleManager.getMyPuffles() -> Puffles already fetched! cant get them again");
        }
        function handleGetMyPuffles(obj) {
            var _local_6 = obj.shift();
            var _local_4;
            var _local_2;
            var _local_5;
            _myPuffles = new Array();
            for (_local_5 in obj) {
                _local_4 = obj[_local_5].split("|");
                _local_2 = makePuffleModelFromCrumb(_local_4);
                if (isNaN(_local_2.id)) {
                    trace(("Puffle id is NaN: " + _local_2.id) + "  not adding it to _myPuffles.");
                } else {
                    _myPuffles.push(_local_2);
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
            trace(newline);
            trace("====================================================================");
            trace("handleGetPufflesByPlayerId");
            for (var _local_6 in obj) {
                trace((("prop: " + _local_6) + "  ") + obj[_local_6]);
            }
            trace("====================================================================");
            var _local_11 = obj.shift();
            var _local_10 = obj.shift();
            if (_roomPuffles != undefined) {
                cleanUpRoomPuffles();
            }
            _roomPuffles = new Array();
            if (_local_10 > 0) {
                var _local_2;
                var _local_4;
                var _local_5;
                trace("obj.length: " + obj.length);
                for (_local_5 in obj) {
                    _local_2 = obj[_local_5].split("|");
                    trace("crumb.length: " + _local_2.length);
                    trace("crumb[0]: " + _local_2[0]);
                    trace("crumb[0].length: " + _local_2[0].length);
                    if (_local_2[0].length > 0) {
                        _local_4 = makeRoomPuffleFromCrumb(_local_2);
                        _roomPuffles.push(_local_4);
                    }
                }
                if (_pendingWalkPuffleID != undefined) {
                    sendStartPuffleWalk(_pendingWalkPuffleID, _pendingAdoptionAnimation);
                }
                var _local_8 = getPlayerLocationString();
                var _local_7 = _shell.getMyPlayerObject();
                var _local_9 = false;
                if ((_local_8 == "igloo") && (_local_7.getIglooPuffleCount)) {
                    _local_9 = true;
                    _local_7.getIglooPuffleCount = false;
                }
                if ((_local_8 == "backyard") && (_local_7.getBackyardPuffleCount)) {
                    _local_9 = true;
                    _local_7.getBackyardPuffleCount = false;
                }
            }
            trace("Puffle loading has complete.");
            pufflesForPlayerLoaded.dispatch();
        }
        function handleAddPuffleResponse(obj) {
            var _local_3;
            var _local_8;
            var _local_6;
            var _local_2;
            _local_3 = obj;
            _local_8 = _local_3[0];
            _local_6 = _local_3[1].split("|");
            _local_2 = makeRoomPuffleFromCrumb(_local_6);
            if ((_roomPuffles == null) || (_roomPuffles == undefined)) {
                _roomPuffles = new Array();
            }
            _roomPuffles.push(_local_2);
            var _local_7 = _local_2.model.id;
            var _local_11 = _local_2.model.typeID;
            var _local_15 = _local_2.model.subTypeID;
            var _local_10 = _local_2.model.isWalking;
            var _local_5 = _local_2.model.x;
            var _local_4 = _local_2.model.y;
            var _local_13 = _local_2.model.stats;
            var _local_9 = _local_2.model["color"];
            _shell.updateListeners(_shell.ADD_PUFFLE, {id:_local_7, typeID:_local_11, subTypeID:_local_15, isWalking:_local_10, x:_local_5, y:_local_4, stats:_local_13, color:_local_9});
        }
        function isMyPuffleById(id) {
            var _local_3 = _myPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_myPuffles[_local_2].id == id) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function getRoomPuffleById(id) {
            var _local_3 = _roomPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_roomPuffles[_local_2].model.id == id) {
                    return(_roomPuffles[_local_2]);
                }
                _local_2++;
            }
            return(undefined);
        }
        function removeRoomPuffleById(id) {
            var _local_3 = _roomPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_roomPuffles[_local_2].model.id == id) {
                    clearRoomPuffle(_roomPuffles[_local_2]);
                    _roomPuffles.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
        }
        function getMyPuffleById(id) {
            var _local_3 = _myPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_myPuffles[_local_2].id == id) {
                    return(_myPuffles[_local_2]);
                }
                _local_2++;
            }
            return(undefined);
        }
        function removeMyPuffleById(id) {
            var _local_3 = _myPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_myPuffles[_local_2].id == id) {
                    _myPuffles.splice(_local_2, 1);
                    break;
                }
                _local_2++;
            }
        }
        function getPuffleModelIdBySubtype(id) {
            var _local_3 = _myPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_myPuffles[_local_2].subTypeID == id) {
                    return(_myPuffles[_local_2].id);
                }
                _local_2++;
            }
            return(undefined);
        }
        function initForRoom() {
            var _local_3 = _roomPuffles;
            var _local_14 = _local_3.length;
            var _local_2 = 0;
            trace("[PuffleManager] handle igloo init complete");
            trace("[PuffleManager] puffle count: " + _local_14);
            while (_local_2 < _local_14) {
                var _local_6 = _local_3[_local_2].model.id;
                var _local_9 = _local_3[_local_2].model.typeID;
                var _local_13 = _local_3[_local_2].model.subTypeID;
                var _local_8 = _local_3[_local_2].model.isWalking;
                var _local_5 = _local_3[_local_2].model.x;
                var _local_4 = _local_3[_local_2].model.y;
                var _local_11 = _local_3[_local_2].model.stats;
                var _local_7 = _local_3[_local_2].model["color"];
                _shell.updateListeners(_shell.ADD_PUFFLE, {id:_local_6, typeID:_local_9, subTypeID:_local_13, isWalking:_local_8, x:_local_5, y:_local_4, stats:_local_11, color:_local_7});
                _local_2++;
            }
        }
        function checkOpenPuffleCare() {
            if (_puffleIDToShowInCare != null) {
                var _local_2 = new Object();
                _local_2.puffle_id = _puffleIDToShowInCare;
                setPuffleIDToShowInCare(null);
                _shell.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PUFFLE_CARE, _local_2, {blockPuffleNotifications:true});
            }
        }
        function getPuffleIDToShowInCare() {
            return(_puffleIDToShowInCare);
        }
        function startRoomPuffleBrains() {
            var _local_3 = _roomPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                _roomPuffles[_local_2].startBrain();
                _local_2++;
            }
        }
        function stopRoomPuffleBrains() {
            var _local_3 = _roomPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                _roomPuffles[_local_2].stopBrain();
                _local_2++;
            }
        }
        function handlePuffleRequestFrame(event) {
            var _local_2 = event.id;
            var _local_3 = event.frame;
            if (isNaN(_local_2)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Puffle id is not a real number: " + _local_2);
                return(undefined);
            }
            if (isNaN(_local_3)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestFrame() -> Frame is undefined!: " + _local_3);
                return(undefined);
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.PUFFLE_FRAME, [_local_2, _local_3], "str", _shell.getCurrentServerRoomId());
        }
        function handleSendPuffleFrame(event) {
            var _local_6 = event[0];
            var _local_2 = Number(event[1]);
            var _local_3 = Number(event[2]);
            if (isNaN(_local_2)) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle ID is not a real number: " + _local_2);
                return(undefined);
            }
            if (isNaN(_local_3)) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleFrame() -> Puffle frame is not a real number. puffle_frame: " + _local_3);
                return(undefined);
            }
            var _local_5 = getRoomPuffleById(_local_2);
            _local_5.model.frame = _local_3;
        }
        function handlePuffleRequestMove(puffle) {
            _shell.updateListeners(_shell.REQUEST_PUFFLE_MOVE, {id:puffle.model.id});
        }
        function sendPuffleMove(id, xpos, ypos) {
            if (_shell.getPlayersInRoomCount() > 1) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.PUFFLE_MOVE, [id, xpos, ypos], "str", _shell.getCurrentServerRoomId());
            } else {
                var _local_2 = getRoomPuffleById(id);
                _local_2.moveTo(xpos, ypos);
            }
        }
        function handleSendPuffleMove(arr) {
            var _local_8 = arr[0];
            var _local_2 = arr[1].split("|");
            var _local_4 = Number(_local_2[0]);
            var _local_6 = Number(_local_2[1]);
            var _local_5 = Number(_local_2[2]);
            var _local_3 = getRoomPuffleById(_local_4);
            if (_local_3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleMove() -> Puffle was undefined! id: " + _local_4);
                return(undefined);
            }
            _local_3.moveTo(_local_6, _local_5);
        }
        function sendSwapPuffle(puffleID) {
            var _local_3;
            if (_global.getCurrentEngine().isInAnIgloo()) {
                _local_3 = _shell.BACKYARD_PATH;
            } else if (_global.getCurrentEngine().isRoomMyBackyard()) {
                _local_3 = _shell.IGLOO_PATH;
            } else {
                trace(("PuffleManager.sendSwapPuffle() unexpected request to swap puffle " + puffleID) + " while not in igloo or backyard");
            }
            _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.SWAP_PUFFLE, [puffleID, _local_3], "str", _shell.getCurrentServerRoomId());
        }
        function sendStartPuffleWalk(puffleID, showAdoptionAnimation) {
            trace(newline);
            trace("################################################");
            trace("sendStartPuffleWalk");
            trace("puffleID: " + puffleID);
            trace("_pendingWalkPuffleID: " + _pendingWalkPuffleID);
            trace("showAdoptionAnimation: " + showAdoptionAnimation);
            var _local_2 = getRoomPuffleById(puffleID);
            var _local_5 = _local_2.isWalkable();
            _pendingAdoptionAnimation = showAdoptionAnimation;
            trace("  puffleWalkable: " + _local_5);
            trace("  puffle: " + _local_2);
            if (_local_2 != undefined) {
                trace("Found a puffle");
                _pendingWalkPuffleID = undefined;
                _shell.getMyPlayerObject().justAdoptedAPuffle = showAdoptionAnimation;
                _local_2.requestStartWalk(showAdoptionAnimation);
            } else if (_pendingWalkPuffleID != puffleID) {
                trace((("ERROR: Attempting to walk a puffle " + puffleID) + " that was not adopted. pending puffle: ") + _pendingWalkPuffleID);
            }
            trace("################################################");
        }
        function sendStartPuffleWalkOutsideIgloo(id) {
            var _local_3 = getMyPuffleById(id);
            var _local_2 = makeRoomPuffleFromPuffleModel(_local_3);
            handlePuffleRequestStartWalk(_local_2);
        }
        function makeRoomPuffleFromPuffleModel(puffleModel) {
            var _local_2 = new com.clubpenguin.shell.RoomPuffleModel();
            _local_2.id = puffleModel.id;
            _local_2.typeID = puffleModel.typeID;
            _local_2.subTypeID = puffleModel.subTypeID;
            _local_2.name = puffleModel.name;
            _local_2.hat = puffleModel.hat;
            _local_2.stats = puffleModel.stats;
            _local_2["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(puffleModel.typeID);
            var _local_4 = new com.clubpenguin.shell.RoomPuffle(_shell, _local_2);
            _local_4.isMine = true;
            if (_roomPuffles == undefined) {
                _roomPuffles = new Array();
            }
            _roomPuffles.push(_local_4);
            return(_local_4);
        }
        function onAdoptPuffleResponse(response) {
            var _local_2;
            var _local_3;
            var _local_4;
            _local_2 = response[2].split("|");
            _local_3 = makePuffleModelFromCrumb(_local_2);
            _myPuffles.push(_local_3);
            _local_4 = makeRoomPuffleFromCrumb(_local_2);
            _local_4.isWalking = false;
            if ((_roomPuffles == undefined) || (_roomPuffles == null)) {
                _roomPuffles = new Array();
            }
            _roomPuffles.push(_local_4);
            _pendingWalkPuffleID = _local_3.id;
        }
        function handlePuffleRequestStartWalk(roomPuffle) {
            trace(newline);
            trace("____________________________________________________________");
            trace("handlePuffleRequestStartWalk");
            trace("roomPuffle.model.id: " + roomPuffle.model.id);
            trace("____________________________________________________________");
            if (isNaN(roomPuffle.model.id)) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle Id is not a real number. id: " + roomPuffle.model.id);
                return(undefined);
            }
            if (getIndexInRoomById(roomPuffle.model.id) == -1) {
                _shell.$e("[SHELL] PuffleManager.handlePuffleRequestStartWalk() -> Puffle was not found in the room! id: " + roomPuffle.model.id);
                return(undefined);
            }
            if (inIglooOrBackyard()) {
                var _local_3 = _shell.getMyPlayerObject();
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
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
            var _local_3 = _shell.getIsRoomIgloo();
            var _local_4 = _global.getCurrentEngine().isRoomMyBackyard();
            return(_local_3 || (_local_4));
        }
        function handleWalkSwapPuffle(event) {
            var _local_2 = parsePuffleEventForWalking(event);
            var _local_3 = new Object();
            _local_3.playerObject = _local_2.playerObject;
            _local_3.puffleId = _local_2.playerObject.attachedPuffle.id;
            _local_3.isWalking = false;
            _local_3.puffleHatVO = _local_2.playerObject.attachedPuffle.hat;
            updateRoomPuffle(_local_2);
            updateRoomPuffle(_local_3);
            detachPuffle(_local_2);
            attachPuffle(_local_2);
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
            trace(newline);
            trace("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
            trace("handleSendPuffleWalk");
            trace("event: " + event);
            var _local_2 = parsePuffleEventForWalking(event);
            clearGoldenState(_local_2.playerObject);
            updateRoomPuffle(_local_2);
            if (_local_2.isWalking) {
                attachPuffle(_local_2);
            } else {
                detachPuffle(_local_2);
            }
            trace("[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
        }
        function parsePuffleEventForWalking(event) {
            var _local_2 = new Object();
            _local_2.playerId = Number(event[1]);
            _local_2.puffleId = Number(event[2]);
            _local_2.puffleTypeId = Number(event[3]);
            _local_2.puffleSubTypeId = Number(event[4]);
            _local_2.isWalking = Boolean(Number(event[5]));
            _local_2.careItemID = Number(event[6]);
            _local_2.playerObject = _shell.getPlayerObjectById(_local_2.playerId);
            _local_2.puffleHatVO = _puffleHatCollection.getPuffleHatVO(_local_2.careItemID);
            return(_local_2);
        }
        function updateRoomPuffle(puffleData) {
            var _local_3 = getRoomPuffleById(puffleData.puffleId);
            if ((_local_3 != undefined) && (_local_3 != null)) {
                _local_3.isWalking = puffleData.isWalking;
                _local_3.model.hat = puffleData.puffleHatVO;
            } else if ((_global.getCurrentEngine().isRoomMyBackyard() || (_shell.isMyIgloo())) && (_shell.isMyPlayer(puffleData.playerObject.player_id))) {
                var _local_5 = makeRoomPuffleFromPuffleModel(puffleData.playerObject.attachedPuffle);
                addRoomPuffleListeners(_local_5);
                _shell.updateListeners(_shell.ADD_PUFFLE, {roomPuffleModel:_local_5.model});
            }
        }
        function attachPuffle(puffleData) {
            var _local_6;
            var _local_4 = puffleData.playerObject;
            if (_shell.isMyPlayer(puffleData.playerId)) {
                _currentWalkingId = puffleData.puffleId;
                _local_6 = getMyPuffleById(puffleData.puffleId);
                displayPuffleTricksDialogue(_local_4);
                loadPuffleTreasureInfographic(_local_4);
            } else {
                var _local_10 = puffleData.puffleId;
                var _local_16 = puffleData.puffleTypeId;
                var _local_17 = puffleData.puffleSubTypeId;
                var _local_7 = null;
                var _local_15 = null;
                var _local_11 = null;
                var _local_14 = null;
                var _local_13 = null;
                var _local_9 = null;
                var _local_12 = puffleData.careItemID;
                var _local_3 = new Array();
                _local_3.push(_local_10);
                _local_3.push(_local_16);
                _local_3.push(_local_17);
                _local_3.push(_local_7);
                _local_3.push(_local_15);
                _local_3.push(_local_11);
                _local_3.push(_local_14);
                _local_3.push(_local_13);
                _local_3.push(_local_9);
                _local_3.push(_local_12);
                _local_6 = makePuffleModelFromCrumb(_local_3);
            }
            _local_4.attachedPuffle = _local_6;
            _global.getCurrentEngine().puffleAvatarController.attachPuffle(_local_4);
            _shell.updateListeners(_shell.UPDATE_PLAYER, _local_4);
            if (_shell.isMyPlayer(puffleData.playerId)) {
                if (_local_4.justAdoptedAPuffle) {
                    _local_4.justAdoptedAPuffle = false;
                    var _local_8 = new com.clubpenguin.engine.puffles.animations.AdoptionAnimation(_shell, _global.getCurrentEngine());
                    _local_8.playAnimation(_local_4.player_id);
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
                var _local_4 = new Object();
                _local_4.message = puffleData.playerObject.attachedPuffle["color"];
                _local_4.interface = getPlayerLocationString();
                _shell.clearMyWalkingPuffleSavedObject();
            }
            _global.getCurrentEngine().puffleAvatarController.detachPuffle(puffleData.playerObject.attachedPuffle.id);
            puffleData.playerObject.attachedPuffle = null;
            _shell.updateListeners(_shell.UPDATE_PLAYER, puffleData.playerObject);
        }
        function clearGoldenState(playerObject) {
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(playerObject, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_3 = playerObject.attachedPuffle.id;
                setPuffleState(playerObject.player_id, DEFAULT_STATE, _local_3);
            }
        }
        function handleReturnPuffle(responseData) {
            var _local_4 = responseData[1];
            var _local_2 = _shell.getMyPlayerObject();
            if (_local_4 == _local_2.attachedPuffle.id) {
                var _local_3 = new Object();
                _local_3.playerId = _local_2.player_id;
                _local_3.playerObject = _local_2;
                detachPuffle(_local_3);
            }
        }
        function getPlayerLocationString() {
            var _local_2 = "";
            if (_global.getCurrentEngine().isInAnIgloo()) {
                _local_2 = "igloo";
            } else if (_global.getCurrentEngine().isRoomMyBackyard()) {
                _local_2 = "backyard";
            }
            return(_local_2);
        }
        function stopAllPufflesWalking() {
            if (_currentWalkingId != undefined) {
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _airtower.WALK_PUFFLE, [_currentWalkingId, 0], "str", _shell.getCurrentServerRoomId());
            }
            if (_roomPuffles != undefined) {
                var _local_3 = _roomPuffles.length;
                var _local_2 = 0;
                while (_local_2 < _local_3) {
                    if (_roomPuffles[_local_2].isMine) {
                        _roomPuffles[_local_2].requestStopWalk();
                    }
                    _local_2++;
                }
            }
        }
        function handleSendChangePuffleRoom(event) {
            trace("handleSendChangePuffleRoom");
            trace("event: " + event);
            var _local_3 = Number(event[1]);
            var _local_4 = String(event[2]);
            switch (_local_4) {
                case _shell.IGLOO_PATH : 
                    if (!_global.getCurrentEngine().isInAnIgloo()) {
                        _shell.updateListeners(_shell.SWAP_PUFFLE, {id:_local_3});
                        removeRoomPuffleById(_local_3);
                    }
                    break;
                case _shell.BACKYARD_PATH : 
                    if (!_global.getCurrentEngine().isRoomMyBackyard()) {
                        _shell.updateListeners(_shell.SWAP_PUFFLE, {id:_local_3});
                        removeRoomPuffleById(_local_3);
                    }
                    break;
                default : 
                    trace("Sending puffle to an unexpected room: " + _local_4);
                    break;
            }
        }
        function playPufflePlayAnim(id, playTypeID) {
            var _local_2 = getRoomPuffleById(id);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.PuffleManager -> playPufflePlayAnim() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local_2.play(playTypeID);
        }
        function playPuffleGumAnim(id) {
            var _local_2 = getRoomPuffleById(id);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.PuffleManager -> playPufflePlayAnim() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local_2.treat(com.clubpenguin.shell.RoomPuffle.TREAT_GUM);
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
            var _local_7 = event[0];
            var _local_5 = event[1].split("|");
            var _local_6 = event[2];
            var _local_3 = _local_5[0];
            var _local_2 = getRoomPuffleById(_local_3);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.PuffleManager -> handleSendPufflePlay() -> Puffle was not found in the room! id: " + _local_3);
                return(undefined);
            }
            _local_2.play(_local_6);
        }
        function handleAdoptPuffle(event) {
            var _local_2 = Number(event[1]);
            _shell.setMyPlayerTotalCoins(_local_2);
        }
        function requestPuffleRest(puffleID) {
            var _local_2 = getRoomPuffleById(puffleID);
            _local_2.requestRest();
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
            var _local_6 = event[0];
            var _local_4 = event[2].split("|");
            var _local_3 = _local_4[0];
            var _local_2 = getRoomPuffleById(_local_3);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleRest() -> Puffle was not found in the room! id: " + _local_3);
                return(undefined);
            }
            _local_2.rest();
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
            var _local_7 = event[0];
            var _local_6 = Number(event[1]);
            var _local_5 = event[2].split("|");
            var _local_8 = Number(event[3]);
            var _local_3 = _local_5[0];
            var _local_2 = getRoomPuffleById(_local_3);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleBath() -> Puffle was not found in the room! id: " + _local_3);
                return(undefined);
            }
            _local_2.bath();
            if (_shell.isMyIgloo()) {
                _shell.setMyPlayerTotalCoins(_local_6);
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
            trace(newline);
            trace("===========================================================");
            trace("handlePuffleBubbleGum");
            trace(event);
            trace("===========================================================");
            var _local_2 = Number(event[1]);
            var _local_3 = getRoomPuffleById(_local_2);
            playPuffleGumAnim(_local_2);
        }
        function hatAdded(puffleID, careItemID) {
            var _local_4 = _puffleHatCollection.getPuffleHatVO(careItemID);
            var _local_3 = getMyPuffleById(puffleID);
            _local_3.hat = null;
            _local_3.hat = com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO();
            _local_3.hat = _local_4;
            var _local_6 = _global.getCurrentEngine();
            var _local_7 = _local_6.puffleManager;
            _local_7.hatAdded(puffleID);
            if (puffleID == _shell.getMyPlayerObject().attachedPuffle.id) {
                _local_6.puffleAvatarController.loadHat(puffleID, _local_4);
            }
        }
        function hatRemoved(puffleID, careItemID) {
            var _local_4 = getMyPuffleById(puffleID);
            _local_4.hat = null;
            _local_4.hat = com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO();
            var _local_5 = _global.getCurrentEngine();
            var _local_6 = _local_5.puffleManager;
            _local_6.hatRemoved(puffleID);
            if (puffleID == _shell.getMyPlayerObject().attachedPuffle.id) {
                _local_5.puffleAvatarController.unloadHat(puffleID);
            }
        }
        function handleVisitorHatUpdate(event) {
            var _local_3 = Number(event[1]);
            var _local_5 = Number(event[2]);
            var _local_7 = getRoomPuffleById(_local_3);
            var _local_8 = _local_7.model;
            var _local_6 = _puffleHatCollection.getPuffleHatVO(_local_5);
            _local_8.hat = _local_6;
            var _local_9 = _global.getCurrentEngine();
            var _local_4 = _local_9.puffleManager;
            if (_local_5 == com.clubpenguin.shell.puffle.PuffleHatVO.getEmptyHatVO().id) {
                _local_4.hatRemoved(_local_3);
            } else {
                _local_4.visitorHatAdded(_local_3);
            }
        }
        function handlePuffleRequestInteraction(event) {
            var _local_4;
            switch (event.interactionType) {
                case com.clubpenguin.shell.RoomPuffle.INTERACTION_PLAY : 
                    _local_4 = _shell.INTERACTIVE_PLAY;
                    break;
                case com.clubpenguin.shell.RoomPuffle.INTERACTION_REST : 
                    _local_4 = _shell.INTERACTIVE_REST;
                    break;
                case com.clubpenguin.shell.RoomPuffle.INTERACTION_FEED : 
                    _local_4 = _shell.INTERACTIVE_FEED;
                    break;
            }
            _shell.updateListeners(_shell.REQUEST_PUFFLE_INTERACTION, {id:event.id, interactionType:_local_4});
        }
        function sendPuffleInteraction(success, puffleID, interactionType, xpos, ypos) {
            if (success) {
                var _local_3 = getRoomPuffleById(puffleID);
                if (_local_3 == undefined) {
                    return(undefined);
                }
                var _local_4;
                if (_local_3.selfInteract) {
                    if (_local_3.isWalking) {
                        trace("Puffle-initiated interaction attempted while being walked!");
                        return(undefined);
                    }
                    if (interactionType == _shell.INTERACTIVE_PLAY) {
                        _local_4 = _airtower.PUFFLE_INIT_INTERACTION_PLAY;
                    } else if (interactionType == _shell.INTERACTIVE_REST) {
                        _local_4 = _airtower.PUFFLE_INIT_INTERACTION_REST;
                    } else {
                        _shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect self initiated interaction type! interactionType: " + interactionType);
                        return(undefined);
                    }
                } else if (interactionType == _shell.INTERACTIVE_PLAY) {
                    _local_4 = _airtower.INTERACTION_PLAY;
                } else if (interactionType == _shell.INTERACTIVE_REST) {
                    _local_4 = _airtower.INTERACTION_REST;
                } else if (interactionType == _shell.INTERACTIVE_FEED) {
                    _local_4 = _airtower.INTERACTION_FEED;
                } else {
                    _shell.$e("[SHELL] sendPuffleInteraction() -> Incorrect interaction type! interactionType: " + interactionType);
                    return(undefined);
                }
                if (_local_4 == undefined) {
                    return(undefined);
                }
                _airtower.send(_airtower.PLAY_EXT, (_airtower.PET_HANDLER + "#") + _local_4, [puffleID, xpos, ypos], "str", _shell.getCurrentServerRoomId());
            } else {
                var _local_3 = getRoomPuffleById(puffleID);
                if (_local_3 == undefined) {
                    return(undefined);
                }
                if (_local_3.selfInteract) {
                    _local_3.cancelSelfInteraction();
                    return(undefined);
                }
                if (interactionType == _shell.INTERACTIVE_PLAY) {
                    _local_3.forceNormalPlay();
                } else if (interactionType == _shell.INTERACTIVE_REST) {
                    _local_3.forceNormalRest();
                } else if (interactionType == _shell.INTERACTIVE_FEED) {
                    _local_3.forceNormalFeed();
                }
            }
        }
        function handleSendPuffleInitPlayInteraction(event) {
            trace(newline);
            trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            trace("handleSendPuffleInitPlayInteraction");
            trace(event);
            trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            var _local_2 = event[1].split("|");
            var _local_7 = Number(_local_2[0]);
            var _local_5 = Number(_local_2[1]);
            var _local_4 = Number(_local_2[2]);
            var _local_3 = getRoomPuffleById(_local_7);
            if (_local_3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInitPlayInteraction() -> Puffle was not found in the room! id: " + _local_7);
                return(undefined);
            }
            var _local_6 = false;
            _local_3.startInteraction(_local_6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local_7, interactionType:_shell.INTERACTIVE_PLAY, x:_local_5, y:_local_4});
        }
        function handleSendPuffleInitRestInteraction(event) {
            trace(newline);
            trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            trace("handleSendPuffleInitRestInteraction");
            trace(event);
            trace("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
            var _local_2 = event[1].split("|");
            var _local_7 = Number(_local_2[0]);
            var _local_5 = Number(_local_2[1]);
            var _local_4 = Number(_local_2[2]);
            var _local_3 = getRoomPuffleById(_local_7);
            if (_local_3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInitRestInteraction() -> Puffle was not found in the room! id: " + _local_7);
                return(undefined);
            }
            var _local_6 = false;
            _local_3.startInteraction(_local_6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local_7, interactionType:_shell.INTERACTIVE_REST, x:_local_5, y:_local_4});
        }
        function handleSendPlayInteraction(event) {
            var _local_12 = event[0];
            var _local_2 = event[1].split("|");
            var _local_7 = Number(_local_2[0]);
            var _local_5 = Number(_local_2[5]);
            var _local_4 = Number(_local_2[6]);
            var _local_3 = getRoomPuffleById(_local_7);
            if (_local_3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _local_7);
                return(undefined);
            }
            var _local_6 = true;
            _local_3.startInteraction(_local_6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local_7, interactionType:_shell.INTERACTIVE_PLAY, x:_local_5, y:_local_4});
        }
        function handleSendRestInteraction(event) {
            var _local_12 = event[0];
            var _local_2 = event[1].split("|");
            var _local_7 = Number(_local_2[0]);
            var _local_5 = Number(_local_2[5]);
            var _local_4 = Number(_local_2[6]);
            var _local_3 = getRoomPuffleById(_local_7);
            if (_local_3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _local_7);
                return(undefined);
            }
            var _local_6 = true;
            _local_3.startInteraction(_local_6);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local_7, interactionType:_shell.INTERACTIVE_REST, x:_local_5, y:_local_4});
        }
        function handleSendFeedInteraction(event) {
            var _local_13 = event[0];
            var _local_7 = Number(event[1]);
            var _local_2 = event[2].split("|");
            var _local_9 = Number(_local_2[0]);
            var _local_6 = Number(_local_2[3]);
            var _local_5 = Number(_local_2[4]);
            var _local_3 = getRoomPuffleById(_local_9);
            if (_shell.isMyIgloo()) {
                _shell.setMyPlayerTotalCoins(_local_7);
            }
            if (_local_3 == undefined) {
                _shell.$e("[SHELL] PuffleManager.handleSendPuffleInteraction() -> Puffle was not found in the room! id: " + _local_9);
                return(undefined);
            }
            var _local_8 = true;
            _local_3.startInteraction(_local_8);
            _shell.updateListeners(_shell.PUFFLE_INTERACTION, {id:_local_9, interactionType:_shell.INTERACTIVE_FEED, x:_local_6, y:_local_5});
        }
        function setPuffleInteractionCompleteById(id) {
            var _local_2 = getRoomPuffleById(id);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.setPuffleInteractionCompleteById() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local_2.stopInteraction();
        }
        function disablePuffleInteractionByID(id) {
            var _local_2 = getRoomPuffleById(id);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.disablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local_2.interactionEnabled = false;
        }
        function enablePuffleInteractionByID(id) {
            var _local_2 = getRoomPuffleById(id);
            if (_local_2 == undefined) {
                _shell.$e("[SHELL] PuffleManager.enablePuffleInteractionByID() -> Puffle was not found in the room! id: " + id);
                return(undefined);
            }
            _local_2.interactionEnabled = true;
        }
        function makePuffleModelFromCrumb(arr) {
            trace("makePuffleModelFromCrumb");
            trace("arr: " + arr);
            var _local_2 = -1;
            _local_2++;
            var _local_16 = Number(arr[_local_2]);
            _local_2++;
            var _local_10 = Number(arr[_local_2]);
            _local_2++;
            var _local_19 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (Number(arr[_local_2])) : null);
            _local_2++;
            var _local_13 = arr[_local_2];
            _local_2++;
            var _local_11 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (new Date(Number(arr[_local_2]) * 1000)) : null);
            _local_2++;
            var _local_6 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (Number(arr[_local_2])) : null);
            _local_2++;
            var _local_8 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (Number(arr[_local_2])) : null);
            _local_2++;
            var _local_7 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (Number(arr[_local_2])) : null);
            _local_2++;
            var _local_5 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (Number(arr[_local_2])) : null);
            _local_2++;
            var _local_17 = Number(arr[_local_2]);
            var _local_14 = _puffleHatCollection.getPuffleHatVO(_local_17);
            var _local_12 = null;
            _local_2++;
            var _local_15 = (((arr[_local_2] != undefined) && (arr[_local_2] != null)) ? (Number(arr[_local_2])) : (DEFAULT_STATE));
            var _local_9 = null;
            if (_local_11 != null) {
                var _local_18 = new Date();
                _local_9 = Math.floor(((((_local_18.getTime() - _local_11.getTime()) / 1000) / 60) / 60) / 24);
            }
            if ((((_local_6 != null) && (_local_8 != null)) && (_local_7 != null)) && (_local_5 != null)) {
                _local_12 = new com.clubpenguin.shell.PuffleStatsVO(_local_6, _local_8, _local_7, _local_5);
            }
            var _local_4 = new com.clubpenguin.shell.PuffleModel();
            _local_4.id = _local_16;
            _local_4.typeID = _local_10;
            _local_4.subTypeID = _local_19;
            _local_4.name = _local_13;
            _local_4.hat = _local_14;
            _local_4.stats = _local_12;
            _local_4.ageInDays = _local_9;
            _local_4["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(_local_10);
            _local_4.updatePuffleState(_local_15);
            return(_local_4);
        }
        function makeRoomPuffleFromCrumb(arr) {
            var _local_3 = 0;
            var _local_6 = Number(arr[_local_3++]);
            var _local_7 = Number(arr[_local_3++]);
            var _local_18 = Number(arr[_local_3++]);
            var _local_8 = arr[_local_3++];
            var _local_20 = Number(arr[_local_3++]);
            var _local_11 = Number(arr[_local_3++]);
            var _local_17 = Number(arr[_local_3++]);
            var _local_15 = Number(arr[_local_3++]);
            var _local_10 = Number(arr[_local_3++]);
            var _local_16 = Number(arr[_local_3++]);
            var _local_13 = Number(arr[_local_3++]);
            var _local_12 = Number(arr[_local_3++]);
            var _local_14 = Boolean(Number(arr[_local_3++]));
            var _local_9 = _puffleHatCollection.getPuffleHatVO(_local_16);
            var _local_19 = new com.clubpenguin.shell.PuffleStatsVO(_local_11, _local_17, _local_15, _local_10);
            var _local_2 = new com.clubpenguin.shell.RoomPuffleModel();
            _local_2.id = _local_6;
            _local_2.typeID = _local_7;
            _local_2.subTypeID = _local_18;
            _local_2.name = _local_8;
            _local_2.x = _local_13;
            _local_2.y = _local_12;
            _local_2.isWalking = _local_14;
            _local_2.hat = _local_9;
            _local_2.stats = _local_19;
            _local_2["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(_local_7);
            var _local_5 = new com.clubpenguin.shell.RoomPuffle(_shell, _local_2);
            _local_5.isMine = isMyPuffleById(_local_6);
            if (((_local_2.typeID == com.clubpenguin.shell.PuffleType.RAINBOW.getTypeId()) || (_local_2.typeID == com.clubpenguin.shell.PuffleType.GOLD.getTypeId())) || (_local_2.isWildPuffle())) {
                _local_5.interactionEnabled = false;
            }
            addRoomPuffleListeners(_local_5);
            return(_local_5);
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
            var _local_3 = _roomPuffles.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_roomPuffles[_local_2].model.id == id) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(-1);
        }
        function clearRoomPuffle(roomPuffle) {
            var _local_3 = roomPuffle.model.id;
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
            _shell.updateListeners(_shell.REMOVE_PUFFLE, {id:_local_3});
        }
        function cleanUpRoomPuffles() {
            if (_roomPuffles == undefined) {
                return(undefined);
            }
            var _local_2 = 0;
            var _local_3 = _roomPuffles.length;
            while (_local_2 < _local_3) {
                clearRoomPuffle(_roomPuffles[_local_2]);
                _local_2++;
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
            var _local_1 = itemID - PUFFLE_INVENTORY_ID;
            return(((_local_1 >= 0) && (_local_1 < com.clubpenguin.shell.PuffleType.PUFFLE_COLOR_TYPE_LIST.length)) || (itemID == RAINBOW_PUFFLE_ID));
        }
        function createMoodVO(data) {
            var _local_1 = new com.clubpenguin.shell.PuffleMoodVO();
            _local_1.superHappy = Boolean(data.superHappy);
            _local_1.happy = Boolean(data.happy);
            _local_1.sad = Boolean(data.sad);
            _local_1.angry = Boolean(data.angry);
            _local_1.tired = Boolean(data.tired);
            _local_1.hungry = Boolean(data.hungry);
            _local_1.dirty = Boolean(data.dirty);
            return(_local_1);
        }
        function receivedPuffleMoodFromAS3(data) {
            var _local_2 = createMoodVO(data);
            var _local_4 = Number(data.puffleID);
            var _local_5 = getRoomPuffleById(_local_4);
            if (_local_5) {
                _local_5.model.mood = _local_2;
            }
            var _local_3 = getMyPuffleById(_local_4);
            if (_local_3) {
                _local_3.mood = _local_2;
            }
        }
        function receivedMyPuffleAddedFromAS3(data) {
            var _local_4 = Number(data.puffleID);
            if (!getMyPuffleById(_local_4)) {
                var _local_2 = new com.clubpenguin.shell.PuffleModel();
                _local_2.id = _local_4;
                _local_2.typeID = Number(data.typeID);
                _local_2.subTypeID = Number(data.subTypeID);
                _local_2.name = data.name;
                _local_2.mood = createMoodVO(data);
                _local_2["color"] = com.clubpenguin.shell.PuffleType.getPuffleColorByTypeId(_local_2.typeID);
                if (_myPuffles == undefined) {
                    _myPuffles = new Array();
                }
                _myPuffles.push(_local_2);
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
            var _local_3 = _shell.getPlayerObjectById(playerId);
            _local_3.attachedPuffle.updatePuffleState(puffleState);
            var _local_5 = com.clubpenguin.engine.puffles.effects.PuffleEffectEnum.getPuffleEffectByTypeId(puffleState);
            _global.getCurrentEngine().puffleAvatarController.addPuffleEffect(puffleID, _local_5);
        }
        function showPuffleByPlayerId(playerId) {
            var _local_3 = _shell.getPlayerObjectById(playerId);
            _global.getCurrentEngine().puffleAvatarController.showPuffle(_local_3.attachedPuffle.id);
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
