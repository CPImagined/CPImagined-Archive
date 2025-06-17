//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.AvatarConfig
    {
        static var _model, _defaultAvatarVO;
        function AvatarConfig () {
        }
        static function initialize(model) {
            _model = model;
            initPermanentAvatars();
            initStarWarsAvatars();
        }
        static function initPermanentAvatars() {
            var _local_1;
            var _local_4 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
            var _local_2 = com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL;
            var _local_3 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_2, -100, 20);
            _model.setSnowballHitCheck(_local_2, _local_4);
            _local_1 = new com.clubpenguin.engine.avatar.model.AvatarVO();
            _local_1.snowball = _local_3;
            _local_1.hasTransformEffect = true;
            _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
            _local_1.setEffectTransition(EPF_TRACE_TRACKER_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT);
            _local_1.setEffectTransition(JEDI_BROWN_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE);
            _local_1.setEffectTransition(JEDI_BLACK_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE);
            _local_1.setEffectTransition(VADER_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE);
            _local_1.hasCustomPlayerCard = false;
            _local_1.isSpriteTransformed = false;
            _local_1.spritePath = "penguin";
            _local_1.spriteAlpha = 100;
            _local_1.spriteScale = 100;
            _local_1.hasColorVersions = false;
            _local_1.duration = 0;
            _local_1.ignoresBlockLayer = false;
            _local_1.speechBubbleOffsetX = 0;
            _local_1.speechBubbleOffsetY = 0;
            _local_1.nicknameOffsetY = 0;
            _local_1.isMemberOnly = false;
            _local_1.attachItems = true;
            _model.setAvatarData(DEFAULT_ID, _local_1);
            _defaultAvatarVO = _local_1;
            _local_1 = _defaultAvatarVO.clone();
            _local_1.hasTransformEffect = false;
            _local_1.spritePath = "w.avatarsprite.epf.usingtracetracker";
            _local_1.clearEffectTransitions();
            _local_1.setEffectTransition(DEFAULT_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT);
            _model.setAvatarData(EPF_TRACE_TRACKER_ID, _local_1);
            initHerbertAvatar();
        }
        static function initStarWarsAvatars() {
            var _local_1 = _defaultAvatarVO.clone();
            _local_1.spritePath = "w.avatarsprite.starwars.jedibrown";
            _local_1.clearEffectTransitions();
            _local_1.setEffectTransition(DEFAULT_ID, com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BLUE);
            _local_1.attachItems = false;
            _local_1.ignoresBlockLayer = true;
            _model.setAvatarData(JEDI_BROWN_ID, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.avatarsprite.starwars.jediblack";
            _model.setAvatarData(JEDI_BLACK_ID, _local_1);
            _local_1 = _local_1.clone();
            _local_1.spritePath = "w.avatarsprite.starwars.vader";
            _model.setAvatarData(VADER_ID, _local_1);
        }
        static function initHerbertAvatar() {
            var _local_1 = _defaultAvatarVO.clone();
            _local_1.spritePath = com.clubpenguin.engine.avatar.transformation.AvatarTransformationEnum.HERBERT_AVATAR_PATH;
            _model.setAvatarData(com.clubpenguin.engine.avatar.transformation.AvatarTransformationEnum.HERBERT_MASCOT_ID, _local_1);
        }
        static var DEFAULT_ID = 0;
        static var EPF_TRACE_TRACKER_ID = 29;
        static var JEDI_BROWN_ID = -1;
        static var JEDI_BLACK_ID = -2;
        static var VADER_ID = -3;
    }
