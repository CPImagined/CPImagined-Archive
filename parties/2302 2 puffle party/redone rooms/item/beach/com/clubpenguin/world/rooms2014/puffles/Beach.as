//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Beach extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _discATrigger, _discBTrigger, _discCTrigger, localize, _INTERFACE;
        function Beach (stageReference) {
            super(stageReference);
            trace(CLASS_NAME + "()");
            _stage.start_x = 385;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            trace(CLASS_NAME + ": init()");
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureTriggers();
            configureNavigation();
            configureRoomElements();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureNavigation() {
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.vet_mc.light_btn, 230, 210), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.discA_btn, 470, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.discB_btn, 260, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.discC_btn, 430, 420), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 625, 285), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.snowPile_mc.freeItem_btn, 135, 285)]);
            _stage.discA_btn.useHandCursor = false;
            _stage.discB_btn.useHandCursor = false;
            _stage.discC_btn.useHandCursor = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.light_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "light", 300, 275);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "village", 160, 395);
            _stage.triggers_mc.dock_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "dock", 230, 180);
            _stage.triggers_mc.freeItem_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, getFreeItem);
            _stage.triggers_mc.kiosk_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            _discATrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.discA_mc);
            _discATrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playdiscA));
            _triggerWatcher.addTrigger(_discATrigger);
            _discBTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.discB_mc);
            _discBTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playdiscB));
            _triggerWatcher.addTrigger(_discBTrigger);
            _discCTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.discC_mc);
            _discCTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playdiscC));
            _triggerWatcher.addTrigger(_discCTrigger);
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function configureRoomElements() {
            localize([_stage.snowPile_mc.sign_mc]);
            _stage.interface_mc.dock_cat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, "dock_catalogue");
        }
        function getFreeItem() {
            _INTERFACE.buyInventory("1852");
        }
        function increasePufflePlayPoints(player_id) {
            if ((player_id == _SHELL.getMyPlayerId()) && (_global.getCurrentParty().PuffleParty.canUsePuffleCareStation(player_id))) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentParty().PuffleParty.sendPuffleCareStationUsed(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION, "puffleparty_frisbee");
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_ITEM_ID);
            }
        }
        function playdiscA(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (_stage.discA_mc._currentframe == 1) {
                    _stage.discA_mc.gotoAndPlay("playA");
                    _stage.discC_mc.gotoAndPlay("playA");
                    increasePufflePlayPoints(players[_local_2]);
                }
                _local_2++;
            }
        }
        function playdiscB(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (_stage.discA_mc._currentframe == 34) {
                    _stage.discA_mc.gotoAndPlay("playB");
                    _stage.discC_mc.gotoAndPlay("playB");
                    increasePufflePlayPoints(players[_local_2]);
                }
                _local_2++;
            }
        }
        function playdiscC(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (_stage.discA_mc._currentframe == 61) {
                    _stage.discA_mc.gotoAndPlay("playC");
                    _stage.discC_mc.gotoAndPlay("playC");
                    increasePufflePlayPoints(players[_local_2]);
                }
                _local_2++;
            }
        }
        function showContent(contentID) {
            trace("show contnet");
            _INTERFACE.showContent(contentID);
        }
        function exit(roomName, x, y) {
            trace(CLASS_NAME + ": exit()");
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            trace(CLASS_NAME + ": destroy()");
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        static var CLASS_NAME = "Beach";
    }
