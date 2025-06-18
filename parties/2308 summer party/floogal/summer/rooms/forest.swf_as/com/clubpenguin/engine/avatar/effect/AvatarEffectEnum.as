dynamic class com.clubpenguin.engine.avatar.effect.AvatarEffectEnum
{
    static var LIB_AVATAR_NAME: String = "avatar";
    static var LIB_AVATAR_DEPTH: Number = 800001;
    static var LIB_SNOW_BALL_NAME: String = "snowball";
    static var LIB_SNOW_BALL_DEPTH: Number = 1000200;
    static var FLAG_NONE: Number = 0;
    static var FLAG_ATTACH_TO_PLAYER: Number = 1;
    static var FLAG_LOOP_ANIMATION: Number = 2;
    static var FLAG_STOP_ON_LAST_FRAME: Number = 4;
    static var FLAG_PLAY_UNDER_PLAYER_DEPTH: Number = 8;
    static var NO_EFFECT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum("NO_EFFECT", "NO_EFFECT", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var SMOKE_POOF_BLUE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "smokePoofBlue", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var SMOKE_POOF_BROWN_LARGE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "smokePoofBrownLarge", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var SMOKE_POOF_BROWN_SMALL = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "smokePoofBrownSmall", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var COIN_TWIRL = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "coin_twirl", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    static var PUFFLE_BATH_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "bathPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_PLAY_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "playPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_SLEEP_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "sleepPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_EAT_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "eatPoint", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_BLUE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_blue", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_RED = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_red", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_BLACK = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_black", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_BROWN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_brown", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_GREEN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_green", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_PINK = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_pink", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_WHITE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_white", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_YELLOW = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_yellow", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_PURPLE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_purple", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_BOUNCE_ORANGE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pufflebounce_orange", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PUFFLE_FOUND_COINS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "treasureHuntFoundCoins", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var QUEST_FOUND_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "QuestFoundItem", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE, 1, {_x: 50, _y: 490});
    static var PIRATE_BATTLE_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "iconPirateBattle", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var PIRATE_BATTLE_POINTS_WIN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pirateBattlePointsWin", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PIRATE_BATTLE_POINTS_LOSS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pirateBattlePointsLoss", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE);
    static var PIRATE_BATTLE_LOW_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pirateBattleLowIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var PIRATE_BATTLE_MID_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pirateBattleMidIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var PIRATE_BATTLE_HIGH_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, "pirateBattleHighIcon", com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER | com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    static var EFFECT_LIBS = [{swfName: com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_NAME, depth: com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.LIB_AVATAR_DEPTH}];
    var _flags;
    var _swfName;
    var _symbolName;
    var _tweenDuration;
    var _tweenOptions;

    function AvatarEffectEnum(swfName, symbolName, flags, tweenDuration, tweenOptions)
    {
        super();
        if (flags == undefined) 
        {
            this._flags = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE;
        }
        else 
        {
            this._flags = flags;
        }
        this._swfName = swfName;
        this._symbolName = symbolName;
        this._tweenDuration = tweenDuration;
        this._tweenOptions = tweenOptions;
    }

    function get tweenDuration()
    {
        return this._tweenDuration;
    }

    function get tweenOptions()
    {
        return this._tweenOptions;
    }

    function get swfName()
    {
        return this._swfName;
    }

    function get symbolName()
    {
        return this._symbolName;
    }

    function isFlagSet(flag)
    {
        return (flag & this._flags) != com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_NONE;
    }

    function get attachToPlayer()
    {
        return this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_ATTACH_TO_PLAYER);
    }

    function get loopAnimation()
    {
        return this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_LOOP_ANIMATION);
    }

    function get stopOnLastFrame()
    {
        return this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_STOP_ON_LAST_FRAME);
    }

    function get playUnderPlayer()
    {
        return this.isFlagSet(com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.FLAG_PLAY_UNDER_PLAYER_DEPTH);
    }

    static function fromString(id)
    {
        if ((__reg0 = id) === "QuestFoundItem") 
        {
            return com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.QUEST_FOUND_ICON;
        }
        return com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
    }

    function toString()
    {
        return "[" + this._swfName + "|" + this._symbolName + "|" + this._flags + "|" + this._tweenDuration + "|" + this._tweenOptions + "]";
    }

}
