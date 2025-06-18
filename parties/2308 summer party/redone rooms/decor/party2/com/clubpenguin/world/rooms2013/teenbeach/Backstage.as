//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.Backstage extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, _mascotCheckTrigger, setupNavigationButtons, _triggerWatcherInterval, _INTERFACE, _ENGINE;
        function Backstage (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 278;
            _stage.start_y = 286;
            init();
        }
        function init() {
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.activateTeenBeachBackStageSettings();
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 575, 215);
            _stage.triggers_mc.bigmommas_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party1", 389, 207);
            _stage.triggers_mc.cameraFlash_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, takePlayerPhoto);
            _mascotCheckTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.mascotCheck_mc);
            _mascotCheckTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, teleportPlayersOffStage));
            _triggerWatcher.addTrigger(_mascotCheckTrigger);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.door_btn, 725, 254), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 564, 123)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.showCatalogue);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function takePlayerPhoto() {
            _stage.camera_MC.cameraflash_MC.gotoAndPlay(2);
            if (!_SHELL.isItemInMyInventory(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.BACKSTAGE_BACKGROUND_ITEM_ID)) {
                _INTERFACE.buyInventory(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.BACKSTAGE_BACKGROUND_ITEM_ID);
            }
        }
        function teleportPlayersOffStage(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (!_SHELL.isPlayerMascotById(players[_local_2]) && !_SHELL.playerModel.isPlayerModerator(players[_local_2])) {
                    _ENGINE.teleportPlayer(players[_local_2], _stage.start_x, _stage.start_y);
                }
                _local_2++;
            }
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.deactivateTeenBeachBackStageSettings();
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Backstage";
        var playersOnStage = new Array();
    }
