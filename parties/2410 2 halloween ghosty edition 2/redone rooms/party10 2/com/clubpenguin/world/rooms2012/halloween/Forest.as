//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.Forest extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, localize, _triggerWatcherInterval, _ghostAnimator;
        function Forest (stageReference) {
            super(stageReference);
            _stage.start_x = 475;
            _stage.start_y = 412;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 630, 225);
            _stage.triggers_mc.shack_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "shack", 160, 410);
            _stage.triggers_mc.foyer_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 382, 400);
            localize([_stage.signstage2_mc, _stage.background_mc.filmsign_mc, _stage.background_mc.signstage3_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _ghostAnimator = new com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator([_stage.ghost0, _stage.ghost1], com.clubpenguin.world.rooms2012.halloween.HauntedGhostAnimator.MODE_PLAY_ONE_DELAYED);
        }
        function checkIfMascot(roomName, x, y) {
            if (_SHELL.isPlayerMascotById(_SHELL.getMyPlayerId())) {
                _SHELL.sendJoinRoom(roomName, x, y);
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _ghostAnimator.destroy();
        }
        static var CLASS_NAME = "Forest";
    }
