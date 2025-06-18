//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.holiday2011.Bakery extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _SHELL, _INTERFACE, _opcodeJournal, _servingLocation0, _servingLocation1, _servingLocation2, _bakerTriggers, _destroyDelegate, _conveyorCountdown, _cookiesAmount;
        function Bakery (stageReference) {
            super(stageReference);
            _stage.start_x = 360;
            _stage.start_y = 385;
            localize([_stage.background_mc.staffOnly_mc, _stage.background_mc.purpleMachine.localizedFrames, _stage.background_mc.cookieCounter.localizedFrames, _stage.background_mc.ovenOutside.ovenInside]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lounge_btn, 75, 378), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.loungeStaff_btn, 92, 241), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool1, 289, 334), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool2, 340, 334), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool3, 394, 334), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool4, 452, 334), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool5, 504, 334), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stool6, 558, 334)]);
            _stage.stool1.useHandCursor = false;
            _stage.stool2.useHandCursor = false;
            _stage.stool3.useHandCursor = false;
            _stage.stool4.useHandCursor = false;
            _stage.stool5.useHandCursor = false;
            _stage.stool6.useHandCursor = false;
            _stage.triggers_mc.lounge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
            _stage.triggers_mc.aprons_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, awardItem);
            if (!_SHELL) {
                init();
            }
        }
        function exit() {
            _SHELL.sendJoinRoom("lounge", 625, 275);
        }
        function awardItem() {
            _INTERFACE.buyInventory(93076);
        }
        function init() {
            _opcodeJournal = new com.clubpenguin.world.rooms.common.OpcodeJournal();
            var _local_2 = _SHELL.getMyPlayerId();
            _opcodeJournal.init(_local_2);
            cookiesAmount = (3);
            _stage.background_mc.ovenOutside.ovenInside.onRelease = com.clubpenguin.util.Delegate.create(this, gingerbreadOvenClicked);
            _stage.background_mc.ovenOutside.gingerbreadIgloo_mc.gingerbreadIgloo_btn.onRelease = com.clubpenguin.util.Delegate.create(this, gingerbreadHouseClicked);
            _servingLocation0 = new com.clubpenguin.world.rooms.holiday2011.WaitedBakery(com.clubpenguin.util.Delegate.create(this, serveCookies), _stage.counter.plate0, _stage.triggers_mc.server0, [_stage.triggers_mc.stool00, _stage.triggers_mc.stool01]);
            _servingLocation0.cookiesServed();
            _servingLocation0.init();
            _servingLocation1 = new com.clubpenguin.world.rooms.holiday2011.WaitedBakery(com.clubpenguin.util.Delegate.create(this, serveCookies), _stage.counter.plate1, _stage.triggers_mc.server1, [_stage.triggers_mc.stool10, _stage.triggers_mc.stool11]);
            _servingLocation1.cookiesServed();
            _servingLocation1.init();
            _servingLocation2 = new com.clubpenguin.world.rooms.holiday2011.WaitedBakery(com.clubpenguin.util.Delegate.create(this, serveCookies), _stage.counter.plate2, _stage.triggers_mc.server2, [_stage.triggers_mc.stool20, _stage.triggers_mc.stool21]);
            _servingLocation2.cookiesServed();
            _servingLocation2.init();
            _bakerTriggers = com.clubpenguin.world.rooms.common.TriggerCheck.fetchInstance();
            _bakerTriggers.addTrigger(_stage.triggers_mc.baker0, com.clubpenguin.util.Delegate.create(this, playerOverBakerTrigger, 0));
            _bakerTriggers.addTrigger(_stage.triggers_mc.baker1, com.clubpenguin.util.Delegate.create(this, playerOverBakerTrigger, 1));
            _bakerTriggers.addTrigger(_stage.triggers_mc.baker2, com.clubpenguin.util.Delegate.create(this, playerOverBakerTrigger, 2));
            _bakerTriggers.init();
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _servingLocation0.destroy();
            _servingLocation1.destroy();
            _servingLocation2.destroy();
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        function gingerbreadOvenClicked() {
            _stage.background_mc.ovenOutside.gotoAndPlay("play");
            _stage.background_mc.ovenOutside.ovenInside.onRelease = null;
        }
        function gingerbreadHouseClicked() {
            if (!_SHELL.isMyPlayerMember()) {
                _INTERFACE.showContent("oops_party2_room");
                return(undefined);
            }
            _opcodeJournal.sendOpcodeHolidayBakeryBakeIgloo();
            _INTERFACE.buyIglooUpgrade(GINGERBREAD_IGLOO_ID);
        }
        function playerOverBakerTrigger(playerID, players, triggerID) {
            var _local_2 = this[MACHINE_OCCUPIED + triggerID];
            var _local_5;
            if ((_local_2 && (players.length > 0)) || ((!_local_2) && (players.length == 0))) {
                return(undefined);
            }
            this[MACHINE_OCCUPIED + triggerID] = !_local_2;
            if (!_local_2) {
                _local_5 = MACHINE_STATE_SHOW;
            } else {
                _local_5 = MACHINE_STATE_HIDE;
            }
            machineChangeState(triggerID, _local_5);
        }
        function machineChangeState(machineID, newState) {
            _stage.background_mc[MACHINE_CLIP_PREFIX + machineID].states.gotoAndPlay(newState);
        }
        function handleThrow(ball) {
            var _local_2 = 0;
            while (_local_2 < MACHINES_AMOUNT) {
                if (!this[MACHINE_OCCUPIED + _local_2]) {
                } else {
                    var _local_3 = _stage.background_mc[MACHINE_CLIP_PREFIX + _local_2];
                    if (_local_3.states.target.hitTest(ball._x, ball._y, true)) {
                        targetHit(_local_2, _local_3);
                        ball._visible = false;
                        return(undefined);
                    }
                }
                _local_2++;
            }
        }
        function targetHit(machineID, machineClip) {
            _targetsHit++;
            if (_targetsHit >= TARGET_CHAMP_AMOUNT) {
                _SHELL.stampEarned(TARGET_CHAMP_STAMP_ID);
            }
            machineClip.play();
            machineClip.states.gotoAndPlay(MACHINE_STATE_SPIN);
            if (_beltStopped) {
                if (!this[MACHINE_ACTIVE + machineID]) {
                    machineClip.light.gotoAndPlay(LIGHT_STATE_GREEN);
                    _stage.background_mc.conveyor[COOKIES_CLIP_PREFIX + machineID].cookies.gotoAndPlay(DOUGH_STATE_DURING);
                }
                this[MACHINE_ACTIVE + machineID] = true;
                checkProgress();
            }
        }
        function checkProgress() {
            var _local_2 = 0;
            while (_local_2 < MACHINES_AMOUNT) {
                if (!this[MACHINE_ACTIVE + _local_2]) {
                    return(undefined);
                }
                _local_2++;
            }
            makeCookies();
        }
        function makeCookies() {
            var _local_2 = 0;
            while (_local_2 < MACHINES_AMOUNT) {
                _stage.background_mc[MACHINE_CLIP_PREFIX + _local_2].light.gotoAndPlay(LIGHT_STATE_RED);
                _stage.background_mc.conveyor[COOKIES_CLIP_PREFIX + _local_2].gotoAndPlay(DOUGH_STATE_CONVEY);
                this[MACHINE_ACTIVE + _local_2] = false;
                _local_2++;
            }
            _stage.background_mc.conveyor.play();
            _beltStopped = false;
            cookiesAmount = ((cookiesAmount+1));
            _conveyorCountdown = CONVEYOR_FRAMES;
            _stage.background_mc.conveyor.onEnterFrame = com.clubpenguin.util.Delegate.create(this, conveyorCountdown);
        }
        function conveyorCountdown() {
            _conveyorCountdown--;
            if (_conveyorCountdown <= 0) {
                _beltStopped = true;
                _stage.background_mc.conveyor.onEnterFrame = null;
            }
        }
        function serveCookies() {
            if (cookiesAmount > 0) {
                cookiesAmount = ((cookiesAmount-1));
                return(true);
            } else {
                _stage.background_mc.cookieCounter.screen.play();
                return(false);
            }
        }
        function set cookiesAmount(value) {
            _cookiesAmount = value;
            _stage.background_mc.cookieCounter.screen.cookiesAmount.text = String(value);
            //return(cookiesAmount);
        }
        function get cookiesAmount() {
            return(_cookiesAmount);
        }
        static var CLASS_NAME = "Bakery";
        static var GINGERBREAD_IGLOO_ID = 43;
        static var MACHINE_OCCUPIED = "_machineOccupied";
        static var MACHINE_ACTIVE = "_machineActive";
        static var MACHINE_CLIP_PREFIX = "machine";
        static var COOKIES_CLIP_PREFIX = "cookies";
        static var MACHINE_STATE_PARK = "park";
        static var MACHINE_STATE_SHOW = "targetShow";
        static var MACHINE_STATE_SPIN = "targetSpin";
        static var MACHINE_STATE_HIDE = "targetHide";
        static var LIGHT_STATE_GREEN = "greenOn";
        static var LIGHT_STATE_RED = "redOn";
        static var DOUGH_STATE_CONVEY = "convey";
        static var DOUGH_STATE_DURING = "during";
        static var CONVEYOR_FRAMES = 87;
        static var TARGET_CHAMP_AMOUNT = 50;
        static var TARGET_CHAMP_STAMP_ID = 185;
        static var MACHINES_AMOUNT = 3;
        var _machineOccupied0 = false;
        var _machineOccupied1 = false;
        var _machineOccupied2 = false;
        var _machineActive0 = false;
        var _machineActive1 = false;
        var _machineActive2 = false;
        var _targetsHit = 0;
        var _beltStopped = true;
    }
