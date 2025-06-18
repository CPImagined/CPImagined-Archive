//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Pizza extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _SHELL, localize, setupNavigationButtons, _setQuestBtnsIntervalID, registerScavengerHuntItem, _ENGINE, _INTERFACE;
        function Pizza (stageReference) {
            super(stageReference);
            _stage.start_x = 360;
            _stage.start_y = 200;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.background_mc.kitchen_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door2_btn, 360, 150), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizzatron_btn, 140, 160)]);
            _stage.background_mc.pizzatron_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showPizzatronHint);
            _stage.background_mc.pizzatron_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hidePizzatronHint);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 560, 280);
            _stage.triggers_mc.pizzatron_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchPizzatronGame);
            _setQuestBtnsIntervalID = setInterval(com.clubpenguin.util.Delegate.create(this, setQuestBtns), 500);
        }
        function setQuestBtns() {
            clearInterval(_setQuestBtnsIntervalID);
            registerScavengerHuntItem("quest_6");
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function showPizzatronHint() {
            _INTERFACE.showHint(_stage.hintpizzatron_mc, "pizzatron_hint");
        }
        function hidePizzatronHint() {
            _INTERFACE.closeHint();
        }
        function launchPizzatronGame() {
            _ENGINE.sendJoinGame("pizzatron", true);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Pizza";
    }
