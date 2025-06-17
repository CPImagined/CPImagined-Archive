//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.enum.IglooItemInteractiveTypeEnum
    {
        var _type;
        function IglooItemInteractiveTypeEnum (type) {
            _type = type;
        }
        function get value() {
            return(_type);
        }
        static var REST = new com.clubpenguin.igloo.enum.IglooItemInteractiveTypeEnum(0);
        static var PLAY = new com.clubpenguin.igloo.enum.IglooItemInteractiveTypeEnum(1);
        static var FEED = new com.clubpenguin.igloo.enum.IglooItemInteractiveTypeEnum(2);
        static var NONE = new com.clubpenguin.igloo.enum.IglooItemInteractiveTypeEnum(3);
    }
