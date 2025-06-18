//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.EPFContext
    {
        var layoutChanged, baseURL, gamesURL, phoneLayer, iconLayer, currentRoomService, equipmentService, epfService, roomCrumbs, languageCode, languageCrumbs, inventory, player, fieldOp, fieldOpTriggered, cancelFieldOpTrigger, INTERFACE, SHELL, ENGINE, inventoryCrumbs, roomViewPaused, openInComChannel, comNotificationQueued, appClosed, _loader, _phoneContainer, phoneOpened, phoneClosed, hudIconMediator, phoneMediator;
        function EPFContext (baseURL, gamesURL, phoneLayer, iconLayer, currentRoomService, equipmentService, epfService, roomCrumbs, languageCode, languageCrumbs, inventory, player, fieldOp, fieldOpTriggered, cancelFieldOpTrigger, _interface, _shell, _engine, inventoryCrumbs) {
            layoutChanged = new org.osflash.signals.Signal(com.clubpenguin.hud.phone.model.PhoneLayout);
            this.baseURL = baseURL;
            this.gamesURL = gamesURL;
            this.phoneLayer = phoneLayer;
            this.iconLayer = iconLayer;
            this.currentRoomService = currentRoomService;
            this.equipmentService = equipmentService;
            this.epfService = epfService;
            this.roomCrumbs = roomCrumbs;
            this.languageCode = languageCode;
            this.languageCrumbs = languageCrumbs;
            this.inventory = inventory;
            this.player = player;
            this.fieldOp = fieldOp;
            this.fieldOpTriggered = fieldOpTriggered;
            this.cancelFieldOpTrigger = cancelFieldOpTrigger;
            INTERFACE = _interface;
            SHELL = _shell;
            ENGINE = _engine;
            this.inventoryCrumbs = inventoryCrumbs;
            roomViewPaused = false;
            openInComChannel = false;
            comNotificationQueued = false;
            appClosed = new org.osflash.signals.Signal(String);
            _loader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onPhoneViewLoaded));
            _phoneContainer = phoneLayer.createEmptyMovieClip("phoneHolder", phoneLayer.getNextHighestDepth());
            _loader.loadClip(baseURL + PHONE_ASSET_FILE_NAME, _phoneContainer, "EPFContext.as EPFContext()");
        }
        function isUserCurrentlyInRoom(roomID) {
            return(roomID == SHELL.getCurrentRoomId());
        }
        function pauseRoomView() {
            roomViewPaused = true;
            currentRoomService.pauseRoomView();
        }
        function playerHasElitePuffleWhistle() {
            var _local_2 = 0;
            while (_local_2 < inventory.length) {
                if (inventory[_local_2].id == PUFFLE_WHISTLE_ID || inventory[_local_2].id == CHIRP_ID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function unpauseRoomView() {
            roomViewPaused = false;
            currentRoomService.unpauseRoomView();
        }
        function onPhoneViewLoaded(event) {
            phoneOpened = new org.osflash.signals.Signal();
            phoneClosed = new org.osflash.signals.Signal();
            hudIconMediator = new com.clubpenguin.hud.phone.mediator.HUDIconMediator(iconLayer.hudIconView, this);
            var _local_2 = event.target.phone;
            phoneMediator = new com.clubpenguin.hud.phone.PhoneMediator(_local_2, this);
        }
        static var PHONE_ASSET_FILE_NAME = "phone.swf";
        static var PUFFLE_WHISTLE_ID = 5060;
		static var CHIRP_ID = 95061;
    }
