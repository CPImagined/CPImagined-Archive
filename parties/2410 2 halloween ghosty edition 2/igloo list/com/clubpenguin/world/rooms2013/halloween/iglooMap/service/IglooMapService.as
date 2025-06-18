//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.service.IglooMapService extends com.clubpenguin.services.AbstractService
    {
        var _context, iglooListReceived, friendsIglooListReceived, connection, extension, messageFormat, _friendsRoster, _bestFriendsMap;
        function IglooMapService (context) {
            super(context.connection);
            trace("Igloo Map Service constructor");
            _context = context;
            iglooListReceived = new org.osflash.signals.Signal(Array, Number);
            friendsIglooListReceived = new org.osflash.signals.Signal(Array);
            connection.getResponded().add(onResponded, this);
        }
        function destroy() {
            connection.getResponded().remove(onResponded, this);
        }
        function getOpenIglooList() {
            trace(this + " getOpenIglooList");
            getBestFriendsList();
        }
        function getBestFriendsList() {
            connection.sendXtMessage(extension, PLAYER_HANDLER + GET_BEST_FRIENDS_LIST, [], messageFormat, _context.currentServerRoomID);
        }
        function onGetOpenIglooList(data) {
            _friendsRoster = _context.getFriendsRoster();
            trace((this + " onGetOpenIglooList: ") + data);
            var _local_9 = String(data.shift());
            var _local_7 = Number(data.shift());
            var _local_8 = Number(data.shift());
            var _local_6 = [];
            var _local_2;
            var _local_4 = 0;
            while (_local_4 < data.length) {
                var _local_3 = data[_local_4].split("|");
                _local_2 = new com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO(_local_3[0]);
                _local_2.playerID = _local_3[0];
                _local_2.name = _local_3[1];
                _local_2.totalLikes = Number(_local_3[2]);
                _local_2.population = Number(_local_3[3]);
                _local_2.isIglooLocked = Boolean(Number(_local_3[4]));
                _local_6.push(_local_2);
                checkForFriend(_local_2, _local_6);
                _local_4++;
            }
            iglooListReceived.dispatch(_local_6, _local_7, _local_8);
        }
        function checkForFriend(iglooMapPVO, iglooList) {
            var _local_3 = _friendsRoster[iglooMapPVO.playerID];
            if (_local_3 != undefined) {
                iglooMapPVO.swid = _local_3.swid;
                iglooMapPVO.isOpenListFriend = true;
                iglooMapPVO.setID(iglooMapPVO.getID() + "dupe");
            }
        }
        function onGetBestFriendsList(data) {
            var _local_3 = data[1].split(",");
            _bestFriendsMap = {};
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _bestFriendsMap[_local_3[_local_2]] = true;
                _local_2++;
            }
            connection.sendXtMessage(extension, IGLOO_HANDLER + GET_OPEN_IGLOO_LIST, [42], messageFormat, _context.currentServerRoomID);
        }
        function onResponded(responseType, responseData) {
            switch (responseType) {
                case GET_OPEN_IGLOO_LIST : 
                    onGetOpenIglooList(responseData);
                    break;
                case GET_BEST_FRIENDS_LIST : 
                    onGetBestFriendsList(responseData);
                    break;
            }
        }
        function toString() {
            return("[IglooMapService]");
        }
        static var IGLOO_HANDLER = "g#";
        static var PLAYER_HANDLER = "u#";
        static var GET_OPEN_IGLOO_LIST = "gri";
        static var GET_BEST_FRIENDS_LIST = "gbffl";
    }
