//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.vo.MedievalPartyCookieVO extends com.clubpenguin.services.vo.JsonServerCookieVO
    {
        var _jsonObject;
        function MedievalPartyCookieVO (cookieId) {
            super(cookieId);
            var _local_3 = _global.getCurrentShell();
        }
        function getCookieHandlerName() {
            return(MEDIEVAL_COOKIE_HANDLER_NAME);
        }
        function getSendCommandName() {
            return(MEDIEVAL_RECEIVE_COMMAND_NAME);
        }
        function getReceiveCommandName() {
            return(MEDIEVAL_RECEIVE_COMMAND_NAME);
        }
        function get msgIndex() {
            if (_jsonObject.ingredients == null) {
                return(0);
            }
            return(_jsonObject.msgIndex);
        }
        function set msgIndex(value) {
            if ((value == null) || (value < 0)) {
                traceSetError("msgIndex", String(value));
                return;
            }
            _jsonObject.msgIndex = value;
            //return(msgIndex);
        }
        function get ingredients() {
            if (_jsonObject.ingredients == null) {
                return(new Array(0, 0, 0, 0, 0));
            }
            return(_jsonObject.ingredients);
        }
        function set ingredients(value) {
            if (value == null) {
                traceSetError("ingredients", String(value));
                return;
            }
            _jsonObject.ingredients = value;
            //return(ingredients);
        }
        function get potionsMade() {
            if (_jsonObject.potionsMade == null) {
                return(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
            }
            return(_jsonObject.potionsMade);
        }
        function set potionsMade(value) {
            if (value == null) {
                traceSetError("potionsMade", String(value));
                return;
            }
            _jsonObject.potionsMade = value;
            //return(potionsMade);
        }
        function get inventory() {
            if (_jsonObject.inventory == null) {
                return(new Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
            }
            return(_jsonObject.inventory);
        }
        function set inventory(value) {
            if (value == null) {
                traceSetError("inventory", String(value));
                return;
            }
            _jsonObject.inventory = value;
            //return(inventory);
        }
        function get golden() {
            if (((_jsonObject.golden == null) || (_jsonObject.golden < 0)) || (_jsonObject.golden > 1)) {
                return(false);
            }
            return(((_jsonObject.golden == 0) ? false : true));
        }
        function set golden(value) {
            if (value == null) {
                traceSetError("golden", String(value));
                return;
            }
            _jsonObject.golden = (value ? 1 : 0);
            //return(golden);
        }
        function traceSetError(propertyName, value) {
            trace((("MedievalPartyVO - ERROR - " + value) + " is not a valid value for ") + propertyName);
        }
        static var PARTY_COOKIE_ID = "20130901";
        static var MEDIEVAL_COOKIE_HANDLER_NAME = "mdvl";
        static var MEDIEVAL_RECEIVE_COMMAND_NAME = "mdvlp";
    }
