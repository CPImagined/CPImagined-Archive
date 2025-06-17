//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.model.PlayerModel
    {
        var _playerCollection, _myPlayerId;
        function PlayerModel () {
            _playerCollection = new com.clubpenguin.util.collection.Collection();
        }
        function initMyPlayer(loginObject) {
            com.clubpenguin.util.Log.debug("initMyPlayer");
            _myPlayerId = String(loginObject.playerID);
            com.clubpenguin.util.Log.debug("initMyPlayer _myPlayerId: " + _myPlayerId);
            var _local_2 = new com.clubpenguin.model.vo.MyPlayerVO();
            _local_2.player_id = loginObject.playerID;
            _local_2.username = loginObject.username;
            _local_2.loginDataRaw = loginObject.loginDataRaw;
            _local_2.player_swid = loginObject.swid;
            _local_2.friendLoginKey = loginObject.friendsLoginKey;
            _local_2.confirmationHash = loginObject.confirmationHash;
            _local_2.friendsLoginVO = new com.clubpenguin.friendsas2.FriendsLoginVO(loginObject.swid, loginObject.friendsLoginKey);
            _local_2.presence = new com.clubpenguin.friendsas2.Presence(com.clubpenguin.friendsas2.Presence.DEFAULT_STATUS, _myPlayerId, null);
            _local_2.activeKey = loginObject.loginKey;
            _local_2.remaining_hours = loginObject.remaining_hours;
            _local_2.max_grace_hours = loginObject.max_grace_hours;
            _local_2.emailAddress = loginObject.emailAddress;
            _playerCollection.addItem(_local_2);
        }
        function changeMyUsername(newName) {
            var _local_2 = getMyPlayerObject();
            _local_2.username = newName.newName;
            _playerCollection.updateItem(_local_2);
        }
        function initActionStatus(actionStatus) {
            com.clubpenguin.util.Log.debug(("Shell.PlayerModel.initActionStatus(" + actionStatus) + ")");
            var _local_2 = getMyPlayerObject();
            _local_2.playerHasDanced = ((actionStatus[0] == 1) ? true : false);
            _local_2.playerHasWaved = ((actionStatus[1] == 1) ? true : false);
            _local_2.playerHasThrownSpecialSnowball = ((actionStatus[2] == 1) ? true : false);
            com.clubpenguin.util.Log.debug("myPlayerVO.playerHasDanced: " + _local_2.playerHasDanced);
            com.clubpenguin.util.Log.debug("myPlayerVO.playerHasWaved: " + _local_2.playerHasWaved);
            com.clubpenguin.util.Log.debug("myPlayerVO.playerHasThrownSpecialSnowball: " + _local_2.playerHasThrownSpecialSnowball);
            _playerCollection.updateItem(_local_2);
        }
        function updateActionStatusDance() {
            var _local_2 = getMyPlayerObject();
            com.clubpenguin.util.Log.debug("myPlayerVO.playerHasDanced: " + _local_2.playerHasDanced);
            if (!_local_2.playerHasDanced) {
                _local_2.playerHasDanced = true;
                return(true);
            }
            return(false);
        }
        function updateActionStatusWave() {
            var _local_2 = getMyPlayerObject();
            com.clubpenguin.util.Log.debug("myPlayerVO.playerHasWaved: " + _local_2.playerHasWaved);
            if (!_local_2.playerHasWaved) {
                _local_2.playerHasWaved = true;
                return(true);
            }
            return(false);
        }
        function updateActionStatusSnowball() {
            var _local_2 = getMyPlayerObject();
            com.clubpenguin.util.Log.debug("myPlayerVO.playerHasThrownSpecialSnowball: " + _local_2.playerHasThrownSpecialSnowball);
            if (!_local_2.playerHasThrownSpecialSnowball) {
                _local_2.playerHasThrownSpecialSnowball = true;
                return(true);
            }
            return(false);
        }
        function get playerCollection() {
            return(_playerCollection);
        }
        function getMyPlayerId() {
            return(Number(_myPlayerId));
        }
        function getMyPlayerIdAsString() {
            return(_myPlayerId);
        }
        function getMyPlayerObject() {
            return(com.clubpenguin.model.vo.MyPlayerVO(_playerCollection.getItemByID(_myPlayerId)));
        }
        function getPlayerObjectById(playerId) {
            return(_playerCollection.getItemByID(String(playerId)));
        }
        function getPlayerList() {
            return(_playerCollection.getItems());
        }
        function isMyPlayerObject(vo) {
            return(getMyPlayerObject().equals(vo));
        }
        function isMyPlayer(playerId) {
            return(getMyPlayerId() == playerId);
        }
        function playerExists(playerId) {
            return(getPlayerObjectById(playerId) != undefined);
        }
        function updatePlayerFromGenericObject(data) {
            var _local_3 = new com.clubpenguin.model.vo.PlayerVO();
            if (data.player_id == undefined) {
                return(undefined);
            }
            for (var _local_4 in data) {
                _local_3[_local_4] = data[_local_4];
            }
            _playerCollection.addItem(_local_3);
        }
        function clear(destroyItems) {
            var _local_2 = getMyPlayerObject();
            _playerCollection.clear(destroyItems);
            _playerCollection.addItem(_local_2);
        }
        function setUpModeratorPenguin(playerType) {
            var _local_2 = null;
            switch (playerType) {
                case MODERATOR_PLAYER : 
                case MASCOT_PLAYER : 
                    _local_2 = new com.clubpenguin.model.vo.ModeratorPlayerVO();
                    break;
                case STEALTH_MODERATOR_PLAYER : 
                    _local_2 = new com.clubpenguin.model.vo.StealthModeratorPlayerVO();
                    break;
                default : 
                    break;
            }
            if (_local_2 != null) {
                var _local_3 = getMyPlayerObject();
                _local_2.update(_local_3);
                switchPlayerInCollection(_local_3, _local_2);
            }
        }
        function switchPlayerInCollection(removingPlayer, addingPlayer) {
            _playerCollection.removeItem(removingPlayer);
            _playerCollection.addItem(addingPlayer);
        }
        function isPlayerModerator() {
            if ((getMyPlayerObject() instanceof com.clubpenguin.model.vo.ModeratorPlayerVO) || (getMyPlayerObject() instanceof com.clubpenguin.model.vo.StealthModeratorPlayerVO)) {
                return(true);
            }
            return(false);
        }
		function isPlayerModeratorByID(playerId) {
            if ((getPlayerObjectById(playerId) instanceof com.clubpenguin.model.vo.ModeratorPlayerVO) || (getPlayerObjectById(playerId) instanceof com.clubpenguin.model.vo.StealthModeratorPlayerVO)) {
                return(true);
            }
            return(false);
        }
        function isPlayerStealthModerator() {
            return(getMyPlayerObject() instanceof com.clubpenguin.model.vo.StealthModeratorPlayerVO);
        }
        function isPlayerStealthModeratorByID(playerId) {
            return(getPlayerObjectById(playerId) instanceof com.clubpenguin.model.vo.StealthModeratorPlayerVO);
        }
        static var PLAYER_NON_MEMBER = 0;
        static var PLAYER_MEMBER = 1;
        static var PLAYER_TRIAL_MEMBER = 2;
        static var MODERATOR_PLAYER = 1;
        static var STEALTH_MODERATOR_PLAYER = 2;
        static var MASCOT_PLAYER = 3;
    }
