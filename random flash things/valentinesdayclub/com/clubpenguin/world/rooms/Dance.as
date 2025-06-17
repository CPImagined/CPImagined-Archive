class com.clubpenguin.world.rooms.Dance extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, localize, setupNavigationButtons, _INTERFACE, _SHELL, _ENGINE, _destroyDelegate, _handleGetBroadcastMusicTracks, _AIRTOWER;
    function Dance(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms.Dance.CLASS_NAME + "()");
        _stage.start_x = 355;
        _stage.start_y = 310;
        this.localize([_stage.corner_mc.dance_mc]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.town_btn, 110, 245), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lounge_btn, 675, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.corner_mc.boiler_btn, 505, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.corner_mc.dance_mc.dance_btn, 545, 220), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dj_mc.dj_btn, 350, 165)]);
        _stage.corner_mc.puffle_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, puffleAnimate);
        _stage.corner_mc.puffle_btn.useHandCursor = false;
        _stage.interface_mc.dance_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dance_catalogue");
        _stage.musiccatalog_mc.musiccatalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dance_catalogue");
        _stage.dj_mc.dj_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showMixMasterHint);
        _stage.dj_mc.dj_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideMixMasterHint);
        _stage.corner_mc.dance_mc.dance_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showDancingHint);
        _stage.corner_mc.dance_mc.dance_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideDancingHint);
        _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 425, 250);
        _stage.triggers_mc.boiler_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "boiler", 560, 320);
        _stage.triggers_mc.lounge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lounge", 565, 305);
        _stage.triggers_mc.mixmaster_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchMixMasterGame);
        _stage.triggers_mc.dancing_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchDancingGame);
        this.configureMusicWidgetFunctionality();
    } // End of the function
    function puffleAnimate()
    {
        _stage.corner_mc.puffle_mc.gotoAndPlay(188);
    } // End of the function
    function showContent(contentID)
    {
        trace ("show contnet");
        _INTERFACE.showContent(contentID);
    } // End of the function
    function showMixMasterHint()
    {
        trace ("show hint");
        _INTERFACE.showHint(_stage.hintmixmaster_mc, "mixmaster_hint");
    } // End of the function
    function hideMixMasterHint()
    {
        trace ("hide hint");
        _INTERFACE.closeHint();
    } // End of the function
    function launchMixMasterGame()
    {
        var _loc2 = _SHELL.getLocalizedString("soundstudio_prompt");
        _INTERFACE.closePrompt();
        _INTERFACE.showPrompt("game", _loc2, undefined, com.clubpenguin.util.Delegate.create(this, clickJoinGamePrompt));
    } // End of the function
    function clickJoinGamePrompt()
    {
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction("dance_club", "soundstudio_open");
        _SHELL.sendJoinRoom("soundroom", 312, 308);
    } // End of the function
    function showDancingHint()
    {
        trace ("show hint");
        _INTERFACE.showHint(_stage.hintdancing_mc, "dancing_hint");
    } // End of the function
    function hideDancingHint()
    {
        trace ("hide hint");
        _INTERFACE.closeHint();
    } // End of the function
    function launchDancingGame()
    {
        _ENGINE.sendJoinGame("dancing", true);
    } // End of the function
    function exit(name, x, y)
    {
        trace (com.clubpenguin.world.rooms.Dance.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(name, x, y);
        this.destroy();
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms.Dance.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
    } // End of the function
    function destroy()
    {
        trace (com.clubpenguin.world.rooms.Dance.CLASS_NAME + ": destroy()");
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _SHELL.sendHideMusicPlayerWidget();
        _AIRTOWER.removeListener(com.clubpenguin.world.rooms.Dance.BROADCASTING_MUSIC_TRACKS_EVENT, _handleGetBroadcastMusicTracks);
    } // End of the function
    function configureMusicWidgetFunctionality()
    {
        trace ("DanceRoom.configureMusicWidgetFunctionality()");
        _SHELL.sendShowMusicPlayerWidget();
        _AIRTOWER = _global.getCurrentAirtower();
        _handleGetBroadcastMusicTracks = com.clubpenguin.util.Delegate.create(this, musicService_getBroadcastMusicTracks_Handler);
        _AIRTOWER.addListener(com.clubpenguin.world.rooms.Dance.BROADCASTING_MUSIC_TRACKS_EVENT, _handleGetBroadcastMusicTracks);
        this.cleanPaperDollDisplay();
        _paperDollGenerator = new com.clubpenguin.world.rooms.common.paperdoll.PaperDollGenerator(_stage, _SHELL, _stage.foreground_mc.tvscreenMC.paperdollMC);
    } // End of the function
    function musicService_getBroadcastMusicTracks_Handler(data)
    {
        trace (String(data));
        if (data.length < 3)
        {
            this.cleanPaperDollDisplay();
            return;
        } // end if
        data.shift();
        data.shift();
        data.shift();
        if (data[0] == undefined || data[0] == "")
        {
            this.cleanPaperDollDisplay();
            return;
        } // end if
        var _loc3 = data[0].split(",");
        var _loc5 = new Array();
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            trace ("songData " + _loc3[_loc2]);
            var _loc4 = _loc3[_loc2].split("|");
            _loc5.push(_loc4);
        } // end of for
        var _loc8 = _loc5[0][0];
        var _loc7 = String(_loc5[0][1]);
        if (_loc7 == undefined)
        {
            this.cleanPaperDollDisplay();
        }
        else
        {
            _stage.foreground_mc.tvscreenMC.playerNameLabel.text = String(_loc7);
            _paperDollGenerator.drawPaperDoll(_loc8);
            _stage.foreground_mc.tvscreenMC.tvscreen.gotoAndStop("on");
            _stage.foreground_mc.tvscreenMC.paperdollMC._visible = true;
        } // end else if
        if (_loc8 == _SHELL.getMyPlayerId())
        {
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(com.clubpenguin.world.rooms.Dance.MY_TRACK_PLAYED, com.clubpenguin.world.rooms.Dance.BI_CONTEXT_SOUNDSTUDIO);
        } // end if
    } // End of the function
    function cleanPaperDollDisplay()
    {
        _stage.foreground_mc.tvscreenMC.paperdollMC._visible = false;
        _stage.foreground_mc.tvscreenMC.playerNameLabel.text = "";
        _paperDollGenerator.clearPaperDoll();
    } // End of the function
    static var CLASS_NAME = "Dance";
    static var MUSIC_CATAGORY = "musictrack";
    static var BROADCASTING_MUSIC_TRACKS_EVENT = "broadcastingmusictracks";
    static var BI_CONTEXT_SOUNDSTUDIO = "soundstudio";
    static var MY_TRACK_PLAYED = "dance_club_song_played";
    var _paperDollGenerator = null;
} // End of Class
