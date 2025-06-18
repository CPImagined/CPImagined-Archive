//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.medieval.Bridge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _PARTY, _parallaxClips, _originalParallaxClipXPos, _originalParallaxClipYPos, setupNavigationButtons, localize, _triggerWatcher, _ropeSnapTrigger, _plankSnaptrigger, _roomUpdateInterval, _ENGINE, _INTERFACE;
        function Bridge (stageReference) {
            super(stageReference);
            _stage.start_x = 90;
            _stage.start_y = 424;
        }
        function init() {
			_PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            if (_PARTY.getTaskComplete(7)) {
                setToDragonDefeatedState();
            }
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _parallaxClips = [_stage.background_mc.clouds0, _stage.background_mc.clouds1, _stage.background_mc.clouds2, _stage.background_mc.clouds3, _stage.background_mc.clouds4, _stage.background_mc.clouds5, _stage.background_mc.clouds6, _stage.background_mc.mountain0, _stage.background_mc.clouds7, _stage.background_mc.clouds8, _stage.background_mc.clouds9, _stage.background_mc.mountain1, _stage.background_mc.clouds10, _stage.background_mc.clouds11, _stage.background_mc.clouds12, _stage.background_mc.clouds13, _stage.background_mc.clouds14, _stage.background_mc.mountain2, _stage.background_mc.clouds15, _stage.background_mc.clouds16, _stage.background_mc.clouds17, _stage.background_mc.clouds18, _stage.background_mc.clouds19];
            _originalParallaxClipXPos = [];
            _originalParallaxClipYPos = [];
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.btn_freecape, 475, 320)]);
            localize([_stage.foreground_mc.free_mc]);
            var _local_2 = 0;
            while (_local_2 < _parallaxClips.length) {
                _originalParallaxClipXPos.push(_parallaxClips[_local_2]._x);
                _originalParallaxClipYPos.push(_parallaxClips[_local_2]._y);
                _local_2++;
            }
            _stage.triggers_mc.exits_mountain_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 620, 250);
            _stage.triggers_mc.exit_boss_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party26", 660, 415);
            _stage.triggers_mc.triggeritem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _ropeSnapTrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.rope_mc);
            _ropeSnapTrigger.isLocalPlayerOnly();
            _ropeSnapTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, snapRope));
            _plankSnaptrigger = new com.clubpenguin.world.rooms2012.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.plank_mc);
            _plankSnaptrigger.isLocalPlayerOnly();
            _plankSnaptrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, snapPlank));
            _triggerWatcher.addTrigger(_ropeSnapTrigger);
            _triggerWatcher.addTrigger(_plankSnaptrigger);
            clearInterval(_roomUpdateInterval);
            _roomUpdateInterval = setInterval(this, "update", 40);
        }
        function setToDragonDefeatedState() {
            _stage.background_mc.gotoAndStop(2);
            _stage.foreground_mc.gotoAndStop(2);
            _stage.plank.gotoAndStop(2);
            _stage.rope.gotoAndStop(2);
			_SHELL.startMusicById(39);
        }
        function snapPlank() {
            if (_stage.plank.plank._currentframe == 1) {
                _stage.plank.plank.gotoAndPlay(2);
            }
        }
        function snapRope() {
            if (_stage.rope.rope._currentframe == 1) {
                _stage.rope.rope.gotoAndPlay(2);
            }
        }
        function update() {
            var _local_5 = _ENGINE.getPlayerMovieClip(_SHELL.getMyPlayerId());
            var _local_7 = _local_5._x;
            var _local_6 = _local_5._y;
            var _local_8 = Math.sqrt(Math.pow(_local_7, 2) + Math.pow(480 - _local_6, 2));
            var _local_4 = _local_8 / MAX_MOVE_DISTANCE;
            var _local_2 = 0;
            while (_local_2 < _parallaxClips.length) {
                var _local_3 = 0.1 + (0.9 * (_local_2 / (_parallaxClips.length - 1)));
                _parallaxClips[_local_2]._x = (_originalParallaxClipXPos[_local_2] + MAX_PARALLAX_X) - ((_local_4 * _local_3) * MAX_PARALLAX_X);
                _parallaxClips[_local_2]._y = _originalParallaxClipYPos[_local_2] + ((_local_4 * _local_3) * MAX_PARALLAX_Y);
                _local_2++;
            }
            _triggerWatcher.checkAllPlayers();
        }
        function getFreeItem() {
            _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.medieval.MedievalParty.BATTLE_CAPE_ID);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _quality  = "HIGH";
            clearInterval(_roomUpdateInterval);
        }
        var MAX_MOVE_DISTANCE = 898.888202;
        var MAX_PARALLAX_X = 250;
        var MAX_PARALLAX_Y = 50;
        static var CLASS_NAME = "Bridge";
    }
