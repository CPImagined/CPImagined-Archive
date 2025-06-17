class com.clubpenguin.world.rooms2014.school.Hallway extends com.clubpenguin.world.rooms2014.school.SchoolRoom
{
    var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
    function Hallway(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms2014.school.Hallway.CLASS_NAME + "()");
        _stage.start_x = 190;
        _stage.start_y = 360;
        this.init();
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms2014.school.Hallway.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
        _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 250, 240);
        _stage.triggers_mc.rink_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "rink", 640, 150);
        _stage.triggers_mc.gym_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "gym", 190, 150);
        _stage.triggers_mc.classroom_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "classroom", 170, 170);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob1_mc.doorleft_btn, 33, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.bob_mc.doorright_btn, 710, 360), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.classDoor_mc.classDoor_btn, 640, 200), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.gymDoor_mc.gymDoor_btn, 400, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker1_btn, 70, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker2_btn, 125, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker3_btn, 187, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker4_btn, 248, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker5_btn, 306, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker6_btn, 450, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker7_btn, 506, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker8_btn, 566, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker9_btn, 630, 412), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.locker10_btn, 682, 412)]);
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
        for (var _loc3 = 1; _loc3 <= 10; ++_loc3)
        {
            var _loc5 = new com.clubpenguin.world.rooms.school.Locker(_stage.foreground_mc["lockermc_" + _loc3]);
            var _loc4 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc["locker" + _loc3 + "_mc"]);
            _loc4.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _loc5));
            _loc4.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _loc4, _loc5));
            _triggerWatcher.addTrigger(_loc4);
        } // end of for
        clearInterval(_triggerWatcherInterval);
        _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        this.configureDailyContent();
        this.configureBanner();
        super.configureRoomElements();
    } // End of the function
    function methodToCall()
    {
    } // End of the function
    function configureDailyContent()
    {
        var _loc3 = _SHELL.getPenguinStandardTime();
        var _loc2 = _loc3.getDay() + 1;
        trace ("The day is " + _loc2);
        _stage.cafeteriaLight_mc.overheadLight_mc.gotoAndStop(_loc2);
        _stage.background_mc.chalkboard_mc.gotoAndStop(_loc2);
    } // End of the function
    function configureBanner()
    {
        var _loc3 = _SHELL.getPenguinStandardTime();
        var _loc2 = com.clubpenguin.world.rooms2014.school.Hallway.getWeek(_loc3) + 1;
        if (_loc2 % 4 == 1)
        {
            this.setBannerColour(1);
        }
        else if (_loc2 % 4 == 2)
        {
            this.setBannerColour(2);
        }
        else if (_loc2 % 4 == 3)
        {
            this.setBannerColour(3);
        }
        else if (_loc2 % 4 == 0)
        {
            this.setBannerColour(4);
        } // end else if
    } // End of the function
    function setBannerColour(frame)
    {
        _stage.background_mc.banner_mc.gotoAndStop(frame);
        _stage.background_mc.teamPoster_mc.gotoAndStop(frame);
        _stage.wallDivider_mc.teamribbon_mc.gotoAndStop(frame);
        _stage.wallDivider_mc.teamframe_mc.gotoAndStop(frame);
    } // End of the function
    static function getWeek(date)
    {
        var _loc3 = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        var _loc5 = date.getFullYear();
        var _loc9 = _loc5 % 4 == 0 && _loc5 % 100 != 0 || _loc5 % 100 == 0 && _loc5 % 400 == 0;
        if (_loc9)
        {
            ++_loc3[1];
        } // end if
        var _loc2 = 0;
        for (var _loc1 = 0; _loc1 < date.getMonth(); ++_loc1)
        {
            _loc2 = _loc2 + _loc3[_loc1];
        } // end of for
        _loc2 = _loc2 + date.getDate();
        var _loc8 = new Date(_loc5, 0, 1);
        var _loc6 = _loc8.getDay();
        if (_loc6 == 0)
        {
            _loc6 = 7;
        } // end if
        _loc2 = _loc2 + (_loc6 - 1);
        var _loc7 = Math.round((_loc2 - 1) / 7);
        if (_loc7 == 0)
        {
            _loc7 = 52;
        } // end if
        return (_loc7);
    } // End of the function
    function openLocker(players, locker)
    {
        trace ("open locker");
        if (players.length <= 0)
        {
            return;
        } // end if
        for (var _loc1 = 0; _loc1 < players.length; ++_loc1)
        {
            locker.openLocker(players[_loc1]);
        } // end of for
    } // End of the function
    function closeLocker(players, trigger, locker)
    {
        if (trigger.getPlayerCount() == 0)
        {
            for (var _loc1 = 0; _loc1 < players.length; ++_loc1)
            {
                locker.closeLocker(players[_loc1]);
            } // end of for
        } // end if
    } // End of the function
    function exit(roomName, x, y)
    {
        trace (com.clubpenguin.world.rooms2014.school.Hallway.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms2014.school.Hallway.CLASS_NAME + ": destroy()");
        clearInterval(_triggerWatcherInterval);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        false;
    } // End of the function
    static var CLASS_NAME = "Hallway";
} // End of Class
