dynamic class com.clubpenguin.world.rooms2012.musicjam.CadenceBackstage extends com.clubpenguin.world.rooms.BaseRoom
{
    static var CLASS_NAME: String = "CadenceBackstage";
    var _SHELL;
    var _destroyDelegate;
    var _stage;
    var _triggerWatcher;
    var _triggerWatcherInterval;
    var localize;

    function CadenceBackstage(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 380;
        this._stage.start_y = 330;
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        this._triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(this._stage, this._SHELL);
        this._stage.triggers_mc.triggerFort_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "party12", 355, 215);
        this._stage.triggers_mc.MascotStageTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exit, "forts", 555, 290);
        this.localize([this._stage.VIP_gateway_MC.exit_text_mc]);
        clearInterval(this._triggerWatcherInterval);
        this._triggerWatcherInterval = setInterval(this._triggerWatcher, "checkAllPlayers", 40);
    }

    function exit(roomName, x, y)
    {
        this._SHELL.sendJoinRoom(roomName, x, y);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
        false;
    }

}
