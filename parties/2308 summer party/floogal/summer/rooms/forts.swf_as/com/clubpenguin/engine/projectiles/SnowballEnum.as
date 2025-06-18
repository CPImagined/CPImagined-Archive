dynamic class com.clubpenguin.engine.projectiles.SnowballEnum
{
    static var FLAG_NONE: Number = 0;
    static var FLAG_HAS_TAIL: Number = 2;
    static var FLAG_IS_FIXED: Number = 4;
    static var FLAG_ORIGIN_AT_HEAD: Number = 8;
    static var FLAG_ORIGIN_AT_CENTER: Number = 16;
    static var FLAG_PLAY_ABOVE_PLAYER_DEPTH: Number = 32;
    static var FLAG_DELAY_ANIM_START: Number = 64;
    static var FLAG_RETURNS_TO_PLAYER: Number = 128;
    static var FLAG_PLAYER_INVISIBLE: Number = 256;
    static var FLAG_HAS_TRAIL: Number = 512;
    static var FLAG_CONSTRUCTIVE: Number = 1024;
    static var FLAG_DESTRUCTIVE: Number = 2048;
    static var FLAG_PLAY_UNDER_PLAYER_DEPTH: Number = 4096;
    static var FLAG_INTELLIGENT_DEPTH_SORT: Number = 8192;
    static var SNOW_BALL_NORMAL = new com.clubpenguin.engine.projectiles.SnowballEnum("ballnormal", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_CANDY = new com.clubpenguin.engine.projectiles.SnowballEnum("ballCandy", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_EGG = new com.clubpenguin.engine.projectiles.SnowballEnum("ballEgg", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_FLOUR = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFlour", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_HAY = new com.clubpenguin.engine.projectiles.SnowballEnum("ballHay", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_MILK = new com.clubpenguin.engine.projectiles.SnowballEnum("ballMilk", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_TIRE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballTire", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_LARGE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballLarge", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DESTRUCTIVE);
    static var SNOW_BALL_ICE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballIce", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_BARF = new com.clubpenguin.engine.projectiles.SnowballEnum("ballBarf", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_FOOD = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFood", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_INVISIBLE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballInvisible", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_PIZZA = new com.clubpenguin.engine.projectiles.SnowballEnum("ballPizza", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_LASER = new com.clubpenguin.engine.projectiles.SnowballEnum("ballLaser", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_HAS_TAIL | com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_IS_FIXED | com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_ORIGIN_AT_HEAD | com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_INTELLIGENT_DEPTH_SORT | com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DELAY_ANIM_START);
    static var SNOW_BALL_FROZEN = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFrozen", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    static var SNOW_BALL_FROZEN_LARGE = new com.clubpenguin.engine.projectiles.SnowballEnum("ballFrozenLarge", com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE);
    var _flags;
    var _symbolName;

    function SnowballEnum(symbolName, flags)
    {
        super();
        if (flags == undefined) 
        {
            this._flags = com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE;
        }
        else 
        {
            this._flags = flags;
        }
        this._symbolName = symbolName;
    }

    function get symbolName()
    {
        return this._symbolName;
    }

    function isFlagSet(flag)
    {
        return (flag & this._flags) != com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_NONE;
    }

    function get hasTail()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_HAS_TAIL);
    }

    function get isFixed()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_IS_FIXED);
    }

    function get delayAnimStart()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DELAY_ANIM_START);
    }

    function get originAtHead()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_ORIGIN_AT_HEAD);
    }

    function get originAtCenter()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_ORIGIN_AT_CENTER);
    }

    function get returnsToPlayer()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_RETURNS_TO_PLAYER);
    }

    function get playerInvisible()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAYER_INVISIBLE);
    }

    function get hasTrail()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_HAS_TRAIL);
    }

    function get isConstructive()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_CONSTRUCTIVE);
    }

    function get isDestructive()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_DESTRUCTIVE);
    }

    function get playUnderPlayer()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAY_UNDER_PLAYER_DEPTH);
    }

    function get playAbovePlayer()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_PLAY_ABOVE_PLAYER_DEPTH);
    }

    function get intelligentSort()
    {
        return this.isFlagSet(com.clubpenguin.engine.projectiles.SnowballEnum.FLAG_INTELLIGENT_DEPTH_SORT);
    }

    function toString()
    {
        return "[" + this._symbolName + "|" + this._flags + "]";
    }

}
