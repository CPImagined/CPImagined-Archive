//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleType extends com.clubpenguin.util.Enumeration
    {
        var _color, _typeId;
        function PuffleType (color, typeId) {
            super();
            _color = color;
            _typeId = typeId;
            PUFFLE_COLOR_TYPE_LIST.push(this);
        }
        static function getPuffleColorByTypeId(typeId) {
            var _local_1 = 0;
            while (_local_1 < PUFFLE_COLOR_TYPE_LIST.length) {
                if (typeId == PUFFLE_COLOR_TYPE_LIST[_local_1].getTypeId()) {
                    return(PUFFLE_COLOR_TYPE_LIST[_local_1].getColor());
                }
                _local_1++;
            }
            return("");
        }
        function getColor() {
            return(_color);
        }
        function getTypeId() {
            return(_typeId);
        }
        function toString() {
            return(("[PuffleType type=\"" + _color) + "\"]");
        }
        static var PUFFLE_COLOR_TYPE_LIST = new Array();
        static var BLUE = new com.clubpenguin.shell.PuffleType("blue", 0);
        static var PINK = new com.clubpenguin.shell.PuffleType("pink", 1);
        static var BLACK = new com.clubpenguin.shell.PuffleType("black", 2);
        static var GREEN = new com.clubpenguin.shell.PuffleType("green", 3);
        static var PURPLE = new com.clubpenguin.shell.PuffleType("purple", 4);
        static var RED = new com.clubpenguin.shell.PuffleType("red", 5);
        static var YELLOW = new com.clubpenguin.shell.PuffleType("yellow", 6);
        static var WHITE = new com.clubpenguin.shell.PuffleType("white", 7);
        static var ORANGE = new com.clubpenguin.shell.PuffleType("orange", 8);
        static var BROWN = new com.clubpenguin.shell.PuffleType("brown", 9);
        static var RAINBOW = new com.clubpenguin.shell.PuffleType("rainbow", 10);
        static var GOLD = new com.clubpenguin.shell.PuffleType("gold", 11);
		static var MAROON = new com.clubpenguin.shell.PuffleType("maroon", 12);
		static var YARR = new com.clubpenguin.shell.PuffleType("yarr", 13);
		static var LOLZ = new com.clubpenguin.shell.PuffleType("lolz", 14);
		static var PETE = new com.clubpenguin.shell.PuffleType("pete", 15);
		static var DARWIN = new com.clubpenguin.shell.PuffleType("darwin", 16);
		static var FLIT = new com.clubpenguin.shell.PuffleType("flit", 17);
    }
