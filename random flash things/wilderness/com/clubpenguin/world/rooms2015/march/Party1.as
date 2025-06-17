class com.clubpenguin.world.rooms2015.march.Party1 extends com.clubpenguin.world.rooms.BaseRoom
{
    var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, isGoingFishing, qcTimer;
    function Party1(stageReference)
    {
        super(stageReference);
        trace (com.clubpenguin.world.rooms2015.march.Party1.CLASS_NAME + "()");
        _stage.start_x = 325;
        _stage.start_y = 250;
        if (!_SHELL)
        {
            this.init();
        } // end if
    } // End of the function
    function init()
    {
        trace (com.clubpenguin.world.rooms2015.march.Party1.CLASS_NAME + ": init()");
        _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
        _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        _stage.touchTriggers_mc._visible = false;
        _stage.triggers_mc._visible = false;
        _stage.block_mc._visible = false;
        _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lodge", 241, 195);
        _stage.triggers_mc.pufflewild_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 360, 300);
        _stage.forestLeft_btn.useHandCursor = false;
        _stage.puffleStump_btn.useHandCursor = false;
        _stage.goFishing_mc.onPress = com.clubpenguin.util.Delegate.create(this, goingFishing);
        _stage.triggers_mc.fishingSpot_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, catchFish);
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.transformSign_mc.transform_btn, 120, 340), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.goFishing_mc, 477, 333)]);
    } // End of the function
    function goingFishing()
    {
        isGoingFishing = true;
    } // End of the function
    function catchFish()
    {
        if (com.clubpenguin.world.rooms2015.march.party.MarchParty.getCurrentTaskItemIndex() == com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISH_INDEX)
        {
            return;
        } // end if
        if (isGoingFishing && com.clubpenguin.world.rooms2015.march.party.MarchParty.getCurrentTaskItemIndex() == com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.FISHING_ROD_INDEX)
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty.collectTaskItem("fish");
        }
        else
        {
            com.clubpenguin.world.rooms2015.march.party.MarchParty.showQuestCommunicatorMessage(com.clubpenguin.world.rooms2015.march.party.MarchParty.CONSTANTS.QC_25_EASIER_WITH_FISHING_ROD, 3);
        } // end else if
    } // End of the function
    function exit(roomName, x, y)
    {
        trace (com.clubpenguin.world.rooms2015.march.Party1.CLASS_NAME + ": exit()");
        _SHELL.sendJoinRoom(roomName, x, y);
    } // End of the function
    function destroy()
    {
        clearTimeout(qcTimer);
        _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        false;
    } // End of the function
    static var CLASS_NAME = "Party1";
} // End of Class
