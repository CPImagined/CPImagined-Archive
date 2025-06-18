//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.hotel.hotelspa.Treadmill extends MovieClip
    {
        var treadmillMC, _SHELL, _ENGINE, puffleCareQuest, exercisingPufflePlayers, exercisingAllPlayers, questInterval, treadmillActive, _playerTrigger, __get__playerTrigger;
        function Treadmill (reference) {
            super();
            treadmillMC = reference;
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            treadmillMC.Treadmill_mc.treadmill_inner_mc.treadArm.gotoAndStop(1);
            puffleCareQuest = _SHELL.getRainbowPuffleQuest();
            treadmillMC.onRollOver = com.clubpenguin.util.Delegate.create(this, treadmillMouseOver);
            treadmillMC.onRollOut = com.clubpenguin.util.Delegate.create(this, treadmillMouseOff);
            exercisingPufflePlayers = new Array();
            exercisingAllPlayers = new Array();
            _SHELL.addListener(_SHELL.UPDATE_PLAYER, com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer));
            _SHELL.addListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function treadmillMouseOver() {
            treadmillMC.treadArm_mc.gotoAndStop(2);
            treadmillMC.Treadmill_mc.gotoAndStop(2);
        }
        function treadmillMouseOff() {
            treadmillMC.Treadmill_mc.gotoAndStop(1);
            treadmillMC.treadArm_mc.gotoAndStop(1);
        }
        function startTreadmill(players) {
            var _local_5 = new Sound(treadmillMC);
            _local_5.attachSound("treadmillStart");
            _local_5.start();
            var _local_3 = 0;
            while (_local_3 < players.length) {
                exercisingAllPlayers.push(players[_local_3]);
                if (players[_local_3] == _SHELL.getMyPlayerId()) {
                    runTreadmill(players[_local_3]);
                }
                if (puffleCareQuest.isPuffleEquipped(players[_local_3]) && (_SHELL.getPlayerObjectById(players[_local_3]).avatarVO.avatar_id != 1)) {
                    exercisingPufflePlayers.push(Number(players[_local_3]));
                    setTimeout(com.clubpenguin.util.Delegate.create(this, animatePuffle), 500, players[_local_3]);
                    if (players[_local_3] == _SHELL.getMyPlayerId()) {
                        com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.sendPuffleCareStationBI(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.TREADMILL_CARESTATION, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
                    }
                } else {
                    _global.getCurrentEngine().updatePlayerFrame(players[_local_3], PENGUIN_WALK_NORTH, true);
                }
                _local_3++;
            }
            if (treadmillMC.Treadmill_mc.treadmill_inner_mc.treadArm._currentframe == 1) {
                treadmillMC.Treadmill_mc.treadmill_inner_mc.treadArm.play();
            }
        }
        function animatePuffle(playerID) {
            var _local_2 = _SHELL.getPlayerObjectById(playerID);
            _ENGINE.puffleAvatarController.updatePuffleFrame(_local_2.attachedPuffle.id, com.clubpenguin.puffleavatar.PuffleAvatarConstants.PUFFLE_WALK_HOP_NORTH_FRAME);
            _ENGINE.puffleAvatarController.hideHat(_local_2.attachedPuffle.id);
            _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_2.attachedPuffle.id, false);
        }
        function runTreadmill(players) {
            var _local_3 = _global.getCurrentEngine().getPlayerMovieClip(_SHELL.getMyPlayerId());
            if ((!puffleCareQuest.isPuffleEquipped(_SHELL.getMyPlayerId())) || (_SHELL.getMyPlayerObject().avatarVO.avatar_id == 1)) {
                _ENGINE.setPlayerAction("animating");
                return(undefined);
            }
            treadmillMC.Treadmill_mc.treadmill_inner_mc.treadArm.play();
            questInterval = setInterval(com.clubpenguin.util.Delegate.create(this, puffleWalked), PLAY_POINTS_INTERVAL);
            treadmillActive = true;
        }
        function playersRemoved(players) {
            var _local_4 = 0;
            while (_local_4 < players.length) {
                var _local_2 = 0;
                while (_local_2 < exercisingAllPlayers.length) {
                    if (Number(players[_local_4]) == Number(exercisingAllPlayers[_local_2])) {
                        exercisingAllPlayers.splice(_local_2, 1);
                    }
                    if (Number(players[_local_4]) == Number(exercisingPufflePlayers[_local_2])) {
                        exercisingPufflePlayers.splice(_local_2, 1);
                        var _local_3 = _SHELL.getPlayerObjectById(players[_local_4]);
                        if (puffleCareQuest.isPuffleEquipped(_local_3.player_id)) {
                            _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_3.attachedPuffle.id, true);
                            _ENGINE.puffleAvatarController.updatePuffleFrame(_local_3.attachedPuffle.id, _ENGINE.getPlayerMovieClip(_local_3.player_id).frame);
                            _ENGINE.puffleAvatarController.showHat(_local_3.attachedPuffle.id);
                        }
                    }
                    _local_2++;
                }
                if (players[_local_4] == _SHELL.getMyPlayerId()) {
                    clearInterval(questInterval);
                }
                _local_4++;
            }
            if (exercisingAllPlayers.length == 0) {
                treadmillMC.Treadmill_mc.treadmill_inner_mc.treadArm.gotoAndStop(1);
                treadmillActive = false;
            }
        }
        function puffleWalked() {
            var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
            _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_ITEM_ID);
            completeTask1();
        }
        function completeTask1() {
            puffleCareQuest.completePuffleQuestTask(TREADMILL_TASK_NUM);
            if ((puffleCareQuest.currentPuffleQuestTaskIndex == (TREADMILL_TASK_NUM - 1)) && (!puffleCareQuest.isTaskComplete(TREADMILL_TASK_NUM))) {
                var _local_2 = setTimeout(showQuestUI, 1000);
            }
        }
        function showQuestUI() {
            _global.getCurrentInterface().showContent(com.clubpenguin.quests.rainbowpuffle.RainbowPuffleQuest.PUFFLE_QUEST_UI);
        }
        function handlePufflePerformingTrick(event) {
            if (event.playerId == _SHELL.getMyPlayerId()) {
                playersRemoved([event.playerId]);
            }
        }
        function cleanTreadmill() {
            var _local_2 = _SHELL.getMyPlayerObject();
            if (puffleCareQuest.isPuffleEquipped(_local_2.player_id)) {
                _ENGINE.puffleAvatarController.setFrameUpdateEnabled(_local_2.attachedPuffle.id, true);
            }
            clearInterval(questInterval);
            _SHELL.removeListener(_SHELL.UPDATE_PLAYER, handleUpdatePlayer);
            _SHELL.removeListener(_SHELL.PUFFLE_PERFORMING_TRICK, com.clubpenguin.util.Delegate.create(this, handlePufflePerformingTrick));
        }
        function set playerTrigger(playerTrigger) {
            _playerTrigger = playerTrigger;
            //return(__get__playerTrigger());
        }
        function handleUpdatePlayer(player_ob) {
            var _local_2 = 0;
            while (_local_2 < exercisingPufflePlayers.length) {
                if ((player_ob.player_id == exercisingPufflePlayers[_local_2]) && (!puffleCareQuest.isPuffleEquipped(player_ob.player_id))) {
                    var _local_3 = new Array();
                    _local_3.push(player_ob.player_id);
                    playersRemoved(_local_3);
                }
                _local_2++;
            }
        }
        static var TREADMILL_TASK_NUM = 1;
        static var PENGUIN_WALK_NORTH = 13;
        static var PLAY_POINTS_INTERVAL = 7000;
        static var frameCount = 0;
    }
