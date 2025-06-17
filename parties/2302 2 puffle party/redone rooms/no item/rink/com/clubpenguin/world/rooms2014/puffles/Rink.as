//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.puffles.Rink extends com.clubpenguin.world.rooms.BaseRoom
    {
        static var _airtower;
        var _stage, _SHELL, _INTERFACE, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, setupNavigationButtons, _micTrigger, _wobbleATrigger, _wobbleBTrigger, _wobbleCTrigger, _teeterLeftTrigger, _teeterRightTrigger, localize, showContent, _handleLightChangeDelegate;
        function Rink (stageReference) {
            super(stageReference);
            _stage.start_x = 385;
            _stage.start_y = 230;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            configureNavigation();
            configureTriggers();
            configureRoomElements();
            _airtower = _global.getCurrentAirtower();
            activateLightBroadcastReceiver();
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
        }
        function configureNavigation() {
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
            _stage.triggers_mc.booth_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, openQuestInterface);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.fishdog_mc.fishdog_btn, 135, 160), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.place1st_mc, 225, 80), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.place2nd_mc, 180, 110), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.place3rd_mc, 298, 105), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.boothContainer_mc.booth_btn, 525, 125)]);
            _stage.fishdog_mc.fishdog_btn.useHandCursor = false;
            _stage.place1st_mc.useHandCursor = false;
            _stage.place2nd_mc.useHandCursor = false;
            _stage.place3rd_mc.useHandCursor = false;
        }
        function configureTriggers() {
            _stage.triggers_mc.forts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "forts", 290, 204);
            _stage.triggers_mc.shool_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "school", 55, 360);
            _micTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.mic_mc);
            _micTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playMicSound));
            _triggerWatcher.addTrigger(_micTrigger);
            _wobbleATrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.wobbleA_mc);
            _wobbleATrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playWobbleA));
            _triggerWatcher.addTrigger(_wobbleATrigger);
            _wobbleBTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.wobbleB_mc);
            _wobbleBTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playWobbleB));
            _triggerWatcher.addTrigger(_wobbleBTrigger);
            _wobbleCTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.wobbleC_mc);
            _wobbleCTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, playWobbleC));
            _triggerWatcher.addTrigger(_wobbleCTrigger);
            _teeterLeftTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.teeterLeft_mc);
            _teeterLeftTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, teeterBack));
            _teeterLeftTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, teeterTotter));
            _triggerWatcher.addTrigger(_teeterLeftTrigger);
            _teeterRightTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.teeterRight_mc);
            _teeterRightTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, teeterTotter));
            _teeterRightTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, teeterBack));
            _triggerWatcher.addTrigger(_teeterRightTrigger);
        }
		function openQuestInterface() {
			_INTERFACE.showContent("w.app.p2014.itembooth");
		}
        function configureRoomElements() {
            localize([_stage.fishdog_mc, _stage.interface_mc.sports_mc]);
            showContent([new com.clubpenguin.world.rooms.common.PopupContentVO(_stage.interface_mc.sports_mc.sports_btn, true, "sport_catalogue", "")]);
        }
        function playMicSound() {
            var _local_3 = new Array("sfx_Microphone01", "sfx_Microphone02");
            var _local_2 = Math.floor(Math.random() * _local_3.length);
            com.clubpenguin.world.rooms2014.puffles.PuffleParty.playSound(_stage.triggers_mc.mic_mc, _local_3[_local_2]);
        }
        function teeterTotter() {
            if ((_stage.teeterTotter_mc._currentframe == 1) && ((_teeterRightTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _teeterRightTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) > (_teeterLeftTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _teeterLeftTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length))) {
                _stage.teeterTotter_mc.gotoAndPlay(2);
            }
        }
        function teeterBack() {
            if ((_stage.teeterTotter_mc._currentframe == 6) && ((_teeterLeftTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _teeterLeftTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) >= (_teeterRightTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _teeterRightTrigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length))) {
                _stage.teeterTotter_mc.gotoAndPlay(7);
            }
        }
        function increasePufflePlayPoints(player_id) {
            if ((player_id == _SHELL.getMyPlayerId()) && (_global.getCurrentParty().PuffleParty.canUsePuffleCareStation(player_id))) {
                var _local_3 = _SHELL.getMyPlayerObject().attachedPuffle.id;
                _global.getCurrentParty().PuffleParty.sendPuffleCareStationUsed(com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_STATION, "puffleparty_wobble");
                _global.getCurrentEngine().puffleAvatarController.displayPuffleWidget(_local_3, "statsBarWidget", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_PLAY_ITEM_ID);
            }
        }
        function playWobbleA(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (_stage.wobbleA_mc._currentframe == 1) {
                    _stage.wobbleA_mc.gotoAndPlay(2);
                    increasePufflePlayPoints(players[_local_2]);
                }
                _local_2++;
            }
        }
        function playWobbleB(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (_stage.wobbleB_mc._currentframe == 1) {
                    _stage.wobbleB_mc.gotoAndPlay(2);
                    increasePufflePlayPoints(players[_local_2]);
                }
                _local_2++;
            }
        }
        function playWobbleC(players) {
            var _local_2 = 0;
            while (_local_2 < players.length) {
                if (_stage.wobbleC_mc._currentframe == 1) {
                    _stage.wobbleC_mc.gotoAndPlay(2);
                    increasePufflePlayPoints(players[_local_2]);
                }
                _local_2++;
            }
        }
        function activateLightBroadcastReceiver() {
            com.clubpenguin.world.rooms2014.puffles.PuffleParty.pebug("activateLightBroadcastReceiver()", CLASS_NAME);
            _handleLightChangeDelegate = com.clubpenguin.util.Delegate.create(this, handleLightUpdate);
            com.clubpenguin.world.rooms2014.puffles.PuffleParty.pebug("activateLightBroadcastReceiver():command:" + _global.getCurrentParty().PuffleParty.CONSTANTS.RINK_LIGHT_COMMAND, CLASS_NAME);
            _airtower.addListener(_global.getCurrentParty().PuffleParty.CONSTANTS.RINK_LIGHT_COMMAND, _handleLightChangeDelegate);
        }
        function deactivateLightBroadcastReceiver() {
            _airtower.removeListener(_global.getCurrentParty().PuffleParty.CONSTANTS.RINK_LIGHT_COMMAND, _handleLightChangeDelegate);
        }
        function handleLightUpdate(data) {
            com.clubpenguin.world.rooms2014.puffles.PuffleParty.pebug(("handleLightUpdate(" + data) + ")", CLASS_NAME);
            var _local_3 = data[1];
            com.clubpenguin.world.rooms2014.puffles.PuffleParty.pebug("handleLightUpdate():isGreen=" + _local_3, CLASS_NAME);
            var _local_2 = "red";
            if (_local_3 == 1) {
                _local_2 = "green";
            }
            if (_local_2 == "red") {
                com.clubpenguin.world.rooms2014.puffles.PuffleParty.playSound(_stage.light_mc, "sfx_redlight");
            }
            _stage.light_mc.gotoAndStop(_local_2);
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            deactivateLightBroadcastReceiver();
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function updateItemBoothState() {
            _global.getCurrentParty().PuffleParty.configureItemBooth(_stage.boothContainer_mc);
        }
        static var CLASS_NAME = "Rink";
    }
