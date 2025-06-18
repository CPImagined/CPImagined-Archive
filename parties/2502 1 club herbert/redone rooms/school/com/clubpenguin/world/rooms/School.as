//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.School extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, localize, setupNavigationButtons, _triggerWatcherInterval;
        function School (stageReference) {
            super(stageReference);
            _stage.start_x = 190;
            _stage.start_y = 360;
            init();
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            localize([_stage.background_mc.bannerWords_mc]);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 250, 240);
            _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 640, 150);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorleft_btn, 44, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorright_btn, 716, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker1_btn, 70, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker2_btn, 125, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker3_btn, 187, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker4_btn, 248, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker5_btn, 306, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker6_btn, 450, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker7_btn, 506, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker8_btn, 566, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker9_btn, 630, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker10_btn, 682, 412)]);
            _stage.foreground_mc.locker1_btn.useHandCursor = false;
            _stage.foreground_mc.locker2_btn.useHandCursor = false;
            _stage.foreground_mc.locker3_btn.useHandCursor = false;
            _stage.foreground_mc.locker4_btn.useHandCursor = false;
            _stage.foreground_mc.locker5_btn.useHandCursor = false;
            _stage.foreground_mc.locker6_btn.useHandCursor = false;
            _stage.foreground_mc.locker7_btn.useHandCursor = false;
            _stage.foreground_mc.locker8_btn.useHandCursor = false;
            _stage.foreground_mc.locker9_btn.useHandCursor = false;
            _stage.foreground_mc.locker10_btn.useHandCursor = false;
            var _local_2 = 1;
            while (_local_2 <= 10) {
                var _local_4 = new com.clubpenguin.world.rooms.school.Locker(_stage.foreground_mc["lockermc_" + _local_2]);
                var _local_3 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc[("locker" + _local_2) + "_mc"]);
                _local_3.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _local_4));
                _local_3.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _local_3, _local_4));
                _triggerWatcher.addTrigger(_local_3);
                _local_2++;
            }
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configureDailyContent();
            configureBanner();
        }
        function methodToCall() {
        }
        function configureDailyContent() {
            var _local_3 = _SHELL.getPenguinStandardTime();
            var _local_2 = _local_3.getDay() + 1;
            _stage.cafeteriaLight_mc.overheadLight_mc.gotoAndStop(_local_2);
            _stage.background_mc.chalkboard_mc.gotoAndStop(_local_2);
        }
        function configureBanner() {
            var _local_3 = _SHELL.getPenguinStandardTime();
            var _local_2 = getWeek(_local_3) + 1;
            if ((_local_2 % 4) == 1) {
                setBannerColour(1);
            } else if ((_local_2 % 4) == 2) {
                setBannerColour(2);
            } else if ((_local_2 % 4) == 3) {
                setBannerColour(3);
            } else if ((_local_2 % 4) == 0) {
                setBannerColour(4);
            }
        }
        function setBannerColour(frame) {
            _stage.background_mc.banner_mc.gotoAndStop(frame);
            _stage.background_mc.teamPoster_mc.gotoAndStop(frame);
            _stage.wallDivider_mc.teamribbon_mc.gotoAndStop(frame);
            _stage.wallDivider_mc.teamframe_mc.gotoAndStop(frame);
        }
        static function getWeek(date) {
            var _local_3 = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            var _local_5 = date.getFullYear();
            var _local_9 = (((_local_5 % 4) == 0) && ((_local_5 % 100) != 0)) || (((_local_5 % 100) == 0) && ((_local_5 % 400) == 0));
            if (_local_9) {
                _local_3[1]++;
            }
            var _local_2 = 0;
            var _local_1 = 0;
            while (_local_1 < date.getMonth()) {
                _local_2 = _local_2 + _local_3[_local_1];
                _local_1++;
            }
            _local_2 = _local_2 + date.getDate();
            var _local_8 = new Date(_local_5, 0, 1);
            var _local_6 = _local_8.getDay();
            if (_local_6 == 0) {
                _local_6 = 7;
            }
            _local_2 = _local_2 + (_local_6 - 1);
            var _local_7 = Math.round((_local_2 - 1) / 7);
            if (_local_7 == 0) {
                _local_7 = 52;
            }
            return(_local_7);
        }
        function openLocker(players, locker) {
            if (players.length <= 0) {
                return(undefined);
            }
            var _local_1 = 0;
            while (_local_1 < players.length) {
                locker.openLocker(players[_local_1]);
                _local_1++;
            }
        }
        function closeLocker(players, trigger, locker) {
            if (trigger.getPlayerCount() == 0) {
                var _local_1 = 0;
                while (_local_1 < players.length) {
                    locker.closeLocker(players[_local_1]);
                    _local_1++;
                }
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "School";
    }
