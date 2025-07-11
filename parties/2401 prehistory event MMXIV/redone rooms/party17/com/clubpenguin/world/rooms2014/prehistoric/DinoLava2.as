﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.DinoLava2 extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, hotSpotsController, _triggerWatcherInterval, _hotSpotTrigger0, _hotSpotTrigger1, _hotSpotTrigger2, _hotSpotTrigger3, _INTERFACE;
        function DinoLava2 (stageReference) {
            super(stageReference);
            _stage.start_x = 393;
            _stage.start_y = 207;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _global.getCurrentParty().PrehistoricParty.activatePuffleHatchBroadcastReceiver();
            _stage.triggers_mc.party15_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party15", 550, 175);
            _stage.triggers_mc.party16_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party16", 555, 290);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.outExit_mc.outExit_btn, 370, 415), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.back_mc.exitRoom_btn, 60, 125)]);
            _stage.background_mc.instruction_btn.onRelease = com.clubpenguin.util.Delegate.create(_global.getCurrentParty().PrehistoricParty, _global.getCurrentParty().PrehistoricParty.showPuffleHatchingInstructions);
            hotSpotsController = new com.clubpenguin.world.rooms2014.prehistoric.HotSpotsController();
            hotSpotsController.addHotSpot(_stage.platform1_mc);
            hotSpotsController.addHotSpot(_stage.background_mc.platform2_mc);
            hotSpotsController.addHotSpot(_stage.background_mc.platform3_mc);
            hotSpotsController.addHotSpot(_stage.platform4_mc);
            hotSpotsController.run();
            configureHotSpotTriggers();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureHotSpotTriggers() {
            _hotSpotTrigger0 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hotSpot0_mc);
            _hotSpotTrigger0.playersAdded.add(com.clubpenguin.util.Delegate.create(hotSpotsController, hotSpotsController.hotSpotActivated, 0));
            _triggerWatcher.addTrigger(_hotSpotTrigger0);
            _hotSpotTrigger1 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hotSpot1_mc);
            _hotSpotTrigger1.playersAdded.add(com.clubpenguin.util.Delegate.create(hotSpotsController, hotSpotsController.hotSpotActivated, 1));
            _triggerWatcher.addTrigger(_hotSpotTrigger1);
            _hotSpotTrigger2 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hotSpot2_mc);
            _hotSpotTrigger2.playersAdded.add(com.clubpenguin.util.Delegate.create(hotSpotsController, hotSpotsController.hotSpotActivated, 2));
            _triggerWatcher.addTrigger(_hotSpotTrigger2);
            _hotSpotTrigger3 = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.hotSpot3_mc);
            _hotSpotTrigger3.playersAdded.add(com.clubpenguin.util.Delegate.create(hotSpotsController, hotSpotsController.hotSpotActivated, 3));
            _triggerWatcher.addTrigger(_hotSpotTrigger3);
        }
        function exit(roomName, x, y) {
            _global.getCurrentParty().PrehistoricParty.deactivatePuffleHatchBroadcastReceiver();
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function showContent(contentID) {
            _INTERFACE.showContent(contentID);
        }
        function destroy() {
            hotSpotsController.destroy();
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "DinoLava2";
    }
