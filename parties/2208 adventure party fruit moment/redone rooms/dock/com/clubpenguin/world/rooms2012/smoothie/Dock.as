//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.smoothie.Dock extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, localize, _triggerWatcherInterval, _opcodeJournal, _INTERFACE, _ENGINE;
        function Dock (stageReference) {
            super(stageReference);
            _stage.start_x = 257;
            _stage.start_y = 295;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms2012.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.beach_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "beach", 400, 270);
            _stage.triggers_mc.skihill_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 775, 338);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 195, 336);
            _stage.melon_mc.watermelon_btn.onRelease = com.clubpenguin.util.Delegate.create(this, collectWatermelon);
            _stage.itemCrate_mc.free_btn.onRelease = com.clubpenguin.util.Delegate.create(this, collectFreeItem);
            _stage.tablet_mc.partycat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
            _stage.interface_mc.party_btn_states.clothing_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showPartyCatalog);
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showDockCatalog);
            _stage.boat_mc.onRollOver = com.clubpenguin.util.Delegate.create(this, showHydroHopperHint);
            _stage.boat_mc.onRollOut = com.clubpenguin.util.Delegate.create(this, hideHint);
            _stage.triggers_mc.boat_trigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, playBoatGame);
            hideWatermelonIfUserHasCollectedIt();
            showSmoothieShack();
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boat_mc, 103, 375), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.shackFront_mc.kioskSign_mc.kioskSign_btn, 620, 375)]);
            localize([_stage.shackFront_mc.kioskSign_mc, _stage.itemCrate_mc.signfree_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _opcodeJournal = new com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal();
            _opcodeJournal.init(_SHELL.getMyPlayerId());
        }
        function showDockCatalog() {
            _INTERFACE.showContent("dock_catalogue");
        }
        function playBoatGame() {
            _ENGINE.sendJoinGame("hydro", true);
        }
        function collectFreeItem() {
            _INTERFACE.buyInventory(com.clubpenguin.world.rooms2012.smoothie.Smoothie.WATERMELON_HEADBAND);
        }
        function showHydroHopperHint() {
            _INTERFACE.showHint(_stage.boat_mc, "hydro_hint", -50, 30);
        }
        function hideHint() {
            _INTERFACE.closeHint();
        }
        function showSmoothieShack() {
            if (com.clubpenguin.world.rooms2012.smoothie.Smoothie.showSmoothieGame()) {
                _stage.statueShack_mc.gotoAndStop(2);
                _stage.shackFront_mc.gotoAndStop(2);
                _stage.triggers_mc.smoothieGame_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, launchSmoothieGame);
            }
        }
        function showPartyCatalog() {
            _INTERFACE.showContent(com.clubpenguin.world.rooms2012.smoothie.Smoothie.PARTY_CATALOGUE);
        }
        function launchSmoothieGame() {
            _opcodeJournal.sendOpcode(com.clubpenguin.world.rooms2012.smoothie.OpcodeJournal.PLAY_SMOOTHIE_SMASH);
            _ENGINE.sendJoinGame("smoothie", true);
        }
        function hideWatermelonIfUserHasCollectedIt() {
            if (_INTERFACE.scavengerHunt.isItemFound(com.clubpenguin.world.rooms2012.smoothie.Smoothie.SCAVENGER_WATERMELON)) {
                _stage.melon_mc.gotoAndStop(2);
            }
            if (!_SHELL.isMyPlayerMember()) {
                _stage.melon_mc.gotoAndStop(2);
            }
        }
        function collectWatermelon() {
            _stage.melon_mc.gotoAndStop(2);
            _INTERFACE.scavengerHunt.itemFound(com.clubpenguin.world.rooms2012.smoothie.Smoothie.SCAVENGER_WATERMELON);
            _INTERFACE.showContent(com.clubpenguin.world.rooms2012.smoothie.Smoothie.CONTENT_SCAVENGER_HUNT);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Dock";
    }
