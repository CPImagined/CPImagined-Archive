//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Lodge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _engine, _interface, _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Lodge (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _engine = _global.getCurrentEngine();
            _interface = _global.getCurrentInterface();
            _stage.start_x = 320;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 441, 265);
            _stage.triggers_mc.attic_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "attic", 556, 274);
            _stage.triggers_mc.pufflewild_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pufflewild", 400, 350);
            _stage.triggers_mc.fish_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playFishingGame);
            _stage.background_mc.village_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, villageRollOver);
            _stage.background_mc.village_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, villageRollOut);
            _stage.background_mc.puffle_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, puffleRollOver);
            _stage.background_mc.puffle_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, puffleRollOut);
            _stage.background_mc.fish_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, fishRollOver);
            _stage.background_mc.fish_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, fishRollOut);
            _stage.background_mc.attic_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, atticRollOver);
            _stage.background_mc.attic_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, atticRollOut);
            _stage.table205_mc.seat_frames = [24, 20];
            _stage.table206_mc.seat_frames = [18, 22];
            _stage.table207_mc.seat_frames = [22, 18];
            _stage.triggers_mc.table205_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 205);
            _stage.table205_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table205_mc);
            _stage.table205_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table205_mc);
            _stage.table205_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table205_mc);
            _stage.triggers_mc.table206_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 206);
            _stage.table206_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table206_mc);
            _stage.table206_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table206_mc);
            _stage.table206_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table206_mc);
            _stage.triggers_mc.table207_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 207);
            _stage.table207_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table207_mc);
            _stage.table207_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table207_mc);
            _stage.table207_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table207_mc);
            _stage.interface_mc.lodge_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showGameUpgrades);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.village_btn, 60, 235), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.puffle_btn, 230, 140), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.fish_btn, 510, 120), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.attic_btn, 650, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table205_mc, 481, 290), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table206_mc, 379, 364), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table207_mc, 556, 369)]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function showGameUpgrades() {
            _interface.showContent("lodge_catalogue");
            trace("show lodge catalogue");
        }
        function villageRollOver() {
            _stage.village_mc.gotoAndStop("2");
        }
        function villageRollOut() {
            _stage.village_mc.gotoAndStop("1");
        }
        function puffleRollOver() {
            _stage.background_mc.puffle_mc.gotoAndStop("2");
        }
        function puffleRollOut() {
            _stage.background_mc.puffle_mc.gotoAndStop("1");
        }
        function atticRollOver() {
            _stage.attic_mc.gotoAndStop("2");
        }
        function atticRollOut() {
            _stage.attic_mc.gotoAndStop("1");
        }
        function fishRollOver() {
            _interface.showHint(_stage.background_mc.fishDoor_mc, "fish_hint", 30, 30);
            _stage.background_mc.fishDoor_mc.gotoAndStop("2");
        }
        function fishRollOut() {
            _interface.closeHint();
            _stage.background_mc.fishDoor_mc.gotoAndStop("1");
        }
        function playFishingGame() {
            trace("PLAY FISHING GAME - _engine : " + _engine);
            _engine.sendJoinGame("fish", true);
        }
        function playTableGame(tableNumber) {
            trace("PLAY TABLE GAME - tableNumber :  " + tableNumber);
            trace("PLAY TABLE GAME - _engine :  " + _engine);
            _engine.sendJoinTable("four", tableNumber, true);
        }
        function tableRollOver(mc) {
            _interface.showHint(mc, "four_hint", 0, -50);
            mc.game_mc.gotoAndStop(2);
            trace("PLAY TABLE GAME tableRollOver - _interface :  " + _interface);
        }
        function tableRollOut(mc) {
            trace("PLAY TABLE GAME tableRollOut - _interface :  " + _interface);
            _interface.closeHint();
            mc.game_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Lodge";
    }
