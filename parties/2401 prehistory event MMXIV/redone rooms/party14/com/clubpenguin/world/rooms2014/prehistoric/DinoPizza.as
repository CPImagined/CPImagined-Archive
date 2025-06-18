//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.DinoPizza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _ovenTrigger, _sauceTrigger, _doughTrigger, _bonesTrigger, setupNavigationButtons, _triggerWatcherInterval, _ENGINE;
        function DinoPizza (stageReference) {
            super(stageReference);
            _stage.start_x = 393;
            _stage.start_y = 207;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.exit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party6", 555, 290);
            _ovenTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.oven_mc);
            _ovenTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, turnOnOvenPizza));
            _ovenTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, turnOffOvenPizza));
            _triggerWatcher.addTrigger(_ovenTrigger);
            _sauceTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.sauce_mc);
            _sauceTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, turnOnSauce));
            _sauceTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, turnOffSauce));
            _triggerWatcher.addTrigger(_sauceTrigger);
            _doughTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.rollingpin_mc);
            _doughTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playDough));
            _doughTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopDough));
            _triggerWatcher.addTrigger(_doughTrigger);
            _bonesTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.bones_mc);
            _bonesTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playBones));
            _bonesTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopBones));
            _triggerWatcher.addTrigger(_bonesTrigger);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.careStation_mc.careStation_btn, 520, 177), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_btn, 388, 141), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.hotSauce_btn, 168, 148), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.rollingPin_btn, 196, 166)]);
            _stage.background_mc.hotSauce_btn.useHandCursor = false;
            _stage.background_mc.rollingPin_btn.useHandCursor = false;
            _stage.background_mc.careStation_mc.careStation_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToPizzaMachine);
            _stage.triggers_mc.careStation_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showPuffleCareStationMenu);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function moveToPizzaMachine() {
            _ENGINE.sendPlayerMove(520, 178);
        }
        function showPuffleCareStationMenu() {
            var _local_3 = com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_SHELL.getMyPlayerObject(), com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE);
            var _local_5 = null;
            if (_local_3) {
                _local_5 = _SHELL.getMyPlayerObject().attachedPuffle["color"];
            }
            _SHELL.sendOpenAS3Module("puffle_care_station_menu", {isWalkingPuffle:_local_3, puffleColor:_local_5}, {modalBackgroundEnabled:true, hideLoadingDialog:true, blockPuffleNotifications:false, persistent:false});
        }
        function turnOnOvenPizza(playerList) {
            if (playerList.length > 0) {
                _stage.ovenContainer_mc.gotoAndStop(2);
            }
        }
        function turnOffOvenPizza(playerList) {
            if (_ovenTrigger.getPlayerCount() <= 0) {
                _stage.ovenContainer_mc.gotoAndStop(1);
            }
        }
        function turnOnSauce(playerList) {
            if (playerList.length > 0) {
                _stage.background_mc.spout_mc.gotoAndPlay(2);
            }
        }
        function turnOffSauce(playerList) {
            if (_sauceTrigger.getPlayerCount() <= 0) {
                _stage.background_mc.spout_mc.gotoAndStop(1);
            }
        }
        function playDough() {
            if ((_stage.counter_mc.rollingpinAnim_mc._currentframe == 1) && ((_doughTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _doughTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.counter_mc.rollingpinAnim_mc.gotoAndPlay(2);
            }
        }
        function stopDough() {
            if ((_stage.counter_mc.rollingpinAnim_mc._currentframe > 1) && ((_doughTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _doughTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0)) {
                _stage.counter_mc.rollingpinAnim_mc.gotoAndStop(1);
            }
        }
        function playBones() {
            if ((_stage.bonesInstrument_mc._currentframe == 1) && ((_bonesTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _bonesTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > 0)) {
                _stage.bonesInstrument_mc.gotoAndPlay(2);
            }
        }
        function stopBones() {
            if ((_stage.bonesInstrument_mc._currentframe > 1) && ((_bonesTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _bonesTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0)) {
                _stage.bonesInstrument_mc.gotoAndStop(1);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DinoPizza";
    }
