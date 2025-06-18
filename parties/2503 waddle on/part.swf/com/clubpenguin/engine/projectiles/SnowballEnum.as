
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.projectiles.SnowballEnum
    {
        var _flags, _symbolName;
        function SnowballEnum (_arg_4, _arg_3) {
            super();
            if (_arg_3 != undefined) {
                _flags = _arg_3;
            } else {
                _flags = FLAG_NONE;
            }
            _symbolName = _arg_4;
        }
        function get symbolName() {
            return(_symbolName);
        }
        function isFlagSet(_arg_2) {
            return((_arg_2 & _flags) != FLAG_NONE);
        }
        function get hasTail() {
            return(isFlagSet(FLAG_HAS_TAIL));
        }
        function get isFixed() {
            return(isFlagSet(FLAG_IS_FIXED));
        }
        function get delayAnimStart() {
            return(isFlagSet(FLAG_DELAY_ANIM_START));
        }
        function get originAtHead() {
            return(isFlagSet(FLAG_ORIGIN_AT_HEAD));
        }
        function get originAtCenter() {
            return(isFlagSet(FLAG_ORIGIN_AT_CENTER));
        }
        function get returnsToPlayer() {
            return(isFlagSet(FLAG_RETURNS_TO_PLAYER));
        }
        function get playerInvisible() {
            return(isFlagSet(FLAG_PLAYER_INVISIBLE));
        }
        function get hasTrail() {
            return(isFlagSet(FLAG_HAS_TRAIL));
        }
        function get isConstructive() {
            return(isFlagSet(FLAG_CONSTRUCTIVE));
        }
        function get isDestructive() {
            return(isFlagSet(FLAG_DESTRUCTIVE));
        }
        function get playUnderPlayer() {
            return(isFlagSet(FLAG_PLAY_UNDER_PLAYER_DEPTH));
        }
        function get playAbovePlayer() {
            return(isFlagSet(FLAG_PLAY_ABOVE_PLAYER_DEPTH));
        }
        function get intelligentSort() {
            return(isFlagSet(FLAG_INTELLIGENT_DEPTH_SORT));
        }
        function toString() {
            return(((("[" + _symbolName) + "|") + _flags) + "]");
        }
        static var FLAG_NONE = 0;
        static var FLAG_HAS_TAIL = 2;
        static var FLAG_IS_FIXED = 4;
        static var FLAG_ORIGIN_AT_HEAD = 8;
        static var FLAG_ORIGIN_AT_CENTER = 16;
        static var FLAG_PLAY_ABOVE_PLAYER_DEPTH = 32;
        static var FLAG_DELAY_ANIM_START = 64;
        static var FLAG_RETURNS_TO_PLAYER = 128;
        static var FLAG_PLAYER_INVISIBLE = 256;
        static var FLAG_HAS_TRAIL = 512;
        static var FLAG_CONSTRUCTIVE = 1024;
        static var FLAG_DESTRUCTIVE = 2048;
        static var FLAG_PLAY_UNDER_PLAYER_DEPTH = 4096;
        static var FLAG_INTELLIGENT_DEPTH_SORT = 8192;
        static var SNOW_BALL_NORMAL = new com.clubpenguin.engine.projectiles.SnowballEnum("ballnormal", FLAG_NONE);
        static var SNOW_BALL_CANDY = new com.clubpenguin.engine.projectiles.SnowballEnum("ballCandy", FLAG_NONE);
        static var SNOW_BALL_EGG = new com.clubpenguin.engine.projectiles.SnowballEnum("ballEgg", FLAG_NONE);
        static var SNOW_BALL_FLOUR = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFlour", FLAG_NONE);
        static var SNOW_BALL_HAY = new com.clubpenguin.engine.projectiles.SnowballEnum("ballHay", FLAG_NONE);
        static var SNOW_BALL_MILK = new com.clubpenguin.engine.projectiles.SnowballEnum("ballMilk", FLAG_NONE);
        static var SNOW_BALL_TIRE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballTire", FLAG_NONE);
        static var SNOW_BALL_LARGE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballLarge", FLAG_DESTRUCTIVE);
        static var SNOW_BALL_ICE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballIce", FLAG_NONE);
        static var SNOW_BALL_BARF = new com.clubpenguin.engine.projectiles.SnowballEnum("ballBarf", FLAG_NONE);
        static var SNOW_BALL_FOOD = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFood", FLAG_NONE);
        static var SNOW_BALL_INVISIBLE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballInvisible", FLAG_NONE);
        static var SNOW_BALL_PIZZA = new com.clubpenguin.engine.projectiles.SnowballEnum("ballPizza", FLAG_NONE);
        static var SNOW_BALL_MAGIC = new com.clubpenguin.engine.projectiles.SnowballEnum("ballMagic", FLAG_NONE);
        static var SNOW_BALL_FIRE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFire", (FLAG_HAS_TAIL | FLAG_DELAY_ANIM_START) | FLAG_PLAY_UNDER_PLAYER_DEPTH);
    }
