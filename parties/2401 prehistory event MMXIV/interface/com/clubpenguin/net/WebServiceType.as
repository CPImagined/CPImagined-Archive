//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.WebServiceType
    {
        var _name, _isCritical;
        function WebServiceType (name, isCritical) {
            _name = name;
            _isCritical = isCritical;
        }
        static function getServiceTypes() {
            return([LANGUAGE, GAMES, STAMPS, POLAROIDS, STAMPBOOK_COVER, ANALYTICS, FURNITURE, PATHS, IGLOOS, ITEMS, PUFFLES, PUFFLE_ITEMS, ROOMS, MASCOTS, MASCOT_MESSAGES, TOUR_GUIDE_MESSAGES, SAFE_CHAT_MESSAGES, SCRIPT_MESSAGES, JOKES, FLOORS, PLAYER_COLORS, NEWSPAPERS, POSTCARDS, PENGUIN_ACTION_FRAMES, GENERAL, LOCATIONS]);
        }
        function get name() {
            return(_name);
        }
        function get isCritical() {
            return(_isCritical);
        }
        static var IS_CRITICAL = true;
        static var NOT_CRITICAL = false;
        static var LANGUAGE = new com.clubpenguin.net.WebServiceType("Language", IS_CRITICAL);
        static var GAMES = new com.clubpenguin.net.WebServiceType("Games", IS_CRITICAL);
        static var STAMPS = new com.clubpenguin.net.WebServiceType("Stamps", IS_CRITICAL);
        static var POLAROIDS = new com.clubpenguin.net.WebServiceType("Polaroids", IS_CRITICAL);
        static var STAMPBOOK_COVER = new com.clubpenguin.net.WebServiceType("StampBook Cover", IS_CRITICAL);
        static var ANALYTICS = new com.clubpenguin.net.WebServiceType("Analytics", IS_CRITICAL);
        static var FURNITURE = new com.clubpenguin.net.WebServiceType("Furniture", IS_CRITICAL);
        static var PATHS = new com.clubpenguin.net.WebServiceType("Paths", IS_CRITICAL);
        static var IGLOOS = new com.clubpenguin.net.WebServiceType("Igloos", IS_CRITICAL);
        static var ITEMS = new com.clubpenguin.net.WebServiceType("Items", IS_CRITICAL);
        static var PUFFLES = new com.clubpenguin.net.WebServiceType("Puffles", IS_CRITICAL);
        static var PUFFLE_ITEMS = new com.clubpenguin.net.WebServiceType("PuffleItems", IS_CRITICAL);
        static var ROOMS = new com.clubpenguin.net.WebServiceType("Rooms", IS_CRITICAL);
        static var LOGIN_SERVER = new com.clubpenguin.net.WebServiceType("Login Server", IS_CRITICAL);
        static var REDEMPTION_SERVER = new com.clubpenguin.net.WebServiceType("Redemption Server", IS_CRITICAL);
        static var WORLD_SERVERS = new com.clubpenguin.net.WebServiceType("World Servers", IS_CRITICAL);
        static var MASCOTS = new com.clubpenguin.net.WebServiceType("Mascots", IS_CRITICAL);
        static var MASCOT_MESSAGES = new com.clubpenguin.net.WebServiceType("Mascot Messages", IS_CRITICAL);
        static var TOUR_GUIDE_MESSAGES = new com.clubpenguin.net.WebServiceType("Tour Guide Messages", IS_CRITICAL);
        static var SAFE_CHAT_MESSAGES = new com.clubpenguin.net.WebServiceType("Safe Chat Messages", IS_CRITICAL);
        static var SCRIPT_MESSAGES = new com.clubpenguin.net.WebServiceType("Script Messages", IS_CRITICAL);
        static var JOKES = new com.clubpenguin.net.WebServiceType("Jokes", IS_CRITICAL);
        static var FLOORS = new com.clubpenguin.net.WebServiceType("Floors", IS_CRITICAL);
        static var PLAYER_COLORS = new com.clubpenguin.net.WebServiceType("Player Colors", IS_CRITICAL);
        static var NEWSPAPERS = new com.clubpenguin.net.WebServiceType("Newspapers", IS_CRITICAL);
        static var POSTCARDS = new com.clubpenguin.net.WebServiceType("Postcards", IS_CRITICAL);
        static var PENGUIN_ACTION_FRAMES = new com.clubpenguin.net.WebServiceType("Penguin Action Frames", IS_CRITICAL);
        static var GENERAL = new com.clubpenguin.net.WebServiceType("General", IS_CRITICAL);
        static var LOCATIONS = new com.clubpenguin.net.WebServiceType("Locations", IS_CRITICAL);
    }
