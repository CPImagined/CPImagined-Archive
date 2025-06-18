//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.TeleportMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var baseView, _context, teleportView, _teleported, appClosed, teleportRooms, currentRoomService, roomCrumbs, languageCrumbs, roomButtonMediators, roomListMediator, joinRoomTimeoutID;
        function TeleportMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
            baseView = view;
            _context = context;
            teleportView = com.clubpenguin.hud.phone.view.TeleportView(view);
            _teleported = new org.osflash.signals.Signal();
            appClosed.add(resetView, this);
            teleportRooms = new com.clubpenguin.hud.phone.model.TeleportRooms();
            currentRoomService = context.currentRoomService;
            roomCrumbs = context.roomCrumbs;
            languageCrumbs = context.languageCrumbs;
            roomButtonMediators = [];
            setupRoomsList();
            resetView();
            view.cancelTeleportButton.onPress = com.clubpenguin.util.Delegate.create(this, cancelTeleport);
        }
        function setupRoomsList() {
            if (com.clubpenguin.hybrid.AS3Manager.isUnderAS3()) {
                teleportView = baseView;
            }
            var _local_8 = teleportView.roomList;
            roomListMediator = new com.clubpenguin.scrollinglist.ScrollingList(_local_8);
            var _local_6 = 0;
            var _local_9 = 0;
            var _local_7 = getTeleportRooms();
            var _local_3;
            var _local_5;
            var _local_2 = 0;
            while (_local_2 < _local_7.length) {
                var _local_4 = com.clubpenguin.hud.phone.model.TeleportRoom(_local_7[_local_2]);
                _local_3 = _local_8.content.attachMovie("roomButton", _local_4["key"], _local_2);
                _local_3._x = _local_9;
                _local_3._y = _local_6;
                _local_6 = _local_6 + _local_3._height;
                _local_5 = new com.clubpenguin.hud.phone.mediator.RoomButtonMediator(_local_3, _local_4);
                _local_5.pressed.add(onRoomButtonPressed, this);
                roomButtonMediators.push(_local_5);
                _local_2++;
            }
        }
        function getTeleportRooms() {
            var _local_6 = [];
            var _local_5 = teleportRooms.IDs;
            var _local_4 = 0;
            while (_local_4 < _local_5.length) {
                var _local_3 = _local_5[_local_4];
                var _local_2 = new com.clubpenguin.hud.phone.model.TeleportRoom(_local_3, roomCrumbs[_local_3].room_id, languageCrumbs[_local_3]);
                if (!_local_2.localizedName.length) {
                } else {
                    _local_6.push(_local_2);
                }
                _local_4++;
            }
            _local_6.sort(com.clubpenguin.util.Delegate.create(this, compareSpecialAlphabet));
            return(_local_6);
        }
        function standardizeAlphabet(input) {
            var _local_6;
            _local_6 = {à:"a", á:"a", â:"a", ã:"a", ä:"a", è:"e", é:"e", ê:"e", ẽ:"e", ë:"e", ì:"i", í:"e", î:"e", ĩ:"e", ï:"e", ò:"o", ó:"o", ô:"o", õ:"o", ö:"o", ù:"u", ú:"u", û:"u", ũ:"u", ü:"u", ñ:"n", ç:"c"};
            var _local_3 = input.split("");
            var _local_5 = new Array();
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                var _local_4 = true;
                if (_local_6[_local_3[_local_2]] != undefined) {
                    _local_5.push(_local_6[_local_3[_local_2]]);
                    _local_4 = false;
                }
                if (_local_4) {
                    _local_5.push(_local_3[_local_2]);
                }
                _local_2++;
            }
            return(_local_5.join(""));
        }
        function compareSpecialAlphabet(objectA, objectB) {
            var _local_2 = standardizeAlphabet(objectA.localizedName.toLowerCase());
            var _local_3 = standardizeAlphabet(objectB.localizedName.toLowerCase());
            if (_local_2 < _local_3) {
                return(-1);
            }
            if (_local_2 > _local_3) {
                return(1);
            }
            return(0);
        }
        function onRoomButtonPressed(teleportRoom) {
            if (_isTeleporting) {
                return(undefined);
            }
            _isTeleporting = true;
            teleportView.roomList._visible = false;
            teleportView.destination.text = teleportRoom.localizedName.toUpperCase();
            showTeleportCountDown();
            joinRoomTimeoutID = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, teleportTo, teleportRoom), TELEPORT_TIMEOUT);
        }
        function teleportTo(teleportRoom) {
            if (_context.isUserCurrentlyInRoom(teleportRoom.serverID)) {
                cancelTeleport();
            } else {
                _teleported.dispatch();
                teleportView.close();
                currentRoomService.joinRoom(teleportRoom.serverID);
            }
            _isTeleporting = false;
        }
        function onClosed() {
            cancelTeleport();
            super.onClosed();
        }
        function cancelTeleport() {
            _isTeleporting = false;
            _global.clearTimeout(joinRoomTimeoutID);
            resetView();
        }
        function resetView() {
            teleportView.reset();
        }
        function showTeleportCountDown() {
            teleportView.showTeleportCountDown();
        }
        static var DELAY_AMOUNT = 250;
        var TELEPORT_TIMEOUT = 1800;
        var DEFAULT_SPAWN_X = 100;
        var DEFAULT_SPAWN_Y = 500;
        var _isTeleporting = false;
        var delayInterval = null;
    }
