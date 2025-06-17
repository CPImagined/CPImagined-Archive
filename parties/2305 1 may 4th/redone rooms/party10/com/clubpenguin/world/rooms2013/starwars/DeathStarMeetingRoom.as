//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.DeathStarMeetingRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, _SHELL, _destroyDelegate, setupNavigationButtons;
        function DeathStarMeetingRoom (stageReference) {
            super(stageReference);
            _stage.start_x = 230;
            _stage.start_y = 230;
            localize([_stage.background_mc.bgBitmap.toShip, _stage.background_mc.bgBitmap.exitSign, _stage.background_mc.bgBitmap.todaysTopic]);
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
            checkRoomState();
        }
        function checkRoomState() {
            var _local_2 =  "active";
            _stage.background_mc.lightonoff_mc.gotoAndStop(_local_2);
            if ("active" == _local_2) {
                _stage.triggers_mc.party15_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party15", 295, 150);
            } else {
                _stage.party15_btn._visible = false;
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.party8_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party8", 186, 350);
            _stage.triggers_mc.party11_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party11", 635, 330);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_mc.door_btn, 90, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.party8_btn, 260, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.party15_btn, 130, 430)]);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.background_mc.door_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, doorRollOver);
            _stage.background_mc.door_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, doorRollOut);
            _stage.background_mc.door_mc.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, doorRollOut);
            _stage.party15_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, lightRollOver);
            _stage.party15_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, lightRollOut);
            _stage.party15_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, lightRollOut);
            _stage.testOn_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevatorsUnlocked);
            _stage.testOff_btn.onRelease = com.clubpenguin.util.Delegate.create(this, elevatorsLocked);
        }
        function doorRollOver() {
            _stage.background_mc.door_mc.gotoAndPlay(10);
        }
        function doorRollOut() {
            _stage.background_mc.door_mc.gotoAndPlay(50);
        }
        function lightRollOver() {
            _stage.background_mc.lightonoff_mc.lightgreen_mc.gotoAndStop(2);
        }
        function lightRollOut() {
            _stage.background_mc.lightonoff_mc.lightgreen_mc.gotoAndStop(1);
        }
        function elevatorsUnlocked() {
            _stage.background_mc.lightonoff_mc.gotoAndStop(2);
        }
        function elevatorsLocked() {
            _stage.background_mc.lightonoff_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "TatooineHub";
    }
