//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.slide.ConveyorBelt
    {
        var endOfConveyorBeltReached, _ENGINE, _SHELL, __get__updatePenguinFrames, frameTriggersList;
        function ConveyorBelt () {
            init();
        }
        function init() {
            trace("Init the conveyor belt");
            endOfConveyorBeltReached = new org.osflash.signals.Signal(Number);
            _ENGINE = _global.getCurrentEngine();
            _SHELL = _global.getCurrentShell();
        }
        function set updatePenguinFrames(value) {
            _updatePenguinFrames = value;
            //return(__get__updatePenguinFrames());
        }
        function addPenguintoConveyorPather(linkageName, player_id, conveyorBeltContainer) {
            conveyorBeltContainer.attachMovie(linkageName, linkageName + player_id, conveyorBeltContainer.getNextHighestDepth(), {_x:0, _y:0});
            var _local_2 = conveyorBeltContainer[linkageName + player_id];
            _local_2.gotoAndStop(1);
            _ENGINE.teleportPlayer(player_id, _local_2.patherMC._x, _local_2.patherMC._y);
            var _local_4 = _ENGINE.getPlayerMovieClip(player_id);
            _local_4._rotation = _local_2.patherMC._rotation;
            if (player_id == _SHELL.getMyPlayerId()) {
                _SHELL.getPlayerObjectById(player_id).isUsingSlide = true;
            }
            _local_2.play();
            _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updatePenguinConveyorPosition, player_id, _local_2);
        }
        function updatePenguinConveyorPosition(player_id, patherMC) {
            var _local_4 = getRegisteredTriggerFunction(patherMC._currentframe, player_id);
            if (patherMC._currentframe == patherMC._totalframes) {
                var _local_5 = _SHELL.getPlayerObjectById(player_id).frame - 16;
                updateFrameBasedOnSlide(player_id, _local_5);
                _SHELL.sendPlayerFrame(_local_5);
                patherMC.gotoAndStop(1);
                delete patherMC.onEnterFrame;
                patherMC.removeMovieClip();
                patherMC = null;
                if (player_id == _SHELL.getMyPlayerId()) {
                    _SHELL.getPlayerObjectById(player_id).isUsingSlide = false;
                }
                endOfConveyorBeltReached.dispatch(Number(player_id));
            } else if (_local_4 != undefined) {
                _local_4();
            } else {
                var _local_8 = _SHELL.getPlayerObjectById(player_id).x;
                var _local_6 = _SHELL.getPlayerObjectById(player_id).y;
                _ENGINE.teleportPlayer(player_id, patherMC.patherMC._x, patherMC.patherMC._y);
                var _local_7 = _ENGINE.getPlayerMovieClip(player_id);
                _local_7._rotation = patherMC.patherMC._rotation;
                if (_updatePenguinFrames) {
                    updateSlidingActorFrame(player_id, _local_8, patherMC.patherMC._x, _local_6, patherMC.patherMC._y);
                }
            }
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
        function destroy() {
        }
        static var MINIMUM_SLIDE_DISPLACEMENT = 1;
        static var PENGUIN_SIT_FRONT_CENTER = 17;
        static var PENGUIN_SIT_FRONT_LEFT = 18;
        static var PENGUIN_SIT_FRONT_RIGHT = 24;
        static var PENGUIN_SIT_BACK_CENTER = 21;
        static var PENGUIN_SIT_BACK_LEFT = 20;
        static var PENGUIN_SIT_BACK_RIGHT = 23;
        var _updatePenguinFrames = true;
    }
