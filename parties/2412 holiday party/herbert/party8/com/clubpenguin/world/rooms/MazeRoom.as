//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.MazeRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, _ENGINE, _showContentDelegate, _showContentTimeout, _SHELL, _INTERFACE, _destroyDelegate;
        function MazeRoom (stageReference) {
            super(stageReference);
            _stage.start_x = 375;
            _stage.start_y = 320;
            localize([_stage.foreground_mc.computerLang_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.foreground_mc.exit_btn, 375, 395)]);
            _stage.foreground_mc.exit_btn.useHandCursor = false;
            var mazeReset = true
            if (mazeReset == true) {
                _stage.foreground_mc.darkness_mc.gotoAndStop("dark");
                _stage.foreground_mc.key01_mc.gotoAndStop("present");
                _stage.foreground_mc.key02_mc.gotoAndStop("present");
                _stage.foreground_mc.key03_mc.gotoAndStop("present");
                _stage.foreground_mc.computerLang_mc.computer_mc.gotoAndStop("park");
            }
            _stage.foreground_mc.move_btn.onRelease = com.clubpenguin.util.Delegate.create(this, moveToMouse);
            _stage.foreground_mc.move_btn.useHandCursor = false;
            _stage.triggers_mc.exitTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 204, 165);
            _stage.onEnterFrame = com.clubpenguin.util.Delegate.create(this, updateDarkness);
            _stage.triggers_mc.key01Trigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, key01Collect);
            _stage.triggers_mc.key02Trigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, key02Collect);
            _stage.triggers_mc.key03Trigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, key03Collect);
        }
        function updateDarkness(event) {
            _stage.foreground_mc.darkness_mc._x = _ENGINE.player_x;
            _stage.foreground_mc.darkness_mc._y = _ENGINE.player_y;
        }
        function moveToMouse() {
            _ENGINE.sendPlayerMove(_xmouse, _ymouse);
        }
        function key01Collect() {
            if (_stage.foreground_mc.key01_mc._currentframe == 1) {
                _stage.foreground_mc.key01_mc.gotoAndPlay("collected");
                keyCollected();
            }
        }
        function key02Collect() {
            if (_stage.foreground_mc.key02_mc._currentframe == 1) {
                _stage.foreground_mc.key02_mc.gotoAndPlay("collected");
                keyCollected();
            }
        }
        function key03Collect() {
            if (_stage.foreground_mc.key03_mc._currentframe == 1) {
                _stage.foreground_mc.key03_mc.gotoAndPlay("collected");
                keyCollected();
            }
        }
        function keyCollected() {
            _stage.foreground_mc.computerLang_mc.computer_mc.play();
        }
        function onActivatedAnimationComplete() {
            if (com.clubpenguin.world.rooms2015.automated.party.NovemberParty.partyCookie.hasPlayerCompletedTask(mazeCompleteTaskId)) {
                return(undefined);
            }
            _showContentDelegate = com.clubpenguin.util.Delegate.create(this, onContentShow);
            _showContentTimeout = setTimeout(_showContentDelegate, 1000);
        }
        function onContentShow() {
            clearTimeout(_showContentTimeout);
            showContent(mazeCompletePopupPathToken);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.customPenguinSize = 80;
        }
        function destroy() {
            clearTimeout(_showContentTimeout);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "MazeRoom";
        var mazeReset = true;
        var mazeCompleteTaskId = -1;
        var mazeCompletePopupPathToken = "";
    }
