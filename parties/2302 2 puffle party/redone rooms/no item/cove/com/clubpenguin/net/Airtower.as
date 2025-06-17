//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.Airtower
    {
        var shell, _isBlocked, LOGIN_IP, LOGIN_PORT, on_login_response, autoLogin, on_world_response;
        function Airtower (shell) {
            this.shell = shell;
            _isBlocked = false;
        }
        function toString() {
            return(("Airtower[" + debugName) + "]");
        }
        function init() {
            var _local_2 = shell.getLoginServer();
            LOGIN_IP = _local_2.ip;
            com.clubpenguin.util.Log.debug("LOGIN_IP: " + LOGIN_IP);
            LOGIN_PORT = _local_2.port;
            com.clubpenguin.util.Log.debug("LOGIN_PORT: " + LOGIN_PORT);
            sf_listener_container = new Object();
            server = new com.clubpenguin.net.Connection();
        }
        function getServer() {
            return(server);
        }
        function setIsJumpToNewServerInProgress(isJumping) {
            isJumpToNewServerInProgress = isJumping;
        }
        function getSentCommandsBuffer() {
            var _local_4 = "";
            var _local_3 = getServer().getSentCommandsBuffer();
            var _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _local_4 = _local_4 + _local_3[_local_2];
                if (_local_2 != (_local_3.length - 1)) {
                    _local_4 = _local_4 + newline;
                }
                _local_2++;
            }
            return(_local_4);
        }
        function cloneListeners(cloneTo) {
            for (var _local_6 in sf_listener_container) {
                var _local_4 = sf_listener_container[_local_6];
                var _local_3 = 0;
                while (_local_3 < _local_4.length) {
                    var _local_2 = _local_4[_local_3];
                    com.clubpenguin.util.Log.debug((((("clone listener -> type: " + _local_6) + " listener.func: ") + _local_2.func) + " listener.scope: ") + _local_2.scope);
                    cloneTo.addListener(_local_6, _local_2.func, _local_2.scope);
                    _local_3++;
                }
            }
        }
        function addListener(type, func, scope) {
            if ((type == undefined) || (func == undefined)) {
                shell.$e((("addListner() -> You must pass a valid listener type and function! type: " + type) + " func: ") + func);
                return(false);
            }
            var _local_3 = getListenersArray(type);
            var _local_4 = getListenerIndex(_local_3, func);
            if (_local_4 == -1) {
                shell.$d(("[airtower] Successfully added listener to: \"" + type) + "\"");
                _local_3.push({func:func, scope:scope});
                return(true);
            }
            shell.$d(("[airtower] Failed to add listener. Tried to add a duplicate listener to: \"" + type) + "\"");
            return(false);
        }
        function removeListener(type, func) {
            var _local_2 = getListenersArray(type);
            var _local_3 = getListenerIndex(_local_2, func);
            if (_local_3 != -1) {
                shell.$d(("[airtower] Successfully removed listener from: \"" + type) + "\"");
                _local_2.splice(_local_3, 1);
                return(true);
            }
            shell.$d(("[airtower] Failed to remove listener which did not exist from: \"" + type) + "\"");
            return(false);
        }
        function getListenerIndex(array, func) {
            var _local_2 = array.length;
            var _local_1 = 0;
            while (_local_1 < _local_2) {
                if (array[_local_1].func == func) {
                    return(_local_1);
                }
                _local_1++;
            }
            return(-1);
        }
        function updateListeners(type, obj) {
            var _local_3 = getListenersArray(type);
            var _local_5 = _local_3.length;
            if (_local_5 < 1) {
                shell.$d(("[airtower] No listeners currently attached to: \"" + type) + "\"");
                return(false);
            }
            if (_local_5 == 1) {
                (_local_3[0].scope ? (_local_3[0].func.call(_local_3[0].scope, obj)) : (_local_3[0].func(obj)));
                return(true);
            }
            var _local_2 = 0;
            while (_local_2 < _local_5) {
                (_local_3[_local_2].scope ? (_local_3[_local_2].func.call(_local_3[_local_2].scope, obj)) : (_local_3[_local_2].func(obj)));
                _local_2++;
            }
            return(true);
        }
        function getListenersArray(type) {
            if (sf_listener_container[type] == undefined) {
                sf_listener_container[type] = new Array();
            }
            return(sf_listener_container[type]);
        }
        function onAirtowerResponse(eventData, type, overrideBlock) {
            if ((!_isBlocked) || (overrideBlock == true)) {
                var _local_2 = String(eventData[0]);
                if (com.clubpenguin.net.BridgeFilter.messageIsSentToAS3(this, _local_2)) {
                    shell.sendAirtowerEvent(eventData.join(SERVER_MESSAGE_DELIMITER) + SERVER_MESSAGE_DELIMITER);
                }
                com.clubpenguin.util.Log.debug(("onAirtowerResponse (eventType = " + _local_2) + ")", $_lc);
                com.clubpenguin.util.Log.debug(("onAirtowerResponse after service test (eventType = " + _local_2) + ")", $_lc);
                eventData.shift();
                switch (_local_2) {
                    case "gwcj" : 
                    case "gw" : 
                    case "jw" : 
                    case "sw" : 
                    case "cjms" : 
                    case "jx" : 
                    case "gz" : 
                    case "jz" : 
                    case "uz" : 
                    case "sz" : 
                    case "uw" : 
                        sendAck(_local_2, eventData.slice());
                        break;
                }
                updateListeners(_local_2, eventData);
            }
        }
        function sendAck(command, data) {
            data = data.slice();
            data.unshift(command);
            data.unshift("time=" + String(new Date().getTime()));
            this.send(PLAY_EXT, "bi#ack", data, "str", _global.getCurrentShell().getCurrentServerRoomId());
        }
        function isBlocked() {
            return(_isBlocked);
        }
        function block() {
            _isBlocked = true;
            server.isBlocked = true;
            server.onConnectionLost = null;
        }
        function unblock() {
            _isBlocked = false;
            server.isBlocked = false;
            server.onConnectionLost = com.clubpenguin.util.Delegate.create(this, handleLostConnection);
        }
        function setConnection(connection) {
            server = connection || (server);
        }
        function setUsername(in_username) {
            username = in_username;
        }
        function setPlayerId(in_playerId) {
            playerId = in_playerId;
        }
        function connectToLogin(in_username, in_pass, login_response, doAutoLogin) {
            com.clubpenguin.util.Log.debug(newline);
            com.clubpenguin.util.Log.debug("********************************************************************");
            com.clubpenguin.util.Log.debug("connectToLogin");
            com.clubpenguin.util.Log.debug("this = " + this);
            com.clubpenguin.util.Log.debug("in_username: " + in_username);
            com.clubpenguin.util.Log.debug("in_pass: " + in_pass);
            com.clubpenguin.util.Log.debug("login_response: " + login_response);
            com.clubpenguin.util.Log.debug("doAutoLogin: " + doAutoLogin);
            com.clubpenguin.util.Log.debug("server: " + server);
            com.clubpenguin.util.Log.debug("server.connected(); " + server.connected());
            com.clubpenguin.util.Log.debug("is_logged_in: " + is_logged_in);
            if (!is_logged_in) {
                if (server.connected()) {
                    server.disconnect();
                }
                on_login_response = login_response;
                username = in_username;
                password = in_pass;
                autoLogin = doAutoLogin;
                server.onConnection = com.clubpenguin.util.Delegate.create(this, handleLoginConnection);
                server.onRandomKey = com.clubpenguin.util.Delegate.create(this, handleLoginRandomKey);
                server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this, onAirtowerResponse);
                server.debug = true;
                this.addListener(HANDLE_LOGIN, handleOnLogin, this);
                this.addListener(HANDLE_LOGIN_EXPIRED, handleExpiredPreactivationLogin, this);
                server.connect(LOGIN_IP, LOGIN_PORT);
            } else {
                shell.$e("connectToLogin() -> Your already logged in! Cant login again");
            }
            com.clubpenguin.util.Log.debug("********************************************************************");
        }
        function handleLostConnection() {
            com.clubpenguin.util.Log.debug("Airtower.handleLostConnection() this = " + this);
            if (!isJumpToNewServerInProgress) {
                shell.sendIdlePlayerTimeout();
            }
            updateListeners(CONNECTION_LOST, null);
        }
        function handleLoginConnection(success) {
            if (success) {
                server.getRandomKey();
            } else {
                server.disconnect();
                on_login_response(false);
            }
        }
        function handleLoginRandomKey(key) {
            rand_key = key;
            login();
        }
        function login() {
            if (!autoLogin) {
                server.login(LOGIN_ZONE, username, getLoginHash());
            } else {
                server.login(LOGIN_ZONE, username, password);
            }
        }
        function handleOnLogin(serverResponse) {
            this.removeListener(HANDLE_LOGIN, handleOnLogin);
            this.removeListener(HANDLE_LOGIN_EXPIRED, handleExpiredPreactivationLogin, this);
            server.disconnect();
            com.clubpenguin.util.Log.debug("handleOnLogin: " + serverResponse);
            var _local_5 = serverResponse[1].split("|");
            loginObject = {};
            loginObject.loginDataRaw = serverResponse[1];
            loginObject.playerID = _local_5[0];
            loginObject.swid = _local_5[1];
            loginObject.username = _local_5[2];
            loginObject.loginKey = _local_5[3];
            loginObject.languageApproved = _local_5[5];
            loginObject.languageRejected = _local_5[6];
            loginObject.friendsLoginKey = serverResponse[3];
            loginObject.confirmationHash = serverResponse[2];
            loginObject.emailAddress = serverResponse[5];
            if (serverResponse[6] != null) {
                var _local_3 = serverResponse[6].split("|");
                loginObject.remaining_hours = _local_3[0];
                loginObject.trialMax = _local_3[1];
                loginObject.max_grace_hours = _local_3[2];
                var _local_6 = new Object();
                _local_6.modalBackgroundEnbaled = true;
                _local_6.blockPuffleNotifications = true;
                _local_6.hideLoadingDialog = true;
                var _local_4 = new Object();
                if (Number(_local_3[0]) < Number(_local_3[1])) {
                    _local_4.state = FRAME_LABEL_BACK;
                    _local_4.trialRemaining = _local_3[0];
                } else {
                    _local_4.state = FRAME_LABEL_WELCOME;
                }
                _local_4.trialMax = _local_3[1];
                _local_4.graceMax = _local_3[2];
                _local_4.confirmationHash = loginObject.confirmationHash;
                _local_4.loginDataRaw = loginObject.loginDataRaw;
                shell.sendOpenAS3Module("preactivation", _local_4, _local_6);
                flash.external.ExternalInterface.call("showActivationBanner", _local_3[0]);
            }
            for (var _local_7 in serverResponse) {
            }
            for (var _local_8 in loginObject) {
                com.clubpenguin.util.Log.debug((("loginObject." + _local_8) + ":") + loginObject[_local_8]);
            }
            shell.playerModel.initMyPlayer(loginObject);
            playerId = loginObject.playerID;
            shell.updateWorldPopulations(serverResponse[4]);
            on_login_response(true);
            is_logged_in = true;
            com.clubpenguin.login.LoginFloodManager.clearFloodControl();
            var _local_9 = shell.getLanguageBitmask();
            com.clubpenguin.util.Log.debug("\t-loginObject.languageRejected: " + loginObject.languageRejected);
            com.clubpenguin.util.Log.debug("\t-lang: " + _local_9);
            com.clubpenguin.util.Log.debug((" -loginObject.languageRejected & lang: " + loginObject.languageRejected) + _local_9);
            if (loginObject.languageRejected & _local_9) {
                com.clubpenguin.util.Log.debug("calling out to nameResubmission");
                flash.external.ExternalInterface.call("nameResubmission", loginObject.playerID, loginObject.confirmationHash, loginObject.loginDataRaw);
            }
        }
        function handleExpiredPreactivationLogin(serverResponse) {
            this.removeListener(HANDLE_LOGIN, handleOnLogin);
            this.removeListener(HANDLE_LOGIN_EXPIRED, handleExpiredPreactivationLogin, this);
            var _local_3 = new Object();
            _local_3.modalBackgroundEnbaled = true;
            _local_3.blockPuffleNotifications = true;
            _local_3.hideLoadingDialog = true;
            var _local_2 = new Object();
            _local_2.state = FRAME_LABEL_EXPIRED;
            _local_2.graceRemaining = serverResponse[1];
            _local_2.confirmationHash = serverResponse[2];
            _local_2.loginDataRaw = serverResponse[3];
            _local_2.emailAddress = serverResponse[4];
            shell.sendOpenAS3Module("preactivation", _local_2, _local_3);
            var _local_4 = shell.getLanguageBitmask();
            if (loginObject.languageRejected & _local_4) {
                flash.external.ExternalInterface.call("nameResubmission", loginObject.playerID, loginObject.confirmationHash, loginObject.loginDataRaw);
            }
        }
        function connectToRedemption(server_ip, server_port, connect_to_world_response) {
            isRedemption = true;
            on_world_response = connect_to_world_response;
            server.onConnection = com.clubpenguin.util.Delegate.create(this, handleWorldConnection);
            server.onRandomKey = com.clubpenguin.util.Delegate.create(this, handleWorldRandomKey);
            this.addListener(HANDLE_LOGIN, joinWorld, this);
            server.connect(server_ip, server_port);
        }
        function connectToWorld(server_ip, server_port, connect_to_world_response, loginKey) {
            isRedemption = false;
            on_world_response = connect_to_world_response;
            server.onConnection = com.clubpenguin.util.Delegate.create(this, handleWorldConnection);
            server.onRandomKey = com.clubpenguin.util.Delegate.create(this, handleWorldRandomKey);
            server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this, onAirtowerResponse);
            server.debug = true;
            this.addListener(HANDLE_LOGIN, joinWorld, this);
            server.connect(server_ip, server_port);
        }
        function handleWorldConnection(success) {
            if (success) {
                server.getRandomKey();
            } else {
                server.onConnection = null;
                server.onConnectionLost = null;
                server.onRandomKey = null;
                server.onExtensionResponse = null;
                on_world_response(false, false, false, false, false);
                on_world_response = null;
            }
        }
        function handleWorldRandomKey(key) {
            rand_key = key;
            worldLogin();
        }
        function worldLogin() {
            com.clubpenguin.util.Log.debug(("worldLogin isJump = " + isJump) + "   use encryption");
            var _local_2 = encryptPassword(loginObject.loginKey + rand_key) + loginObject.loginKey;
            server.login(SERVER_ZONE, loginObject.Username, _local_2, shell.getMyPlayerObject().confirmationHash, shell.getMyPlayerObject().loginDataRaw);
        }
        function joinWorld() {
            this.removeListener(HANDLE_LOGIN, joinWorld);
            server.onConnectionLost = com.clubpenguin.util.Delegate.create(this, handleLostConnection);
            var _local_2 = new Array();
            if (isRedemption) {
                _local_2.push(loginObject.loginDataRaw);
                _local_2.push(loginObject.confirmationHash);
            } else {
                _local_2.push(playerId);
                _local_2.push(loginObject.loginKey);
            }
            _local_2.push(shell.getLanguageAbbriviation());
            if (!isJump) {
                var _local_3 = com.clubpenguin.util.QueryParams.getQueryParams();
                if (Number(_local_3.rm)) {
                    _local_2.push(Number(_local_3.rm));
                }
            } else {
                _local_2.push("jmp");
            }
            if (isRedemption) {
                this.addListener(REDEMPTION_JOIN_WORLD, handleJoinRedemption, this);
                this.send(REDEMPTION, REDEMPTION_JOIN_WORLD, _local_2, "str", -1);
                return(undefined);
            }
            this.addListener(JOIN_WORLD, handleJoinWorld, this);
            this.addListener(GET_ACTIVE_FEATURES, handleGetActiveFeatures, this);
            this.send(PLAY_EXT, (NAVIGATION + "#") + JOIN_WORLD, _local_2, "str", -1);
        }
        function handleJoinRedemption(obj) {
            this.removeListener(REDEMPTION_JOIN_WORLD, handleJoinRedemption);
            var _local_4 = new Array();
            var _local_5 = new Array();
            var _local_6 = false;
            var _local_7 = obj.shift();
            if (obj[0] != "") {
                _local_4 = obj[0];
            }
            if (obj[1] != "") {
                _local_5 = obj[1];
            }
            if (obj[2] != "") {
                _local_6 = Boolean(Number(obj[2]));
            }
            var _local_3 = new Array();
            _local_3[0] = _local_4;
            _local_3[1] = _local_5;
            _local_3[2] = _local_6;
            on_world_response(_local_3);
            on_world_response = undefined;
        }
        function handleJoinWorld(obj) {
            com.clubpenguin.util.Log.debug(newline);
            com.clubpenguin.util.Log.debug("*********************************************");
            com.clubpenguin.util.Log.debug("handleJoinWorld");
            for (var _local_3 in obj) {
                com.clubpenguin.util.Log.debug((("prop: " + _local_3) + "  ") + obj[_local_3]);
            }
            com.clubpenguin.util.Log.debug("*********************************************");
            this.removeListener(JOIN_WORLD, handleJoinWorld);
            var _local_6 = Boolean(Number(obj[1]));
            var _local_4 = Boolean(Number(obj[2]));
            var _local_5 = Boolean(Number(obj[4]));
            shell.playerModel.setUpModeratorPenguin(Number(obj[3]));
            on_world_response(true, _local_6, _local_4, _local_5);
            on_world_response = undefined;
            isJump = false;
            shell.sendGetABTestData();
            this.send(PLAY_EXT, (NEW_USER_EXPERIENCE_HANDLER + "#") + GET_ACTION_STATUS, null, "str", -1);
            this.addListener(GET_ACTION_STATUS, handleGetActionStatus, this);
        }
        function handleGetActionStatus(serverResponse) {
            com.clubpenguin.util.Log.debug("handleGetActionStatus: " + serverResponse);
            this.removeListener(GET_ACTION_STATUS, handleGetActionStatus);
            var _local_4 = new Array(serverResponse[1], serverResponse[2], serverResponse[3]);
            shell.playerModel.initActionStatus(_local_4);
            _global.getCurrentEngine().localPlayerSpecialActionIndicators();
        }
        function handleGetActiveFeatures(obj) {
            this.removeListener(GET_ACTIVE_FEATURES, handleGetActiveFeatures);
            shell.activeFeaturesArray = obj.slice(1);
            shell.updateListeners(shell.UPDATE_ACTIVE_FEATURES);
        }
        function send(extension, command, arr, type, room_id) {
            com.clubpenguin.util.Log.debug("@@@@@ Airtower.send()  this=" + this);
            server.sendXtMessage(extension, command, arr, type, room_id);
        }
        function disconnect(disconnectFriends) {
            com.clubpenguin.util.Log.debug((("[airtower] disconnect() this = " + this) + "  disconnectFriends=") + disconnectFriends);
            if (disconnectFriends == undefined) {
                disconnectFriends = true;
            }
            if (server.connected()) {
                if (!isJumpToNewServerInProgress) {
                    if (disconnectFriends) {
                        shell.disconnectFromFriends();
                    }
                }
                server.disconnect();
            } else {
                shell.$d("[airtower] disconnect() -> Trying to disconnect the server when its not connected");
            }
        }
        function getLoginHash() {
            var _local_2 = encryptPassword(password).toUpperCase();
            _local_2 = _local_2 + password;
            _local_2 = encryptPassword((_local_2 + rand_key) + encryptPassword(_local_2 + encryptPassword((password = password + _local_2))));
            return(_local_2);
        }
        function hex_md5(s) {
            return(com.clubpenguin.crypto.MD5.hash(s));
        }
        function encryptPassword(pass) {
            var _local_1 = com.clubpenguin.crypto.MD5.hash(pass);
            _local_1 = (_local_1.substr(16, 16) + "") + _local_1.substr(0, 16);
            return(_local_1);
        }
        static var linkageId = "__Packages.com.clubpenguin.net.Airtower";
        static var serializable = Object.registerClass(linkageId, com.clubpenguin.net.Airtower);
        static var $_lc = new com.clubpenguin.util.LogChannel("Airtower");
        var SERVER_MESSAGE_DELIMITER = "%";
        var STRING_TYPE = "str";
        var XML_TYPE = "xml";
        var PLAY_EXT = "s";
        var GAME_EXT = "z";
        var NAVIGATION = "j";
        var PLAYER_HANDLER = "u";
        var ITEM_HANDLER = "i";
        var IGNORE_HANDLER = "n";
        var BUDDY_HANDLER = "b";
        var TOY_HANDLER = "t";
        var TABLE_HANDLER = "a";
        var IGLOO_HANDLER = "g";
        var PET_HANDLER = "p";
        var MESSAGE_HANDLER = "m";
        var MAIL_HANDLER = "l";
        var SURVEY_HANDLER = "e";
        var WADDLE = "w";
        var SETTING_HANDLER = "s";
        var MODERATION_HANDLER = "o";
        var NINJA_HANDLER = "ni";
        var CARD_HANDLER = "cd";
        var ROOM_HANDLER = "r";
        var NEW_USER_EXPERIENCE_HANDLER = "nx";
        var PLAYER_TRANSFORMATION_HANDLER = "pt";
        var GHOST_BUSTER_HANDLER = "gb";
        var PLAYER_TICKET_HANDLER = "tic";
        var COOKIE_BAKERY_HANDLER = "ba";
        var BATTLE_ROOM_COUNTDOWN_UPDATE = "brcu";
        var BATTLE_ROOM_STATUS_UPDATE = "brsu";
        var BATTLE_ROOM_HIT_SNOWBALL = "bhs";
        var BATTLE_ROOM_THROW_SNOWBALL = "brts";
        var REDEMPTION = "red";
        var REDEMPTION_JOIN_WORLD = "rjs";
        var HANDLE_LOGIN = "l";
        var HANDLE_LOGIN_EXPIRED = "loginMustActivate";
        var HANDLE_ALERT = "a";
        var HANDLE_ERROR = "e";
        var GET_BUDDY_LIST = "gb";
        var GET_IGNORE_LIST = "gn";
        var GET_PLAYER = "gp";
        var GET_ROOM_LIST = "gr";
        var GET_TABLE = "gt";
        var JOIN_WORLD = "js";
        var JOIN_ROOM = "jr";
        var CLIENT_ROOM_LOADED = "crl";
        var REFRESH_ROOM = "grs";
        var LOAD_PLAYER = "lp";
        var ADD_PLAYER = "ap";
        var REMOVE_PLAYER = "rp";
        var UPDATE_PLAYER = "up";
        var PLAYER_MOVE = "sp";
        var PLAYER_TELEPORT = "tp";
        var REFRESH_PLAYER_FRIEND_INFORMATION = "rpfi";
        var PLAYER_FRAME = "sf";
        var PLAYER_ACTION = "sa";
        var OPEN_BOOK = "at";
        var CLOSE_BOOK = "rt";
        var THROW_BALL = "sb";
        var JOIN_GAME = "jg";
        var JOIN_NON_BLACK_HOLE_GAME = "jnbhg";
        var LEAVE_NON_BLACK_HOLE_GAME = "lnbhg";
        var SEND_MESSAGE = "sm";
        var SEND_PHRASECHAT_MESSAGE = "sc";
        var SEND_BLOCKED_MESSAGE = "mm";
        var SEND_EMOTE = "se";
        var SEND_JOKE = "sj";
        var SEND_SAFE_MESSAGE = "ss";
        var SEND_LINE_MESSAGE = "sl";
        var SEND_QUICK_MESSAGE = "sq";
        var SEND_TOUR_GUIDE_MESSAGE = "sg";
        var COIN_DIG_UPDATE = "cdu";
        var GET_INVENTORY_LIST = "gi";
        var GET_CURRENT_TOTAL_COIN = "gtc";
        var NINJA_GET_INVENTORY_LIST = "ngi";
        var GET_CURRENCIES = "currencies";
        var MAIL_START_ENGINE = "mst";
        var GET_MAIL = "mg";
        var SEND_MAIL = "ms";
        var RECEIVE_MAIL = "mr";
        var DELETE_MAIL = "md";
        var DELETE_MAIL_FROM_PLAYER = "mdp";
        var GET_MAIL_DETAILS = "mgd";
        var MAIL_CHECKED = "mc";
        var GAME_OVER = "zo";
        var BUY_INVENTORY = "ai";
        var CHECK_INVENTORY = "qi";
        var ADD_IGNORE = "an";
        var REMOVE_IGNORE = "rn";
        var REMOVE_BUDDY = "rb";
        var REQUEST_BUDDY = "br";
        var ACCEPT_BUDDY = "ba";
        var BUDDY_ONLINE = "bon";
        var BUDDY_OFFLINE = "bof";
        var FIND_BUDDY = "bf";
        var GET_PLAYER_OBJECT = "gp";
        var GET_MASCOT_OBJECT = "gmo";
        var REPORT_PLAYER = "r";
        var GET_ACTION_STATUS = "gas";
        var UPDATE_PLAYER_COLOUR = "upc";
        var UPDATE_PLAYER_HEAD = "uph";
        var UPDATE_PLAYER_FACE = "upf";
        var UPDATE_PLAYER_NECK = "upn";
        var UPDATE_PLAYER_BODY = "upb";
        var UPDATE_PLAYER_HAND = "upa";
        var UPDATE_PLAYER_FEET = "upe";
        var UPDATE_PLAYER_FLAG = "upl";
        var UPDATE_PLAYER_PHOTO = "upp";
        var UPDATE_PLAYER_REMOVE = "upr";
        var SEND_ACTION_DANCE = "sdance";
        var SEND_ACTION_WAVE = "swave";
        var SEND_ACTION_SNOWBALL = "ssnowball";
        var GET_FURNITURE_LIST = "gii";
        var UPDATE_ROOM = "up";
        var UPDATE_FLOOR = "ag";
        var UPDATE_IGLOO_TYPE = "au";
        var BUY_IGLOO_LOCATION = "aloc";
        var UNLOCK_IGLOO = "or";
        var LOCK_IGLOO = "cr";
        var UPDATE_IGLOO_MUSIC = "um";
        var GET_IGLOO_DETAILS = "gm";
        var JOIN_PLAYER_ROOM = "jp";
        var SAVE_IGLOO_FURNITURE = "ur";
        var JUMP_TO_IGLOO = "ji";
        var GET_IGLOO_LIST = "gr";
        var GET_IGLOO_LIST_ITEM = "gri";
        var PLAYER_IGLOO_OPEN = "pio";
        var BUY_FURNITURE = "af";
        var BUY_MULTIPLE_FURNITURE = "buy_multiple_furniture";
        var SEND_IGLOO = "sig";
        var GET_OWNED_IGLOOS = "go";
        var ACTIVATE_IGLOO = "ao";
        var GET_MY_PLAYER_PUFFLES = "pgu";
        var GET_PLAYER_PUFFLES = "pg";
        var PUFFLE_FRAME = "ps";
        var PUFFLE_MOVE = "pm";
        var PUFFLE_VISITOR_HAT_UPDATE = "puphi";
        var ADD_A_PUFFLE = "addpuffle";
        var REST_PUFFLE = "pr";
        var BATH_PUFFLE = "pb";
        var PLAY_PUFFLE = "pp";
        var BUBBLE_GUM_PUFFLE = "pbg";
        var FEED_PUFFLE = "pf";
        var WALK_PUFFLE = "pw";
        var TREAT_PUFFLE = "pt";
        var SWAP_PUFFLE = "puffleswap";
        var WALK_SWAP_PUFFLE = "pufflewalkswap";
        var INTERACTION_PLAY = "ip";
        var INTERACTION_REST = "ir";
        var INTERACTION_FEED = "if";
        var PUFFLE_INIT_INTERACTION_PLAY = "pip";
        var PUFFLE_INIT_INTERACTION_REST = "pir";
        var ADOPT_PUFFLE = "pn";
        var PUFFLE_QUIZ_STATUS = "pgas";
        var ADD_PUFFLE_CARE_ITEM = "papi";
        var UPDATE_TABLE = "ut";
        var GET_TABLE_POPULATION = "gt";
        var JOIN_TABLE = "jt";
        var LEAVE_TABLE = "lt";
        var UPDATE_WADDLE = "uw";
        var GET_WADDLE_POPULATION = "gw";
        var GET_WADDLE_CJ = "gwcj";
        var JOIN_WADDLE = "jw";
        var LEAVE_WADDLE = "lw";
        var START_WADDLE = "sw";
        var SEND_WADDLE = "jx";
        var CARD_JITSU_MATCH_SUCCESSFUL = "cjms";
        var SPY_PHONE_REQUEST = "spy";
        var HEARTBEAT = "h";
        var TIMEOUT = "t";
        var MODERATOR_ACTION = "ma";
        var KICK = "k";
        var MUTE = "m";
        var BAN = "b";
        var INT_BAN = "initban";
        var SEND_MASCOT_MESSAGE = "sma";
        var DONATE = "dc";
        var POLL = "spl";
        var CONNECTION_LOST = "con";
        var GET_CARDS = "gcd";
        var GET_NINJA_LEVEL = "gnl";
        var GET_FIRE_LEVEL = "gfl";
        var GET_WATER_LEVEL = "gwl";
        var GET_SNOW_LEVEL = "gsl";
        var GET_NINJA_RANKS = "gnr";
        var BUY_POWER_CARDS = "bpc";
        var SET_SAVED_MAP_CATEGORY = "mcs";
        var SET_PLAYER_CARD_OPENED = "pcos";
        var SET_VISITED_CONTENT_FLAGS = "vcfs";
        var GET_VISITED_CONTENT_FLAGS = "vcf";
        var PLAYER_TRANSFORMATION = "spts";
        var GET_LAST_REVISION = "glr";
        var MOBILE_ACCOUNT_ACTIVATION_REQUIRED = "maar";
        var GET_PLAYER_ID_AND_NAME_BY_SWID = "pbs";
        var GET_PLAYER_INFO_BY_NAME = "pbn";
        var GET_PLAYER_INFO_BY_ID = "pbi";
        var GET_PLAYER_IDS_BY_SWIDS = "pbsm";
        var PBSM_START = "pbsms";
        var PBSM_FINISHED = "pbsmf";
        static var LOGIN_ZONE = "w1";
        static var SERVER_ZONE = "w1";
        var SCAVENGER_HUNT_NOTIFICATION = "shn";
        var GET_SCAVENGER_HUNT_TICKETS = "gptc";
        var INC_SCAVENGER_HUNT_TICKETS = "iptc";
        var DEC_SCAVENGER_HUNT_TICKETS = "dptc";
        var COINS_AWARDED = "$";
        var PLAYER_DIRECTOR_POINTS = "pdp";
        var GET_COINS_FOR_CHANGE_TOTALS = "gcfct";
        var CAN_PURCHASE_COOKIE = "cac";
        var PURCHASE_COOKIE = "ac";
        var COOKIES_READY = "cr";
        var GET_BAKERY_ROOM_STATE = "barsu";
        var SEND_SNOWBALL_ENTER_HOPPER = "seh";
        var GET_COOKIE_STOCK = "ctc";
        var CANCEL_COOKIE_RESERVATION = "cc";
        var GET_PARTY_COOKIE = "qpc";
        var SET_PARTY_COOKIE = "spd";
        var SET_PLAYER_TEST_GROUP_ID = "pigt";
        var UPDATE_EGG_TIMER = "uet";
        var SNOWBALL_HIT = "sh";
        var GET_AB_TEST_DATA = "gabcms";
        var GET_ACTIVE_FEATURES = "activefeatures";
        var server_ip = "";
        var server_port = 0;
        var loginObject = {};
        var username = "";
        var password = "";
        var playerId = -1;
        var rand_key = "";
        var is_logged_in = false;
        var server = null;
        var sf_listener_container = new Object();
        var isRedemption = false;
        var isJump = false;
        var isJumpToNewServerInProgress = false;
        var FRAME_LABEL_WELCOME = "welcome";
        var FRAME_LABEL_BACK = "back";
        var FRAME_LABEL_EXPIRED = "expired";
        var debugName = "";
    }
