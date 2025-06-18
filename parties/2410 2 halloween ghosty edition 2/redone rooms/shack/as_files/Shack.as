//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Shack extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _INTERFACE;
        function Shack (stageReference) {
            super(stageReference);
            _stage.start_x = 375;
            _stage.start_y = 320;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            var _local_3 = 1;
            while (_local_3 <= 5) {
                var _local_5 = new com.clubpenguin.world.rooms2014.halloween.Coffin(_stage.backWall["coffin" + _local_3]);
                var _local_4 = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc[("locker" + _local_3) + "_mc"]);
                _local_4.playersAdded.add(com.clubpenguin.util.Delegate.create(this, openLocker, _local_5));
                _local_4.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, closeLocker, _local_4, _local_5));
                _triggerWatcher.addTrigger(_local_4);
                _local_3++;
            }
        }
        function configureTriggers() {
            _stage.triggers_mc.school_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 645, 385);
            _stage.triggers_mc.dojo_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dojoext", 390, 375);
            _stage.triggers_mc.mine_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mine", 415, 175);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 670, 333);
            _stage.triggers_mc.skate_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "skatepark", 120, 160);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.castleFront.school_btn, 325, 286), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.dojo_btn, 404, 223), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backWall.mine.mine_btn, 525, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.skate_btn, 745, 260), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair1_btn, 436, 318), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair2_btn, 494, 293), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chair3_btn, 545, 319), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backWall.coffin1.coffin_btn, 33, 250), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backWall.coffin2.coffin_btn, 60, 243), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backWall.coffin3.coffin_btn, 94, 239), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backWall.coffin4.coffin_btn, 126, 244), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backWall.coffin5.coffin_btn, 158, 252)]);
        }
        function configureRoomElements() {
            _stage.skate_btn.useHandCursor = false;
            _stage.dojo_btn.useHandCursor = false;
            _stage.chair1_btn.useHandCursor = false;
            _stage.chair2_btn.useHandCursor = false;
            _stage.chair3_btn.useHandCursor = false;
            _stage.backWall.coffin1.coffin_btn.useHandCursor = false;
            _stage.backWall.coffin2.coffin_btn.useHandCursor = false;
            _stage.backWall.coffin3.coffin_btn.useHandCursor = false;
            _stage.backWall.coffin4.coffin_btn.useHandCursor = false;
            _stage.backWall.coffin5.coffin_btn.useHandCursor = false;
            _stage.backWall.mine.mine_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, mineRollOver);
            _stage.backWall.mine.mine_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, mineRollOut);
        }
        function mineRollOver() {
            _stage.backWall.mine.gotoAndPlay(9);
        }
        function mineRollOut() {
            _stage.backWall.mine.gotoAndStop(1);
        }
        function openLocker(players, locker) {
            if (players.length > 0) {
                locker.openLocker();
            }
        }
        function closeLocker(players, trigger, locker) {
            if (trigger.getPlayerCount() == 0) {
                locker.closeLocker();
            }
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Shack";
    }
