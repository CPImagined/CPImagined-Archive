dynamic class com.clubpenguin.world.rooms2014.pirate.Town extends com.clubpenguin.world.rooms.BasePartyRoom
{
    static var CLASS_NAME: String = "Town";
    var _SHELL;
    var _destroyDelegate;
    var _stage;
    var localize;
    var setupNavigationButtons;

    function Town(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 400;
        this._stage.start_y = 240;
        this.localize([this._stage.signs_mc]);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.dock_btn, 20, 275), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.coffee_btn, 225, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.dance_btn, 390, 190), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.shop_btn, 580, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.forts_btn, 730, 260)]);
        this._stage.background_mc.dock_btn.useHandCursor = false;
        this._stage.background_mc.forts_btn.useHandCursor = false;
        this._stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "dock", 676, 201);
        this._stage.triggers_mc.coffee_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "coffee", 355, 200);
        this._stage.triggers_mc.dance_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "dance", 170, 270);
        this._stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "shop", 555, 210);
        this._stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forts", 195, 220);
    }

    function exit(name, x, y)
    {
        if (this._SHELL.isNewPlayerExperienceRunning == false) 
        {
            this._SHELL.sendJoinRoom(name, x, y);
        }
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function initializePartyCookieDependentAssets()
    {
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
    }

}
