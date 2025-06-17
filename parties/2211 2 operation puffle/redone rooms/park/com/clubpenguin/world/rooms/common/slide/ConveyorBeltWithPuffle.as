//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.slide.ConveyorBeltWithPuffle extends com.clubpenguin.world.rooms.common.slide.ConveyorBelt
    {
        var _ENGINE, _SHELL, addPenguintoConveyorPather;
        function ConveyorBeltWithPuffle () {
            super();
        }
        function init() {
            super.init();
        }
        function startPuffleToPenguinAnimation(linkageName, playerID, conveyorBeltContainer) {
            var _local_6;
            var _local_5;
            var _local_2 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(playerID).attachedPuffle.id);
            _local_2.stopPuffleUpdates();
            var _local_4 = new Object();
            _local_4.playerId = playerID;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_TREASURE_HUNTING, playerID);
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _local_4);
            _local_6 = Number(_local_2._x + puffleXOffset);
            _local_5 = Number(_local_2._y + puffleYOffset);
            _local_2._currentframe = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_WEST_FRAME;
            _local_2.getPuffleClip().swapDepths(_ENGINE.getPlayerMovieClip(playerID).getDepth() + 1);
            com.greensock.TweenMax.to(_local_2.getPuffleClip(), 0.5, {_x:_local_6, _y:_local_5, rotation:360, ease:com.greensock.easing.Quad.easeOut, onComplete:com.clubpenguin.util.Delegate.create(this, addPenguintoConveyorPather), onCompleteParams:[linkageName, playerID, conveyorBeltContainer]});
        }
        function startPuffleOffPenguinAnimation(playerID) {
            var _local_4;
            var _local_3;
            var _local_2 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(playerID).attachedPuffle.id);
            _local_2._currentframe = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_EAST_FRAME;
            _local_4 = Number(_local_2._x - puffleXOffset);
            _local_3 = Number(_local_2._y - puffleYOffset);
            com.greensock.TweenMax.to(_local_2.getPuffleClip(), 0.4, {_x:_local_4, _y:_local_3, ease:com.greensock.easing.Quad.easeIn, onComplete:com.clubpenguin.util.Delegate.create(this, onTweenPuffleOffofPlayerComplete), onCompleteParams:[playerID, _local_2]});
        }
        function onTweenPuffleOffofPlayerComplete(playerID, puffleAvatar) {
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
        function updatePenguinConveyorPosition(player_id, patherMC) {
            super.updatePenguinConveyorPosition(player_id, patherMC);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getPlayerObjectById(player_id), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_3 = _ENGINE.puffleAvatarController.getPuffleClip(_SHELL.getPlayerObjectById(player_id).attachedPuffle.id);
                _local_3._x = patherMC.patherMC._x + puffleXOffset;
                _local_3._y = patherMC.patherMC._y + puffleYOffset;
                _local_3.swapDepths(_ENGINE.getPlayerMovieClip(player_id).getDepth() + 1);
            }
        }
        function updateFrameBasedOnSlide(player_id, frame) {
            super.updateFrameBasedOnSlide(player_id, frame);
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getPlayerObjectById(player_id), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                var _local_3 = _ENGINE.puffleAvatarController.getPuffleAvatar(_SHELL.getPlayerObjectById(player_id).attachedPuffle.id);
                if (_local_3._currentframe != frame) {
                    _local_3._currentframe = frame;
                }
            }
        }
        static var puffleXOffset = -25;
        static var puffleYOffset = 0;
    }
