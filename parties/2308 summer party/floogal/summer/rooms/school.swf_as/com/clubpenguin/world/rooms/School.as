dynamic class com.clubpenguin.world.rooms.School extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "School";
    var _SHELL;
    var _destroyDelegate;
    var _stage;
    var _triggerWatcher;
    var _triggerWatcherInterval;
    var localize;
    var setupNavigationButtons;

    function School(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 190;
        this._stage.start_y = 360;
        this.init();
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(this._stage, this._SHELL);
        this.localize([this._stage.background_mc.bannerWords_mc]);
        this._stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "shack", 250, 240);
        this._stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "rink", 640, 150);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.bob_mc.doorleft_btn, 44, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.bob_mc.doorright_btn, 716, 366), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker1_btn, 70, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker2_btn, 125, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker3_btn, 187, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker4_btn, 248, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker5_btn, 306, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker6_btn, 450, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker7_btn, 506, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker8_btn, 566, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker9_btn, 630, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.foreground_mc.locker10_btn, 682, 412)]);
        this._stage.foreground_mc.locker1_btn.useHandCursor = false;
        this._stage.foreground_mc.locker2_btn.useHandCursor = false;
        this._stage.foreground_mc.locker3_btn.useHandCursor = false;
        this._stage.foreground_mc.locker4_btn.useHandCursor = false;
        this._stage.foreground_mc.locker5_btn.useHandCursor = false;
        this._stage.foreground_mc.locker6_btn.useHandCursor = false;
        this._stage.foreground_mc.locker7_btn.useHandCursor = false;
        this._stage.foreground_mc.locker8_btn.useHandCursor = false;
        this._stage.foreground_mc.locker9_btn.useHandCursor = false;
        this._stage.foreground_mc.locker10_btn.useHandCursor = false;
        var __reg3 = 1;
        while (__reg3 <= 10) 
        {
            var __reg4 = new com.clubpenguin.world.rooms.school.Locker(this._stage.foreground_mc["lockermc_" + __reg3]);
            var __reg2 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(this._stage.triggers_mc["locker" + __reg3 + "_mc"]);
            __reg2.playersAdded.add(com.clubpenguin.util.Delegate.create(this, this.openLocker, __reg4));
            __reg2.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, this.closeLocker, __reg2, __reg4));
            this._triggerWatcher.addTrigger(__reg2);
            ++__reg3;
        }
        clearInterval(this._triggerWatcherInterval);
        this._triggerWatcherInterval = setInterval(this._triggerWatcher, "checkAllPlayers", 40);
        this.configureDailyContent();
        this.configureBanner();
    }

    function methodToCall()
    {
    }

    function configureDailyContent()
    {
        var __reg3 = this._SHELL.getPenguinStandardTime();
        var __reg2 = __reg3.getDay() + 1;
        this._stage.cafeteriaLight_mc.overheadLight_mc.gotoAndStop(__reg2);
        this._stage.background_mc.chalkboard_mc.gotoAndStop(__reg2);
    }

    function configureBanner()
    {
        var __reg3 = this._SHELL.getPenguinStandardTime();
        var __reg2 = com.clubpenguin.world.rooms.School.getWeek(__reg3) + 1;
        if (__reg2 % 4 == 1) 
        {
            this.setBannerColour(1);
            return undefined;
        }
        if (__reg2 % 4 == 2) 
        {
            this.setBannerColour(2);
            return undefined;
        }
        if (__reg2 % 4 == 3) 
        {
            this.setBannerColour(3);
            return undefined;
        }
        if (__reg2 % 4 == 0) 
        {
            this.setBannerColour(4);
        }
    }

    function setBannerColour(frame)
    {
        this._stage.background_mc.banner_mc.gotoAndStop(frame);
        this._stage.background_mc.teamPoster_mc.gotoAndStop(frame);
        this._stage.wallDivider_mc.teamribbon_mc.gotoAndStop(frame);
        this._stage.wallDivider_mc.teamframe_mc.gotoAndStop(frame);
    }

    static function getWeek(date)
    {
        var __reg3 = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        var __reg5 = date.getFullYear();
        var __reg8 = (__reg5 % 4 == 0 && __reg5 % 100 != 0) || (__reg5 % 100 == 0 && __reg5 % 400 == 0);
        if (__reg8) 
        {
            ++__reg3[1];
        }
        var __reg2 = 0;
        var __reg1 = 0;
        while (__reg1 < date.getMonth()) 
        {
            __reg2 = __reg2 + __reg3[__reg1];
            ++__reg1;
        }
        __reg2 = __reg2 + date.getDate();
        var __reg9 = new Date(__reg5, 0, 1);
        var __reg7 = __reg9.getDay();
        if (__reg7 == 0) 
        {
            __reg7 = 7;
        }
        __reg2 = __reg2 + (__reg7 - 1);
        var __reg6 = Math.round((__reg2 - 1) / 7);
        if (__reg6 == 0) 
        {
            __reg6 = 52;
        }
        return __reg6;
    }

    function openLocker(players, locker)
    {
        if (players.length > 0) 
        {
            var __reg1 = 0;
            for (;;) 
            {
                if (__reg1 >= players.length) 
                {
                    return undefined;
                }
                locker.openLocker(players[__reg1]);
                ++__reg1;
            }
        }
    }

    function closeLocker(players, trigger, locker)
    {
        if (trigger.getPlayerCount() == 0) 
        {
            var __reg1 = 0;
            for (;;) 
            {
                if (__reg1 >= players.length) 
                {
                    return undefined;
                }
                locker.closeLocker(players[__reg1]);
                ++__reg1;
            }
        }
    }

    function exit(roomName, x, y)
    {
        this._SHELL.sendJoinRoom(roomName, x, y);
    }

    function destroy()
    {
        clearInterval(this._triggerWatcherInterval);
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        false;
    }

}
