﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.effect.AvatarEffectEnum
    {
        var _flags, _swfName, _symbolName;
        function AvatarEffectEnum (swfName, symbolName, flags) {
            super();
            if (flags != undefined) {
                _flags = flags;
            } else {
                _flags = FLAG_NONE;
            }
            _swfName = swfName;
            _symbolName = symbolName;
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
        function toString() {
            return(((((("[" + _swfName) + "|") + _symbolName) + "|") + _flags) + "]");
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
        static var CAMERA_FLASH_SIMPLE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "cameraFlashSimple", FLAG_ATTACH_TO_PLAYER);
        static var CAMERA_FLASH_SPARKLE = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "cameraFlashSparkle", FLAG_ATTACH_TO_PLAYER);
        static var SUPERSTAR_POINTS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "superstarPoint", FLAG_ATTACH_TO_PLAYER);
        static var DIRECTOR_POINTS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "directorPoint", FLAG_ATTACH_TO_PLAYER);
        static var PUFFLE_BATH_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "bathPoint", FLAG_NONE);
        static var PUFFLE_PLAY_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "playPoint", FLAG_NONE);
        static var PUFFLE_SLEEP_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "sleepPoint", FLAG_NONE);
        static var PUFFLE_EAT_POINT = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "eatPoint", FLAG_NONE);
        static var STAR_WARS_BATTLE_ICON = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "battleIcon", FLAG_STOP_ON_LAST_FRAME);
        static var STAR_WARS_BATTLE_POINTS_LOSS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "battlePointsLoss", FLAG_ATTACH_TO_PLAYER);
        static var STAR_WARS_BATTLE_POINTS_WIN = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "battlePointsWin", FLAG_ATTACH_TO_PLAYER);
        static var PUFFLE_FOUND_COINS = new com.clubpenguin.engine.avatar.effect.AvatarEffectEnum(LIB_AVATAR_NAME, "treasureHuntFoundCoins", FLAG_NONE);
        static var EFFECT_LIBS = [{swfName:LIB_AVATAR_NAME, depth:LIB_AVATAR_DEPTH}];
    }
