//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.effect.AvatarEffectEnum
    {
        var _flags, _swfName, _symbolName, _tweenDuration, _tweenOptions;
        function AvatarEffectEnum (swfName, symbolName, flags, tweenDuration, tweenOptions) {
            super();
            if (flags != undefined) {
                _flags = flags;
            } else {
                _flags = FLAG_NONE;
            }
            _swfName = swfName;
            _symbolName = symbolName;
            _tweenDuration = tweenDuration;
            _tweenOptions = tweenOptions;
        }
        function get tweenDuration() {
            return(_tweenDuration);
        }
        function get tweenOptions() {
            return(_tweenOptions);
        }
        function get swfName() {
            return(_swfName);
        }
        function get symbolName() {
            return(_symbolName);
        }
        function isFlagSet(flag) {
            return((flag & _flags) != FLAG_NONE);
        }
        function get attachToPlayer() {
            return(isFlagSet(FLAG_ATTACH_TO_PLAYER));
        }
        function get loopAnimation() {
            return(isFlagSet(FLAG_LOOP_ANIMATION));
        }
        function get stopOnLastFrame() {
            return(isFlagSet(FLAG_STOP_ON_LAST_FRAME));
        }
        function get playUnderPlayer() {
            return(isFlagSet(FLAG_PLAY_UNDER_PLAYER_DEPTH));
        }
        static function fromString(id) {
            if (!(id === "QuestFoundItem")) {
            } else {
                return(QUEST_FOUND_ICON);
            }
            return(NO_EFFECT);
        }
        function toString() {
            return(((((((((("[" + _swfName) + "|") + _symbolName) + "|") + _flags) + "|") + _tweenDuration) + "|") + _tweenOptions) + "]");
        }
        static var LIB_AVATAR_NAME = "avatar";
        static var LIB_AVATAR_DEPTH = 800001;
        static var LIB_SNOW_BALL_NAME = "snowball";
        static var LIB_SNOW_BALL_DEPTH = 1000200;
        static var FLAG_NONE = 0;
        static var FLAG_ATTACH_TO_PLAYER = 1;
        static var FLAG_LOOP_ANIMATION = 2;
        static var FLAG_STOP_ON_LAST_FRAME = 4;
        static var FLAG_PLAY_UNDER_PLAYER_DEPTH = 8;
        static var NO_EFFECT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum("NO_EFFECT", "NO_EFFECT", FLAG_NONE);
        static var SMOKE_POOF_BLUE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "smokePoofBlue", FLAG_ATTACH_TO_PLAYER);
        static var SMOKE_POOF_BROWN_LARGE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "smokePoofBrownLarge", FLAG_ATTACH_TO_PLAYER);
        static var SMOKE_POOF_BROWN_SMALL = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "smokePoofBrownSmall", FLAG_ATTACH_TO_PLAYER);
        static var COIN_TWIRL = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "coin_twirl", FLAG_ATTACH_TO_PLAYER);
        static var PUFFLE_BATH_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "bathPoint", FLAG_NONE);
        static var PUFFLE_PLAY_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "playPoint", FLAG_NONE);
        static var PUFFLE_SLEEP_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "sleepPoint", FLAG_NONE);
        static var PUFFLE_EAT_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "eatPoint", FLAG_NONE);
        static var PUFFLE_BOUNCE_BLUE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_blue", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_RED = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_red", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_BLACK = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_black", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_BROWN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_brown", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_GREEN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_green", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_PINK = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_pink", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_WHITE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_white", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_YELLOW = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_yellow", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_PURPLE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_purple", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_BOUNCE_ORANGE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pufflebounce_orange", FLAG_ATTACH_TO_PLAYER | FLAG_NONE);
        static var PUFFLE_FOUND_COINS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "treasureHuntFoundCoins", FLAG_NONE);
        static var QUEST_FOUND_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "QuestFoundItem", FLAG_NONE, 1, {_x:50, _y:490});
        static var PIRATE_BATTLE_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "iconPirateBattle", FLAG_ATTACH_TO_PLAYER | FLAG_STOP_ON_LAST_FRAME);
        static var PIRATE_BATTLE_POINTS_WIN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pirateBattlePointsWin", FLAG_NONE);
        static var PIRATE_BATTLE_POINTS_LOSS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pirateBattlePointsLoss", FLAG_NONE);
        static var PIRATE_BATTLE_LOW_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pirateBattleLowIcon", FLAG_ATTACH_TO_PLAYER | FLAG_STOP_ON_LAST_FRAME);
        static var PIRATE_BATTLE_MID_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pirateBattleMidIcon", FLAG_ATTACH_TO_PLAYER | FLAG_STOP_ON_LAST_FRAME);
        static var PIRATE_BATTLE_HIGH_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "pirateBattleHighIcon", FLAG_ATTACH_TO_PLAYER | FLAG_STOP_ON_LAST_FRAME);
        static var EFFECT_LIBS = [{swfName:LIB_AVATAR_NAME, depth:LIB_AVATAR_DEPTH}];
    }
