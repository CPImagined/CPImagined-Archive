dynamic class com.clubpenguin.world.rooms2012.musicjam.CadenceStadium extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "CadenceStadium";
    static var ONE_SECOND: Number = 1000;
    var _ENGINE;
    var _INTERFACE;
    var _SHELL;
    var _cadenceSongIsPlaying;
    var _cadenceTrack;
    var _cadenceTrackLoaded;
    var _clockCheckIntervalID;
    var _destroyDelegate;
    var _opcodeJournal;
    var _roomStampsToEarn;
    var _stadiumStampsInterval;
    var _stage;
    var _triggerWatcher;
    var _triggerWatcherInterval;
    var localize;
    var setupNavigationButtons;

    function CadenceStadium(stageReference)
    {
        super(stageReference);
        this._stage.isSmallPenguin = true;
        this._stage.start_x = 700;
        this._stage.start_y = 300;
        this._cadenceTrackLoaded = false;
        this._roomStampsToEarn = [31, 32, 34, 35, 36];
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(this._stage, this._SHELL);
        this.localize([this._stage.pathway_mc.exit_text_mc, this._stage.vip_door_mc]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.vip_door_mc, 625, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.pathway_mc.exit_sign_btn, 380, 450), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.pathway_mc.exit_button, 380, 450)]);
        this._stage.triggers_mc.trigger_vip_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.checkVIPEntryRequirements);
        this._stage.triggers_mc.trigger_exit_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forts", 355, 215);
        this._stage.pathway_mc.exit_button.onRollOver = com.clubpenguin.util.Delegate.create(this, this.pathRollOver);
        this._stage.pathway_mc.exit_button.onRollOut = com.clubpenguin.util.Delegate.create(this, this.pathRollOut);
        this._stage.pathway_mc.exit_button.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, this.pathReleaseOutside);
        this._stage.background_mc.backdrop_mc.giantCadence_mc._visible = false;
        this._stage.background_mc.backdrop_mc.cadenceLight_mc._visible = false;
        this._stage.background_mc.backdrop_mc.cadenceBubbles_mc._visible = false;
        clearInterval(this._triggerWatcherInterval);
        this._triggerWatcherInterval = setInterval(this._triggerWatcher, "checkAllPlayers", 40);
        this.loadExternalMusic(this._SHELL.getPath(com.clubpenguin.world.rooms2012.musicjam.MusicJam.CADENCE_MUSIC_TRACK));
        this.checkTime();
        clearInterval(this._clockCheckIntervalID);
        this._clockCheckIntervalID = setInterval(this, "checkTime", com.clubpenguin.world.rooms2012.musicjam.CadenceStadium.ONE_SECOND);
        this._opcodeJournal = new com.clubpenguin.world.rooms2012.musicjam.OpcodeJournal();
        this._opcodeJournal.init(this._SHELL.getMyPlayerId());
    }

    function checkTime()
    {
        var __reg3 = this._SHELL.getPenguinStandardTime();
        var __reg4 = __reg3.getHours() * 3600 + __reg3.getMinutes() * 60 + __reg3.getSeconds();
        var __reg2 = __reg4 % com.clubpenguin.world.rooms2012.musicjam.MusicJam.CYCLE_LENGTH;
        if (__reg2 < com.clubpenguin.world.rooms2012.musicjam.MusicJam.PERFORMANCE_LENGTH && (this._cadenceSongIsPlaying == undefined || this._cadenceSongIsPlaying == false)) 
        {
            this.showCadencePerformance(__reg2);
            return;
        }
        if (__reg2 > com.clubpenguin.world.rooms2012.musicjam.MusicJam.PERFORMANCE_LENGTH && (this._cadenceSongIsPlaying == undefined || this._cadenceSongIsPlaying == true)) 
        {
            this.openStageToPlayers();
        }
    }

    function checkVIPEntryRequirements()
    {
        if (this._SHELL.isMyPlayerMember()) 
        {
            this._opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.musicjam.OpcodeJournal.MEMBER_ENTERS_BACKSTAGE);
            this.exit("party13", 380, 260);
            return;
        }
        this._opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.musicjam.OpcodeJournal.NON_MEMBER_OOPS_BACKSTAGE);
        this._INTERFACE.showContent(com.clubpenguin.world.rooms2012.musicjam.MusicJam.OOPS_NON_MEMBER_BACKSTAGE);
    }

    function loadExternalMusic(url)
    {
        this._cadenceTrack = new Sound();
        this._cadenceTrack.onLoad = com.clubpenguin.util.Delegate.create(this, this.onCadenceTrackLoaded);
        this._cadenceTrack.loadSound(url, true);
    }

    function onCadenceTrackLoaded(success)
    {
        if (success) 
        {
            this._cadenceTrack.stop();
            this._cadenceTrackLoaded = true;
        }
    }

    function showCadencePerformance(songOffset)
    {
        if (this._cadenceTrackLoaded) 
        {
            this._opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.musicjam.OpcodeJournal.ATTEND_CADENCE_CONCERT);
            this._SHELL.stopMusic();
            this._cadenceTrack.start(songOffset);
            this._cadenceSongIsPlaying = true;
            this._stage.block_mc.gotoAndStop(2);
            var __reg2 = this._ENGINE.getPlayerMovieClip(this._SHELL.getMyPlayerId());
            if (this._stage.triggers_mc.stage_mc.hitTest(__reg2._x, __reg2._y, true)) 
            {
                var __reg4 = 180 - Math.round(Math.random() * 80);
                var __reg3 = 240 + Math.round(Math.random() * 40) - 20;
                this._ENGINE.sendPlayerTeleportAndMove(180, 218, __reg4, __reg3);
            }
            this._stage.background_mc.backdrop_mc.giantCadence_mc._visible = true;
            this._stage.background_mc.backdrop_mc.cadenceLight_mc._visible = true;
            this._stage.background_mc.backdrop_mc.cadenceBubbles_mc._visible = true;
            this._stage.foreground_mc.band1.gotoAndStop("playing");
            this._stage.foreground_mc.band2.gotoAndStop("playing");
            this._stage.foreground_mc.band3.gotoAndStop("playing");
            this._stage.foreground_mc.band4.gotoAndStop("playing");
            this._stage.foreground_mc.band5.play();
            this._stage.foreground_mc.band1._visible = true;
            this._stage.foreground_mc.band2._visible = true;
            this._stage.foreground_mc.band3._visible = true;
            this._stage.foreground_mc.band4._visible = true;
            this._stage.foreground_mc.band5._visible = true;
        }
    }

    function earnStadiumStamps()
    {
        this._SHELL.stampEarned(this._roomStampsToEarn.shift());
        clearInterval(this._stadiumStampsInterval);
        this._stadiumStampsInterval = setInterval(this, "onStampEarnInterval", 4000);
    }

    function onStampEarnInterval()
    {
        if (this._roomStampsToEarn.length <= 0) 
        {
            clearInterval(this._stadiumStampsInterval);
        }
        this._SHELL.stampEarned(this._roomStampsToEarn.shift());
        if (this._roomStampsToEarn.length <= 0) 
        {
            clearInterval(this._stadiumStampsInterval);
        }
    }

    function openStageToPlayers()
    {
        this._cadenceSongIsPlaying = false;
        this._cadenceTrack.stop();
        this._SHELL.startRoomMusic();
        this._stage.block_mc.gotoAndStop(1);
        this._stage.background_mc.backdrop_mc.giantCadence_mc._visible = false;
        this._stage.background_mc.backdrop_mc.cadenceLight_mc._visible = false;
        this._stage.background_mc.backdrop_mc.cadenceBubbles_mc._visible = false;
        this._stage.foreground_mc.band1.gotoAndStop("park");
        this._stage.foreground_mc.band2.gotoAndStop("park");
        this._stage.foreground_mc.band3.gotoAndStop("park");
        this._stage.foreground_mc.band4.gotoAndStop("park");
        this._stage.foreground_mc.band5.stop();
        this._stage.foreground_mc.band1._visible = false;
        this._stage.foreground_mc.band2._visible = false;
        this._stage.foreground_mc.band3._visible = false;
        this._stage.foreground_mc.band4._visible = false;
        this._stage.foreground_mc.band5._visible = false;
    }

    function pathReleaseOutside()
    {
        this._stage.pathway_mc.gotoAndStop(1);
    }

    function pathRollOver()
    {
        this._stage.pathway_mc.gotoAndStop(2);
    }

    function pathRollOut()
    {
        this._stage.pathway_mc.gotoAndStop(1);
    }

    function exit(roomName, x, y)
    {
        this._SHELL.sendJoinRoom(roomName, x, y);
    }

    function destroy()
    {
        this._cadenceTrack.stop();
        this._cadenceTrack = new Sound();
        clearInterval(this._clockCheckIntervalID);
        clearInterval(this._triggerWatcherInterval);
        clearInterval(this._stadiumStampsInterval);
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        false;
    }

}
