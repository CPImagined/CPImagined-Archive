//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Beach extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _SHELL, localize, setupNavigationButtons, _ENGINE, _INTERFACE;
        function Beach (stageReference) {
            super(stageReference);
            _stage.start_x = 475;
            _stage.start_y = 290;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            localize([_stage.livingSled, _stage.roboMaker, _stage.garage1, _stage.garage2, _stage.garageSignRobot, _stage.garageSignPenguin, _stage.tombstones3]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navBtn_light1, 105, 218), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navBtn_light2, 202, 204)]);
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 200, 170);
            _stage.triggers_mc.guitar_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playguitar);
            _stage.triggers_mc.robo_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, roboTriggerFunction);
            _stage.triggers_mc.penguin_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, penguinTriggerFunction);
            _stage.triggers_mc.robo_mc.gotoAndStop("on");
            _stage.block_mc.roboBlock_mc.gotoAndStop("off");
            _stage.triggers_mc.penguin_mc.gotoAndStop("on");
            _stage.block_mc.penguinBlock_mc.gotoAndStop("off");
            _stage.foreground_mc.navBtn_garage1.onRollOver = com.clubpenguin.util.Delegate.create(this, garage1RollOver);
            _stage.foreground_mc.navBtn_garage1.onRollOut = com.clubpenguin.util.Delegate.create(this, garage1RollOut);
            _stage.foreground_mc.navBtn_garage1.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, garage1RollOut);
            _stage.foreground_mc.navBtn_garage1.onRelease = com.clubpenguin.util.Delegate.create(this, garage1Release);
            _stage.foreground_mc.navBtn_garage2.onRollOver = com.clubpenguin.util.Delegate.create(this, garage2RollOver);
            _stage.foreground_mc.navBtn_garage2.onRollOut = com.clubpenguin.util.Delegate.create(this, garage2RollOut);
            _stage.foreground_mc.navBtn_garage2.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, garage2RollOut);
            _stage.foreground_mc.navBtn_garage2.onRelease = com.clubpenguin.util.Delegate.create(this, garage2Release);
            _stage.navBtn_light1.onRollOver = com.clubpenguin.util.Delegate.create(this, light1DoorRollOver);
            _stage.navBtn_light1.onRollOut = com.clubpenguin.util.Delegate.create(this, light1DoorRollOut);
            _stage.navBtn_light1.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, light1DoorRollOut);
            _stage.navBtn_light2.onRollOver = com.clubpenguin.util.Delegate.create(this, light2DoorRollOver);
            _stage.navBtn_light2.onRollOut = com.clubpenguin.util.Delegate.create(this, light2DoorRollOut);
            _stage.navBtn_light2.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, light2DoorRollOut);
        }
        function garage1RollOver() {
            if (_stage.lock_robot._currentframe != 10) {
                _stage.garage1Door.gotoAndStop("open");
            }
        }
        function garage1RollOut() {
            if (_stage.lock_robot._currentframe != 10) {
                if (_stage.doorTimer_Robot._currentframe == 1) {
                    _stage.garage1Door.gotoAndStop("close");
                }
            }
        }
        function garage1Release() {
            _ENGINE.sendPlayerMove(298, 193);
            _stage.doorTimer_Robot.gotoAndPlay("start");
        }
        function garage2RollOver() {
            if (_stage.lock_penguin._currentframe != 10) {
                _stage.garage2Door.gotoAndStop("open");
            }
        }
        function garage2RollOut() {
            if (_stage.lock_penguin._currentframe != 10) {
                if (_stage.doorTimer_Penguin._currentframe == 1) {
                    _stage.garage2Door.gotoAndStop("close");
                }
            }
        }
        function garage2Release() {
            _ENGINE.sendPlayerMove(384, 184);
            _stage.doorTimer_Penguin.gotoAndPlay("start");
        }
        function roboTriggerFunction() {
            if (_stage.garage2Door._currentframe == 10) {
                _stage.garage2Door.gotoAndStop("close");
            }
            _stage.lock_robot.gotoAndStop("lock");
            _stage.lock_penguin.gotoAndStop("lock");
            _INTERFACE.showContent("w.p2024.halloween.monster_maker");
        }
        function penguinTriggerFunction() {
            if (_stage.garage1Door._currentframe == 10) {
                _stage.garage1Door.gotoAndStop("close");
            }
            _stage.lock_robot.gotoAndStop("lock");
            _stage.lock_penguin.gotoAndStop("lock");
            _stage.director_penguin.gotoAndPlay("start");
        }
        function light1DoorRollOver(contentID) {
            _stage.doorB_mc.gotoAndStop(2);
        }
        function light1DoorRollOut(contentID) {
            _stage.doorB_mc.gotoAndStop(1);
        }
        function light2DoorRollOver(contentID) {
            _stage.doorA_mc.gotoAndStop(2);
        }
        function light2DoorRollOut(contentID) {
            _stage.doorA_mc.gotoAndStop(1);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function playguitar() {
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Beach";
    }
