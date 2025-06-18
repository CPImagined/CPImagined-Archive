dynamic class com.clubpenguin.world.rooms2015.august.PoolRink extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "PoolRink";
    static var SLIDE_COMMAND: String = "followpath";
    static var WATER_SPLASH_EFFECT: String = "waterSplashEffect";
    static var DIVING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_DIVE;
    static var PLAY_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.PLAYING_TASK;
    var _INTERFACE;
    var _SHELL;
    var _destroyDelegate;
    var _divingBoard;
    var _divingBoardTrigger;
    var _slide1Trigger;
    var _stage;
    var _triggerWatcher;
    var _triggerWatcherInterval;
    var _waterSlideHandlerDelegate;
    var localize;
    var setupNavigationButtons;

    function PoolRink(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 385;
        this._stage.start_y = 345;
        if (!this._SHELL) 
        {
            this.init();
        }
        this.localize([this._stage.LangMenu, this._stage.interface_mc.sports_mc]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navTube1, 436, 139), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navTube2, 497, 144), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navTube3, 560, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navTube4, 626, 142), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.navWaterslide, 131, 82)]);
        this._stage.navTube1.useHandCursor = false;
        this._stage.navTube2.useHandCursor = false;
        this._stage.navTube3.useHandCursor = false;
        this._stage.navTube4.useHandCursor = false;
        this._stage.navWaterslide.useHandCursor = false;
        this._stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forts", 270, 185);
        this._stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "school", 55, 360);
        this._stage.interface_mc.sports_mc.sports_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.openPigfarmCatalog);
    }

    function catalog()
    {
        this._INTERFACE.showContent("sport_catalogue");
    }

    function exit(name, x, y)
    {
        this._SHELL.sendJoinRoom(name, x, y);
    }

    function openPigfarmCatalog()
    {
        var __reg2 = {catalogType: "catalog_sports"};
        this._SHELL.sendOpenAS3Module(com.clubpenguin.modules.AS3ModuleConstants.PIGFARM_CATALOG, __reg2, {blockPuffleNotifications: true});
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(this._stage, this._SHELL);
        clearInterval(this._triggerWatcherInterval);
        this._triggerWatcherInterval = setInterval(this._triggerWatcher, "checkAllPlayers", 40);
        this.configureWaterSlideFunctionality();
        this.configureDivingBoardTrigger();
    }

    function configureWaterSlideFunctionality()
    {
        var __reg3 = 1;
        while (__reg3 <= 2) 
        {
            this["_slide" + __reg3] = new com.clubpenguin.world.rooms.common.slide.ConveyorBelt();
            this["_slide" + __reg3 + "EndDelegate"] = com.clubpenguin.util.Delegate.create(this, this.handleSlideEnd, __reg3);
            this["_slide" + __reg3].endOfConveyorBeltReached.add(this["_slide" + __reg3 + "EndDelegate"], this);
            ++__reg3;
        }
        this._waterSlideHandlerDelegate = com.clubpenguin.util.Delegate.create(this, this.handlePenguinOnSlide);
        _global.getCurrentAirtower().addListener(com.clubpenguin.world.rooms2015.august.PoolRink.SLIDE_COMMAND, this._waterSlideHandlerDelegate);
        this.configureSlideTriggers();
    }

    function playSlideTeleport()
    {
        _global.getCurrentParty().BaseParty.playSound(this._stage, "sfx_transport");
    }

    function playSlideSFX()
    {
        var __reg3 = Math.floor(Math.random() * 3) + 1;
        _global.getCurrentParty().BaseParty.playSound(this._stage, "sfx_slide_" + __reg3);
    }

    function playTrumpet()
    {
        this._stage.trumpet_mc.key1_mc.gotoAndPlay(2);
        this._stage.trumpet_mc.key2_mc.gotoAndPlay(2);
        this._stage.trumpet_mc.key3_mc.gotoAndPlay(2);
    }

    function configureSlideTriggers()
    {
        this._slide1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(this._stage.triggers_mc.slide1Trigger);
        this._slide1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, this.sendAddPlayerToSlide, 1));
        this._triggerWatcher.addTrigger(this._slide1Trigger);
    }

    function sendAddPlayerToSlide(players, slideNum)
    {
        this.playSlideSFX();
        var __reg3 = 0;
        for (;;) 
        {
            if (__reg3 >= players.length) 
            {
                return;
            }
            if (players[__reg3] == this._SHELL.getMyPlayerId()) 
            {
                var __reg4 = _global.getCurrentAirtower();
                __reg4.send(__reg4.PLAY_EXT, "u#" + com.clubpenguin.world.rooms2015.august.PoolRink.SLIDE_COMMAND, [slideNum], "str", this._SHELL.getCurrentServerRoomId());
            }
            ++__reg3;
        }
    }

    function handlePenguinOnSlide(data)
    {
        var __reg3 = Number(data[1]);
        var __reg2 = Number(data[2]);
        this["_slide" + __reg2].addPenguintoConveyorPather("Waterslide_Path_" + __reg2, __reg3, this._stage.waterSlideContainerMC);
        data = null;
    }

    function handleSlideEnd(player_id, slideNum)
    {
        if (this._stage["slideSplash_" + slideNum]._currentframe == 1) 
        {
            this._stage["slideSplash_" + slideNum].gotoAndPlay(2);
        }
    }

    function divingBoardRollOver()
    {
        this._stage.background_mc.divingBoardState_mc.gotoAndStop("rollOver");
    }

    function divingBoardRollOut()
    {
        this._stage.background_mc.divingBoardState_mc.gotoAndStop("rollOut");
    }

    function configureDivingBoardTrigger()
    {
        this._stage.divingBoard_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.divingBoardRollOver);
        this._stage.divingBoard_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.divingBoardRollOut);
        this._stage.divingBoard_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, this.divingBoardRollOut);
        this._stage.divingBoard_btn.useHandCursor = false;
        var __reg2 = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationVO();
        __reg2.effectRef = this._stage.background_mc.divingBoardState_mc.divingBoard_mc;
        __reg2.taskEnum = com.clubpenguin.world.rooms2015.august.PoolRink.PLAY_TASK;
        __reg2.assetPath = com.clubpenguin.world.rooms2015.august.PoolRink.DIVING_PATH;
        this._divingBoard = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(__reg2);
        this._divingBoard.stationBIInfo("cruise_deck", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION);
        this.configureStationTrigger(this._divingBoard, this._divingBoardTrigger, this._stage.triggers_mc.divingBoard_mc);
    }

    function configureStationTrigger(careStation, playerTrigger, triggerClip)
    {
        playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
        playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
        playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
        this._triggerWatcher.addTrigger(playerTrigger);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
    }

}
