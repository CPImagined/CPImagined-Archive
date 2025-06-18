dynamic class com.clubpenguin.world.rooms.common.behaviors.RoomBehavior implements com.clubpenguin.world.rooms.common.behaviors.IRoomBehavior
{
    var _SHELL;
    var _handlePufflePerformingTrickDelegate;
    var _isShowStatsBarWidget;
    var _loader;

    function RoomBehavior()
    {
        this._isShowStatsBarWidget = true;
        this._SHELL = _global.getCurrentShell();
        this._handlePufflePerformingTrickDelegate = com.clubpenguin.util.Delegate.create(this, this.handlePufflePerformingTrick);
        this._SHELL.addListener(this._SHELL.PUFFLE_PERFORMING_TRICK, this._handlePufflePerformingTrickDelegate);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.PUFFLE_PERFORMING_TRICK, this._handlePufflePerformingTrickDelegate);
    }

    function applyEffect(playerId)
    {
    }

    function handlePufflePerformingTrick(event)
    {
        if (event.playerId == this._SHELL.getMyPlayerId()) 
        {
            this._isShowStatsBarWidget = false;
            this._loader.cancelAndRemoveAnimation();
            this._SHELL.removeListener(this._SHELL.PUFFLE_PERFORMING_TRICK, this._handlePufflePerformingTrickDelegate);
        }
    }

}
