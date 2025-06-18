//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Mall extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, localize, _triggerWatcherInterval, _INTERFACE, _escalatorHandlerDelegate, _slide1, _slide2, _slide1Trigger, _slide2Trigger, _checkTargetDelegate;
        function Mall (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 155;
            _stage.start_y = 367;
            _stage.customPenguinSize = 90;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 468, 255);
			_stage.triggers_mc.stage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "stage", 115, 340);
            _stage.plaza_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, doorMouseOver);
            _stage.plaza_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, doorMouseOff);
            _stage.plaza_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, doorMouseOff);
            _stage.costumes_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, costumeStoreMouseOver);
            _stage.costumes_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, costumeStoreMouseOff);
            _stage.costumes_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, costumeStoreMouseOff);
			_stage.berry_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, berryStoreMouseOver);
            _stage.berry_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, berryStoreMouseOff);
            _stage.berry_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, berryStoreMouseOff);
            _stage.triggers_mc.costume_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showCatalogue);
			_stage.triggers_mc.berry_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showMallCatalogue);
            _stage.interface_mc.costume_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalogue);
			_stage.interface_mc.berry_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showMallCatalogue);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.plaza_btn, 115, 335), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.berry_btn, 132, 173), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.costumes_btn, 695, 162)]);
            localize([_stage.foreground_mc.langAnvils_mc, _stage.foreground_mc.langFragile_mc, _stage.costumeTrunk_mc, _stage.interface_mc.costume_btn_states]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureSlideFunctionality();
            configureSnowballTracking();
        }
        function doorMouseOver() {
            _stage.background_mc.door_mc.gotoAndStop(2);
        }
        function doorMouseOff() {
            _stage.background_mc.door_mc.gotoAndStop(1);
        }
		function berryStoreMouseOver() {
            _stage.berryGlow_mc.gotoAndStop(2);
			_stage.register_mc.gotoAndStop(2);
        }
        function berryStoreMouseOff() {
            _stage.berryGlow_mc.gotoAndStop(1);
			_stage.register_mc.gotoAndStop(1);
        }
        function costumeStoreMouseOver() {
            _stage.costumeTrunk_mc.costumeState_mc.gotoAndStop(2);
            _stage.storeGlow_mc.gotoAndStop(2);
        }
        function costumeStoreMouseOff() {
            _stage.costumeTrunk_mc.costumeState_mc.gotoAndStop(1);
            _stage.storeGlow_mc.gotoAndStop(1);
        }
        function showCatalogue() {
            trace(CLASS_NAME + ": showCatalogue()");
            _INTERFACE.showContent("costume_catalogue");
        }
		function showMallCatalogue() {
            _INTERFACE.showContent("mall_catalogue");
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _global.getCurrentAirtower().removeListener(SLIDE_COMMAND, _escalatorHandlerDelegate);
        }
        function configureSlideFunctionality() {
            var _local_3 = 1;
            while (_local_3 <= 2) {
                this["_slide" + _local_3] = new com.clubpenguin.world.rooms.common.slide.ConveyorBelt();
                this["_slide" + _local_3].updatePenguinFrames = false;
                _local_3++;
            }
            _slide1.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSlideTeleport, 1), true);
            _slide2.registerFrameTrigger(2, com.clubpenguin.util.Delegate.create(this, playSlideTeleport, 2), true);
            _slide1.registerFrameTrigger(3, com.clubpenguin.util.Delegate.create(this, playSlideSFX, 1), true);
            _slide2.registerFrameTrigger(3, com.clubpenguin.util.Delegate.create(this, playSlideSFX, 2), true);
            _escalatorHandlerDelegate = com.clubpenguin.util.Delegate.create(this, handlePenguinOnSlide);
            _global.getCurrentAirtower().addListener(SLIDE_COMMAND, _escalatorHandlerDelegate);
            configureSlideTriggers();
        }
        function playSlideTeleport(slideNum) {
        }
        function playSlideSFX(slideNum) {
        }
        function configureSlideTriggers() {
            _slide1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.escalator_trigger_1);
            _slide1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide, 1));
            _triggerWatcher.addTrigger(_slide1Trigger);
            _slide2Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.escalator_trigger_2);
            _slide2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, sendAddPlayerToSlide, 2));
            _triggerWatcher.addTrigger(_slide2Trigger);
        }
        function configureSnowballTracking() {
            _checkTargetDelegate = com.clubpenguin.util.Delegate.create(this, onSnowballLand);
            _SHELL.addListener(_SHELL.BALL_LAND, _checkTargetDelegate);
        }
        function sendAddPlayerToSlide(players, slideNum) {
            var _local_3 = 0;
            while (_local_3 < players.length) {
                if (players[_local_3] == _SHELL.getMyPlayerId()) {
                    var _local_4 = _global.getCurrentAirtower();
                    _local_4.send(_local_4.PLAY_EXT, "u#" + SLIDE_COMMAND, [slideNum], "str", _SHELL.getCurrentServerRoomId());
                }
                _local_3++;
            }
        }
        function handlePenguinOnSlide(data) {
            var _local_3 = Number(data[1]);
            var _local_2 = Number(data[2]);
            this["_slide" + _local_2].addPenguintoConveyorPather("Escalator_Path_" + _local_2, _local_3, _stage.slideContainerMC);
            data = null;
        }
        function onSnowballLand(snowballInfo) {
            trace((("Gym.onSnowballLand: " + snowballInfo.player_id) + " ") + _SHELL.getMyPlayerId());
            var _local_3 = snowballInfo.player_id;
            if (_SHELL.getMyPlayerId() == _local_3) {
                if (_stage.foreground_mc.fountain_collider.hitTest(snowballInfo.x, snowballInfo.y, true) == true) {
                    com.clubpenguin.world.rooms2014.school.SchoolParty.playSound(_stage, "sfx_coin_water_" + Math.ceil(Math.random() * 3));
                } else {
                    com.clubpenguin.world.rooms2014.school.SchoolParty.playSound(_stage, "sfx_coin_" + Math.ceil(Math.random() * 3));
                }
            }
        }
        static var CLASS_NAME = "Mall";
        static var SLIDE_COMMAND = "followpath";
    }
