dynamic class com.clubpenguin.world.rooms2014.pirate.Forest extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "Forest";
    var _SHELL;
    var _destroyDelegate;
    var _stage;
    var _triggerWatcher;
    var _triggerWatcherInterval;
    var setupNavigationButtons;

    function Forest(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 393;
        this._stage.start_y = 306;
        if (this._SHELL) 
        {
            return;
        }
        this.init();
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(this._stage, this._SHELL);
        this._stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "plaza", 635, 347);
        this._stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "shack", 200, 330);
        this._stage.triggers_mc.cove_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "cove", 113, 217);
        this._stage.triggers_mc.lake_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "lake", 220, 160);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.plaza_btn, 72, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.shack_btn, 677, 187), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.cove_btn, 572, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.treasure_btn, 391, 235)]);
        this._stage.cove_btn.useHandCursor = false;
        this._stage.plaza_btn.useHandCursor = false;
        this._stage.shack_btn.useHandCursor = false;
        clearInterval(this._triggerWatcherInterval);
        this._triggerWatcherInterval = setInterval(this._triggerWatcher, "checkAllPlayers", 40);
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
    }

    function initializePartyCookieDependentAssets()
    {
        _global.getCurrentParty().PirateParty.configureTreasureChestState(this._stage.chest_mc, this._stage.crabs_mc, this._stage.treasure_btn);
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
