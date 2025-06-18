//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.Plaza extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, localize, _triggerWatcherInterval;
        function Plaza (stageReference) {
            super(stageReference);
            _stage.start_x = 350;
            _stage.start_y = 345;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.park_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "park", 335, 145);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 630, 335);
            _stage.triggers_mc.pet_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pet", 380, 210);
            _stage.triggers_mc.hotel_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "hotellobby", 380, 210);
            _stage.triggers_mc.stage_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "mall", 105, 330);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "pizza", 385, 285);
            _stage.triggers_mc.cave_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "cave", 590, 307);
            _stage.triggers_mc.forest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forest", 140, 228);
            _stage.manhole_mc.manhole_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, manholeRollOver);
            _stage.manhole_mc.manhole_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, manholeRollOut);
            _stage.pet_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, petshopRollOver);
            _stage.pet_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, petshopRollOff);
            _stage.hotel_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, hotelRollOver);
            _stage.hotel_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, hotelRollOff);
            _stage.stage_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, stageRollOver);
            _stage.stage_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, stageRollOff);
            _stage.pizza_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, pizzaRollOver);
            _stage.pizza_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, pizzaRollOff);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forest_btn, 745, 395), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.park_btn, 30, 230), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.forts_btn, 11, 404), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pet_btn, 197, 254), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.hotel_btn, 344, 256), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.treasure_mc.treasure_btn, 343, 145), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.manhole_mc.manhole_btn, 470, 310), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stage_btn, 522, 255), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pizza_btn, 663, 270)]);
            _stage.forts_btn.useHandCursor = false;
            _stage.forest_btn.useHandCursor = false;
            _stage.park_btn.useHandCursor = false;
            localize([_stage.langHotel_mc, _stage.langPizza_mc, _stage.langStage_mc]);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function initializePartyCookieDependentAssets() {
            _global.getCurrentParty().PirateParty.configureTreasureChestState(_stage.chest_mc, _stage.crabs_mc, _stage.treasure_btn);
        }
        function manholeRollOver() {
            _stage.manhole_mc.gotoAndPlay("lidOpen");
        }
        function manholeRollOut() {
            _stage.manhole_mc.gotoAndPlay("lidClose");
        }
        function petshopRollOver() {
            _stage.doorPet_mc.gotoAndStop(2);
        }
        function petshopRollOff() {
            _stage.doorPet_mc.gotoAndStop(1);
        }
        function hotelRollOver() {
            _stage.doorHotel_mc.gotoAndStop(2);
        }
        function hotelRollOff() {
            _stage.doorHotel_mc.gotoAndStop(1);
        }
        function stageRollOver() {
            _stage.doorStage_mc.gotoAndStop(2);
        }
        function stageRollOff() {
            _stage.doorStage_mc.gotoAndStop(1);
        }
        function pizzaRollOver() {
            _stage.doorPizza_mc.gotoAndStop(2);
        }
        function pizzaRollOff() {
            _stage.doorPizza_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Plaza";
    }
