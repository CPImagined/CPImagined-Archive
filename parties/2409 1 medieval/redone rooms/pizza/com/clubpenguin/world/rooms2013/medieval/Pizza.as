//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.Pizza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons, localize, setupHint, _ENGINE;
        function Pizza (stageReference) {
            super(stageReference);
            _stage.start_x = 455;
            _stage.start_y = 235;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _stage.interface_mc.catalogue_Btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance, com.clubpenguin.world.rooms2013.medieval.MedievalParty.instance.showPartyCatalogue);
        }
        function configureTriggers() {
            _stage.triggers_mc.plazaTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "plaza", 560, 280);
            _stage.triggers_mc.pizzatronTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchPizzatronGame);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_mc.exit_btn, 460, 155), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.kitchen_mc.kitchen_btn, 224, 147), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat01_mc.nav_btn, 108, 327), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat02_mc.nav_btn, 72, 355), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat03_mc.nav_btn, 201, 432), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat04_mc.nav_btn, 250, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat05_mc.nav_btn, 556, 268), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat06_mc.nav_btn, 576, 322), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat07_mc.nav_btn, 717, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat08_mc.nav_btn, 734, 295), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat09_mc.nav_btn, 290, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.seat10_mc.nav_btn, 263, 293)]);
        }
        function configureRoomElements() {
            localize([_stage.tree_mc.kitchenSign_mc.kitchen_mc]);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.seat01_mc.nav_btn.useHandCursor = false;
            _stage.seat02_mc.nav_btn.useHandCursor = false;
            _stage.seat03_mc.nav_btn.useHandCursor = false;
            _stage.seat04_mc.nav_btn.useHandCursor = false;
            _stage.seat05_mc.nav_btn.useHandCursor = false;
            _stage.seat06_mc.nav_btn.useHandCursor = false;
            _stage.seat07_mc.nav_btn.useHandCursor = false;
            _stage.seat08_mc.nav_btn.useHandCursor = false;
            _stage.seat09_mc.nav_btn.useHandCursor = false;
            _stage.seat10_mc.nav_btn.useHandCursor = false;
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.kitchen_mc.kitchen_btn, _stage.background_mc.kitchen_mc, "pizzatron_hint")]);
        }
        function launchPizzatronGame() {
            _ENGINE.sendJoinGame("pizzatron", true);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Pizza";
    }
