//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.DinoTown extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _stage, _SHELL, _destroyDelegate, _triggerWatcher, _triggerWatcherInterval, _targetDestination, _targetX, _targetY, _sfxCurtainOpen, _sfxCurtainClose, _sfxGateOpen, _sfxGateClose, _sfxDoorOpen, _sfxDoorClose, _ENGINE, _footprint, _footprintTrigger;
        function DinoTown (stageReference) {
            super(stageReference);
            _stage.start_x = 223;
            _stage.start_y = 309;
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
            clearInterval(_triggerWatcherInterval);
            _triggerWatcherInterval = setInterval(_triggerWatcher, "checkAllPlayers", 40);
            configurefootprintTrigger();
        }
        function configureTriggers() {
            _stage.triggers_mc.restaurant_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party4", 160, 315);
            _stage.triggers_mc.village_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party5", 570, 190);
            _stage.triggers_mc.prehistoricForts_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party2", 139, 249);
            _stage.triggers_mc.shop_mc.triggerFunction = com.clubpenguin.util.Delegate.create(this, exit, "party13", 500, 210);
            _stage.triggers_mc.stuckOnBlockTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, movePlayerOffBlock);
            _stage.triggers_mc.sendPlayerTrigger.triggerFunction = com.clubpenguin.util.Delegate.create(this, sendPlayerToDestination);
            _stage.triggers_mc.nest_mc.triggerFunction = com.clubpenguin.util.Delegate.create(_global.getCurrentParty().PrehistoricParty, _global.getCurrentParty().PrehistoricParty.launchDinoDigGame);
        }
        function configureNavigation() {
        }
        function configureRoomElements() {
            _stage.background_mc.stageClick_mc.stageClickNavigation_btn.useHandCursor = false;
            _targetDestination = new String();
            _targetX = new Number();
            _targetY = new Number();
            _stage.customPenguinSize = 85;
            _stage.block_mc._visible = false;
            _stage.triggers_mc._visible = false;
            _stage.cavemanVillageNavigation_mc.cavemanVillageNavigation_btn.useHandCursor = false;
            _sfxCurtainOpen = new Sound(_stage);
            _sfxCurtainOpen.attachSound("openCurtain");
            _sfxCurtainClose = new Sound(_stage);
            _sfxCurtainClose.attachSound("closeCurtain");
            _sfxGateOpen = new Sound(_stage);
            _sfxGateOpen.attachSound("openGate");
            _sfxGateClose = new Sound(_stage);
            _sfxGateClose.attachSound("closeGate");
            _sfxDoorOpen = new Sound(_stage);
            _sfxDoorOpen.attachSound("openDoor");
            _sfxDoorClose = new Sound(_stage);
            _sfxDoorClose.attachSound("closeDoor");
            _stage.background_mc.shopDoor.shopDoor_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, openCurtainAudio);
            _stage.background_mc.shopDoor.shopDoor_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, closeCurtainAudio);
            _stage.background_mc.giantGate.onRollOver = com.clubpenguin.util.Delegate.create(this, openGateAudio);
            _stage.background_mc.giantGate.onRollOut = com.clubpenguin.util.Delegate.create(this, closeGateAudio);
            _stage.background_mc.restaurantDoor_mc.restaurantDoor_btn.onRollOver = com.clubpenguin.util.Delegate.create(this, openDoorAudio);
            _stage.background_mc.restaurantDoor_mc.restaurantDoor_btn.onRollOut = com.clubpenguin.util.Delegate.create(this, closeDoorAudio);
            _stage.background_mc.nest_mc.nest_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToNest);
            _stage.driveThru_mc.driveThru_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToDriveThru);
            _stage.background_mc.shopDoor.shopDoor_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToShop);
            _stage.background_mc.giantGate.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToGiantGate);
            _stage.cavemanVillageNavigation_mc.cavemanVillageNavigation_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToCavemanVillage);
            var _local_2 = _SHELL.getPlayerObjectById(_SHELL.getMyPlayerId());
            if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                _stage.background_mc.footprint_mc.footprintNav_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToFootprint);
            } else {
                _stage.background_mc.footprint_mc.footprintNav_btn._visible = false;
            }
            _stage.background_mc.restaurantDoor_mc.restaurantDoor_btn.onRelease = com.clubpenguin.util.Delegate.create(this, navigateToRestaurant);
            _stage.background_mc.stageClick_mc.stageClickNavigation_btn.onRelease = com.clubpenguin.util.Delegate.create(this, storeXandY);
            _stage.background_mc.nest_mc.nest_btn.onRollOver = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.showDinoDigHint, _stage.background_mc.nest_mc);
            _stage.background_mc.nest_mc.nest_btn.onRollOut = com.clubpenguin.util.Delegate.create(com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty, com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hideDinoDigHint);
        }
        function openCurtainAudio() {
            _sfxCurtainClose.stop();
            _sfxCurtainOpen.start();
        }
        function closeCurtainAudio() {
            _sfxCurtainOpen.stop();
            _sfxCurtainClose.start();
        }
        function openGateAudio() {
            _sfxGateClose.stop();
            _sfxGateOpen.start();
        }
        function closeGateAudio() {
            _sfxGateOpen.stop();
            _sfxGateClose.start();
        }
        function openDoorAudio() {
            _sfxDoorClose.stop();
            _sfxDoorOpen.start();
        }
        function closeDoorAudio() {
            _sfxDoorOpen.stop();
            _sfxDoorClose.start();
        }
        function storeXandY() {
            _targetX = _xmouse;
            _targetY = _ymouse;
            _targetDestination = "SomewhereElse";
            sendPlayerToDestination();
        }
        function navigateToNest() {
            _targetDestination = "Nest";
            _ENGINE.sendPlayerMove(503, 310);
        }
        function navigateToDriveThru() {
            _targetDestination = "DriveThru";
            _ENGINE.sendPlayerMove(85, 240);
        }
        function navigateToShop() {
            _targetDestination = "Shop";
            _ENGINE.sendPlayerMove(452, 246);
        }
        function navigateToGiantGate() {
            _targetDestination = "GiantGate";
            _ENGINE.sendPlayerMove(673, 302);
        }
        function navigateToCavemanVillage() {
            _targetDestination = "CavemanVillage";
            _ENGINE.sendPlayerMove(67, 450);
        }
        function navigateToFootprint() {
            _targetDestination = "Footprint";
            _ENGINE.sendPlayerMove(202, 369);
            _ENGINE.sendPlayerMove(202, 369);
        }
        function navigateToRestaurant() {
            _targetDestination = "Restaurant";
            _ENGINE.sendPlayerMove(164, 252);
        }
        function joinGame(gameName, is_prompt) {
            _ENGINE.sendJoinGame(gameName, is_prompt);
        }
        function movePlayerOffBlock() {
            _stage.triggers_mc.sendPlayerTrigger._x = 130;
            _ENGINE.sendPlayerMove(130, 300);
        }
        function sendPlayerToDestination() {
            _stage.triggers_mc.sendPlayerTrigger._x = -170;
            switch (_targetDestination) {
                case "Nest" : 
                    _ENGINE.sendPlayerMove(503, 310);
                    _targetDestination = "";
                    break;
                case "DriveThru" : 
                    _ENGINE.sendPlayerMove(130, 300);
                    _targetDestination = "";
                    break;
                case "Shop" : 
                    _ENGINE.sendPlayerMove(452, 246);
                    _targetDestination = "";
                    break;
                case "GiantGate" : 
                    _ENGINE.sendPlayerMove(673, 302);
                    _targetDestination = "";
                    break;
                case "CavemanVillage" : 
                    _ENGINE.sendPlayerMove(67, 450);
                    _targetDestination = "";
                    break;
                case "Footprint" : 
                    _ENGINE.sendPlayerMove(202, 369);
                    _targetDestination = "";
                    break;
                case "Restaurant" : 
                    _ENGINE.sendPlayerMove(164, 252);
                    _targetDestination = "";
                    break;
                case "SomewhereElse" : 
                    _ENGINE.sendPlayerMove(_targetX, _targetY);
                    _targetDestination = "";
                    break;
                default : 
                    _ENGINE.sendPlayerMove(_targetX, _targetY);
                    _targetDestination = "";
                    break;
            }
        }
        function exit(roomName, x, y) {
            _SHELL.sendJoinRoom(roomName, x, y);
        }
        function destroy() {
            _SHELL.removeListener(_SHELL.ROOM_DESTROYED, _destroyDelegate);
            _footprint.cleanStation();
        }
        function configurefootprintTrigger() {
            _footprint = new com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStation(_stage.background_mc.footprint_mc, GROOM_TASK, null, DIVING_PATH);
            _stage.background_mc.footprint_mc.footprintNav_btn.useHandCursor = false;
            configureStationTrigger(_footprint, _footprintTrigger, _stage.triggers_mc.footprintWater_mc);
            _footprint.stationBIInfo("prehistoric_footprint", com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationsConstants.PUFFLE_CLEAN_STATION);
        }
        function configureStationTrigger(careStation, playerTrigger, triggerClip) {
            playerTrigger = new com.clubpenguin.world.rooms.common.triggers.PlayerTrigger(triggerClip);
            playerTrigger.playersAdded.add(com.clubpenguin.util.Delegate.create(careStation, careStation.beginActivity));
            playerTrigger.playersRemoved.add(com.clubpenguin.util.Delegate.create(careStation, careStation.endActivity));
            _triggerWatcher.addTrigger(playerTrigger);
        }
        static var CLASS_NAME = "DinoTown";
        static var DIVING_PATH = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareStationAnimationConstants.PUFFLE_DIVE;
        static var GROOM_TASK = com.clubpenguin.world.rooms.hotel.hotelcarestations.HotelCareTaskEnum.GROOMING_TASK;
        static var WATER_SPLASH_EFFECT = "waterSplashEffect";
    }
