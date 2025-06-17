//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Party2 extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _handleConcert, _ENGINE, _updateDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, localize, _triggerWatcherInterval, musicJamPerformances, _setQuestBtnsIntervalID, registerScavengerHuntItem;
        function Party2 (stageReference) {
            super(stageReference);
            _stage.start_x = 525;
            _stage.start_y = 260;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
			_handleConcert = com.clubpenguin.util.Delegate.create(this, handleConcert);
			_updateDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdatePlayer);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_global.getCurrentAirtower().addListener("jamconcert", _handleConcert);
			_SHELL.addListener("jamtp", _updateDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.lobby_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 360, 350);
            _stage.triggers_mc.pool_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 70, 215);
            _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchGame);
            _stage.triggers_mc.mic_1.triggerFunction = com.clubpenguin.util.Delegate.create(this, playMicCheck);
            _stage.triggers_mc.mic_2.triggerFunction = com.clubpenguin.util.Delegate.create(this, playMicCheck);
            _stage.lobby_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exit1MouseOver);
            _stage.lobby_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exit1MouseOff);
            _stage.lobby_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exit1MouseOff);
            _stage.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, gameMouseOver);
            _stage.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, gameMouseOff);
            _stage.game_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, gameMouseOff);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lobby_btn, 730, 405), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.game_btn, 505, 126)]);
            localize([_stage.background_mc.scheduleText_mc.langNext_mc, _stage.background_mc.scheduleText_mc.langPerforming_mc, _stage.background_mc.scheduleText_mc.langFollowed_mc, _stage.background_mc.schedule_mc.timer_mc.timerbitmap_mc.minutes_mc.langMins_mc, _stage.background_mc.schedule_mc.timer_mc.timerbitmap_mc.minutes_mc.langMin_mc, _stage.dj_game_mc.dj_game_state_mc.dj_game_logo_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            musicJamPerformances = new com.clubpenguin.world.rooms2014.music.MusicJamPerformances(_stage);
            _setQuestBtnsIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, setQuestBtns), 500);
        }
		var handleConcert = function(obj)
		{
			obj.shift();
			_stage.playConcert(obj[0]);
		};
		function handleUpdatePlayer() {
			var _loc4_ = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
			if(_stage.triggers_mc.stage_mc.hitTest(_loc4_.x, _loc4_.y)) {
				_ENGINE.sendPlayerTeleportAndMove(291, 268, 292, 269);
				_stage.block_mc.gotoAndStop(2);
			};
		}
        function setQuestBtns() {
            clearInterval(_setQuestBtnsIntervalID);
            registerScavengerHuntItem("quest_4");
        }
        function playMicCheck() {
            var _local_3 = random(2);
            if (_local_3 == 1) {
                _global.getCurrentParty().BaseParty.playSound(_stage.mic_1, "sfx_mic_" + random(2));
            }
        }
        function exit1MouseOver() {
            _stage.foreground_mc.elevator_mc.gotoAndPlay(2);
        }
        function exit1MouseOff() {
            _stage.foreground_mc.elevator_mc.gotoAndPlay(16);
        }
        function launchGame() {
            _global.getCurrentParty().MusicParty.launchMusicGame();
        }
        function gameMouseOver() {
            _stage.dj_game_mc.gotoAndStop(2);
        }
        function gameMouseOff() {
            _stage.dj_game_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
			_global.getCurrentAirtower().removeListener("jamconcert", _handleConcert);
			_SHELL.removeListener("jamtp", _updateDelegate);
            musicJamPerformances.clean();
        }
        static var CLASS_NAME = "Party2";
        static var PERFORMING_FRAME = 1;
        static var WAVING_FRAME = 2;
    }
