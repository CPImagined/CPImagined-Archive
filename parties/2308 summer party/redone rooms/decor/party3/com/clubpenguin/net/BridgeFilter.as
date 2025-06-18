//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.BridgeFilter
    {
        var airtower;
        function BridgeFilter () {
            airtower = new com.clubpenguin.net.Airtower();
        }
        static function messageIsSentToAS3(airtower, eventType) {
            switch (eventType) {
                case airtower.ADD_PUFFLE_CARE_ITEM : 
                case airtower.GET_MY_PLAYER_PUFFLES : 
                case airtower.GET_PLAYER_PUFFLES : 
                case airtower.WALK_PUFFLE : 
                case airtower.REST_PUFFLE : 
                case airtower.INTERACTION_REST : 
                case airtower.PLAY_PUFFLE : 
                case airtower.JOIN_WORLD : 
                case airtower.JOIN_ROOM : 
                case airtower.PLAYER_HANDLER : 
                case airtower.ADOPT_PUFFLE : 
                case airtower.PUFFLE_VISITOR_HAT_UPDATE : 
                case GET_PUFFLE_CARE_INVENTORY : 
                case GET_MY_PUFFLES_STATS : 
                case PUFFLE_CARE_ITEM_DELIVERED : 
                case RETURN_PUFFLE : 
                case PUFFLE_PLAYED_GAME : 
                case CAN_LIKE_IGLOO : 
                case LIKE_IGLOO : 
                case GET_IGLOO_LIKE_BY : 
                case PLAYER_BY_SWID_USERNAME : 
                case LIKE_UPDATE_EVENT : 
                case GET_SNOWBALL_PLAYER_DETAILS : 
                case GET_PUFFLE_QUIZ : 
                case UPDATE_PUFFLE_QUIZ : 
                case CHECK_PUFFLE_NAME : 
                case OK : 
                case INVALID_NAME : 
                case NOT_ENOUGH_COINS : 
                case PUFFLE_ADOPTION_BI : 
                case SEND_CARE_BI : 
                case GET_PUFFLE_HANDLER : 
                case airtower.HANDLE_ERROR : 
                case GET_CARD_DATA : 
                case airtower.GET_NINJA_LEVEL : 
                case airtower.GET_FIRE_LEVEL : 
                case airtower.GET_WATER_LEVEL : 
                case airtower.GET_SNOW_LEVEL : 
                case TRIAL_OFFER : 
                case TRIAL_ACCEPT : 
                case TRIAL_DAYS_LEFT : 
                case TRIAL_EXPIRED : 
                case TRIAL_ACTIVE : 
                case GET_SNOWBALL_PLAYER_DETAILS : 
                case PUFFLE_FOUND_TREASURE : 
                    return(true);
                    return(false);
            }
            return(false);
        }
        static var GET_PUFFLE_CARE_INVENTORY = "pgpi";
        static var GET_MY_PUFFLES_STATS = "pgmps";
        static var PUFFLE_CARE_ITEM_DELIVERED = "pcid";
        static var RETURN_PUFFLE = "prp";
        static var PUFFLE_PLAYED_GAME = "ppg";
        static var CAN_LIKE_IGLOO = "cli";
        static var LIKE_IGLOO = "li";
        static var GET_IGLOO_LIKE_BY = "gili";
        static var PLAYER_BY_SWID_USERNAME = "pbsu";
        static var LIKE_UPDATE_EVENT = "lue";
        static var GET_SNOWBALL_PLAYER_DETAILS = "gpsd";
        static var GET_PUFFLE_QUIZ = "pgpq";
        static var UPDATE_PUFFLE_QUIZ = "pupq";
        static var CHECK_PUFFLE_NAME = "pcn";
        static var INVALID_NAME = "441";
        static var NOT_ENOUGH_COINS = "401";
        static var PUFFLE_ADOPTION_BI = "bipa";
        static var SEND_CARE_BI = "bipc";
        static var GET_PUFFLE_HANDLER = "phg";
        static var OK = "200";
        static var TRIAL_OFFER = "sdto";
        static var TRIAL_ACCEPT = "sdta";
        static var TRIAL_DAYS_LEFT = "sdtd";
        static var TRIAL_EXPIRED = "sdtx";
        static var TRIAL_ACTIVE = "sdtac";
        static var PUFFLE_FOUND_TREASURE = "puffledig";
        static var GET_CARD_DATA = "gcd";
    }
