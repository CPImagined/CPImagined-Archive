//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Village extends as_files.ScavengerHuntRoom
    {
        var _stage, localize, _destroyDelegate, _SHELL, setupNavigationButtons, _INTERFACE;
        function Village (stageReference) {
            super(stageReference);
            _stage.start_x = 515;
            _stage.start_y = 360;
            localize([_stage.tour_mc.langTour_mc, _stage.epfsign_mc]);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.lodge_btn, 504, 201), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.epf_btn, 660, 260)]);
            _stage.tour_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onTourButtonClicked);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 480, 180);
            _stage.triggers_mc.mtn_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mtn", 420, 160);
            _stage.triggers_mc.lodge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lodge", 170, 247);
            _stage.triggers_mc.epf_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "agentlobbymulti", 180, 265);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 305, 160);
            _stage.triggers_mc.wild_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 380, 390);
            _stage.lodge_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, lodgeRollOver);
            _stage.lodge_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, lodgeRollOut);
            _stage.lodge_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, lodgeRollOut);
            _stage.epf_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, epfRollOver);
            _stage.epf_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, epfRollOut);
            _stage.epf_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, epfRollOut);
            _stage.tour_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, tourRollOver);
            _stage.tour_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, tourRollOut);
            _stage.tour_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tourRollOut);
        }
        function lodgeRollOver() {
            _stage.lodgeDoor_mc.gotoAndStop(2);
        }
        function lodgeRollOut() {
            _stage.lodgeDoor_mc.gotoAndStop(1);
        }
        function epfRollOver() {
            _stage.epfDoor_mc.gotoAndStop(2);
        }
        function epfRollOut() {
            _stage.epfDoor_mc.gotoAndStop(1);
        }
        function tourRollOver() {
            _stage.tour_mc.gotoAndStop(2);
        }
        function tourRollOut() {
            _stage.tour_mc.gotoAndStop(1);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function onTourButtonClicked() {
            if (_INTERFACE.isTourGuide()) {
                _INTERFACE.showContent("give_tour");
            } else {
                _INTERFACE.showContent("take_tour");
            }
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Village";
    }
