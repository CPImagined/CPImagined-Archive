dynamic class com.clubpenguin.net.BridgeFilter
{
    static var GET_PUFFLE_CARE_INVENTORY: String = "pgpi";
    static var GET_MY_PUFFLES_STATS: String = "pgmps";
    static var PUFFLE_CARE_ITEM_DELIVERED: String = "pcid";
    static var RETURN_PUFFLE: String = "prp";
    static var PUFFLE_PLAYED_GAME: String = "ppg";
    static var CAN_LIKE_IGLOO: String = "cli";
    static var LIKE_IGLOO: String = "li";
    static var GET_IGLOO_LIKE_BY: String = "gili";
    static var PLAYER_BY_SWID_USERNAME: String = "pbsu";
    static var LIKE_UPDATE_EVENT: String = "lue";
    static var GET_SNOWBALL_PLAYER_DETAILS: String = "gpsd";
    static var GET_PUFFLE_QUIZ: String = "pgpq";
    static var UPDATE_PUFFLE_QUIZ: String = "pupq";
    static var CHECK_PUFFLE_NAME: String = "pcn";
    static var CHECK_PUFFLE_NAME_WITH_RESPONSE: String = "checkpufflename";
    static var REQUEST_NAME_SUGGESTION: String = "recommendpufflenames";
    static var GET_DIG_COOLDOWN: String = "getdigcooldown";
    static var INVALID_NAME: String = "441";
    static var NOT_ENOUGH_COINS: String = "401";
    static var PUFFLE_ADOPTION_BI: String = "bipa";
    static var SEND_CARE_BI: String = "bipc";
    static var GET_PUFFLE_HANDLER: String = "phg";
    static var OK: String = "200";
    static var TRIAL_OFFER: String = "sdto";
    static var TRIAL_ACCEPT: String = "sdta";
    static var TRIAL_DAYS_LEFT: String = "sdtd";
    static var TRIAL_EXPIRED: String = "sdtx";
    static var TRIAL_ACTIVE: String = "sdtac";
    static var PUFFLE_FOUND_TREASURE: String = "puffledig";
    static var GET_CARD_DATA: String = "gcd";
    static var MODERATOR_MESSAGE_TYPE: String = "moderatormessage";
    static var BANNING_MESSAGE_TYPE: String = "ban";
    static var INIT_BAN_MESSAGE_TYPE: String = "initban";
    static var CARE_STATION_MENU_MESSAGE_TYPE: String = "carestationmenu";
    static var GAME_OVER: String = "zo";
    static var SOCCER_GAME: String = "spgameshot";
    var airtower;

    function BridgeFilter()
    {
        this.airtower = new com.clubpenguin.net.Airtower();
    }

    static function messageIsSentToAS3(airtower, eventType)
    {
        var __reg0;
        if ((__reg0 = eventType) === airtower.ADD_PUFFLE_CARE_ITEM) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_MY_PLAYER_PUFFLES) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_PLAYER_PUFFLES) 
        {
            return true;
        }
        else if (__reg0 === airtower.WALK_PUFFLE) 
        {
            return true;
        }
        else if (__reg0 === airtower.REST_PUFFLE) 
        {
            return true;
        }
        else if (__reg0 === airtower.INTERACTION_REST) 
        {
            return true;
        }
        else if (__reg0 === airtower.PLAY_PUFFLE) 
        {
            return true;
        }
        else if (__reg0 === airtower.JOIN_WORLD) 
        {
            return true;
        }
        else if (__reg0 === airtower.JOIN_ROOM) 
        {
            return true;
        }
        else if (__reg0 === airtower.PLAYER_HANDLER) 
        {
            return true;
        }
        else if (__reg0 === airtower.ADOPT_PUFFLE) 
        {
            return true;
        }
        else if (__reg0 === airtower.PUFFLE_VISITOR_HAT_UPDATE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_PUFFLE_CARE_INVENTORY) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_MY_PUFFLES_STATS) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.PUFFLE_CARE_ITEM_DELIVERED) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.RETURN_PUFFLE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.PUFFLE_PLAYED_GAME) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.CAN_LIKE_IGLOO) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.LIKE_IGLOO) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_IGLOO_LIKE_BY) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.PLAYER_BY_SWID_USERNAME) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.LIKE_UPDATE_EVENT) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_SNOWBALL_PLAYER_DETAILS) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_PUFFLE_QUIZ) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.UPDATE_PUFFLE_QUIZ) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.CHECK_PUFFLE_NAME) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.CHECK_PUFFLE_NAME_WITH_RESPONSE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.REQUEST_NAME_SUGGESTION) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_DIG_COOLDOWN) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.OK) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.INVALID_NAME) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.NOT_ENOUGH_COINS) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.PUFFLE_ADOPTION_BI) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.SEND_CARE_BI) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_PUFFLE_HANDLER) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GAME_OVER) 
        {
            return true;
        }
        else if (__reg0 === airtower.HANDLE_ERROR) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_CARD_DATA) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_NINJA_LEVEL) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_FIRE_LEVEL) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_WATER_LEVEL) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_SNOW_LEVEL) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.TRIAL_OFFER) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.TRIAL_ACCEPT) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.TRIAL_DAYS_LEFT) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.TRIAL_EXPIRED) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.TRIAL_ACTIVE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.GET_SNOWBALL_PLAYER_DETAILS) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.PUFFLE_FOUND_TREASURE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.MODERATOR_MESSAGE_TYPE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.BANNING_MESSAGE_TYPE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.INIT_BAN_MESSAGE_TYPE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.CARE_STATION_MENU_MESSAGE_TYPE) 
        {
            return true;
        }
        else if (__reg0 === com.clubpenguin.net.BridgeFilter.SOCCER_GAME) 
        {
            return true;
        }
        else if (__reg0 === airtower.GET_AB_TEST_DATA) 
        {
            return true;
        }
        return false;
    }

}
