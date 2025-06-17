//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Attic extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _engine, _interface, _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _triggerWatcherInterval;
        function Attic (stageReference) {
            super(stageReference);
            _engine = _global.getCurrentEngine();
            _interface = _global.getCurrentInterface();
            _stage.start_x = 382;
            _stage.start_y = 202;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.lodge_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "lodge", 570, 225);
            _stage.triggers_mc.boxdimension_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "boxdimension", 540, 160);
            _stage.background_mc.horse_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, horseRollOver);
            _stage.background_mc.box_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, boxRollOver);
            _stage.background_mc.box_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, boxRollOut);
            _stage.background_mc.box_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, boxRollOut);
            _stage.triggers_mc.table200_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 200);
            _stage.table200_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table200_mc);
            _stage.table200_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table200_mc);
            _stage.table200_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table200_mc);
            _stage.triggers_mc.table201_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 201);
            _stage.table201_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table201_mc);
            _stage.table201_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table201_mc);
            _stage.table201_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table201_mc);
            _stage.triggers_mc.table202_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 202);
            _stage.table202_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table202_mc);
            _stage.table202_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table202_mc);
            _stage.table202_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table202_mc);
            _stage.triggers_mc.table203_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, playTableGame, 203);
            _stage.table203_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, tableRollOver, _stage.table203_mc);
            _stage.table203_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table203_mc);
            _stage.table203_mc.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, tableRollOut, _stage.table203_mc);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.lodge_btn, 621, 252), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.box_btn, 488, 408), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table200_mc, 118, 332), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table201_mc, 170, 380), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table202_mc, 300, 388), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.table203_mc, 350, 346)]);
            _stage.background_mc.horse_btn.useHandCursor = false;
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function playTableGame(tableNumber) {
            _engine.sendJoinTable("four", tableNumber, true);
        }
        function tableRollOver(mc) {
            _interface.showHint(mc, "four_hint", 0, -50);
            mc.game_mc.gotoAndStop(2);
        }
        function tableRollOut(mc) {
            _interface.closeHint();
            mc.game_mc.gotoAndStop(1);
        }
        function horseRollOver() {
            _stage.rockingHorse_mc.gotoAndPlay(2);
        }
        function boxRollOver() {
            _stage.foreground_mc.fgRight_mc.box_mc.gotoAndStop(2);
        }
        function boxRollOut() {
            _stage.foreground_mc.fgRight_mc.box_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Attic";
    }
