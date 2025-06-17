//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.carestations.FeedingBowl
    {
        var foodMC, _SHELL, _ENGINE, feedingPlayers;
        function FeedingBowl (foodbowlMC) {
            foodMC = foodbowlMC;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            feedingPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function beginFeeding(players) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                var _local_6 = _ENGINE.getPlayerMovieClip(players[_local_3]);
                var _local_7 = _SHELL.getPlayerObjectById(players[_local_3]);
                if (isPuffleEquipped(players[_local_3]) || (_global.getCurrentParty().PuffleParty.isActive && (_global.getCurrentParty().PuffleParty.getIsPlayerPuffle(players[_local_3])))) {
                    feedingPlayers.push(Number(players[_local_3]));
                    var _local_5 = _SHELL.isMyPlayer(Number(players[_local_3]));
                    if ((foodMC._currentframe == 1) || (_local_5)) {
                        foodMC.gotoAndPlay(2);
                        _global.getCurrentEngine().puffleAvatarController.updatePuffleFrame(_local_7.attachedPuffle.id, com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_STAND_SOUTH_FRAME);
                        if (_local_5) {
                            foodMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, puffleEating, _local_6);
                            com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.FEED_CHAIR_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION);
                        }
                    }
                }
                _local_3++;
            }
        }
        function isPuffleEquipped(playerId) {
            return(com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getPlayerObjectById(playerId), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE));
        }
        function puffleEating(playerMC) {
            if (foodMC._currentframe == foodMC._totalframes) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_EAT_ITEM_ID);
                delete foodMC.onEnterFrame;
                return(undefined);
            }
        }
        function endFeeding(players) {
            var _local_4 = 0;
            while (_local_4 < feedingPlayers.length) {
                var _local_2 = 0;
                while (_local_2 < players.length) {
                    if (Number(feedingPlayers[_local_4]) == Number(players[_local_2])) {
                        feedingPlayers.splice(_local_4, 1);
                        break;
                    }
                    _local_2++;
                }
                _local_4++;
            }
            _local_4 = 0;
            while (_local_4 < players.length) {
                if (_SHELL.isMyPlayer(players[_local_4]) || (feedingPlayers.length == 0)) {
                    foodMC.gotoAndStop(1);
                    delete foodMC.onEnterFrame;
                }
                _local_4++;
            }
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                endFeeding([event.playerId]);
            }
        }
        function cleanStation() {
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < feedingPlayers.length) {
                if ((player_ob.player_id == feedingPlayers[_local_2]) && (!isPuffleEquipped(player_ob.player_id))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    endFeeding(_local_3);
                }
                _local_2++;
            }
        }
    }
