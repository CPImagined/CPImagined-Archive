//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.teenbeach.SurfRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _AIRTOWER, _joinRoomDelegate, _ENGINE, setupNavigationButtons, _triggerWatcher, _boatTrigger, _triggerWatcherInterval, _INTERFACE;
        function SurfRoom (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 250;
            _stage.start_y = 250;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.activateTeenBeachPlayerOverrides();
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _AIRTOWER = _global.getCurrentAirtower();
            _joinRoomDelegate = com.clubpenguin.util.Delegate.create(this, handleJoinRoom);
            _ENGINE.penguinTransformComplete.add(_joinRoomDelegate);
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.configureItemHut(CLASS_NAME.toLowerCase(), _stage.boatFront.hutBob.itemHut_mc);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _quality  = "MEDIUM";
            _stage.interface_mc.catalogue_btn.onRelease = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.showCatalogue);
            if (!com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.checkHasVisitedSurfRoom()) {
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.setSurfRoomVisited();
                com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2013.teenbeach.OpcodeJournal.FIRST_TIME_IN_SURF_ROOM);
            }
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boatFront.hutBob.itemHut_mc.itemHut_btn, 380, 410), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boatFront.map_btn, 505, 400)]);
            _stage.nav1_btn.useHandCursor = false;
            _stage.nav2_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.itemHutTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty, com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.collectPartyItem, CLASS_NAME.toLowerCase());
            _stage.triggers_mc.mapTrigger_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, showMap);
            _boatTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.boatTrigger_mc);
            _boatTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, hideSurfboard));
            _boatTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, showSurfboard));
            _triggerWatcher.addTrigger(_boatTrigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureRoomElements() {
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.background_mc.elevatorDoor1_mc.elevator_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showMap);
        }
        function handleJoinRoom(playerObj) {
            var _local_2 = _ENGINE.getPlayerMovieClip(playerObj.player_id);
            _local_2.attachMovie("Surfboard", "surfboard", playerObj.getNextHighestDepth(), {_x:0, _y:0});
        }
        function hideSurfboard(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_3 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                _local_3.surfboard._visible = false;
                _local_2++;
            }
        }
        function showSurfboard(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_4 = _ENGINE.getPlayerMovieClip(players[_local_2]);
                _ENGINE.updatePlayerFrame(players[_local_2], 1);
                _local_4.surfboard._visible = true;
                _local_2++;
            }
        }
        function showMap() {
            _INTERFACE.showContent("map");
        }
        function configureItemHut() {
        }
        function collectPartyItem() {
        }
        function exit(name, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(name, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            _quality  = "HIGH";
            com.clubpenguin.world.rooms2013.teenbeach.TeenBeachParty.instance.deactivateTeenBeachPlayerOverrides();
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "party3";
    }
