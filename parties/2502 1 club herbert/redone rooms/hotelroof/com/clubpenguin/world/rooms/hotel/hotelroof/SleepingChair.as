//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelroof.SleepingChair
    {
        var chairMC, _stage, _SHELL, _ENGINE, puffleCareQuest, sleepingPlayers, sfxSnoringLoop, questInterval;
        function SleepingChair (reference, stage) {
            chairMC = reference;
            _stage = stage;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            puffleCareQuest = _SHELL.getRainbowPuffleQuest();
            sleepingPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function beginSleeping(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_4 = _SHELL.getPlayerObjectById(players[_local_2]);
                if (puffleCareQuest.isPuffleEquipped(players[_local_2]) && (_local_4.avatarVO.avatar_id != 1)) {
                    sleepingPlayers.push(Number(players[_local_2]));
                    if ((!_soundPlaying) && (_SHELL.isMyPlayer(players[_local_2]))) {
                        sfxSnoringLoop = new Sound(_stage);
                        sfxSnoringLoop.attachSound("snoringLoopSFX");
                        sfxSnoringLoop.start(0, 999);
                    }
                    _ENGINE.puffleAvatarController.updatePuffleFrame(_local_4.attachedPuffle.id, com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_SLEEP_FRAME);
                    if (players[_local_2] == _SHELL.getMyPlayerId()) {
                        _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_SHELL.getMyPlayerObject().attachedPuffle.id, false);
                        questInterval = setInterval(com.clubpenguin.util.Delegate.create(this, puffleNapping), SLEEP_POINTS_INTERVAL);
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.SLEEP_CHAIR_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_SLEEP_STATION);
                    }
                }
                _local_2++;
            }
        }
        function puffleNapping(player_Obj) {
            var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
            _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_REST_ITEM_ID);
            completeTask4();
        }
        function completeTask4() {
            if (((puffleCareQuest.currentPuffleQuestTaskIndex == (SLEEPING_TASK_NUM - 1)) && (puffleCareQuest.isNextPuffleQuestTaskAvailable())) && (!puffleCareQuest.isTaskComplete(SLEEPING_TASK_NUM))) {
                var _local_2 = setTimeout(showQuestUI, 1000);
                _stage.background_mc.cannonStatus_mc.gotoAndStop("available");
            }
            puffleCareQuest.completePuffleQuestTask(SLEEPING_TASK_NUM);
        }
        function showQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
        }
        function endSleeping(players) {
            var _local_4 = 0;
            while (_local_4 < sleepingPlayers.length) {
                var _local_3 = 0;
                while (_local_3 < players.length) {
                    if (Number(sleepingPlayers[_local_4]) == Number(players[_local_3])) {
                        sleepingPlayers.splice(_local_4, 1);
                        var _local_2 = _SHELL.getPlayerObjectById(players[_local_3]);
                        if (puffleCareQuest.isPuffleEquipped(_local_2.player_id)) {
                            _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_2.attachedPuffle.id, true);
                            _ENGINE.puffleAvatarController.updatePuffleFrame(_local_2.attachedPuffle.id, _ENGINE.getPlayerMovieClip(_local_2.player_id).frame);
                        }
                        break;
                    }
                    _local_3++;
                }
                _local_4++;
            }
            clearInterval(questInterval);
            frameCount = 0;
            delete chairMC.onEnterFrame;
            sfxSnoringLoop.stop();
            _soundPlaying = false;
            clearInterval(questInterval);
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                endSleeping([event.playerId]);
            }
        }
        function cleanChair() {
            var _local_2 = _SHELL.getMyPlayerObject();
            if (puffleCareQuest.isPuffleEquipped(_local_2.player_id)) {
                _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_2.attachedPuffle.id, true);
            }
            _soundPlaying = false;
            sfxSnoringLoop.stop();
            clearInterval(questInterval);
            frameCount = 0;
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < sleepingPlayers.length) {
                if ((player_ob.player_id == sleepingPlayers[_local_2]) && (!puffleCareQuest.isPuffleEquipped(player_ob.player_id))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    endSleeping(_local_3);
                }
                _local_2++;
            }
        }
        static var frameCount = 0;
        var _soundPlaying = false;
        static var SLEEPING_TASK_NUM = 4;
        static var SLEEP_POINTS_INTERVAL = 7000;
    }
