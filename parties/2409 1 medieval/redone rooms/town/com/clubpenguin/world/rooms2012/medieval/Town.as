//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Town extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _PARTY,  _SHELL, localize, setupNavigationButtons, _triggerWatcher, _dragonFireTrigger, _beanstalkUnlockTrigger, _roomUpdateInterval, _opcodeJournal, _beanstalkTimeout, _beanstalkUnlocked, _ENGINE;
        function Town (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 350;
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            if (_PARTY.getTaskComplete(7)) {
                setToDragonDefeatedState();
            };
            _stage.beanstalkAll.beanstalk_mc2._visible = false;
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "coffee", 365, 205);
            _stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dance", 125, 272);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shop", 395, 220);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 220, 285);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 600, 346);
            _stage.triggers_mc.beanstalk_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party27", 35, 270);
            localize([_stage.clubsign_mc, _stage.marketsign_mc, _stage.beanstalkAll.coffeesign_mc, _stage.leftbuildings_mc.beanstalk_mc.beansack_mc, _stage.leftbuildings_mc.beanstalk_mc.beansack2_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.coffeedoor_btn, 230, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.clubdoor_mc.clubdoor_btn, 400, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.market_btn, 535, 240)]);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _dragonFireTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.guarddragon_mc);
            _dragonFireTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, dragonFireAnimation));
            _beanstalkUnlockTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.skykingdom);
            _beanstalkUnlockTrigger.addClothingRequirement("hand", com.clubpenguin.world.rooms2012.medieval.MedievalParty.SKYWARD_STAFF_ID);
            _beanstalkUnlockTrigger.playersStanding.add(com.clubpenguin.util.Delegate.create(this, unlockBeanstalk));
            _triggerWatcher.addTrigger(_beanstalkUnlockTrigger);
            _triggerWatcher.addTrigger(_dragonFireTrigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function unlockBeanstalk(playerList) {
            if (playerList.length <= 0) {
                return(undefined);
            }
            clearInterval(_beanstalkTimeout);
            _beanstalkTimeout = setInterval(this, "onBeanstalkTimeout", 5000);
            if (!_beanstalkUnlocked) {
                _beanstalkUnlocked = true;
                _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.medieval.OpcodeJournal.MEMBER_UNLOCKS_SKY_KINGDOM);
                _stage.beanstalkAll.beanstalk_mc._visible = true;
                _stage.beanstalkAll.beanstalk_mc2._visible = false;
                _stage.beanstalkAll.beanstalk_mc.gotoAndPlay(2);
                _stage.block_mc.gotoAndStop(2);
            }
        }
        function onBeanstalkTimeout() {
            clearInterval(_beanstalkTimeout);
            _stage.beanstalkAll.beanstalk_mc._visible = false;
            _stage.beanstalkAll.beanstalk_mc2._visible = true;
            _stage.beanstalkAll.beanstalk_mc2.gotoAndPlay(2);
            _stage.block_mc.gotoAndStop(1);
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            if (_stage.block_mc.hitTest(_local_2.x, _local_2.y, true)) {
                _ENGINE.sendPlayerTeleport(240, 290);
            }
            _beanstalkUnlocked = false;
        }
        function setToDragonDefeatedState() {
            _stage.background_mc.leftbuildings_mc.tallbanner_02.gotoAndStop(2);
            _stage.leftbuildings_mc.beanstalk_mc.gotoAndStop(2);
            _stage.banner03.gotoAndStop(2);
            _stage.banner01.gotoAndStop(2);
            _stage.banner02.gotoAndStop(2);
            _stage.tallbanner_01.gotoAndStop(2);
            _stage.background_mc.mountain.gotoAndStop(2);
        }
        function dragonFireAnimation() {
            if (_stage.dragonfire_mc._currentframe == 1) {
                _stage.dragonfire_mc.gotoAndPlay(2);
            }
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_beanstalkTimeout);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "Town";
    }
