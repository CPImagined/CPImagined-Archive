//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.hollywood.Shop extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _destroyDelegate, _SHELL, _triggerWatcher, setupNavigationButtons, _sewingATrigger, _sewingBTrigger, _sewingCTrigger, _triggerWatcherInterval, _INTERFACE;
        function Shop (stageReference) {
            super(stageReference);
            _stage.start_x = 560;
            _stage.start_y = 300;
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.triggers_mc.town_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "town", 524, 280);
            _stage.triggers_mc.redemption_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, pickUpItem);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.wall_mc.door_btn, 545, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.chest_mc.chest_btn, 260, 345)]);
            _stage.interface_mc.party_catalog_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalog, com.clubpenguin.world.rooms2013.hollywood.Hollywood.PARTY_CATALOGUE_1);
            _stage.interface_mc.clothing_btn_states.clothing_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showCatalog, "clothing_catalogue");
            _stage.switchbox_mc.switchbox1_mc.bluebtn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, setLights, 1);
            _stage.switchbox_mc.switchbox1_mc.yellowbtn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, setLights, 2);
            _stage.switchbox_mc.switchbox1_mc.greenbtn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, setLights, 3);
            _stage.switchbox_mc.switchbox1_mc.redbtn_mc.onRelease = com.clubpenguin.util.Delegate.create(this, setLights, 4);
            _sewingATrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.chairA_mc);
            _sewingATrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startSewingA));
            _sewingATrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopSewingA));
            _triggerWatcher.addTrigger(_sewingATrigger);
            _sewingBTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.chairB_mc);
            _sewingBTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startSewingB));
            _sewingBTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopSewingB));
            _triggerWatcher.addTrigger(_sewingBTrigger);
            _sewingCTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.chairC_mc);
            _sewingCTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, startSewingC));
            _sewingCTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, stopSewingC));
            _triggerWatcher.addTrigger(_sewingCTrigger);
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
		function pickUpItem() {
			_INTERFACE.buyInventory(5207);
		}
        function showCatalog(catalogName) {
            _INTERFACE.showContent(catalogName);
        }
        function setLights(lightState) {
            _stage.foreground_mc.lights_mc.gotoAndStop(lightState);
        }
        function startSewingA() {
            _stage.sewingCorner_mc.sewingMachineA_mc.gotoAndStop(2);
        }
        function startSewingB() {
            _stage.sewingTable_mc.sewingMachineB_mc.gotoAndStop(2);
        }
        function startSewingC() {
            _stage.sewingTable_mc.sewingMachineC_mc.gotoAndStop(2);
        }
        function stopSewingA() {
            _stage.sewingCorner_mc.sewingMachineA_mc.gotoAndStop(1);
        }
        function stopSewingB() {
            _stage.sewingTable_mc.sewingMachineB_mc.gotoAndStop(1);
        }
        function stopSewingC() {
            _stage.sewingTable_mc.sewingMachineC_mc.gotoAndStop(1);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Shop";
    }
