//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.LocalData
    {
        static var _loginPlayerObjectToSave, _unstoredNewspaperIssue, _lastWorldId, _savedGame;
        function LocalData () {
        }
        static function setLoginPlayerObjectToSave(obj) {
            _loginPlayerObjectToSave = obj;
        }
        static function getLoginPlayerObjectToSave() {
            return(_loginPlayerObjectToSave);
        }
        static function savePlayerObject() {
            var _local_4 = getLoginPlayerObjectToSave();
            var _local_2 = _global.getCurrentShell().playerModel.getMyPlayerObject();
            for (var _local_6 in _local_4) {
            }
            for (var _local_5 in _local_2) {
            }
            var _local_11 = _local_4.isRememberUsername;
            var _local_10 = _local_4.isRememberPassword;
            var _local_7 = isPlayerCurrentlySaved(_local_4.Username.toLowerCase());
            if (_local_11) {
                var _local_3 = new Object();
                _local_3.Feet = _local_2.feet;
                _local_3.Hand = _local_2.hand;
                _local_3.Body = _local_2.body;
                _local_3.Neck = _local_2.neck;
                _local_3.Face = _local_2.face;
                _local_3.Head = _local_2.head;
                _local_3.Colour = _local_2.colour_id;
                _local_3.LastSave = _global.getCurrentShell().getLocalEpoch();
                _local_3.Nickname = _local_2.nickname.toLowerCase();
                _local_3.Username = _local_4.Username.toLowerCase();
                _local_3.PassCode = undefined;
                _local_3.LastWorldId = getLastWorldId();
                _local_3.swid = _local_2.friendsLoginVO.swid;
                if (_global.getCurrentShell().playerModel.isPlayerStealthModeratorByID(_local_2.player_id)) {
                    _local_3.AvatarAlpha = _global.getCurrentShell().playerModel.getPlayerObjectById(_local_2.player_id).avatarAlpha;
                } else {
                    _local_3.AvatarAlpha = undefined;
                }
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_2, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                    _local_3.walkingPuffleId = _local_2.attachedPuffle.id;
                    _local_3.walkingPuffleSubTypeID = _local_2.attachedPuffle.subTypeID;
                    _local_3.walkingPuffleColor = _local_2.attachedPuffle["color"];
                    if (_local_2.attachedPuffle.hasHat) {
                        _local_3.walkingPuffleHatId = _local_2.attachedPuffle.hat.id;
                    }
                } else {
                    _local_3.walkingPuffleId = undefined;
                    _local_3.walkingPuffleSubTypeID = undefined;
                    _local_3.walkingPuffleColor = undefined;
                    _local_3.walkingPuffleHatId = undefined;
                }
                var _local_9 = _local_4.Username.toLowerCase();
                if (_local_10) {
                    _local_3.PassCode = _global.getCurrentShell().freezeCode(_local_9, _local_4.Password);
                }
                _local_3.LastNewspaper = getStoredNewspaperIssue();
                _local_3.so_version = SAVED_GAME_VERSION;
                if (_local_7) {
                    removeFromSavedPlayersByUsername(_local_4.Username);
                }
                addPlayerToSavedPlayers(_local_3);
                var _local_8 = getSavedPlayers().length;
                if (_local_8 > MAX_SAVED_PLAYERS) {
                    removeOldSavedPlayers();
                }
            } else if (_local_7) {
                removeFromSavedPlayersByUsername(_local_4.Username);
            }
        }
        static function saveRoomPlayerObject(room_playerObject) {
            var _local_4 = getLoginPlayerObjectToSave();
            var _local_3 = _global.getCurrentShell().getMyPlayerObject();
            var _local_10 = _local_4.isRememberUsername;
            var _local_9 = _local_4.isRememberPassword;
            var _local_6 = isPlayerCurrentlySaved(_local_4.Username.toLowerCase());
            if (_local_10) {
                var _local_2 = new Object();
                _local_2.Feet = room_playerObject.feet;
                _local_2.Hand = room_playerObject.hand;
                _local_2.Body = room_playerObject.body;
                _local_2.Neck = room_playerObject.neck;
                _local_2.Face = room_playerObject.face;
                _local_2.Head = room_playerObject.head;
                _local_2.Colour = room_playerObject.colour_id;
                _local_2.LastSave = _global.getCurrentShell().getLocalEpoch();
                _local_2.Nickname = _local_3.nickname.toLowerCase();
                _local_2.Username = _local_4.Username.toLowerCase();
                _local_2.PassCode = undefined;
                _local_2.LastWorldId = getLastWorldId();
                if (_global.getCurrentShell().playerModel.isPlayerStealthModeratorByID(_local_3.player_id)) {
                    _local_2.AvatarAlpha = _global.getCurrentShell().playerModel.getPlayerObjectById(_local_3.player_id).avatarAlpha;
                } else {
                    _local_2.AvatarAlpha = undefined;
                }
                if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(_local_3, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE)) {
                    _local_2.walkingPuffleId = _local_3.attachedPuffle.id;
                    _local_2.walkingPuffleSubTypeID = _local_3.attachedPuffle.subTypeID;
                    _local_2.walkingPuffleColor = _local_3.attachedPuffle["color"];
                    if (_local_3.attachedPuffle.hasHat) {
                        _local_2.walkingPuffleHatId = _local_3.attachedPuffle.hat.id;
                    }
                } else {
                    _local_2.walkingPuffleId = undefined;
                    _local_2.walkingPuffleSubTypeID = undefined;
                    _local_2.walkingPuffleColor = undefined;
                    _local_2.walkingPuffleHatId = undefined;
                }
                var _local_8 = _local_4.Username.toLowerCase();
                if (_local_9) {
                    _local_2.PassCode = _global.getCurrentShell().freezeCode(_local_8, _local_4.Password);
                }
                _local_2.LastNewspaper = getStoredNewspaperIssue();
                _local_2.so_version = SAVED_GAME_VERSION;
                if (_local_6) {
                    removeFromSavedPlayersByUsername(_local_4.Username);
                }
                addPlayerToSavedPlayers(_local_2);
                var _local_7 = getSavedPlayers().length;
                if (_local_7 > MAX_SAVED_PLAYERS) {
                    removeOldSavedPlayers();
                }
            } else if (_local_6) {
                removeFromSavedPlayersByUsername(_local_4.Username);
            }
        }
        static function removeFromSavedPlayersByUsername(username) {
            var _local_2 = getSavedPlayers();
            var _local_3 = _local_2.length;
            var _local_1 = 0;
            while (_local_1 < _local_3) {
                if (_local_2[_local_1].Username.toLowerCase() == username.toLowerCase()) {
                    _local_2.splice(_local_1, 1);
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getSavedPlayers() {
            var _local_1 = getSavedGame();
            if (_local_1.data.playerlist == undefined) {
                _local_1.data.playerlist = new Array();
            }
            var _local_2 = _local_1.data.playerlist;
            return(_local_1.data.playerlist.sortOn(["Nickname"], [Array.CASEINSENSITIVE]));
        }
        static function getLastWorldIdForActivePlayer() {
            var _local_1 = getLoginPlayerObjectToSave().Username;
            var _local_2 = getSavedPlayerByUsername(_local_1);
            return(_local_2.LastWorldId);
        }
        static function setLastNewspaperIssue(issue) {
            _unstoredNewspaperIssue = issue;
            savePlayerObject();
        }
        static function getLastWorldId() {
            return(_lastWorldId);
        }
        static function setLastWorldId(id) {
            _lastWorldId = id;
        }
        static function getStoredNewspaperIssue() {
            if (_unstoredNewspaperIssue != null) {
                var _local_1 = _unstoredNewspaperIssue;
                _unstoredNewspaperIssue = null;
                return(_local_1);
            }
            var _local_2 = getLoginPlayerObjectToSave().Username;
            var _local_3 = getSavedPlayerByUsername(_local_2);
            return(_local_3.LastNewspaper);
        }
        static function getSavedGame() {
            if (_savedGame == undefined) {
                _savedGame = SharedObject.getLocal(SAVED_GAME_NAME, SAVED_GAME_LOCATION);
            }
            return(_savedGame);
        }
        static function removeOldSavedPlayers() {
            var _local_1 = getSavedPlayers();
            _local_1.sortOn("LastSave");
            _local_1.splice(MAX_SAVED_PLAYERS);
        }
        static function addPlayerToSavedPlayers(playerObject) {
            for (var _local_2 in playerObject) {
            }
            getSavedPlayers().push(playerObject);
        }
        static function isPlayerCurrentlySaved(username) {
            var _local_2 = getSavedPlayers();
            var _local_3 = _local_2.length;
            var _local_1 = 0;
            while (_local_1 < _local_3) {
                if (_local_2[_local_1].Username.toLowerCase() == username.toLowerCase()) {
                    return(true);
                }
                _local_1++;
            }
            return(false);
        }
        static function getSavedPlayerByUsername(username) {
            var _local_3 = getSavedPlayers();
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                if (_local_3[_local_2].Username.toLowerCase() == username.toLowerCase()) {
                    return(_local_3[_local_2]);
                }
                _local_2++;
            }
            _global.getCurrentShell().$e("[shell] getSavedPlayerByUsername() -> Not able to find player in the saved player list: username: " + username);
            return(undefined);
        }
        static function saveNicknameToCookie(nickname) {
            flash.external.ExternalInterface.call(SET_COOKIE_METHOD, NICKNAME_COOKIE_NAME, nickname);
        }
        static function setSavedPlayers(players) {
            getSavedGame().data.playerlist = players;
        }
        static function debugTrace(msg) {
            if (_debugTracesActive) {
            }
        }
        static var SAVED_GAME_LOCATION = "/";
        static var SAVED_GAME_NAME = "SaveGame";
        static var SAVED_GAME_VERSION = 1;
        static var MAX_SAVED_PLAYERS = 6;
        static var SET_COOKIE_METHOD = "setCookie";
        static var NICKNAME_COOKIE_NAME = "penguinNickname";
        static var _debugTracesActive = false;
    }
