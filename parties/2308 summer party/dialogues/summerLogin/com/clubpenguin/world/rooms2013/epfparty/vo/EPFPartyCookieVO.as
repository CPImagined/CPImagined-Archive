//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.epfparty.vo.EPFPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function EPFPartyCookieVO (cookieId) {
            super(cookieId);
            var _local_3 = _global.getCurrentShell();
        }
        function getCookieHandlerName() {
            return(EPF_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(EPF_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(EPF_RECEIVE_COMMAND_NAME);
        }
        function get garyMessageViewed() {
            if (_jsonObject.garyMessageViewed == null) {
                return(false);
            }
            return(_jsonObject.garyMessageViewed);
        }
        function set garyMessageViewed(value) {
            if (value == null) {
                traceSetError("garyMessageViewed", String(value));
                return;
            }
            _jsonObject.garyMessageViewed = value;
            //return(garyMessageViewed);
        }
        function get directorVideoViewed() {
            if (_jsonObject.directorVideoViewed == null) {
                return(false);
            }
            return(_jsonObject.directorVideoViewed);
        }
        function set directorVideoViewed(value) {
            if (value == null) {
                traceSetError("directorVideoViewed", String(value));
                return;
            }
            _jsonObject.directorVideoViewed = value;
            //return(directorVideoViewed);
        }
        function get score() {
            if (_jsonObject.score == null) {
                return(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
            }
            return(_jsonObject.score);
        }
        function set score(value) {
            if (value == null) {
                traceSetError("score", String(value));
                return;
            }
            _jsonObject.score = value;
            //return(score);
        }
        function get goldenItemIdsUnlocked() {
            if (_jsonObject.goldenItemIdsUnlocked == null) {
                return(0);
            }
            return(_jsonObject.goldenItemIdsUnlocked);
        }
        function set goldenItemIdsUnlocked(value) {
            if (value == null) {
                traceSetError("goldenItemIdsUnlocked", String(value));
                return;
            }
            _jsonObject.goldenItemIdsUnlocked = value;
            //return(goldenItemIdsUnlocked);
        }
        function get goldenItemIds() {
            if (_jsonObject.goldenItemIds == null) {
                return(new Array(0, 0, 0, 0, 0));
            }
            return(_jsonObject.goldenItemIds);
        }
        function set goldenItemIds(value) {
            if (value == null) {
                traceSetError("goldenItemIds", String(value));
                return;
            }
            _jsonObject.goldenItemIds = value;
            //return(goldenItemIds);
        }
        function get endGameUnlocked() {
            if (_jsonObject.endGameUnlocked == null) {
                return(false);
            }
            return(_jsonObject.endGameUnlocked);
        }
        function set endGameUnlocked(value) {
            if (value == null) {
                traceSetError("endGameUnlocked", String(value));
                return;
            }
            _jsonObject.endGameUnlocked = value;
            //return(endGameUnlocked);
        }
        function get endGameWon() {
            if (_jsonObject.endGameWon == null) {
                return(false);
            }
            return(_jsonObject.endGameWon);
        }
        function set endGameWon(value) {
            if (value == null) {
                traceSetError("endGameWon", String(value));
                return;
            }
            _jsonObject.endGameWon = value;
            //return(endGameWon);
        }
        function get coinBonusCollected() {
            if (_jsonObject.coinBonusCollected == null) {
                return(false);
            }
            return(_jsonObject.coinBonusCollected);
        }
        function set coinBonusCollected(value) {
            if (value == null) {
                traceSetError("coinBonusCollected", String(value));
                return;
            }
            _jsonObject.coinBonusCollected = value;
            //return(coinBonusCollected);
        }
        function traceSetError(propertyName, value) {
            com.clubpenguin.world.rooms2013.epfparty.EPFParty.pebug((("ERROR - " + value) + " is not a valid value for ") + propertyName, "EPFPartyCookieVO");
        }
        static var EPF_COOKIE_HANDLER_NAME = "epfparty";
        static var EPF_RECEIVE_COMMAND_NAME = "epfpartycookie";
    }
