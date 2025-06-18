dynamic class com.clubpenguin.world.rooms2014.pirate.Cove extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "Cove";
    var _lastSfxTime: Number = 0;
    var _ENGINE;
    var _SHELL;
    var _destroyDelegate;
    var _roomUpdateInterval;
    var _stage;
    var _triggerWatcher;
    var _triggerWatcherInterval;
    var localize;
    var setupHint;
    var setupNavigationButtons;
    var showContent;

    function Cove(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 130;
        this._stage.start_y = 237;
        this._lastSfxTime = getTimer();
        if (!this._SHELL) 
        {
            this.init();
        }
        this.localize([this._stage.background_mc.mineSign_mc, this._stage.cpuEntrance_mc.cpuText_mc]);
        this.setupHint([new com.clubpenguin.world.rooms.common.HintVO(this._stage.waves_mc.waves_btn, this._stage.waves_mc.waves_btn, "waves_hint")]);
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(this._stage, this._SHELL);
        this.configureNavigation();
        this.configureTriggers();
        this.configureRoomElements();
        this.showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(this._stage.interface_mc.cove_cat_btn, true, "cove_catalogue", "")]);
        clearInterval(this._triggerWatcherInterval);
        this._triggerWatcherInterval = setInterval(this._triggerWatcher, "checkAllPlayers", 40);
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function initializePartyCookieDependentAssets()
    {
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function playSound(sfxName, trigger_mc)
    {
        var __reg5 = trigger_mc.player_mc;
        var __reg4 = getTimer();
        var __reg6 = __reg4 - this._lastSfxTime;
        var __reg3 = this._SHELL.isMyPlayer(__reg5.player_id);
        if (__reg6 > 3000 || __reg3) 
        {
            var __reg2 = new Sound(trigger_mc);
            __reg2.attachSound(sfxName);
            if (!__reg3) 
            {
                __reg2.setVolume(20);
            }
            __reg2.start();
            this._lastSfxTime = __reg4;
        }
    }

    function configureTriggers()
    {
        this._stage.triggers_mc.forestTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forest", 463, 323);
        this._stage.triggers_mc.wavesTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.launchWavesGame);
    }

    function configureNavigation()
    {
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.forestNav_btn, 130, 178), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.chestNav_btn, 287, 207), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.waves_mc.waves_btn, 187, 347)]);
        this._stage.forestNav_btn.useHandCursor = false;
        this._stage.chestNav_btn.useHandCursor = false;
    }

    function configureRoomElements()
    {
    }

    function launchWavesGame()
    {
        if (this._SHELL.isNewPlayerExperienceRunning == false) 
        {
			this._ENGINE.sendJoinGame("waves", true);
        }
    }

    function exit(roomName, x, y)
    {
        this._SHELL.sendJoinRoom(roomName, x, y);
    }

    function destroy()
    {
        clearInterval(this._roomUpdateInterval);
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
    }

}
