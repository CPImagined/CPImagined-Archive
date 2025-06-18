//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelspa.GroomingChair extends MovieClip
    {
        var chairMC, washMC, _SHELL, puffleCareQuest, groomingPlayers;
        function GroomingChair (chairRef, washRef) {
            super();
            chairMC = chairRef;
            washMC = washRef;
            _SHELL = _global.getCurrentShell();
            puffleCareQuest = _SHELL.getRainbowPuffleQuest();
            chairMC.onRollOver = com.clubpenguin.util.Delegate.create(this, chairMouseOver);
            chairMC.onRollOut = com.clubpenguin.util.Delegate.create(this, chairMouseOff);
            groomingPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function chairMouseOver() {
            chairMC.washChair_mc.gotoAndStop(2);
            chairMC.chairarm_mc.gotoAndStop(2);
        }
        function chairMouseOff() {
            chairMC.washChair_mc.gotoAndStop(1);
            chairMC.chairarm_mc.gotoAndStop(1);
        }
        function beginGrooming(players) {
            var _local_7 = _global.getCurrentEngine();
            var _local_3 = 0;
            while (_local_3 < players.length) {
                var _local_8 = _local_7.getPlayerMovieClip(players[_local_3]);
                var _local_5 = _SHELL.getPlayerObjectById(players[_local_3]);
                if (puffleCareQuest.isPuffleEquipped(players[_local_3]) && (_local_5.avatarVO.avatar_id != 1)) {
                    groomingPlayers.push(Number(players[_local_3]));
                    var _local_6 = _SHELL.isMyPlayer(Number(players[_local_3]));
                    if ((washMC._currentframe == 1) || (_local_6)) {
                        washMC.gotoAndPlay(2);
                        if (washMC._name == "chairwash_1") {
                            _local_7.puffleAvatarController.updatePuffleFrame(_local_5.attachedPuffle.id, RIGHT_SIT_FRAME);
                        } else if (washMC._name == "chairwash_2") {
                            _local_7.puffleAvatarController.updatePuffleFrame(_local_5.attachedPuffle.id, LEFT_SIT_FRAME);
                        }
                        if (_local_6) {
                            _local_7.puffleAvatarController.setFrameUpdateEnabled(_local_5.attachedPuffle.id, false);
                            washMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, washPuffle, _local_8);
                        }
                    }
                    if (_local_6) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.GROOM_CHAIR_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
                    }
                }
                _local_3++;
            }
        }
        function washPuffle(playerMC) {
            if (washMC._currentframe == washMC._totalframes) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_ITEM_ID);
                completeTask2();
                delete washMC.onEnterFrame;
                return(undefined);
            }
        }
        function completeTask2() {
            if (((puffleCareQuest.currentPuffleQuestTaskIndex == (GROOMING_TASK_NUM - 1)) && (puffleCareQuest.isNextPuffleQuestTaskAvailable())) && (!puffleCareQuest.isTaskComplete(GROOMING_TASK_NUM))) {
                var _local_2 = setTimeout(showQuestUI, 1000);
            }
            puffleCareQuest.completePuffleQuestTask(GROOMING_TASK_NUM);
        }
        function showQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
        }
        function endGrooming(players) {
            var _local_6 = 0;
            while (_local_6 < groomingPlayers.length) {
                var _local_3 = 0;
                while (_local_3 < players.length) {
                    if (Number(groomingPlayers[_local_6]) == Number(players[_local_3])) {
                        groomingPlayers.splice(_local_6, 1);
                        break;
                    }
                    _local_3++;
                }
                _local_6++;
            }
            _local_6 = 0;
            while (_local_6 < players.length) {
                if (_SHELL.isMyPlayer(players[_local_6]) || (groomingPlayers.length == 0)) {
                    var _local_7 = _global.getCurrentEngine();
                    var _local_5 = _SHELL.getMyPlayerObject();
                    delete washMC.onEnterFrame;
                    _local_7.puffleAvatarController.setFrameUpdateEnabled(_local_5.attachedPuffle.id, true);
                    _local_7.puffleAvatarController.updatePuffleFrame(_local_5.attachedPuffle.id, _local_7.getPlayerMovieClip(_local_5.player_id).frame);
                    washMC.gotoAndStop(1);
                }
                _local_6++;
            }
        }
        function cleanChair() {
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
            var _local_3 = _SHELL.getMyPlayerObject();
            if (puffleCareQuest.isPuffleEquipped(_local_3.player_id)) {
                _global.getCurrentEngine().puffleAvatarController.setFrameUpdateEnabled(_local_3.attachedPuffle.id, true);
            }
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                endGrooming([event.playerId]);
            }
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < groomingPlayers.length) {
                if ((player_ob.player_id == groomingPlayers[_local_2]) && (!puffleCareQuest.isPuffleEquipped(player_ob.player_id))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    endGrooming(_local_3);
                }
                _local_2++;
            }
        }
        static var GROOMING_TASK_NUM = 2;
        static var LEFT_SIT_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SIT_SOUTHWEST_FRAME;
        static var RIGHT_SIT_FRAME = com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SIT_SOUTHEAST_FRAME;
    }
