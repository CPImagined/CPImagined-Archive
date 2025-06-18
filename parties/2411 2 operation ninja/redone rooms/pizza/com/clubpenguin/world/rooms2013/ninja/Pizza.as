//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Pizza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate;
        function Pizza (stageReference) {
            super(stageReference);
            _stage.start_x = 300;
            _stage.start_y = 310;
            localize([_stage.background_mc.kitchen_mc, _stage.background_mc.pizzaframe_mc.pizzamenu_mc, _stage.background_mc.sushiframe_mc.sushisign_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.plaza_btn, 420, 205), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.pizzatron_btn, 200, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat04_btn, 514, 253)]);
            _stage.desk_mc.register_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, registerAnimate);
            _stage.desk_mc.register_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.desk_mc.register_btn.useHandCursor = false;
            _stage.background_mc.pizzatron_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showPizzatronHint);
            _stage.background_mc.pizzatron_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hidePizzatronHint);
            _stage.triggers_mc.plaza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 580, 250);
            _stage.triggers_mc.pizzatron_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchPizzatronGame);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, openCatalogue);
        }
        function openCatalogue() {
            _INTERFACE.showContent("party_catalogue");
        }
        function registerAnimate() {
            if (_stage.desk_mc.register_mc._currentframe == 2) {
                _stage.desk_mc.register_mc.gotoAndStop(3);
            } else {
                _stage.desk_mc.register_mc.gotoAndStop(2);
            }
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function showPizzatronHint() {
            _INTERFACE.showHint(_stage.background_mc.pizzatron_btn, "pizzatron_hint");
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
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Pizza";
    }
