//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_IglooMapModel
    {
        var _context, _service, _localPlayer, onInitialized, friendsIglooListReceived, _playerList;
        function TrickorTreat_IglooMapModel (context) {
            _context = context;
            _service = new com.clubpenguin.world.rooms2013.halloween.iglooMap.service.IglooMapService(context);
            _localPlayer = new com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO(String(_context.myPlayerID));
            _localPlayer.name = _context.myPlayerName;
            trace("_localPlayer.name " + _localPlayer);
            _localPlayer.playerID = String(_context.myPlayerID);
            _localPlayer.isLocalPlayer = true;
            onInitialized = new org.osflash.signals.Signal();
            friendsIglooListReceived = new org.osflash.signals.Signal();
        }
        function get playerList() {
            return(_playerList);
        }
        function get localPlayer() {
            return(_localPlayer);
        }
        function init() {
            trace(this + " initializing");
            _service.iglooListReceived.addOnce(onIglooListReceived, this);
            _service.getOpenIglooList();
        }
        function onIglooListReceived(playerListIn, localPlayerTotalLikes, localPlayerPopulation) {
            _playerList = new com.clubpenguin.world.rooms2013.halloween.iglooMap.collection.IglooMapPlayerList();
            _playerList.add(playerListIn);
            _localPlayer.totalLikes = localPlayerTotalLikes;
			_localPlayer.population = "";
            _localPlayer.population = localPlayerPopulation;
            onInitialized.dispatch();
        }
        function getFriendsIglooList() {
            _service.friendsIglooListReceived.addOnce(onFriendsIglooListReceived, this);
        }
        function onFriendsIglooListReceived(playerListIn) {
            if ((_playerList == null) || (_playerList == undefined)) {
                _playerList = new com.clubpenguin.world.rooms2013.halloween.iglooMap.collection.IglooMapPlayerList();
            }
            _playerList.add(playerListIn);
            friendsIglooListReceived.dispatch();
        }
        function destroy() {
            _service.destroy();
        }
        function toString() {
            return("[IglooMapModel]");
        }
    }
