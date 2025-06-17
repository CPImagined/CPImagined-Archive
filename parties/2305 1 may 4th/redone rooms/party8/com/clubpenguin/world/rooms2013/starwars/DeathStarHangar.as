//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DeathStarHangar extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, setupNavigationButtons;
        function DeathStarHangar (stageReference) {
            super(stageReference);
            _stage.start_x = 170;
            _stage.start_y = 270;
            if (!_SHELL) {
                init();
            }
            com.clubpenguin.world.rooms2013.starwars.StarWarsParty.instance.waitForPlayerLoadComplete("DeathStar");
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.starwars.StarWarsParty, com.clubpenguin.world.rooms2013.starwars.StarWarsParty.launchCatalogue);
        }
        function configureTriggers() {
            _stage.triggers_mc.throneRoomTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party9", 385, 355);
            _stage.triggers_mc.meetingRoomTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 250, 180);
            _stage.triggers_mc.falconTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 655, 353);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.throneRoom_mc.nav_btn, 97, 198), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.meetingRoomExit_mc.nav_btn, 65, 450), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cockpit_mc.nav01_btn, 414, 269), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.cockpit_mc.nav02_btn, 452, 266), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.falcon_mc.nav_btn, 342, 262)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.customPenguinSize = 65;
            _stage.cockpit_mc.nav01_btn.useHandCursor = false;
            _stage.cockpit_mc.nav02_btn.useHandCursor = false;
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DeathStarHangar";
    }
