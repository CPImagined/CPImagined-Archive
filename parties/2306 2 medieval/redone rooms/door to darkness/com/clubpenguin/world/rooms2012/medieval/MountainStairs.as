//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.MountainStairs extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, setupNavigationButtons, _garyWaveExplosion, _triggerWatcher, _cave1Trigger, _cave2Trigger, _fallingRockInteval, _roomUpdateInterval, _ENGINE;
        function MountainStairs (stageReference) {
            super(stageReference);
            _stage.start_x = 665;
            _stage.start_y = 420;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.triggers_mc.exit_skihill_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 562, 342);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cave1_btn, 213, 202), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.door_btn, 467, 146), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cave2_btn, 588, 119)]);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _cave1Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.caveblink_mc);
            _cave1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerEnterCave1));
            _cave1Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveCave1));
            _cave2Trigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.cavegrowl_mc);
            _cave2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, onPlayerEnterCave2));
            _cave2Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, onPlayerLeaveCave2));
			//_garyWaveExplosion = new com.clubpenguin.world.rooms2012.common.triggers.PlayerTrigger(_stage.triggers_mc.chirpdoor_mc);
			//_garyWaveExplosion.requireAction(com.clubpenguin.world.rooms2012.common.triggers.PlayerAction.WAVING);
			//_garyWaveExplosion.playersStanding.add(com.clubpenguin.util.Delegate.create(this, showGaryExplosion));
			//_triggerWatcher.addTrigger(_garyWaveExplosion);
            _triggerWatcher.addTrigger(_cave1Trigger);
            _triggerWatcher.addTrigger(_cave2Trigger);
            clearInterval(_fallingRockInteval);
            _fallingRockInteval = setInterval(this, "onFallingRockInterval", Math.floor(Math.random() * 30000) + 11000);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 80);
        }
		//function showGaryExplosion() {
		//	_stage.rockcover_mc.bigDoor.gotoAndPlay(2);
		//	_stage.triggers_mc.gotoAndStop(4);
		//}
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function onFallingRockInterval() {
            clearInterval(_fallingRockInteval);
            _fallingRockInteval = setInterval(this, "onFallingRockInterval", Math.floor(Math.random() * 30000) + 11000);
            if (_stage.background_mc.fallingRock._currentframe == 1) {
                _stage.background_mc.fallingRock.gotoAndPlay(2);
            }
        }
        function onPlayerEnterCave2(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getPlayerMovieClip(playerList[_local_2])._visible = false;
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = false;
                _local_2++;
            }
            if (_stage.growlEffect._currentframe == 1) {
                _stage.growlEffect.gotoAndPlay(2);
            }
        }
        function onPlayerLeaveCave2(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getPlayerMovieClip(playerList[_local_2])._visible = true;
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = true;
                _local_2++;
            }
        }
        function onPlayerEnterCave1(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getPlayerMovieClip(playerList[_local_2])._visible = false;
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = false;
                _local_2++;
            }
            if (_stage.caveEyeBlink._currentframe == 1) {
                _stage.caveEyeBlink.gotoAndPlay(2);
            }
        }
        function onPlayerLeaveCave1(playerList) {
            var _local_2 = 0;
            while (_local_2 < playerList.length) {
                _ENGINE.getPlayerMovieClip(playerList[_local_2])._visible = true;
                _ENGINE.getNicknameMovieClip(playerList[_local_2])._visible = true;
                _local_2++;
            }
            if (_cave1Trigger.getPlayerCount <= 0) {
                _stage.caveEyeBlink.gotoAndStop(1);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            clearInterval(_fallingRockInteval);
            clearInterval(_roomUpdateInterval);
        }
        static var CLASS_NAME = "MountainStairs";
    }
