//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelroof.FeedingChair
    {
        var chairMC, foodMC, _SHELL, puffleCareQuest, feedingPlayers;
        function FeedingChair (reference, food) {
            chairMC = reference;
            foodMC = food;
            _SHELL = _global.getCurrentShell();
            puffleCareQuest = _SHELL.getRainbowPuffleQuest();
            feedingPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function beginFeeding(players) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                var _local_7 = _global.getCurrentEngine().getPlayerMovieClip(players[_local_3]);
                var _local_6 = _SHELL.getPlayerObjectById(players[_local_3]);
                if (puffleCareQuest.isPuffleEquipped(players[_local_3]) && (_local_6.avatarVO.avatar_id != 1)) {
                    feedingPlayers.push(Number(players[_local_3]));
                    var _local_5 = _SHELL.isMyPlayer(Number(players[_local_3]));
                    if ((foodMC._currentframe == 1) || (_local_5)) {
                        foodMC.gotoAndPlay(2);
                        _global.getCurrentEngine().puffleAvatarController.updatePuffleFrame(_local_6.attachedPuffle.id, com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_STAND_SOUTH_FRAME);
                        if (_local_5) {
                            chairMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, puffleEating, _local_7);
                            com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.FEED_CHAIR_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_FOOD_STATION);
                        }
                    }
                }
                _local_3++;
            }
        }
        function puffleEating(playerMC) {
            if (foodMC._currentframe == foodMC._totalframes) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_EAT_ITEM_ID);
                completeTask3();
                delete chairMC.onEnterFrame;
                return(undefined);
            }
        }
        function completeTask3() {
            if (((puffleCareQuest.currentPuffleQuestTaskIndex == (EATING_TASK_NUM - 1)) && (puffleCareQuest.isNextPuffleQuestTaskAvailable())) && (!puffleCareQuest.isTaskComplete(EATING_TASK_NUM))) {
                var _local_2 = setTimeout(showQuestUI, 1000);
            }
            puffleCareQuest.completePuffleQuestTask(EATING_TASK_NUM);
        }
        function showQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
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
                    delete chairMC.onEnterFrame;
                }
                _local_4++;
            }
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                endFeeding([event.playerId]);
            }
        }
        function cleanChair() {
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < feedingPlayers.length) {
                if ((player_ob.player_id == feedingPlayers[_local_2]) && (!puffleCareQuest.isPuffleEquipped(player_ob.player_id))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    endFeeding(_local_3);
                }
                _local_2++;
            }
        }
        static var EATING_TASK_NUM = 3;
    }
