//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    public class WebServiceType 
    {

        private static const CRITICAL:Boolean = true;
        private static const NOT_CRITICAL:Boolean = false;
        private static const CHUNK:Boolean = true;
        private static const DONT_CHUNK:Boolean = false;
        public static const CHUNK_MAP:WebServiceType = new WebServiceType("Chunking Map", "chunking_map.json", 0, DONT_CHUNK, CRITICAL);
        public static const LANGUAGE:WebServiceType = new WebServiceType("Language", "game_strings.json", 1, CHUNK, CRITICAL);
        public static const PATHS:WebServiceType = new WebServiceType("Paths", "paths.json", 2, DONT_CHUNK, CRITICAL);
        public static const ROOMS:WebServiceType = new WebServiceType("Rooms", "rooms.json", 3, DONT_CHUNK, CRITICAL);
        public static const MASCOT_MESSAGES:WebServiceType = new WebServiceType("Mascot Messages", "mascot_messages.json", 4, CHUNK, NOT_CRITICAL);
        public static const GAMES:WebServiceType = new WebServiceType("Games", "games.json", 5, DONT_CHUNK, CRITICAL);
        public static const STAMPS:WebServiceType = new WebServiceType("Stamps", "stamps.json", 6, CHUNK, CRITICAL);
        public static const FURNITURE:WebServiceType = new WebServiceType("Furniture", "furniture_items.json", 7, CHUNK, CRITICAL);
        public static const ITEMS:WebServiceType = new WebServiceType("Items", "paper_items.json", 8, CHUNK, CRITICAL);
        public static const PENGUIN_ACTION_FRAMES:WebServiceType = new WebServiceType("Penguin Action Frames", "penguin_action_frames.json", 9, CHUNK, CRITICAL);
        public static const MASCOTS:WebServiceType = new WebServiceType("Mascots", "mascots.json", 10, DONT_CHUNK, CRITICAL);
        public static const IGLOOS:WebServiceType = new WebServiceType("Igloos", "igloos.json", 11, DONT_CHUNK, CRITICAL);
        public static const PUFFLES:WebServiceType = new WebServiceType("Puffles", "puffles.json", 12, DONT_CHUNK, CRITICAL);
        public static const PUFFLE_ITEMS:WebServiceType = new WebServiceType("PuffleItems", "puffle_items.json", 13, CHUNK, CRITICAL);
        public static const TOUR_GUIDE_MESSAGES:WebServiceType = new WebServiceType("Tour Guide Messages", "tour_guide_messages.json", 14, DONT_CHUNK, CRITICAL);
        public static const JOKES:WebServiceType = new WebServiceType("Jokes", "jokes.json", 15, DONT_CHUNK, CRITICAL);
        public static const FLOORS:WebServiceType = new WebServiceType("Floors", "igloo_floors.json", 16, DONT_CHUNK, CRITICAL);
        public static const SCRIPT_MESSAGES:WebServiceType = new WebServiceType("Script Messages", "stage_script_messages.json", 17, DONT_CHUNK, CRITICAL);
        public static const PLAYER_COLORS:WebServiceType = new WebServiceType("Player Colors", "player_colors.json", 18, DONT_CHUNK, CRITICAL);
        public static const NEWSPAPERS:WebServiceType = new WebServiceType("Newspapers", "newspapers.json", 19, DONT_CHUNK, CRITICAL);
        public static const POSTCARDS:WebServiceType = new WebServiceType("Postcards", "postcards.json", 20, DONT_CHUNK, CRITICAL);
        public static const GENERAL:WebServiceType = new WebServiceType("General", "general.json", 21, DONT_CHUNK, CRITICAL);
        public static const SAFE_CHAT_MESSAGES:WebServiceType = new WebServiceType("Safe Chat Messages", "safe_chat_messages.json", 22, DONT_CHUNK, CRITICAL);
        public static const POLAROIDS:WebServiceType = new WebServiceType("Polaroids", "polaroids.json", 23, DONT_CHUNK, CRITICAL);
        public static const STAMPBOOK_COVER:WebServiceType = new WebServiceType("StampBook Cover", "cover.json", 24, DONT_CHUNK, CRITICAL);
        public static const LOCATIONS:WebServiceType = new WebServiceType("Locations", "igloo_locations.json", 25, DONT_CHUNK, CRITICAL);
        public static const ANALYTICS:WebServiceType = new WebServiceType("Analytics", "weblogger.php", 26, false, false);

        private var _name:String;
        private var _fileName:String;
        private var _priority:int;
        private var _requiresChunking:Boolean;
        private var _isCritical:Boolean;

        public function WebServiceType(name:String, fileName:String, priority:int, requiresChunking:Boolean, isCritical:Boolean)
        {
            this._name = name;
            this._fileName = fileName;
            this._priority = priority;
            this._requiresChunking = requiresChunking;
            this._isCritical = isCritical;
        }

        public static function getServiceTypes():Array
        {
            return ([CHUNK_MAP, LANGUAGE, GAMES, STAMPS, POLAROIDS, STAMPBOOK_COVER, MASCOTS, FURNITURE, PATHS, IGLOOS, ITEMS, PUFFLES, PUFFLE_ITEMS, ROOMS, TOUR_GUIDE_MESSAGES, JOKES, FLOORS, SCRIPT_MESSAGES, PLAYER_COLORS, NEWSPAPERS, POSTCARDS, PENGUIN_ACTION_FRAMES, MASCOT_MESSAGES, GENERAL, SAFE_CHAT_MESSAGES, LOCATIONS, ANALYTICS]);
        }

        public static function getPrioritizedServiceTypes():Array
        {
            return (WebServiceType.getServiceTypes().sortOn("priority", Array.NUMERIC));
        }

        public static function getCriticalServiceTypes():Array
        {
            var webServiceType:WebServiceType;
            var criticalTypes:Array = [];
            for each (webServiceType in WebServiceType.getServiceTypes())
            {
                if (webServiceType.isCritical)
                {
                    criticalTypes.push(webServiceType);
                };
            };
            return (criticalTypes);
        }

        public static function getWebServiceTypeByFileName(fileName:String):WebServiceType
        {
            var wsType:WebServiceType;
            var webServiceType:WebServiceType;
            for each (webServiceType in WebServiceType.getServiceTypes())
            {
                if (webServiceType.fileName == fileName)
                {
                    wsType = webServiceType;
                    break;
                };
            };
            return (wsType);
        }


        public function get name():String
        {
            return (this._name);
        }

        public function get fileName():String
        {
            return (this._fileName);
        }

        public function get priority():int
        {
            return (this._priority);
        }

        public function get requiresChunking():Boolean
        {
            return (this._requiresChunking);
        }

        public function get isCritical():Boolean
        {
            return (this._isCritical);
        }

        public function toString():String
        {
            return (this._name);
        }


    }
}//package com.clubpenguin.main.service.webservice
