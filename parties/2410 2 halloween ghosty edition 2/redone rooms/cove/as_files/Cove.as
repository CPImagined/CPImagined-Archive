//Created by Action Script Viewer - https://www.buraks.com/asv
    class as_files.Cove extends as_files.ScavengerHuntRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, localize, setupNavigationButtons, _spoutInterval, _INTERFACE, _ENGINE, _triggerWatcherInterval;
        function Cove (stageReference) {
            super(stageReference);
            _stage.start_x = 405;
            _stage.start_y = 260;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            localize([]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navChair_btn, 375, 134), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navChair2_btn, 697, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navStool_btn, 422, 135), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navStool3_btn, 572, 223), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.navStool2_btn, 563, 265), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.waves_btn, 570, 410)]);
            _stage.navChair_btn.useHandCursor = false;
            _stage.navChair2_btn.useHandCursor = false;
            _stage.navStool_btn.useHandCursor = false;
            _stage.navStool3_btn.useHandCursor = false;
            _stage.navStool2_btn.useHandCursor = false;
            _stage.interface_mc.cove_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "cove_catalogue");
            _stage.waves_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, showWavesHintRollOver);
            _stage.waves_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hideWavesHintRollOut);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 595, 375);
            _stage.triggers_mc.waves_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchWavesGame);
            _spoutInterval = new com.clubpenguin.world.rooms.common.SyncedInterval(4, 0);
            _spoutInterval.signal.add(playSpout, this);
        }
        function playSpout() {
            _stage.plank_mc.spout_mc.play();
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function showWavesHintRollOver() {
            _INTERFACE.showHint(_stage.wavesBoard_mc, "waves_hint");
            _stage.wavesBoard_mc.gotoAndStop("rollOver");
        }
        function hideWavesHintRollOut() {
            _INTERFACE.closeHint();
            _stage.wavesBoard_mc.gotoAndStop("rollOut");
        }
        function launchWavesGame() {
            _ENGINE.sendJoinGame("waves", true);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _spoutInterval.destroy();
        }
        static var CLASS_NAME = "Cove";
    }
