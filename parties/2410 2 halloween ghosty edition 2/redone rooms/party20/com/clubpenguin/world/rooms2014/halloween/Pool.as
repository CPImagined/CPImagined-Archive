//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.halloween.Pool extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _aniStep, setupNavigationButtons, _triggerWatcherInterval, _hintAnimationInterval, _targetArray, _animationArray, _currentPumpkin, _INTERFACE;
        function Pool (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 140;
            _stage.start_y = 270;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.elevator_btn, 55, 230)]);
			_aniStep = 0
            configureArrays();
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _hintAnimationInterval = setInterval(this, "animateHint", 150);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.elevator_btn, 55, 230)]);
        }
        function configureTriggers() {
            _stage.triggers_mc.elevator_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, elevatorUI);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.background_mc.elevator_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, elevatorRollOver);
            _stage.background_mc.elevator_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.background_mc.elevator_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, elevatorRollOut);
            _stage.pumpkinHitArea0_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 0);
            _stage.pumpkinHitArea1_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 1);
            _stage.pumpkinHitArea2_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 2);
            _stage.pumpkinHitArea3_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 3);
            _stage.pumpkinHitArea4_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 4);
            _stage.pumpkinHitArea5_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 5);
            _stage.pumpkinHitArea6_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 6);
            _stage.pumpkinHitArea7_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 7);
            _stage.pumpkinHitArea8_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 8);
            _stage.pumpkinHitArea9_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 9);
            _stage.pumpkinHitArea10_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 10);
            _stage.pumpkinHitArea11_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 11);
            _stage.pumpkinHitArea12_mc.onRelease = com.clubpenguin.util.Delegate.create(this, pumpkinPop, 12);
        }
        function pumpkinPop(x) {
            if (_targetArray[x].lit) {
                _targetArray[x].instance.gotoAndPlay(2);
                _targetArray[x].lit = false;
                _targetArray[x].hitTarget._y = _targetArray[x].hitTarget._y + 480;
            }
        }
        function configureArrays() {
            _targetArray = [{instance:_stage.pumpkin0_mc, hitTarget:_stage.pumpkinHitArea0_mc, lit:false}, {instance:_stage.pumpkin1_mc, hitTarget:_stage.pumpkinHitArea1_mc, lit:false}, {instance:_stage.pumpkin2_mc, hitTarget:_stage.pumpkinHitArea2_mc, lit:false}, {instance:_stage.pumpkin3_mc, hitTarget:_stage.pumpkinHitArea3_mc, lit:false}, {instance:_stage.pumpkin4_mc, hitTarget:_stage.pumpkinHitArea4_mc, lit:false}, {instance:_stage.pumpkin5_mc, hitTarget:_stage.pumpkinHitArea5_mc, lit:false}, {instance:_stage.pumpkin6_mc, hitTarget:_stage.pumpkinHitArea6_mc, lit:false}, {instance:_stage.pumpkin7_mc, hitTarget:_stage.pumpkinHitArea7_mc, lit:false}, {instance:_stage.pumpkin8_mc, hitTarget:_stage.pumpkinHitArea8_mc, lit:false}, {instance:_stage.pumpkin9_mc, hitTarget:_stage.pumpkinHitArea9_mc, lit:false}, {instance:_stage.pumpkin10_mc, hitTarget:_stage.pumpkinHitArea10_mc, lit:false}, {instance:_stage.pumpkin11_mc, hitTarget:_stage.pumpkinHitArea11_mc, lit:false}, {instance:_stage.pumpkin12_mc, hitTarget:_stage.pumpkinHitArea12_mc, lit:false}];
            var _local_2 = 0;
            while (_local_2 < _targetArray.length) {
                _targetArray[_local_2].instance._visible = false;
                _local_2++;
            }
            _animationArray = [{animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:6}, {animate:9}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:2}, {animate:3}, {animate:10}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:15}, {animate:5}, {animate:1}, {animate:7}, {animate:8}, {animate:11}, {animate:4}, {animate:12}, {animate:13}, {animate:16}];
        }
        function animateHint() {
            createPumpkin(_animationArray[_aniStep].animate);
            _aniStep++;
        }
        function createPumpkin(x) {
            if (x == 16) {
                clearInterval(_hintAnimationInterval);
            } else if (x == 2) {
                _currentPumpkin = _targetArray[x - 1];
                _currentPumpkin.instance._visible = true;
                _currentPumpkin.lit = true;
                _stage.foreground_mc.noMove_mc.gotoAndStop(2);
            } else if (x != 15) {
                _currentPumpkin = _targetArray[x - 1];
                _currentPumpkin.instance._visible = true;
                _currentPumpkin.lit = true;
            }
        }
        function elevatorRollOver() {
            trace("roll over");
            if (_stage.background_mc.elevator_mc.door_mc._currentFrame == 1) {
                _stage.background_mc.elevator_mc.door_mc.gotoAndPlay("open");
            } else {
                _stage.background_mc.elevator_mc.door_mc.gotoAndPlay(21 - (_stage.background_mc.elevator_mc.door_mc._currentFrame - 1));
            }
        }
        function elevatorRollOut() {
            if (_stage.background_mc.elevator_mc.door_mc._currentFrame > 9) {
                _stage.background_mc.elevator_mc.door_mc.gotoAndPlay("close");
            } else {
                _stage.background_mc.elevator_mc.door_mc.gotoAndPlay(1 + (21 - _stage.background_mc.elevator_mc.door_mc._currentFrame));
            }
        }
        function elevatorUI() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2014.halloween.party.HalloweenParty.CONSTANTS.ELEVATOR_UI_PATH);
        }
        function showContentPopup(contentID, data) {
            _INTERFACE.showContent(contentID, null, null, data, null);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Pool";
    }
