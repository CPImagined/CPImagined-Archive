﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.Stadium extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, localize, setupNavigationButtons, showContent, _SHELL, _INTERFACE, _destroyDelegate;
        function Stadium (stageReference) {
            super(stageReference);
            _stage.start_x = 385;
            _stage.start_y = 200;
            localize([_stage.fishdog_mc, _stage.boxseats_mc, _stage.wallsoccer_mc, _stage.snack_mc.snacksign_mc, _stage.sport_mc.sportsign_mc, _stage.interface_mc.sports_mc]);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.sport_mc.door_btn, 668, 120), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.snack_mc.door_btn, 557, 112), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.fishdog_mc.fishdog_btn, 63, 114), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair1_btn, 204, 82), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair2_btn, 236, 79), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair3_btn, 267, 77), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.background_mc.chair4_btn, 298, 74), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.backwall_mc.door_mc.door_btn, 385, 130), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.wallsoccer_mc.door_mc, 385, 130)]);
            _stage.sports_mc.sportdoor_btn.useHandCursor = false;
            _stage.fishdog_mc.fishdog_btn.useHandCursor = false;
            _stage.background_mc.chair1_btn.useHandCursor = false;
            _stage.background_mc.chair2_btn.useHandCursor = false;
            _stage.background_mc.chair3_btn.useHandCursor = false;
            _stage.background_mc.chair4_btn.useHandCursor = false;
            _stage.snacks_mc.snackdoor_btn.useHandCursor = false;
            _stage.backwall_mc.door_mc.door_btn.useHandCursor = false;
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.sports_mc.sports_btn, true, "sport_catalogue", "")]);
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit);
            _stage.triggers_mc.sports_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, catalog);
        }
        function exit(roomName, spawnX, spawnY) {
            _SHELL.sendJoinRoom(roomName, spawnX, spawnY);
        }
        function catalog() {
            _INTERFACE.showContent("sport_catalogue");
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _stage.background_mc.lightsnack_mc.light_btn.onPress = com.clubpenguin.util.Delegate.create(_stage.background_mc.lightsnack_mc, play);
            _stage.background_mc.lightsport_mc.light_btn.onPress = com.clubpenguin.util.Delegate.create(_stage.background_mc.lightsport_mc, play);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            for (var _local_2 in this) {
                var _local_2 = null;
            }
        }
        static var CLASS_NAME = "Stadium";
    }
