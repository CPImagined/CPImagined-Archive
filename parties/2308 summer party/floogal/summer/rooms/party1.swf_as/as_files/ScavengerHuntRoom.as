dynamic class as_files.ScavengerHuntRoom extends com.clubpenguin.world.rooms.BaseRoom
{
    var scavengerItems = {};
    var _SHELL;
    var _currentParty;
    var _stage;

    function ScavengerHuntRoom(stageReference)
    {
        super(stageReference);
        this._currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
    }

    function registerScavengerHuntItem(item_name)
    {
        var __reg4 = item_name.split("_");
        var __reg2 = Number(__reg4[1]);
        this.scavengerItems[item_name] = __reg2;
        this.setTaskAvailability(item_name, __reg2);
    }

    function setTaskAvailability(item_name, taskId)
    {
        if (this._currentParty.isTaskAvailable(taskId) && !this._currentParty.isQuestTaskComplete(taskId)) 
        {
            this._stage[item_name + "_btn"].onRollOver = com.clubpenguin.util.Delegate.create(this, this.questItemRollOver, this._stage[item_name + "_mc"]);
            this._stage[item_name + "_btn"].onRollOut = com.clubpenguin.util.Delegate.create(this, this.questItemRollOut, this._stage[item_name + "_mc"]);
            this._stage[item_name + "_btn"].onRelease = com.clubpenguin.util.Delegate.create(this, this.onScavengerItemClicked, item_name);
            this._stage[item_name + "_btn"]._visible = true;
            this._stage[item_name + "_mc"]._visible = true;
            return;
        }
        this._stage[item_name + "_btn"]._visible = false;
        this._stage[item_name + "_mc"]._visible = false;
    }

    function questItemRollOver(item_mc)
    {
        item_mc.gotoAndStop(2);
    }

    function questItemRollOut(item_mc)
    {
        item_mc.gotoAndStop(1);
    }

    function onScavengerItemClicked(item_name)
    {
        this._stage[item_name + "_btn"]._visible = false;
        this._stage[item_name + "_mc"]._visible = false;
        this.setTaskComplete(Number(this.scavengerItems[item_name]));
        this.showCheckMark();
    }

    function setTaskComplete(taskId)
    {
        this._currentParty.taskComplete(taskId);
        if (this._stage.checkmark_mc) 
        {
            this._stage.checkmark_mc.removeMovieClip();
        }
    }

    function showCheckMark()
    {
        if (this._stage.checkmark_mc) 
        {
            this._stage.checkmark_mc.removeMovieClip();
        }
        var __reg4 = this._SHELL.getMyPlayerId();
        var __reg3 = _global.getCurrentEngine().getPlayerMovieClip(__reg4);
        this._stage.attachMovie("CheckMarkAnimation", "checkmark_mc", this._stage.getNextHighestDepth());
        this._stage.checkmark_mc.swapDepths(this._stage.getNextHighestDepth());
        this._stage.checkmark_mc._x = __reg3._x;
        this._stage.checkmark_mc._y = __reg3._y + 120;
        this._stage.checkmark_mc._xscale = 250;
        this._stage.checkmark_mc._yscale = 250;
    }

}
