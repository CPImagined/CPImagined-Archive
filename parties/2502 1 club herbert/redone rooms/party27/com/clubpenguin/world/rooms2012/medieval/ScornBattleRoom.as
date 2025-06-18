//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.ScornBattleRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _isWeek2, _stage, _PARTY, _INTERFACE, _triggerWatcher, _SHELL, setupNavigationButtons, _revealScornTrigger, _roomUpdateInterval, _destroyDelegate, _ENGINE, _scornBattleTriggerTimeout;
        function ScornBattleRoom (stageReference, isWeek2) {
            super(stageReference);
            _isWeek2 = isWeek2;
            _stage.start_x = 665;
            _stage.start_y = 390;
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.scorn_statue_mc.btn_dragonfight, 580, 300)]);
			_stage.triggers_mc.dragonfight_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, startBossBattle);
            _revealScornTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.dragonanim_mc);
            _revealScornTrigger.isLocalPlayerOnly();
            _revealScornTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, revealScorn));
            _triggerWatcher.addTrigger(_revealScornTrigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
            _stage.triggers_mc.bossbattle_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, startBossBattle);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.bridge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party26", 680, 90);
            if (_ENGINE.getGameCompletedParams().isScornBattleJustPlayed || _PARTY.getTaskComplete(6)) {
                setScornDefeatedState();
                var _local_2 = _ENGINE.getGameCompletedParams();
                if (_ENGINE.getGameCompletedParams().isScornBattleJustPlayed) {
                    onScornBattleGameComplete();
                };
				if (!_PARTY.getTaskComplete(6)) {
					_PARTY.setTaskComplete(6);
				};
            } else if (!_PARTY.getTaskComplete(6)) {
                clearInterval(_scornBattleTriggerTimeout);
                _scornBattleTriggerTimeout = setInterval(this, "startBossBattle", 10000);
            }
        }
        function onScornBattleGameComplete() {
			if (!_PARTY.getTaskComplete(6)) {
				_INTERFACE.showContent("w.app.p2025.doom.scorn.end");
			};
        }
        function setScornDefeatedState() {
            _stage.foreground_mc.gotoAndStop(2);
            _stage.background_mc.gotoAndStop(2);
            _stage.block_mc.gotoAndStop(2);
			_stage.scorn_statue_mc.gotoAndStop(2);
			_stage.rock_mc.gotoAndStop(2);
			_stage.triggers_mc.gotoAndStop(2);
        }
        function revealScorn() {
            if (_stage.background_mc.dragonrise_mc._currentframe == 1) {
				_INTERFACE.showContent("w.app.p2025.doom.scorn.appear");
                _stage.background_mc.dragonrise_mc.gotoAndPlay(2);
				clearInterval(_scornBattleTriggerTimeout);
                _scornBattleTriggerTimeout = setInterval(this, "startBossBattle", 10000);
            }
        }
        function startBossBattle() {
            com.clubpenguin.world.rooms2012.medieval.MedievalParty.track("startScornBattle");
            clearInterval(_scornBattleTriggerTimeout);
            _ENGINE.sendJoinGame(com.clubpenguin.world.rooms2012.medieval.MedievalParty.GAME_SCORN_BATTLE, true);
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_scornBattleTriggerTimeout);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "ScornBattleRoom";
    }
