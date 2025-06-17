//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.services.CurrentRoomService extends com.clubpenguin.services.AbstractService
    {
        var _roomJoined, connection, extension, messageFormat;
        function CurrentRoomService (connection) {
            super(connection);
            _roomJoined = new org.osflash.signals.Signal(Array);
            connection.getResponded().add(onResponded, this);
        }
        function get roomJoined() {
            return(_roomJoined);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case JOIN_ROOM : 
                    onRoomJoined(responseData);
                    break;
                case JOIN_PLAYER_ROOM : 
                    var _local_3 = String(responseData[3]);
                    _global.getCurrentEngine().playerHostedRoomType = _local_3;
            }
        }
        function joinRoom(targetRoomServerSideID, x, y) {
            _global.getCurrentShell().isLastJoinedRoomIgloo = false;
            if (((targetRoomServerSideID == 321) || (targetRoomServerSideID == 320)) && (!_global.getCurrentShell().isItemInMyInventory(STARTER_DECK_ITEM_ID))) {
                targetRoomServerSideID = 324;
            }
            if (x && (y)) {
                connection.sendXtMessage(extension, NAVIGATION_HANDLER + JOIN_ROOM, [targetRoomServerSideID, x, y], messageFormat, -1);
            } else {
                connection.sendXtMessage(extension, NAVIGATION_HANDLER + JOIN_ROOM, [targetRoomServerSideID, 0, 0], messageFormat, -1);
            }
            _global.getCurrentShell().sendAS3LeavingRoom();
            return(_roomJoined);
        }
        function pauseRoomView() {
            if (_global.getCurrentShell().getCurrentRoomId() >= 1000) {
                return(undefined);
            }
            _roovViewIsPaused = true;
            _global.getCurrentShell().quietAirtower();
            _global.getCurrentEngine().hideAndUnloadRoomMovieClip();
        }
        function unpauseRoomView(noRoomRefresh) {
            if (!_roovViewIsPaused) {
                return(undefined);
            }
            _roovViewIsPaused = false;
            _global.getCurrentShell().enableAirtower();
            _global.getCurrentEngine().removeRoomBitmap();
            if (!noRoomRefresh) {
                refreshRoom();
            }
            _global.getCurrentShell().sendAS3StopNotificationServices();
        }
        function refreshRoom() {
            connection.sendXtMessage(extension, NAVIGATION_HANDLER + REFRESH_ROOM, [], messageFormat, -1);
        }
        function onRoomJoined(responseData) {
            _roomJoined.dispatch(responseData);
        }
        static var NAVIGATION_HANDLER = "j#";
        static var JOIN_ROOM = "jr";
        static var JOIN_PLAYER_ROOM = "jp";
        static var REFRESH_ROOM = "grs";
        var _roovViewIsPaused = false;
        var STARTER_DECK_ITEM_ID = 821;
    }
