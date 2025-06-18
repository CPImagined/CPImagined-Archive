//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.ninja.Lodge extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, setupNavigationButtons, setupHint, _INTERFACE, _ENGINE, _SHELL, _destroyDelegate, _triggerWatcher;
        function Lodge (stageReference) {
            super(stageReference);
            _stage.start_x = 475;
            _stage.start_y = 205;
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit_btn, 384, 444), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.fish_btn, 295, 188), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.attic_btn, 494, 189)]);
            _stage.groom1_mc.groom1_btn.useHandCursor = false;
            _stage.groom2_mc.groom2_btn.useHandCursor = false;
            setupHint([new com.clubpenguin.world.rooms.common.HintVO(_stage.background_mc.fish_btn, _stage.background_mc.fish_btn, "fish_hint")]);
            _stage.triggers_mc.fish_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, joinFishGame);
            _stage.interface_mc.lodge_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalog);
            _stage.interface_mc.party_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(_INTERFACE, _INTERFACE.showContent, "party_catalogue");
            _stage.triggers_mc.attic_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "attic", 483, 280);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 440, 283);
        }
        function joinFishGame() {
            _ENGINE.sendJoinGame("fish", true);
        }
        function showCatalog() {
            _INTERFACE.showContent("lodge_catalogue");
        }
        function exit(name, x, y) {
            _SHELL.sendJoinRoom(name, x, y);
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function update() {
            _triggerWatcher.checkAllPlayers();
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Lodge";
    }
