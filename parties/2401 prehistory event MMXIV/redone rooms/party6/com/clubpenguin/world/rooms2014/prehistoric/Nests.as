//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.Nests extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, setupNavigationButtons, _car1Trigger, _car2Trigger, _stomp1Trigger, _triggerWatcherInterval, localize, _sfxDoorOpen, _sfxDoorClose, _ENGINE, _INTERFACE, _footprint, _footprintTrigger;
        function Nests (stageReference) {
            super(stageReference);
            _stage.start_x = 400;
            _stage.start_y = 350;
            _stage.customPenguinSize = 85;
            if (!_SHELL) {
                init();
            }
        }
        function init() {
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _triggerWatcher = new com.clubpenguin.world.rooms.common.triggers.TriggerWatcher(_stage, _SHELL);
            _stage.foreground_mc.partyCat_btn.onRelease = com.clubpenguin.util.Delegate.create(this, showContent, com.clubpenguin.world.rooms.common.RoomConstants.PARTY_CATALOGUE_1);
            setupNavigationButtons([new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.carSeat1, 93, 222), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.carSeat2, 192, 182), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.carSeat3, 157, 170), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat1, 287, 243), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat2, 370, 244), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat3, 283, 273), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat4, 351, 280), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat5, 307, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat6, 389, 330), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat7, 327, 374), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.stoneSeat8, 391, 369), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.exit7_btn, 380, 175), new com.clubpenguin.world.rooms.common.NavigationButtonVO(_stage.pizzaParlor.door_mc.door_btn, 625, 280)]);
            _stage.carSeat1.useHandCursor = false;
            _stage.carSeat2.useHandCursor = false;
            _stage.carSeat3.useHandCursor = false;
            _stage.stoneSeat1.useHandCursor = false;
            _stage.stoneSeat2.useHandCursor = false;
            _stage.stoneSeat3.useHandCursor = false;
            _stage.stoneSeat4.useHandCursor = false;
            _stage.stoneSeat5.useHandCursor = false;
            _stage.stoneSeat6.useHandCursor = false;
            _stage.stoneSeat7.useHandCursor = false;
            _stage.stoneSeat8.useHandCursor = false;
            _stage.exit7_btn.useHandCursor = false;
            _stage.triggers_mc.party2_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 555, 290);
            _stage.triggers_mc.party7_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party7", 430, 370);
            _stage.triggers_mc.party10_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party10", 160, 192);
            _stage.triggers_mc.pizza_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party14", 390, 182);
            _car1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.car1_mc);
            _car1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, car1PizzaAppear));
            _car1Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, car1PizzaVanish));
            _triggerWatcher.addTrigger(_car1Trigger);
            _car2Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(_stage.triggers_mc.car2_mc);
            _car2Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, car2PizzaAppear));
            _car2Trigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(this, car2PizzaVanish));
            _triggerWatcher.addTrigger(_car2Trigger);
            var _local_2 = com.clubpenguin.util.Delegate.create(this, joinGame, com.clubpenguin.world.rooms2013.prehistoric.Prehistoric.DINO_HUNT_GAME, true);
            _stage.triggers_mc.nest1_mc.triggerFunction = _local_2;
            _stage.triggers_mc.nest2_mc.triggerFunction = _local_2;
            _stage.triggers_mc.nest6_mc.triggerFunction = _local_2;
            _stage.triggers_mc.nest7_mc.triggerFunction = _local_2;
            configureRoomElements();
            _stomp1Trigger = new com.clubpenguin.world.rooms.common.triggers.PlayerWalkTrigger(_stage.triggers_mc.stomp1_mc);
            _stomp1Trigger.playersAdded.add(com.clubpenguin.util.Delegate.create(this, stompOnItem, _stage.stomp1_mc));
            _triggerWatcher.addTrigger(_stomp1Trigger);
            var _local_3 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _stage.puddle_mc.waterPuddleNav_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToPuddle);
            } else {
                _stage.puddle_mc.waterPuddleNav_btn._visible = false;
            }
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configurefootprintTrigger();
        }
        function configureRoomElements() {
            localize([_stage.pizzaParlor.pizzaSign]);
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.pizzaParlor.door_mc.door_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, pizzaDoorOver);
            _stage.pizzaParlor.door_mc.door_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, pizzaDoorOut);
            _stage.pizzaParlor.door_mc.door_btn.onReleaseOutside = com.clubpenguin.util.Delegate.create(this, pizzaDoorOut);
            _sfxDoorOpen = new Sound(_stage);
            _sfxDoorOpen.attachSound("openDoor");
            _sfxDoorClose = new Sound(_stage);
            _sfxDoorClose.attachSound("closeDoor");
        }
        function stompOnItem(players, itemMC) {
            var _local_5;
            var _local_2 = 0;
            while (_local_2 < players.length) {
                var _local_3 = _SHELL.getPlayerObjectById(players[_local_2]);
                if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.canPlayerStomp(_local_3.avatar_id)) {
                    _local_5 = true;
                    break;
                }
                _local_2++;
            }
            if ((itemMC._currentframe == 1) && (_local_5)) {
                itemMC.gotoAndStop(2);
            }
        }
        function pizzaDoorOver() {
            _stage.pizzaParlor.door_mc.gotoAndStop("open");
            openDoorAudio();
        }
        function pizzaDoorOut() {
            _stage.pizzaParlor.door_mc.gotoAndStop("close");
            closeDoorAudio();
        }
        function car1PizzaAppear() {
            _stage.car1.pizza.gotoAndPlay("appear");
        }
        function car1PizzaVanish() {
            if ((_car1Trigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _car1Trigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0) {
                _stage.car1.pizza.gotoAndPlay("vanish");
            }
        }
        function car2PizzaAppear() {
            _stage.car2.pizza.gotoAndPlay("appear");
        }
        function car2PizzaVanish() {
            if ((_car2Trigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STOPPED).length + _car2Trigger.getPlayersWhoAre(com.clubpenguin.world.rooms.common.triggers.PlayerTrigger.STANDING).length) == 0) {
                _stage.car2.pizza.gotoAndPlay("vanish");
            }
        }
        function openDoorAudio() {
            _sfxDoorClose.stop();
            _sfxDoorOpen.start();
        }
        function closeDoorAudio() {
            _sfxDoorOpen.stop();
            _sfxDoorClose.start();
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function joinGame(gameName, is_prompt) {
            _ENGINE.sendJoinGame(gameName, is_prompt);
        }
        function showContent(content) {
            _INTERFACE.showContent(content);
        }
        function destroy() {
            clearInterval(_triggerWatcherInterval);
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
        }
        function navigateToPuddle() {
            _ENGINE.sendPlayerMove(126, 369);
        }
        function configurefootprintTrigger() {
            _footprint = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_stage.background_mc.footprint_mc, GROOM_TASK, null, DIVING_PATH);
            _stage.puddle_mc.waterPuddleNav_btn.useHandCursor = false;
            configureStationTrigger(_footprint, _footprintTrigger, _stage.triggers_mc.footprintWater_mc);
            _footprint.stationBIInfo("prehistoric_puddle", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "Nests";
        static var DIVING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_DIVE;
        static var GROOM_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.GROOMING_TASK;
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
    }
