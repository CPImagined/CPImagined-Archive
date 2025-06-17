//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.BridgeFilter
    {
        var airtower;
        function BridgeFilter () {
            airtower = new com.clubpenguin.net.Airtower();
        }
        static function messageIsSentToAS3(_arg_1, _arg_2) {
            switch (_arg_2) {
                case _arg_1.ADD_PUFFLE_CARE_ITEM : 
                case _arg_1.GET_MY_PLAYER_PUFFLES : 
                case _arg_1.GET_PLAYER_PUFFLES : 
                case _arg_1.WALK_PUFFLE : 
                case _arg_1.REST_PUFFLE : 
                case _arg_1.INTERACTION_REST : 
                case _arg_1.PLAY_PUFFLE : 
                case _arg_1.JOIN_WORLD : 
                case _arg_1.JOIN_ROOM : 
                case _arg_1.PLAYER_HANDLER : 
                case _arg_1.ADOPT_PUFFLE : 
                case _arg_1.PUFFLE_VISITOR_HAT_UPDATE : 
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
                case CHECK_PUFFLE_NAME_WITH_RESPONSE : 
                case REQUEST_NAME_SUGGESTION : 
                case GET_DIG_COOLDOWN : 
                case OK : 
                case INVALID_NAME : 
                case NOT_ENOUGH_COINS : 
                case PUFFLE_ADOPTION_BI : 
                case SEND_CARE_BI : 
                case GET_PUFFLE_HANDLER : 
                case GAME_OVER : 
                case _arg_1.HANDLE_ERROR : 
                case GET_CARD_DATA : 
                case _arg_1.GET_NINJA_LEVEL : 
                case _arg_1.GET_FIRE_LEVEL : 
                case _arg_1.GET_WATER_LEVEL : 
                case _arg_1.GET_SNOW_LEVEL : 
                case TRIAL_OFFER : 
                case TRIAL_ACCEPT : 
                case TRIAL_DAYS_LEFT : 
                case TRIAL_EXPIRED : 
                case TRIAL_ACTIVE : 
                case GET_SNOWBALL_PLAYER_DETAILS : 
                case PUFFLE_FOUND_TREASURE : 
                case MODERATOR_MESSAGE_TYPE : 
                case BANNING_MESSAGE_TYPE : 
                case INIT_BAN_MESSAGE_TYPE : 
                case CARE_STATION_MENU_MESSAGE_TYPE : 
                case SOCCER_GAME : 
                case _arg_1.GET_AB_TEST_DATA : 
                    return(true);
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
        static var CHECK_PUFFLE_NAME_WITH_RESPONSE = "checkpufflename";
        static var REQUEST_NAME_SUGGESTION = "recommendpufflenames";
        static var GET_DIG_COOLDOWN = "getdigcooldown";
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
        static var MODERATOR_MESSAGE_TYPE = "moderatormessage";
        static var BANNING_MESSAGE_TYPE = "ban";
        static var INIT_BAN_MESSAGE_TYPE = "initban";
        static var CARE_STATION_MENU_MESSAGE_TYPE = "carestationmenu";
        static var GAME_OVER = "zo";
        static var SOCCER_GAME = "spgameshot";
    }
