class com.clubpenguin.world.rooms2014.music.DeckStage extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, localize, _triggerWatcherInterval, musicJamPerformances;
    function DeckStage(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms2014.music.DeckStage.CLASS_NAME + "()");
        _stage.start_x = 525;
        _stage.start_y = 260;
        if (!_SHELL)
        {
            this.init();
        } // end if
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms2014.music.DeckStage.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
        _stage.triggers_mc.lobby_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 360, 350);
        _stage.triggers_mc.pool_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 70, 215);
        _stage.triggers_mc.game_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchGame);
        _stage.triggers_mc.mic_1.triggerFunction = com.clubpenguin.util.Delegate.create(this, playMicCheck);
        _stage.triggers_mc.mic_2.triggerFunction = com.clubpenguin.util.Delegate.create(this, playMicCheck);
        _stage.lobby_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, exit1MouseOver);
        _stage.lobby_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, exit1MouseOff);
        _stage.lobby_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, exit1MouseOff);
        _stage.game_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, gameMouseOver);
        _stage.game_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, gameMouseOff);
        _stage.game_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, gameMouseOff);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lobby_btn, 730, 405), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.game_btn, 505, 126)]);
        this.localize([_stage.background_mc.scheduleText_mc.langNext_mc, _stage.background_mc.scheduleText_mc.langPerforming_mc, _stage.background_mc.scheduleText_mc.langFollowed_mc, _stage.background_mc.schedule_mc.timer_mc.timerbitmap_mc.minutes_mc.langMins_mc, _stage.background_mc.schedule_mc.timer_mc.timerbitmap_mc.minutes_mc.langMin_mc, _stage.dj_game_mc.dj_game_state_mc.dj_game_logo_mc]);
        clearInterval(_triggerWatcherInterval);
        _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        musicJamPerformances = new com.clubpenguin.world.rooms2014.music.MusicJamPerformances(_stage);
    } // End of the function
    function playMicCheck()
    {
        var _loc3 = random(2);
        if (_loc3 == 1)
        {
            _global.getCurrentParty().BaseParty.playSound(_stage.mic_1, "sfx_mic_" + random(2));
        } // end if
    } // End of the function
    function exit1MouseOver()
    {
        _stage.foreground_mc.elevator_mc.gotoAndPlay(2);
    } // End of the function
    function exit1MouseOff()
    {
        _stage.foreground_mc.elevator_mc.gotoAndPlay(16);
    } // End of the function
    function launchGame()
    {
        _global.getCurrentParty().MusicParty.launchMusicGame();
    } // End of the function
    function gameMouseOver()
    {
        _stage.dj_game_mc.gotoAndStop(2);
    } // End of the function
    function gameMouseOff()
    {
        _stage.dj_game_mc.gotoAndStop(1);
    } // End of the function
    function exit(roomName, x, y)
    {
        trace (com.clubpenguin.world.rooms2014.music.DeckStage.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms2014.music.DeckStage.CLASS_NAME + ": destroy()");
        clearInterval(_triggerWatcherInterval);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        musicJamPerformances.clean();
        false;
    } // End of the function
    static var CLASS_NAME = "DeckStage";
    static var PERFORMING_FRAME = 1;
    static var WAVING_FRAME = 2;
} // End of Class
