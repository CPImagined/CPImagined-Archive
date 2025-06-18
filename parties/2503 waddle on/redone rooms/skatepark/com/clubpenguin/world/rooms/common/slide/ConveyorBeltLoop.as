//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.slide.ConveyorBeltLoop
    {
        var _conveyorBeltContainer, endOfConveyorBeltReached, _ENGINE, _SHELL, currentPassengers, _conveyorBeltCollection, _mcNames, frameTriggersList;
        function ConveyorBeltLoop (conveyorBeltContainer) {
            _conveyorBeltContainer = conveyorBeltContainer;
            init();
        }
        function init() {
            endOfConveyorBeltReached = new org.osflash.signals.Signal(Number);
            _ENGINE = _global.getCurrentEngine();
            _SHELL = _global.getCurrentShell();
            currentPassengers = new Array();
        }
        function addConveyorBelt(linkageName, slide) {
            if (_conveyorBeltCollection == undefined) {
                _conveyorBeltCollection = new Array();
                _mcNames = new Array();
            }
            if (_conveyorBeltCollection[linkageName] == undefined) {
                _conveyorBeltCollection[linkageName] = 1;
                _mcNames.push(linkageName);
            }
        }
        function addPenguintoConveyorPather(linkageName, player_id) {
            if (_conveyorBeltCollection[linkageName] == undefined) {
                return(undefined);
            }
            _conveyorBeltContainer.attachMovie(linkageName, linkageName + player_id, _conveyorBeltContainer.getNextHighestDepth(), {_x:0, _y:0});
            var _local_6 = _conveyorBeltContainer[linkageName + player_id];
            _local_6.gotoAndStop(1);
            _local_6.pathLinkageName = linkageName;
            if (player_id == _SHELL.getMyPlayerId()) {
            }
            _ENGINE.teleportPlayer(player_id, _local_6.patherMC._x, _local_6.patherMC._y);
            var _local_5 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(player_id).attachedPuffle.id);
            _local_5.stopPuffleUpdates();
            var _local_4 = _ENGINE.getPlayerMovieClip(player_id);
            _local_4._rotation = _local_6.patherMC._rotation;
            if (player_id == _SHELL.getMyPlayerId()) {
                _SHELL.getPlayerObjectById(player_id).isUsingSlide = true;
            }
            _local_6.play();
            _local_6.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updatePenguinConveyorPosition, player_id, _local_6);
            if (currentPassengersIndex(player_id) == -1) {
                currentPassengers.push({playerID:player_id, patherMC:_local_6});
            }
        }
        function updatePenguinConveyorPosition(player_id, patherMC) {
            var _local_5 = getRegisteredTriggerFunction(patherMC._currentframe, player_id);
            if ((patherMC._currentframe == patherMC._totalframes) || (currentPassengersIndex(player_id) == -1)) {
                if ((_mcNames.length > 1) && (currentPassengersIndex(player_id) != -1)) {
                    var _local_2 = 0;
                    while (_local_2 < _mcNames.length) {
                        if (patherMC.pathLinkageName != _mcNames[_local_2]) {
                            cleanupCurrentBelt(patherMC);
                            addPenguintoConveyorPather(_mcNames[_local_2], player_id);
                            return(undefined);
                        }
                        _local_2++;
                    }
                }
                var _local_6 = _SHELL.getPlayerObjectById(player_id).frame - 16;
                updateFrameBasedOnSlide(player_id, _local_6);
                _SHELL.sendPlayerFrame(_local_6);
                cleanupCurrentBelt(patherMC);
                if (player_id == _SHELL.getMyPlayerId()) {
                    _SHELL.getPlayerObjectById(player_id).isUsingSlide = false;
                }
                var _local_10 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(player_id).attachedPuffle.id);
                _local_10.startPuffleUpdates();
                endOfConveyorBeltReached.dispatch(Number(player_id));
            } else if (_local_5 != undefined) {
                _local_5();
            } else {
                var _local_9 = _SHELL.getPlayerObjectById(player_id).x;
                var _local_7 = _SHELL.getPlayerObjectById(player_id).y;
                _ENGINE.teleportPlayer(player_id, patherMC.patherMC._x, patherMC.patherMC._y);
                var _local_8 = _ENGINE.getPlayerMovieClip(player_id);
                _local_8._rotation = patherMC.patherMC._rotation;
                updateSlidingActorFrame(player_id, _local_9, patherMC.patherMC._x, _local_7, patherMC.patherMC._y);
            }
        }
        function cleanupCurrentBelt(patherMC) {
            patherMC.gotoAndStop(1);
            delete patherMC.onEnterFrame;
            patherMC.removeMovieClip();
            patherMC = null;
        }
        function updateSlidingActorFrame(player_id, old_x, new_x, old_y, new_y) {
            var _local_4 = new_x - old_x;
            var _local_3 = new_y - old_y;
            var _local_2 = 0;
            if (_local_4 > MINIMUM_SLIDE_DISPLACEMENT) {
                _local_2 = ((_local_3 > MINIMUM_SLIDE_DISPLACEMENT) ? (PENGUIN_SIT_FRONT_RIGHT) : (PENGUIN_SIT_BACK_RIGHT));
            } else if (_local_4 < (-MINIMUM_SLIDE_DISPLACEMENT)) {
                _local_2 = ((_local_3 > MINIMUM_SLIDE_DISPLACEMENT) ? (PENGUIN_SIT_FRONT_LEFT) : (PENGUIN_SIT_BACK_LEFT));
            } else {
                _local_2 = ((_local_3 > MINIMUM_SLIDE_DISPLACEMENT) ? (PENGUIN_SIT_FRONT_CENTER) : (PENGUIN_SIT_BACK_CENTER));
            }
            if (_local_2 <= 0) {
                return(undefined);
            }
            updateFrameBasedOnSlide(player_id, _local_2);
        }
        function updateFrameBasedOnSlide(player_id, frame) {
            _ENGINE.updatePlayerFrame(player_id, frame, true);
            _SHELL.getPlayerObjectById(player_id).frame = frame;
        }
        function registerFrameTrigger(frame, callback, clientSide) {
            if (frameTriggersList == undefined) {
                frameTriggersList = new Array();
            }
            clientSide = ((clientSide == undefined) ? false : (clientSide));
            frameTriggersList.push({f:frame, callback:callback, clientSide:clientSide});
        }
        function getRegisteredTriggerFunction(frame, player_id) {
            if (frameTriggersList == undefined) {
                return(undefined);
            }
            player_id = ((player_id == undefined) ? 0 : (player_id));
            var _local_2 = 0;
            while (_local_2 < frameTriggersList.length) {
                if (frame == Number(frameTriggersList[_local_2].f)) {
                    if (frameTriggersList[_local_2].clientSide && (player_id == _SHELL.getMyPlayerId())) {
                        return(frameTriggersList[_local_2].callback);
                    }
                }
                _local_2++;
            }
            return(undefined);
        }
        function endCurrentBelt(patherMC, player_id) {
            cleanupCurrentBelt();
            var _local_6 = _SHELL.getPlayerObjectById(player_id).frame - 16;
            updateFrameBasedOnSlide(player_id, _local_6);
            _SHELL.sendPlayerFrame(_local_6);
            patherMC.gotoAndStop(1);
            delete patherMC.onEnterFrame;
            patherMC.removeMovieClip();
            patherMC = null;
            if (player_id == _SHELL.getMyPlayerId()) {
                _SHELL.getPlayerObjectById(player_id).isUsingSlide = false;
                _root.onMouseDown = null;
            }
            var _local_7 = _ENGINE.getPlayerMovieClip(player_id);
            _local_7._rotation = 0;
            var _local_8 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(player_id).attachedPuffle.id);
            _local_8.startPuffleUpdates();
            var _local_5 = currentPassengersIndex(player_id);
            if (_local_5 != -1) {
                currentPassengers.splice(_local_5, 1);
            }
            endOfConveyorBeltReached.dispatch(Number(player_id));
        }
        function removePassenger(playerID, xDest, yDest) {
            var _local_2 = currentPassengersIndex(playerID);
            if (_local_2 != -1) {
                currentPassengers.splice(_local_2, 1);
            }
        }
        function destroy() {
            _root.onMouseDown = null;
        }
        function currentPassengersIndex(playerID) {
            var _local_2 = 0;
            while (_local_2 < currentPassengers.length) {
                if (currentPassengers[_local_2].playerID == playerID) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(-1);
        }
        static var MINIMUM_SLIDE_DISPLACEMENT = 1;
        static var PENGUIN_SIT_FRONT_CENTER = 17;
        static var PENGUIN_SIT_FRONT_LEFT = 18;
        static var PENGUIN_SIT_FRONT_RIGHT = 24;
        static var PENGUIN_SIT_BACK_CENTER = 21;
        static var PENGUIN_SIT_BACK_LEFT = 20;
        static var PENGUIN_SIT_BACK_RIGHT = 23;
    }
