dynamic class com.clubpenguin.net.Airtower
{
    static var linkageId: String = "__Packages.com.clubpenguin.net.Airtower";
    static var serializable = Object.registerClass(com.clubpenguin.net.Airtower.linkageId, com.clubpenguin.net.Airtower);
    static var $_lc = new com.clubpenguin.util.LogChannel("Airtower");
    var SERVER_MESSAGE_DELIMITER: String = "%";
    var STRING_TYPE: String = "str";
    var XML_TYPE: String = "xml";
    var PLAY_EXT: String = "s";
    var GAME_EXT: String = "z";
    var NAVIGATION: String = "j";
    var PLAYER_HANDLER: String = "u";
    var ITEM_HANDLER: String = "i";
    var IGNORE_HANDLER: String = "n";
    var BUDDY_HANDLER: String = "b";
    var TOY_HANDLER: String = "t";
    var TABLE_HANDLER: String = "a";
    var IGLOO_HANDLER: String = "g";
    var PET_HANDLER: String = "p";
    var MESSAGE_HANDLER: String = "m";
    var MAIL_HANDLER: String = "l";
    var SURVEY_HANDLER: String = "e";
    var WADDLE: String = "w";
    var SETTING_HANDLER: String = "s";
    var MODERATION_HANDLER: String = "o";
    var NINJA_HANDLER: String = "ni";
    var CARD_HANDLER: String = "cd";
    var ROOM_HANDLER: String = "r";
    var NEW_USER_EXPERIENCE_HANDLER: String = "nx";
    var PLAYER_TRANSFORMATION_HANDLER: String = "pt";
    var GHOST_BUSTER_HANDLER: String = "gb";
    var PLAYER_TICKET_HANDLER: String = "tic";
    var COOKIE_BAKERY_HANDLER: String = "ba";
    var BATTLE_ROOM_COUNTDOWN_UPDATE: String = "brcu";
    var BATTLE_ROOM_STATUS_UPDATE: String = "brsu";
    var BATTLE_ROOM_HIT_SNOWBALL: String = "bhs";
    var BATTLE_ROOM_THROW_SNOWBALL: String = "brts";
    var REDEMPTION: String = "red";
    var REDEMPTION_JOIN_WORLD: String = "rjs";
    var HANDLE_LOGIN: String = "l";
    var HANDLE_LOGIN_EXPIRED: String = "loginMustActivate";
    var HANDLE_ALERT: String = "a";
    var HANDLE_ERROR: String = "e";
    var GET_BUDDY_LIST: String = "gb";
    var GET_IGNORE_LIST: String = "gn";
    var GET_PLAYER: String = "gp";
    var GET_ROOM_LIST: String = "gr";
    var GET_TABLE: String = "gt";
    var JOIN_WORLD: String = "js";
    var JOIN_ROOM: String = "jr";
    var CLIENT_ROOM_LOADED: String = "crl";
    var REFRESH_ROOM: String = "grs";
    var LOAD_PLAYER: String = "lp";
    var ADD_PLAYER: String = "ap";
    var REMOVE_PLAYER: String = "rp";
    var UPDATE_PLAYER: String = "up";
    var PLAYER_MOVE: String = "sp";
    var PLAYER_TELEPORT: String = "tp";
    var REFRESH_PLAYER_FRIEND_INFORMATION: String = "rpfi";
    var PLAYER_FRAME: String = "sf";
    var PLAYER_ACTION: String = "sa";
    var OPEN_BOOK: String = "at";
    var CLOSE_BOOK: String = "rt";
    var THROW_BALL: String = "sb";
    var JOIN_GAME: String = "jg";
    var JOIN_NON_BLACK_HOLE_GAME: String = "jnbhg";
    var LEAVE_NON_BLACK_HOLE_GAME: String = "lnbhg";
    var SEND_MESSAGE: String = "sm";
    var SEND_PHRASECHAT_MESSAGE: String = "sc";
    var SEND_BLOCKED_MESSAGE: String = "mm";
    var SEND_EMOTE: String = "se";
    var SEND_JOKE: String = "sj";
    var SEND_SAFE_MESSAGE: String = "ss";
    var SEND_LINE_MESSAGE: String = "sl";
    var SEND_QUICK_MESSAGE: String = "sq";
    var SEND_TOUR_GUIDE_MESSAGE: String = "sg";
    var COIN_DIG_UPDATE: String = "cdu";
    var GET_INVENTORY_LIST: String = "gi";
    var GET_CURRENT_TOTAL_COIN: String = "gtc";
    var NINJA_GET_INVENTORY_LIST: String = "ngi";
    var GET_CURRENCIES: String = "currencies";
    var MAIL_START_ENGINE: String = "mst";
    var GET_MAIL: String = "mg";
    var SEND_MAIL: String = "ms";
    var RECEIVE_MAIL: String = "mr";
    var DELETE_MAIL: String = "md";
    var DELETE_MAIL_FROM_PLAYER: String = "mdp";
    var GET_MAIL_DETAILS: String = "mgd";
    var MAIL_CHECKED: String = "mc";
    var GAME_OVER: String = "zo";
    var BUY_INVENTORY: String = "ai";
    var CHECK_INVENTORY: String = "qi";
    var ADD_IGNORE: String = "an";
    var REMOVE_IGNORE: String = "rn";
    var REMOVE_BUDDY: String = "rb";
    var REQUEST_BUDDY: String = "br";
    var ACCEPT_BUDDY: String = "ba";
    var BUDDY_ONLINE: String = "bon";
    var BUDDY_OFFLINE: String = "bof";
    var FIND_BUDDY: String = "bf";
    var GET_PLAYER_OBJECT: String = "gp";
    var GET_MASCOT_OBJECT: String = "gmo";
    var REPORT_PLAYER: String = "r";
    var GET_ACTION_STATUS: String = "gas";
    var UPDATE_PLAYER_COLOUR: String = "upc";
    var UPDATE_PLAYER_HEAD: String = "uph";
    var UPDATE_PLAYER_FACE: String = "upf";
    var UPDATE_PLAYER_NECK: String = "upn";
    var UPDATE_PLAYER_BODY: String = "upb";
    var UPDATE_PLAYER_HAND: String = "upa";
    var UPDATE_PLAYER_FEET: String = "upe";
    var UPDATE_PLAYER_FLAG: String = "upl";
    var UPDATE_PLAYER_PHOTO: String = "upp";
    var UPDATE_PLAYER_REMOVE: String = "upr";
    var SEND_ACTION_DANCE: String = "sdance";
    var SEND_ACTION_WAVE: String = "swave";
    var SEND_ACTION_SNOWBALL: String = "ssnowball";
    var GET_FURNITURE_LIST: String = "gii";
    var UPDATE_ROOM: String = "up";
    var UPDATE_FLOOR: String = "ag";
    var UPDATE_IGLOO_TYPE: String = "au";
    var BUY_IGLOO_LOCATION: String = "aloc";
    var UNLOCK_IGLOO: String = "or";
    var LOCK_IGLOO: String = "cr";
    var UPDATE_IGLOO_MUSIC: String = "um";
    var GET_IGLOO_DETAILS: String = "gm";
    var JOIN_PLAYER_ROOM: String = "jp";
    var SAVE_IGLOO_FURNITURE: String = "ur";
    var JUMP_TO_IGLOO: String = "ji";
    var GET_IGLOO_LIST: String = "gr";
    var GET_IGLOO_LIST_ITEM: String = "gri";
    var PLAYER_IGLOO_OPEN: String = "pio";
    var BUY_FURNITURE: String = "af";
    var BUY_MULTIPLE_FURNITURE: String = "buy_multiple_furniture";
    var SEND_IGLOO: String = "sig";
    var GET_OWNED_IGLOOS: String = "go";
    var ACTIVATE_IGLOO: String = "ao";
    var GET_MY_PLAYER_PUFFLES: String = "pgu";
    var RETURN_PUFFLE: String = "prp";
    var GET_PLAYER_PUFFLES: String = "pg";
    var PUFFLE_FRAME: String = "ps";
    var PUFFLE_MOVE: String = "pm";
    var PUFFLE_VISITOR_HAT_UPDATE: String = "puphi";
    var ADD_A_PUFFLE: String = "addpuffle";
    var REST_PUFFLE: String = "pr";
    var BATH_PUFFLE: String = "pb";
    var PLAY_PUFFLE: String = "pp";
    var BUBBLE_GUM_PUFFLE: String = "pbg";
    var FEED_PUFFLE: String = "pf";
    var WALK_PUFFLE: String = "pw";
    var TREAT_PUFFLE: String = "pt";
    var SWAP_PUFFLE: String = "puffleswap";
    var WALK_SWAP_PUFFLE: String = "pufflewalkswap";
    var INTERACTION_PLAY: String = "ip";
    var INTERACTION_REST: String = "ir";
    var INTERACTION_FEED: String = "if";
    var PUFFLE_INIT_INTERACTION_PLAY: String = "pip";
    var PUFFLE_INIT_INTERACTION_REST: String = "pir";
    var ADOPT_PUFFLE: String = "pn";
    var PUFFLE_QUIZ_STATUS: String = "pgas";
    var ADD_PUFFLE_CARE_ITEM: String = "papi";
    var UPDATE_TABLE: String = "ut";
    var GET_TABLE_POPULATION: String = "gt";
    var JOIN_TABLE: String = "jt";
    var LEAVE_TABLE: String = "lt";
    var UPDATE_WADDLE: String = "uw";
    var GET_WADDLE_POPULATION: String = "gw";
    var GET_WADDLE_CJ: String = "gwcj";
    var JOIN_WADDLE: String = "jw";
    var LEAVE_WADDLE: String = "lw";
    var START_WADDLE: String = "sw";
    var SEND_WADDLE: String = "jx";
    var CARD_JITSU_MATCH_SUCCESSFUL: String = "cjms";
    var SPY_PHONE_REQUEST: String = "spy";
    var HEARTBEAT: String = "h";
    var TIMEOUT: String = "t";
    var MODERATOR_ACTION: String = "ma";
    var KICK: String = "k";
    var MUTE: String = "m";
    var BAN: String = "b";
    var INT_BAN: String = "initban";
    var SEND_MASCOT_MESSAGE: String = "sma";
    var DONATE: String = "dc";
    var POLL: String = "spl";
    var CONNECTION_LOST: String = "con";
    var GET_CARDS: String = "gcd";
    var GET_NINJA_LEVEL: String = "gnl";
    var GET_FIRE_LEVEL: String = "gfl";
    var GET_WATER_LEVEL: String = "gwl";
    var GET_SNOW_LEVEL: String = "gsl";
    var GET_NINJA_RANKS: String = "gnr";
    var BUY_POWER_CARDS: String = "bpc";
    var SET_SAVED_MAP_CATEGORY: String = "mcs";
    var SET_PLAYER_CARD_OPENED: String = "pcos";
    var SET_VISITED_CONTENT_FLAGS: String = "vcfs";
    var GET_VISITED_CONTENT_FLAGS: String = "vcf";
    var PLAYER_TRANSFORMATION: String = "spts";
    var GET_LAST_REVISION: String = "glr";
    var MOBILE_ACCOUNT_ACTIVATION_REQUIRED: String = "maar";
    var GET_PLAYER_ID_AND_NAME_BY_SWID: String = "pbs";
    var GET_PLAYER_INFO_BY_NAME: String = "pbn";
    var GET_PLAYER_INFO_BY_ID: String = "pbi";
    var GET_PLAYER_IDS_BY_SWIDS: String = "pbsm";
    var PBSM_START: String = "pbsms";
    var PBSM_FINISHED: String = "pbsmf";
    static var LOGIN_ZONE: String = "w1";
    static var SERVER_ZONE: String = "w1";
    var SCAVENGER_HUNT_NOTIFICATION: String = "shn";
    var GET_SCAVENGER_HUNT_TICKETS: String = "gptc";
    var INC_SCAVENGER_HUNT_TICKETS: String = "iptc";
    var DEC_SCAVENGER_HUNT_TICKETS: String = "dptc";
    var COINS_AWARDED: String = "$";
    var PLAYER_DIRECTOR_POINTS: String = "pdp";
    var GET_COINS_FOR_CHANGE_TOTALS: String = "gcfct";
    var CAN_PURCHASE_COOKIE: String = "cac";
    var PURCHASE_COOKIE: String = "ac";
    var COOKIES_READY: String = "cr";
    var GET_BAKERY_ROOM_STATE: String = "barsu";
    var SEND_SNOWBALL_ENTER_HOPPER: String = "seh";
    var GET_COOKIE_STOCK: String = "ctc";
    var CANCEL_COOKIE_RESERVATION: String = "cc";
    var GET_PARTY_COOKIE: String = "qpc";
    var SET_PARTY_COOKIE: String = "spd";
    var SET_PLAYER_TEST_GROUP_ID: String = "pigt";
    var UPDATE_EGG_TIMER: String = "uet";
    var SNOWBALL_HIT: String = "sh";
    var GET_AB_TEST_DATA: String = "gabcms";
    var GET_ACTIVE_FEATURES: String = "activefeatures";
    var server_ip: String = "";
    var server_port: Number = 0;
    var loginObject = {};
    var username: String = "";
    var password: String = "";
    var playerId: Number = -1;
    var rand_key: String = "";
    var is_logged_in: Boolean = false;
    var server = null;
    var sf_listener_container = new Object();
    var isRedemption: Boolean = false;
    var isJump: Boolean = false;
    var isJumpToNewServerInProgress: Boolean = false;
    var FRAME_LABEL_WELCOME: String = "welcome";
    var FRAME_LABEL_EXPIRED: String = "expired";
    var debugName: String = "";
    var LOGIN_IP;
    var LOGIN_PORT;
    var _isBlocked;
    var autoLogin;
    var on_login_response;
    var on_world_response;
    var shell;

    function Airtower(shell)
    {
        this.shell = shell;
        this._isBlocked = false;
    }

    function toString()
    {
        return "Airtower[" + this.debugName + "]";
    }

    function init()
    {
        var __reg2 = this.shell.getLoginServer();
        this.LOGIN_IP = __reg2.ip;
        com.clubpenguin.util.Log.debug("LOGIN_IP: " + this.LOGIN_IP);
        this.LOGIN_PORT = __reg2.port;
        com.clubpenguin.util.Log.debug("LOGIN_PORT: " + this.LOGIN_PORT);
        this.sf_listener_container = new Object();
        this.server = new com.clubpenguin.net.Connection();
    }

    function getServer()
    {
        return this.server;
    }

    function setIsJumpToNewServerInProgress(isJumping)
    {
        this.isJumpToNewServerInProgress = isJumping;
    }

    function getSentCommandsBuffer()
    {
        var __reg2 = "";
        var __reg4 = this.getServer().getSentCommandsBuffer();
        var __reg3 = 0;
        while (__reg3 < __reg4.length) 
        {
            __reg2 = __reg2 + __reg4[__reg3];
            if (__reg3 != __reg4.length - 1) 
            {
                __reg2 = __reg2 + "\n";
            }
            ++__reg3;
        }
        return __reg2;
    }

    function cloneListeners(cloneTo)
    {
        for (var __reg6 in this.sf_listener_container) 
        {
            var __reg4 = this.sf_listener_container[__reg6];
            var __reg3 = 0;
            while (__reg3 < __reg4.length) 
            {
                var __reg2 = __reg4[__reg3];
                com.clubpenguin.util.Log.debug("clone listener -> type: " + __reg6 + " listener.func: " + __reg2.func + " listener.scope: " + __reg2.scope);
                cloneTo.addListener(__reg6, __reg2.func, __reg2.scope);
                ++__reg3;
            }
        }
    }

    function addListener(type, func, scope)
    {
        if (type == undefined || func == undefined) 
        {
            this.shell.$e("addListner() -> You must pass a valid listener type and function! type: " + type + " func: " + func);
            return false;
        }
        var __reg3 = this.getListenersArray(type);
        var __reg4 = this.getListenerIndex(__reg3, func);
        if (__reg4 == -1) 
        {
            this.shell.$d("[airtower] Successfully added listener to: \"" + type + "\"");
            __reg3.push({func: func, scope: scope});
            return true;
        }
        this.shell.$d("[airtower] Failed to add listener. Tried to add a duplicate listener to: \"" + type + "\"");
        return false;
    }

    function removeListener(type, func)
    {
        var __reg3 = this.getListenersArray(type);
        var __reg2 = this.getListenerIndex(__reg3, func);
        if (__reg2 != -1) 
        {
            this.shell.$d("[airtower] Successfully removed listener from: \"" + type + "\"");
            __reg3.splice(__reg2, 1);
            return true;
        }
        this.shell.$d("[airtower] Failed to remove listener which did not exist from: \"" + type + "\"");
        return false;
    }

    function getListenerIndex(array, func)
    {
        var __reg2 = array.length;
        var __reg1 = 0;
        while (__reg1 < __reg2) 
        {
            if (array[__reg1].func == func) 
            {
                return __reg1;
            }
            ++__reg1;
        }
        return -1;
    }

    function updateListeners(type, obj)
    {
        var __reg3 = this.getListenersArray(type);
        var __reg5 = __reg3.length;
        if (__reg5 < 1) 
        {
            this.shell.$d("[airtower] No listeners currently attached to: \"" + type + "\"");
            return false;
        }
        if (__reg5 == 1) 
        {
            __reg3[0].scope ? __reg3[0].func.call(__reg3[0].scope, obj) : __reg3[0].func(obj);
            return true;
        }
        var __reg2 = 0;
        while (__reg2 < __reg5) 
        {
            __reg3[__reg2].scope ? __reg3[__reg2].func.call(__reg3[__reg2].scope, obj) : __reg3[__reg2].func(obj);
            ++__reg2;
        }
        return true;
    }

    function getListenersArray(type)
    {
        if (this.sf_listener_container[type] == undefined) 
        {
            this.sf_listener_container[type] = new Array();
        }
        return this.sf_listener_container[type];
    }

    function onAirtowerResponse(eventData, type, overrideBlock)
    {
        var __reg0;
        if (!this._isBlocked || overrideBlock == true) 
        {
            var __reg2 = String(eventData[0]);
            if (com.clubpenguin.net.BridgeFilter.messageIsSentToAS3(this, __reg2)) 
            {
                this.shell.sendAirtowerEvent(eventData.join(this.SERVER_MESSAGE_DELIMITER) + this.SERVER_MESSAGE_DELIMITER);
            }
            com.clubpenguin.util.Log.debug("onAirtowerResponse (eventType = " + __reg2 + ")", com.clubpenguin.net.Airtower.$_lc);
            com.clubpenguin.util.Log.debug("onAirtowerResponse after service test (eventType = " + __reg2 + ")", com.clubpenguin.net.Airtower.$_lc);
            eventData.shift();
            if ((__reg0 = __reg2) === "gwcj") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "gw") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "jw") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "sw") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "cjms") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "jx") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "gz") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "jz") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "uz") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "sz") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            else if (__reg0 === "uw") 
            {
                this.sendAck(__reg2, eventData.slice());
            }
            this.updateListeners(__reg2, eventData);
        }
    }

    function sendAck(command, data)
    {
        data = data.slice();
        data.unshift(command);
        data.unshift("time=" + String((new Date()).getTime()));
        this.send(this.PLAY_EXT, "bi#ack", data, "str", _global.getCurrentShell().getCurrentServerRoomId());
    }

    function isBlocked()
    {
        return this._isBlocked;
    }

    function block()
    {
        this._isBlocked = true;
        this.server.isBlocked = true;
        this.server.onConnectionLost = null;
    }

    function unblock()
    {
        this._isBlocked = false;
        this.server.isBlocked = false;
        this.server.onConnectionLost = com.clubpenguin.util.Delegate.create(this, this.handleLostConnection);
    }

    function setConnection(connection)
    {
        this.server = connection || this.server;
    }

    function setUsername(in_username)
    {
        this.username = in_username;
    }

    function setPlayerId(in_playerId)
    {
        this.playerId = in_playerId;
    }

    function connectToLogin(in_username, in_pass, login_response, doAutoLogin)
    {
        com.clubpenguin.util.Log.debug("\n");
        com.clubpenguin.util.Log.debug("********************************************************************");
        com.clubpenguin.util.Log.debug("connectToLogin");
        com.clubpenguin.util.Log.debug("this = " + this);
        com.clubpenguin.util.Log.debug("in_username: " + in_username);
        com.clubpenguin.util.Log.debug("in_pass: " + in_pass);
        com.clubpenguin.util.Log.debug("login_response: " + login_response);
        com.clubpenguin.util.Log.debug("doAutoLogin: " + doAutoLogin);
        com.clubpenguin.util.Log.debug("server: " + this.server);
        com.clubpenguin.util.Log.debug("server.connected(); " + this.server.connected());
        com.clubpenguin.util.Log.debug("is_logged_in: " + this.is_logged_in);
        if (this.is_logged_in) 
        {
            this.shell.$e("connectToLogin() -> Your already logged in! Cant login again");
        }
        else 
        {
            if (this.server.connected()) 
            {
                this.server.disconnect();
            }
            this.on_login_response = login_response;
            this.username = in_username;
            this.password = in_pass;
            this.autoLogin = doAutoLogin;
            this.server.onConnection = com.clubpenguin.util.Delegate.create(this, this.handleLoginConnection);
            this.server.onRandomKey = com.clubpenguin.util.Delegate.create(this, this.handleLoginRandomKey);
            this.server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this, this.onAirtowerResponse);
            this.server.debug = true;
            this.addListener(this.HANDLE_LOGIN, this.handleOnLogin, this);
            this.addListener(this.HANDLE_LOGIN_EXPIRED, this.handleExpiredPreactivationLogin, this);
            this.server.connect(this.LOGIN_IP, this.LOGIN_PORT);
        }
        com.clubpenguin.util.Log.debug("********************************************************************");
    }

    function handleLostConnection()
    {
        com.clubpenguin.util.Log.debug("Airtower.handleLostConnection() this = " + this);
        if (!this.isJumpToNewServerInProgress) 
        {
            this.shell.sendIdlePlayerTimeout();
        }
        this.updateListeners(this.CONNECTION_LOST, null);
    }

    function handleLoginConnection(success)
    {
        if (success) 
        {
            this.server.getRandomKey();
            return undefined;
        }
        this.server.disconnect();
        this.on_login_response(false);
    }

    function handleLoginRandomKey(key)
    {
        this.rand_key = key;
        this.login();
    }

    function login()
    {
        if (!this.autoLogin) 
        {
            this.server.login(com.clubpenguin.net.Airtower.LOGIN_ZONE, this.username, this.getLoginHash());
            return undefined;
        }
        this.server.login(com.clubpenguin.net.Airtower.LOGIN_ZONE, this.username, this.password);
    }

    function handleOnLogin(serverResponse)
    {
        this.removeListener(this.HANDLE_LOGIN, this.handleOnLogin);
        this.removeListener(this.HANDLE_LOGIN_EXPIRED, this.handleExpiredPreactivationLogin, this);
        this.server.disconnect();
        com.clubpenguin.util.Log.debug("handleOnLogin: " + serverResponse);
        var __reg5 = serverResponse[1].split("|");
        this.loginObject = {};
        this.loginObject.loginDataRaw = serverResponse[1];
        this.loginObject.playerID = __reg5[0];
        this.loginObject.swid = __reg5[1];
        this.loginObject.username = __reg5[2];
        this.loginObject.loginKey = __reg5[3];
        this.loginObject.languageApproved = __reg5[5];
        this.loginObject.languageRejected = __reg5[6];
        this.loginObject.friendsLoginKey = serverResponse[3];
        this.loginObject.confirmationHash = serverResponse[2];
        this.loginObject.emailAddress = serverResponse[5];
        if (serverResponse[6] != null) 
        {
            var __reg4 = serverResponse[6].split("|");
            this.loginObject.remaining_hours = __reg4[0];
            this.loginObject.trialMax = __reg4[1];
            this.loginObject.max_grace_hours = __reg4[2];
            var __reg9 = new Object();
            __reg9.modalBackgroundEnbaled = true;
            __reg9.blockPuffleNotifications = true;
            __reg9.hideLoadingDialog = true;
            var __reg3 = new Object();
            __reg3.state = this.FRAME_LABEL_WELCOME;
            __reg3.trialRemaining = __reg4[0];
            __reg3.trialMax = __reg4[1];
            __reg3.graceMax = __reg4[2];
            __reg3.confirmationHash = this.loginObject.confirmationHash;
            __reg3.loginDataRaw = this.loginObject.loginDataRaw;
            this.shell.sendOpenAS3Module("preactivation", __reg3, __reg9);
            flash.external.ExternalInterface.call("showActivationBanner", __reg4[0]);
        }
        for (var __reg8 in serverResponse) 
        {
        };
        for (var __reg7 in this.loginObject) 
        {
            com.clubpenguin.util.Log.debug("loginObject." + __reg7 + ":" + this.loginObject[__reg7]);
        }
        this.shell.playerModel.initMyPlayer(this.loginObject);
        this.playerId = this.loginObject.playerID;
        this.shell.updateWorldPopulations(serverResponse[4]);
        var __reg6 = new Object();
        __reg6.type = 15;
        __reg6.playerSWID = this.loginObject.swid;
        __reg6.playerID = this.loginObject.playerID;
        this.shell.sendPlaydomTracking(__reg6);
        this.on_login_response(true);
        this.is_logged_in = true;
        com.clubpenguin.login.LoginFloodManager.clearFloodControl();
        var __reg10 = this.shell.getLanguageBitmask();
        com.clubpenguin.util.Log.debug("\t-loginObject.languageRejected: " + this.loginObject.languageRejected);
        com.clubpenguin.util.Log.debug("\t-lang: " + __reg10);
        com.clubpenguin.util.Log.debug(" -loginObject.languageRejected & lang: " + this.loginObject.languageRejected + __reg10);
        if (this.loginObject.languageRejected & __reg10) 
        {
            com.clubpenguin.util.Log.debug("calling out to nameResubmission");
            flash.external.ExternalInterface.call("nameResubmission", this.loginObject.playerID, this.loginObject.confirmationHash, this.loginObject.loginDataRaw);
        }
    }

    function handleExpiredPreactivationLogin(serverResponse)
    {
        this.removeListener(this.HANDLE_LOGIN, this.handleOnLogin);
        this.removeListener(this.HANDLE_LOGIN_EXPIRED, this.handleExpiredPreactivationLogin, this);
        var __reg3 = new Object();
        __reg3.modalBackgroundEnbaled = true;
        __reg3.blockPuffleNotifications = true;
        __reg3.hideLoadingDialog = true;
        var __reg2 = new Object();
        __reg2.state = this.FRAME_LABEL_EXPIRED;
        __reg2.graceRemaining = serverResponse[1];
        __reg2.confirmationHash = serverResponse[2];
        __reg2.loginDataRaw = serverResponse[3];
        __reg2.emailAddress = serverResponse[4];
        this.shell.sendOpenAS3Module("preactivation", __reg2, __reg3);
        var __reg5 = this.shell.getLanguageBitmask();
        if (this.loginObject.languageRejected & __reg5) 
        {
            flash.external.ExternalInterface.call("nameResubmission", this.loginObject.playerID, this.loginObject.confirmationHash, this.loginObject.loginDataRaw);
        }
    }

    function connectToRedemption(server_ip, server_port, connect_to_world_response)
    {
        this.isRedemption = true;
        this.on_world_response = connect_to_world_response;
        this.server.onConnection = com.clubpenguin.util.Delegate.create(this, this.handleWorldConnection);
        this.server.onRandomKey = com.clubpenguin.util.Delegate.create(this, this.handleWorldRandomKey);
        this.addListener(this.HANDLE_LOGIN, this.joinWorld, this);
        this.server.connect(server_ip, server_port);
    }

    function connectToWorld(server_ip, server_port, connect_to_world_response, loginKey)
    {
        this.isRedemption = false;
        this.on_world_response = connect_to_world_response;
        this.server.onConnection = com.clubpenguin.util.Delegate.create(this, this.handleWorldConnection);
        this.server.onRandomKey = com.clubpenguin.util.Delegate.create(this, this.handleWorldRandomKey);
        this.server.onExtensionResponse = com.clubpenguin.util.Delegate.create(this, this.onAirtowerResponse);
        this.server.debug = true;
        this.addListener(this.HANDLE_LOGIN, this.joinWorld, this);
        this.server.connect(server_ip, server_port);
    }

    function handleWorldConnection(success)
    {
        if (success) 
        {
            this.server.getRandomKey();
            return undefined;
        }
        this.server.onConnection = null;
        this.server.onConnectionLost = null;
        this.server.onRandomKey = null;
        this.server.onExtensionResponse = null;
        this.on_world_response(false, false, false, false, false);
        this.on_world_response = null;
    }

    function handleWorldRandomKey(key)
    {
        this.rand_key = key;
        this.worldLogin();
    }

    function worldLogin()
    {
        com.clubpenguin.util.Log.debug("worldLogin isJump = " + this.isJump + "   use encryption");
        var __reg2 = this.encryptPassword(this.loginObject.loginKey + this.rand_key) + this.loginObject.loginKey;
        this.server.login(com.clubpenguin.net.Airtower.SERVER_ZONE, this.loginObject.Username, __reg2, this.shell.getMyPlayerObject().confirmationHash, this.shell.getMyPlayerObject().loginDataRaw);
    }

    function joinWorld()
    {
        this.removeListener(this.HANDLE_LOGIN, this.joinWorld);
        this.server.onConnectionLost = com.clubpenguin.util.Delegate.create(this, this.handleLostConnection);
        var __reg2 = new Array();
        if (this.isRedemption) 
        {
            __reg2.push(this.loginObject.loginDataRaw);
            __reg2.push(this.loginObject.confirmationHash);
        }
        else 
        {
            __reg2.push(this.playerId);
            __reg2.push(this.loginObject.loginKey);
        }
        __reg2.push(this.shell.getLanguageAbbriviation());
        if (this.isJump) 
        {
            __reg2.push("jmp");
        }
        else 
        {
            var __reg3 = com.clubpenguin.util.QueryParams.getQueryParams();
            if (Number(__reg3.rm)) 
            {
                __reg2.push(Number(__reg3.rm));
            }
        }
        if (this.isRedemption) 
        {
            this.addListener(this.REDEMPTION_JOIN_WORLD, this.handleJoinRedemption, this);
            this.send(this.REDEMPTION, this.REDEMPTION_JOIN_WORLD, __reg2, "str", -1);
            return undefined;
        }
        this.addListener(this.JOIN_WORLD, this.handleJoinWorld, this);
        this.addListener(this.GET_ACTIVE_FEATURES, this.handleGetActiveFeatures, this);
        this.send(this.PLAY_EXT, this.NAVIGATION + "#" + this.JOIN_WORLD, __reg2, "str", -1);
    }

    function handleJoinRedemption(obj)
    {
        this.removeListener(this.REDEMPTION_JOIN_WORLD, this.handleJoinRedemption);
        var __reg6 = new Array();
        var __reg5 = new Array();
        var __reg4 = false;
        var __reg7 = obj.shift();
        if (obj[0] != "") 
        {
            __reg6 = obj[0];
        }
        if (obj[1] != "") 
        {
            __reg5 = obj[1];
        }
        if (obj[2] != "") 
        {
            __reg4 = Boolean(Number(obj[2]));
        }
        var __reg3 = new Array();
        __reg3[0] = __reg6;
        __reg3[1] = __reg5;
        __reg3[2] = __reg4;
        this.on_world_response(__reg3);
        this.on_world_response = undefined;
    }

    function handleJoinWorld(obj)
    {
        com.clubpenguin.util.Log.debug("\n");
        com.clubpenguin.util.Log.debug("*********************************************");
        com.clubpenguin.util.Log.debug("handleJoinWorld");
        for (var __reg3 in obj) 
        {
            com.clubpenguin.util.Log.debug("prop: " + __reg3 + "  " + obj[__reg3]);
        }
        com.clubpenguin.util.Log.debug("*********************************************");
        this.removeListener(this.JOIN_WORLD, this.handleJoinWorld);
        var __reg4 = Boolean(Number(obj[1]));
        var __reg6 = Boolean(Number(obj[2]));
        var __reg5 = Boolean(Number(obj[4]));
        this.shell.playerModel.setUpModeratorPenguin(Number(obj[3]));
        this.on_world_response(true, __reg4, __reg6, __reg5);
        this.on_world_response = undefined;
        this.isJump = false;
        this.shell.sendGetABTestData();
        this.send(this.PLAY_EXT, this.NEW_USER_EXPERIENCE_HANDLER + "#" + this.GET_ACTION_STATUS, null, "str", -1);
        this.addListener(this.GET_ACTION_STATUS, this.handleGetActionStatus, this);
    }

    function handleGetActionStatus(serverResponse)
    {
        com.clubpenguin.util.Log.debug("handleGetActionStatus: " + serverResponse);
        this.removeListener(this.GET_ACTION_STATUS, this.handleGetActionStatus);
        var __reg4 = new Array(serverResponse[1], serverResponse[2], serverResponse[3]);
        this.shell.playerModel.initActionStatus(__reg4);
        _global.getCurrentEngine().localPlayerSpecialActionIndicators();
    }

    function handleGetActiveFeatures(obj)
    {
        this.removeListener(this.GET_ACTIVE_FEATURES, this.handleGetActiveFeatures);
        this.shell.activeFeaturesArray = obj.slice(1);
        this.shell.updateListeners(this.shell.UPDATE_ACTIVE_FEATURES);
    }

    function send(extension, command, arr, type, room_id)
    {
        com.clubpenguin.util.Log.debug("@@@@@ Airtower.send()  this=" + this);
        this.server.sendXtMessage(extension, command, arr, type, room_id);
    }

    function disconnect(disconnectFriends)
    {
        com.clubpenguin.util.Log.debug("[airtower] disconnect() this = " + this + "  disconnectFriends=" + disconnectFriends);
        if (disconnectFriends == undefined) 
        {
            disconnectFriends = true;
        }
        if (this.server.connected()) 
        {
            if (!this.isJumpToNewServerInProgress) 
            {
                if (disconnectFriends) 
                {
                    this.shell.disconnectFromFriends();
                }
            }
            this.server.disconnect();
            return undefined;
        }
        this.shell.$d("[airtower] disconnect() -> Trying to disconnect the server when its not connected");
    }

    function getLoginHash()
    {
        var __reg2 = this.encryptPassword(this.password).toUpperCase();
        __reg2 = this.encryptPassword(__reg2 + this.rand_key + this.encryptPassword((__reg2 = __reg2 + this.password) + this.encryptPassword(this.password = this.password + __reg2)));
        return __reg2;
    }

    function hex_md5(s)
    {
        return com.clubpenguin.crypto.MD5.hash(s);
    }

    function encryptPassword(pass)
    {
        var __reg1 = com.clubpenguin.crypto.MD5.hash(pass);
        __reg1 = __reg1.substr(16, 16) + "" + __reg1.substr(0, 16);
        return __reg1;
    }

}
