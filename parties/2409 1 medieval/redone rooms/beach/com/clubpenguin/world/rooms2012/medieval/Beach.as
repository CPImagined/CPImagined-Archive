//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Beach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _PARTY, _INTERFACE, _mushroomClips, _destroyDelegate, _SHELL, setupNavigationButtons, _triggerWatcher, _wizardLabTrigger, _roomUpdateInterval, _opcodeJournal;
        function Beach (stageReference) {
            super(stageReference);
            _stage.start_x = 480;
            _stage.start_y = 345;
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            if (_PARTY.getTaskComplete(7)) {
                setToDragonDefeatedState();
            }
            if (true) {
                if (_PARTY.getTaskComplete(7) || !_PARTY.getTaskComplete(3) || _PARTY.getTaskComplete(5)) {
                    _stage.sunbeam.gotoAndStop(2);
                    _stage.orbs.gotoAndStop(2);
                } else {
                    _stage.orbs.orbs_btn.onRelease = com.clubpenguin.util.Delegate.create(this, pickUpScavengerHuntItem);
                }
            } else {
                _stage.sunbeam.gotoAndStop(2);
                _stage.orbs.gotoAndStop(3);
            }
            _mushroomClips = [_stage.mushroom1, _stage.mushroom2, _stage.mushroom3, _stage.mushroom4, _stage.mushroom5];
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 70, 260);
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 200, 325);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 125, 415);
            _stage.wateringCan.water_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onWateringCanClick);
            _stage.table.teapot_mc.teapot_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onTeapotClick);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.tower_mc.wizarddoor_btn, 240, 225), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.free_item_btn, 485, 297)]);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _wizardLabTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.lab_mc);
            _wizardLabTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayeOnWizardLabTrigger));
            _triggerWatcher.addTrigger(_wizardLabTrigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.medieval.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function pickUpScavengerHuntItem() {
            if (!_PARTY.getTaskComplete(5)) {
                _stage.sunbeam.gotoAndStop(2);
                _stage.orbs.gotoAndStop(2);
                _PARTY.setTaskComplete(5);
            }
        }
        function onPlayeOnWizardLabTrigger(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                if ((playerList[_local_2] == _SHELL.getMyPlayerId()) && (_SHELL.isPlayerMascotById(_SHELL.getMyPlayerId()))) {
                    _SHELL.sendJoinRoom("light", 440, 190);
                    break;
                }
                _local_2++;
            }
            if (_stage.labExplosion._currentframe == 1) {
                _stage.labExplosion.gotoAndPlay(2);
            }
        }
        function onTeapotClick() {
            if (_stage.table.teapot_mc._currentframe == 1) {
                _stage.table.teapot_mc.gotoAndPlay(2);
            }
        }
        function onWateringCanClick() {
            if (_mushroomClips.length > 0) {
                _stage.wateringCan.gotoAndPlay(2);
                if (_mushroomClips[0]._currentframe == 1) {
                    _mushroomClips[0].gotoAndPlay(2);
                    _mushroomClips.splice(0, 1);
                }
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function setToDragonDefeatedState() {
            _stage.background_mc.mountain.gotoAndStop(2);
            _stage.background_mc.banner3.gotoAndStop(2);
            _stage.scornStatue.gotoAndStop(2);
            _stage.tower_mc.banner1.gotoAndStop(2);
        }
        function destroy() {
            clearInterval(_roomUpdateInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Beach";
    }
