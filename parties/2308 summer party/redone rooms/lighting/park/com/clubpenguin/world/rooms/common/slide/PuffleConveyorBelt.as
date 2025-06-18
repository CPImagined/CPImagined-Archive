//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.slide.PuffleConveyorBelt
    {
        var endOfConveyorBeltReached, _ENGINE, _SHELL, frameTriggersList;
        function PuffleConveyorBelt () {
            init();
        }
        function init() {
            endOfConveyorBeltReached = new org.osflash.signals.Signal(Number);
            _ENGINE = _global.getCurrentEngine();
            _SHELL = _global.getCurrentShell();
        }
        function startPufflePathFollow(linkageName, puffleAvatar, conveyorBeltContainer, playerID, animationFunc) {
            puffleAvatar = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(playerID).attachedPuffle.id);
            puffleAvatar.stopPuffleUpdates();
            var _local_3 = new Object();
            _local_3.playerId = playerID;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, playerID);
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_3);
            puffleAvatar._currentframe = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SIT_SOUTHEAST_FRAME;
            addPuffleToConveyorBelt(linkageName, puffleAvatar, conveyorBeltContainer, playerID, animationFunc);
        }
        function addPuffleToConveyorBelt(linkageName, puffleAvatar, conveyorBeltContainer, playerID) {
            conveyorBeltContainer.attachMovie(linkageName, linkageName + puffleAvatar.id, conveyorBeltContainer.getNextHighestDepth(), {_x:0, _y:0});
            var _local_2 = conveyorBeltContainer[linkageName + puffleAvatar.id];
            _local_2.gotoAndStop(1);
            puffleAvatar._x = _local_2.patherMC._x + PUFFLE_X_OFFSET;
            puffleAvatar._y = _local_2.patherMC._y;
            _local_2.play();
            _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updatePuffleConveyorPosition, puffleAvatar, _local_2, playerID);
        }
        function updatePuffleConveyorPosition(puffleAvatar, patherMC, playerID) {
            var _local_4 = getRegisteredTriggerFunction(patherMC._currentframe);
            if (patherMC._currentframe == patherMC._totalframes) {
                patherMC.gotoAndStop(1);
                delete patherMC.onEnterFrame;
                patherMC.removeMovieClip();
                patherMC = null;
                endOfConveyorBeltReached.dispatch(Number(playerID));
            } else if (_local_4 != undefined) {
                _local_4();
            } else {
                var _local_6 = puffleAvatar._x;
                var _local_5 = puffleAvatar._y;
                puffleAvatar._x = patherMC.patherMC._x + PUFFLE_X_OFFSET;
                puffleAvatar._y = patherMC.patherMC._y;
                updateFrameToPuffleZipline(puffleAvatar);
            }
        }
        function updateFrameToPuffleZipline(puffleAvatar) {
            var _local_1 = 80;
            if (puffleAvatar._currentframe == _local_1) {
                return(undefined);
            }
            puffleAvatar._currentframe = _local_1;
        }
        function updateSlidingPuffleFrame(puffleAvatar, oldX, oldY) {
            var _local_3 = puffleAvatar._x - oldX;
            var _local_2 = puffleAvatar._y - oldY;
            var _local_1 = 0;
            if (_local_3 > MINIMUM_SLIDE_DISPLACEMENT) {
                _local_1 = ((_local_2 > MINIMUM_SLIDE_DISPLACEMENT) ? (PUFFLE_SIT_FRONT_RIGHT) : (PUFFLE_SIT_BACK_RIGHT));
            } else if (_local_3 < (-MINIMUM_SLIDE_DISPLACEMENT)) {
                _local_1 = ((_local_2 > MINIMUM_SLIDE_DISPLACEMENT) ? (PUFFLE_SIT_FRONT_LEFT) : (PUFFLE_SIT_BACK_LEFT));
            } else {
                _local_1 = ((_local_2 > MINIMUM_SLIDE_DISPLACEMENT) ? (PUFFLE_SIT_FRONT_CENTER) : (PUFFLE_SIT_BACK_CENTER));
            }
            if (_local_1 <= 0) {
                return(undefined);
            }
            puffleAvatar._currentframe = _local_1;
        }
        function onPathComplete(playerID) {
            tweenPuffleBackToPlayer(playerID);
        }
        function tweenPuffleBackToPlayer(playerID) {
            var _local_5;
            var _local_4;
            var _local_2;
            var _local_3;
            _local_2 = _SHELL.getPlayerObjectById(playerID);
            _local_3 = _ENGINE.puffleAvatarController.getPuffleAvatar(_local_2.attachedPuffle.id);
            _local_3._currentframe = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_SOUTH_FRAME;
            _local_5 = Number(_local_2.x);
            _local_4 = Number(_local_2.y);
            com.greensock.TweenMax.to(_local_3.getPuffleClip(), 0.4, {_x:_local_5, _y:_local_4, ease:com.greensock.easing.Quad.easeOut, onComplete:com.clubpenguin.util.Delegate.create(this, onTweenBacktoPlayerComplete), onCompleteParams:[playerID, _local_3]});
        }
        function onTweenBacktoPlayerComplete(playerID, puffleAvatar) {
            puffleAvatar._currentframe = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SIT_SOUTHEAST_FRAME;
            if (playerID == _SHELL.getMyPlayerId()) {
                _SHELL.sendAS3EnablePuffleTricksHUD();
                _ENGINE.puffleAvatarController.displayPuffleWidget(_SHELL.getPlayerObjectById(playerID).attachedPuffle.id, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_ITEM_ID);
            } else {
                var _local_2 = new Object();
                _local_2.playerId = playerID;
                _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_TREASURE_HUNTING, playerID);
                _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_2);
                puffleAvatar.startPuffleUpdates();
            }
        }
        function registerFrameTrigger(frame, callback) {
            if (frameTriggersList == undefined) {
                frameTriggersList = new Array();
            }
            frameTriggersList.push({f:frame, callback:callback});
        }
        function getRegisteredTriggerFunction(frame) {
            if (frameTriggersList == undefined) {
                return(undefined);
            }
            var _local_2 = 0;
            while (_local_2 < frameTriggersList.length) {
                if (frame == Number(frameTriggersList[_local_2].f)) {
                    return(frameTriggersList[_local_2].callback);
                }
                _local_2++;
            }
            return(undefined);
        }
        static var MINIMUM_SLIDE_DISPLACEMENT = 1;
        static var PUFFLE_SIT_FRONT_CENTER = 17;
        static var PUFFLE_SIT_FRONT_LEFT = 18;
        static var PUFFLE_SIT_FRONT_RIGHT = 24;
        static var PUFFLE_SIT_BACK_CENTER = 21;
        static var PUFFLE_SIT_BACK_LEFT = 20;
        static var PUFFLE_SIT_BACK_RIGHT = 23;
        static var PUFFLE_X_OFFSET = -30;
    }
