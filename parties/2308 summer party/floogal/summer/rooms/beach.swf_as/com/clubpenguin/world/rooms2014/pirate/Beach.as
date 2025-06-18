dynamic class com.clubpenguin.world.rooms2014.pirate.Beach extends com.clubpenguin.world.rooms.BasePartyRoom
{
    static var CLASS_NAME: String = "Beach";
    var _ENGINE;
    var _SHELL;
    var _destroyDelegate;
    var _stage;
    var setupNavigationButtons;
    var wem;

    function Beach(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 400;
        this._stage.start_y = 200;
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.background_mc.light_btn, 190, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.lighthouseDoor_mc.light_btn, 190, 210)]);
        this._stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "light", 300, 275);
        this._stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "village", 160, 395);
        this._stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "dock", 230, 180);
		this._stage.triggers_mc.party1_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "party1", 230, 180);
    }

    function bucketAnimate()
    {
        this._stage.bucket_mc.play();
    }

    function moveToMouse()
    {
        this._ENGINE.sendPlayerMove(_xmouse, _ymouse);
    }

    function exit(name, x, y)
    {
        this._SHELL.sendJoinRoom(name, x, y);
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        var __reg3 = this._SHELL.getMascotOptions();
        if (__reg3.migrator_active) 
        {
            this._stage.background_mc.ship_mc._visible = true;
            this._stage.triggers_mc.ship_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "ship", 440, 300);
        }
        else 
        {
            this._stage.background_mc.ship_mc._visible = false;
        }
        this.wem = new com.clubpenguin.world.rooms.weathereffects.WeatherEffectsManager(this._SHELL, this._stage.background_mc);
        this.wem.setupFireAnimationHeight(45);
        this.wem.setupRainAnimationHeight(70);
        this.wem.setupSnowAnimationHeight(70);
        this.wem.setupRainAnimationSpeed(0.4);
        this.wem.setupSnowAnimationSpeed(0.8);
        this.wem.setupRainDelayTime(2);
        this.wem.setupSnowDelayTime(2);
        this.wem.startWeatherEffectCheck();
        this._stage.lighthouseDoor_mc.light_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, this.rollOverDoor);
        this._stage.lighthouseDoor_mc.light_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, this.rollOutDoor);
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function initializePartyCookieDependentAssets()
    {
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function rollOverDoor()
    {
        this._stage.lighthouseDoor_mc.gotoAndStop(2);
    }

    function rollOutDoor()
    {
        this._stage.lighthouseDoor_mc.gotoAndStop(1);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this.wem.destroy();
    }

}
