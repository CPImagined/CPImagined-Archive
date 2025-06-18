dynamic class as_files.Party1 extends as_files.ScavengerHuntRoom
{
    static var CLASS_NAME: String = "Party1";
    var _SHELL;
    var _destroyDelegate;
    var _setQuestBtnsIntervalID;
    var _stage;
    var registerScavengerHuntItem;
    var setupNavigationButtons;

    function Party1(stageReference)
    {
        super(stageReference);
        this._stage.start_x = 178;
        this._stage.start_y = 165;
        this.setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(this._stage.nav_beach, 62, 135)]);
        this._stage.nav_beach.useHandCursor = false;
        this._setQuestBtnsIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, this.setQuestBtns), 500);
        this._stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, this.exitBeach);
    }

    function setQuestBtns()
    {
        clearInterval(this._setQuestBtnsIntervalID);
        this.registerScavengerHuntItem("quest_1");
        this.registerScavengerHuntItem("quest_2");
        this.registerScavengerHuntItem("quest_3");
        this.registerScavengerHuntItem("quest_22");
        this.registerScavengerHuntItem("quest_23");
        this.registerScavengerHuntItem("quest_24");
    }

    function exitBeach()
    {
        this._SHELL.sendJoinRoom("beach", 560, 380);
    }

    function init()
    {
        this._destroyDelegate = com.clubpenguin.util.Delegate.create(this, this.destroy);
        this._SHELL.addListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
    }

    function destroy()
    {
        this._SHELL.removeListener(this._SHELL.ROOM_DESTROYED, this._destroyDelegate);
    }

}
