//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.ScornBattleRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _isWeek2, _stage, _triggerWatcher, _SHELL, setupNavigationButtons, _revealScornTrigger, _roomUpdateInterval, _destroyDelegate, _ENGINE, _scornBattleTriggerTimeout, _opcodeJournal;
        function ScornBattleRoom (stageReference, isWeek2) {
            super(stageReference);
            _isWeek2 = isWeek2;
            _stage.start_x = 665;
            _stage.start_y = 390;
        }
        function init() {
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            if (_stage.btn_dragonfight) {
                setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.btn_dragonfight, 580, 300)]);
                _stage.triggers_mc.dragonfight_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, startBossBattle);
            } else {
                if (_stage.triggers_mc.dragonanim_mc) {
                    _revealScornTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.dragonanim_mc);
                    _revealScornTrigger.isLocalPlayerOnly();
                    _revealScornTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, revealScorn));
                    _triggerWatcher.addTrigger(_revealScornTrigger);
                    clearInterval(_roomUpdateInterval);
                    _roomUpdateInterval = setInterval(this, "update", 40);
                }
                _stage.triggers_mc.bossbattle_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, startBossBattle);
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.bridge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party27", 680, 90);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function setScornDefeatedState() {
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.medieval.OpcodeJournal.SCORN_DEFEATED);
        }
        function revealScorn() {
            if (_stage.background_mc.dragonrise_mc._currentframe == 1) {
                _stage.background_mc.dragonrise_mc.gotoAndPlay(2);
            }
        }
        function startBossBattle() {
            com.clubpenguin.world.rooms2012.medieval.MedievalParty.track("startScornBattle");
            clearInterval(_scornBattleTriggerTimeout);
            _stage.background_mc.dragonrise_mc.gotoAndStop(1);
            _SHELL.sendJoinRoom("party", 397, 338);
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
