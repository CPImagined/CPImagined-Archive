//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.enums.errors
{
    import com.clubpenguin.lib.enums.Enum;

    public class ErrorCodeEnum extends Enum 
    {

        public static const CONNECTION_LOST:ErrorCodeEnum = new ErrorCodeEnum(1, "w.app.error.message.connectionlost", "w.app.dialog.error.button.learnmore", "connection_web", "_self");
        public static const SOCKET_TIMEOUT:ErrorCodeEnum = new ErrorCodeEnum(2, "w.app.error.message.timeout", "w.app.dialog.error.button.ok", "client_web", "_self");
        public static const MULTI_CONNECTIONS:ErrorCodeEnum = new ErrorCodeEnum(3, "w.app.error.message.multiconnections", "w.app.dialog.error.button.ok", "client_web", "_self");
        public static const ALREADY_OWN_INVENTORY_ITEM:ErrorCodeEnum = new ErrorCodeEnum(400, "item_in_inventory_warn", "w.app.dialog.error.button.ok");
        public static const NOT_ENOUGH_COINS:ErrorCodeEnum = new ErrorCodeEnum(401, "w.app.error.message.notenoughcoins", "w.app.dialog.error.button.ok");
        public static const MAX_FURNITURE_ITEMS:ErrorCodeEnum = new ErrorCodeEnum(403, "shell.PLAYER_HAS_MAX_ITEMS", "w.app.dialog.error.button.ok");
        public static const MAX_PUFFLECARE_ITEMS:ErrorCodeEnum = new ErrorCodeEnum(406, "max_puffle_care_item", "w.app.dialog.error.button.ok");
        public static const MAX_PUFFLEHAT_ITEMS:ErrorCodeEnum = new ErrorCodeEnum(407, "max_puffle_hat_item", "w.app.dialog.error.button.ok");
        public static const ALREADY_OWN_SUPERPLAY_ITEM:ErrorCodeEnum = new ErrorCodeEnum(408, "item_in_inventory_warn", "w.app.dialog.error.button.ok");
        public static const MAX_CJ_MATS:ErrorCodeEnum = new ErrorCodeEnum(409, "w.furniture.buy.too.many.mats", "w.app.dialog.error.button.ok");
        public static const MAX_PUFFLES:ErrorCodeEnum = new ErrorCodeEnum(440, "w.app.error.message.toomanypuffles", "w.app.dialog.error.button.ok");
        public static const NAME_NOT_ALLOWED:ErrorCodeEnum = new ErrorCodeEnum(441, "w.app.error.message.nameunavailable", "w.app.dialog.error.button.ok");
        public static const ALREADY_OWN_IGLOO:ErrorCodeEnum = new ErrorCodeEnum(500, "duplicate_igloo_warn", "w.app.dialog.error.button.ok");
        public static const ALREADY_OWN_FLOOR:ErrorCodeEnum = new ErrorCodeEnum(501, "duplicate_floor_warn", "w.app.dialog.error.button.ok");
        public static const ALREADY_OWN_LOCATION:ErrorCodeEnum = new ErrorCodeEnum(502, "duplicate_location_warn", "w.app.dialog.error.button.ok");
        public static const PLAY_TIME_UP:ErrorCodeEnum = new ErrorCodeEnum(910, "w.app.error.message.playtimeup", "w.app.dialog.error.button.ok", "community_web", "_self");
        public static const PLAY_TIME_ENDING:ErrorCodeEnum = new ErrorCodeEnum(914, "w.app.error.message.playtimeending", "w.app.dialog.error.button.ok");
        public static const PLAY_HOURS_ENDING:ErrorCodeEnum = new ErrorCodeEnum(915, "w.app.error.message.playhourending", "w.app.dialog.error.button.ok");
        public static const PLAY_HOURS_UP:ErrorCodeEnum = new ErrorCodeEnum(916, "w.app.error.message.playhourup", "w.app.dialog.error.button.ok", "community_web", "_self");
        public static const PLAY_HOURS_HASNT_START:ErrorCodeEnum = new ErrorCodeEnum(917, "w.app.error.message.playhourupdate", "w.app.dialog.error.button.ok", "community_web", "_self");
        public static const PLAY_HOURS_UPDATE:ErrorCodeEnum = new ErrorCodeEnum(918, "w.app.error.message.playhourupdate", "w.app.dialog.error.button.ok");
        public static const CLIENT_TIMEOUT:ErrorCodeEnum = new ErrorCodeEnum(1002, "w.app.error.message.timeout", "w.app.dialog.error.button.ok", "client_web", "_self");
        public static const SOCKET_LOST_CONNECTION:ErrorCodeEnum = new ErrorCodeEnum(10004, "w.app.error.message.connectionlost", "w.app.dialog.error.button.learnmore", "connection_web", "_self");
        public static const WEB_SERVICE_LOAD_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10010, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10011, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_CHUNK_MAP_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10012, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_LANGUAGE_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10013, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_PATHS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10014, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_ROOMS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10015, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_MASCOT_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10016, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_GAMES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10017, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_STAMPS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10018, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_FURNITURE_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10019, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_ITEMS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10020, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_PENGUIN_ACTION_FRAMES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10021, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_MASCOTS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10022, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_IGLOOS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(0x2727, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_PUFFLES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10024, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_PUFFLE_ITEMS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10025, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_TOUR_GUIDE_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10026, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_JOKES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10027, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_FLOORS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10028, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_SCRIPT_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10029, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_PLAYER_COLORS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10030, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_NEWSPAPERS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10031, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_POSTCARDS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10032, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_GENERAL_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10033, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_SAFE_CHAT_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10034, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_POLAROIDS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10035, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_STAMPBOOK_COVER_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10036, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_LOAD_ANALYTICS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10037, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_CHUNK_MAP_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10038, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_LANGUAGE_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10039, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_PATHS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10040, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_ROOMS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10041, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_MASCOT_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10042, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_GAMES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10043, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_STAMPS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10044, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_FURNITURE_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10045, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_ITEMS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10046, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_PENGUIN_ACTION_FRAMES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10047, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_MASCOTS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10048, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_IGLOOS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10049, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_PUFFLES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10050, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_PUFFLE_ITEMS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10051, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_TOUR_GUIDE_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10052, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_JOKES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10053, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_FLOORS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10054, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_SCRIPT_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10055, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_PLAYER_COLORS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10056, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_NEWSPAPERS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10057, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_POSTCARDS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10058, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_GENERAL_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10059, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_SAFE_CHAT_MESSAGES_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10060, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_POLAROIDS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10061, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_STAMPBOOK_COVER_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10062, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const WEB_SERVICE_SEND_ANALYTICS_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10063, "shell.LOAD_ERROR.hardcoded", "w.app.dialog.error.button.ok.hardcoded", "community_web.hardcoded", "_self");
        public static const BRIDGE_DISCONNECT:ErrorCodeEnum = new ErrorCodeEnum(10100, "");
        public static const BRIDGE_SECURITY_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10101, "");
        public static const BRIDGE_ASYNC_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10102, "");
        public static const BRIDGE_ARGUMENT_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10103, "");
        public static const MAX_IGLOO_FURNITURE_ERROR:ErrorCodeEnum = new ErrorCodeEnum(10006, "shell.MAX_IGLOO_FURNITURE_ERROR", "w.app.dialog.error.button.ok");

        private var _id:uint;
        private var _errorMessageTag:String;
        private var _buttonTextTag:String;
        private var _buttonURLTag:String;
        private var _target:String;

        public function ErrorCodeEnum(id:uint, errorMessageTag:String, buttonTextTag:String="", buttonURLTag:String="", target:String="")
        {
            this._id = id;
            this._errorMessageTag = errorMessageTag;
            this._buttonTextTag = buttonTextTag;
            this._buttonURLTag = buttonURLTag;
            this._target = target;
        }

        public static function hasError(error_id:uint):Boolean
        {
            var hasError:Boolean;
            var list:Array = Enum.createList(ErrorCodeEnum);
            var i:int;
            while (i < list.length)
            {
                if ((list[i] as ErrorCodeEnum).getId() == error_id)
                {
                    hasError = true;
                    break;
                };
                i++;
            };
            return (hasError);
        }

        public static function getTypeByErrorCode(error_id:uint):ErrorCodeEnum
        {
            var foundEnum:ErrorCodeEnum;
            var list:Array = Enum.createList(ErrorCodeEnum);
            var i:int;
            while (i < list.length)
            {
                if ((list[i] as ErrorCodeEnum).getId() == error_id)
                {
                    foundEnum = (list[i] as ErrorCodeEnum);
                    break;
                };
                i++;
            };
            if (!foundEnum)
            {
                throw (new Error(("No Error was found with an id of " + error_id)));
            };
            return (foundEnum);
        }


        public function getId():uint
        {
            return (this._id);
        }

        public function getErrorMessageTag():String
        {
            return (this._errorMessageTag);
        }

        public function get errorMessageTag():String
        {
            return (this._errorMessageTag);
        }

        public function get buttonTextTag():String
        {
            return (this._buttonTextTag);
        }

        public function get buttonURLTag():String
        {
            return (this._buttonURLTag);
        }

        public function get target():String
        {
            return (this._target);
        }


    }
}//package com.clubpenguin.lib.enums.errors
