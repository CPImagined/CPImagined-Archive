//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.enum.IglooItemTypeEnum
    {
        var _type;
        function IglooItemTypeEnum (type) {
            _type = type;
        }
        function get value() {
            return(_type);
        }
        function toString() {
            return(_type);
        }
        static var FLOORING = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("flooring");
        static var IGLOO_BUILDING = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("igloo");
        static var LOCATION = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("location");
        static var FURNITURE_FLOOR = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("furniture_floor");
        static var FURNITURE_WALL = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("furniture_wall");
        static var FURNITURE_ROOM = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("furniture_room");
        static var FURNITURE_PET = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("furniture_pet");
        static var MUSIC_NORMAL = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("music_normal");
        static var MUSIC_CUSTOM = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("music_custom");
        static var MUSIC_STUDIO = new com.clubpenguin.igloo.enum.IglooItemTypeEnum("music_studio");
        static var ALL_FURNITURE = [FURNITURE_FLOOR, FURNITURE_PET, FURNITURE_ROOM, FURNITURE_WALL];
    }
