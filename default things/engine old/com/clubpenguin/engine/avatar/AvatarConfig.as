class com.clubpenguin.engine.avatar.AvatarConfig
{
    static var _model, _defaultAvatar;
    function AvatarConfig()
    {
    } // End of the function
    static function initialize(model)
    {
        _model = model;
        com.clubpenguin.engine.avatar.AvatarConfig.initDefaultAvatar();
        com.clubpenguin.engine.avatar.AvatarConfig.initEvergreenAvatars();
        com.clubpenguin.engine.avatar.AvatarConfig.initMascotAvatars();
    } // End of the function
    static function initDefaultAvatar()
    {
        var _loc1;
        var _loc4 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
        var _loc2 = com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL;
        var _loc3 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_loc2, -100, 20);
        com.clubpenguin.engine.avatar.AvatarConfig._model.setSnowballHitCheck(_loc2, _loc4);
        _loc1 = new com.clubpenguin.engine.avatar.model.AvatarVO();
        _loc1.spritePath = "penguin";
        _loc1.isSpriteTransformed = false;
        _loc1.isMemberOnly = false;
        _loc1.duration = 0;
        _loc1.snowball = _loc3;
        _loc1.hasTransformEffect = true;
        _loc1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
        _loc1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
        _loc1.hasCustomPlayerCard = false;
        _loc1.customPlayerCardBackgroundID = -1;
        _loc1.hasColorVersions = false;
        _loc1.attachItems = true;
        _loc1.canRevertToDefault = false;
        _loc1.revertSoundEffectSymbol = null;
        _loc1.speechBubbleOffsetX = 0;
        _loc1.speechBubbleOffsetY = 0;
        _loc1.nicknameOffsetY = 0;
        _loc1.shadowScaleX = 100;
        _loc1.shadowScaleY = 100;
        _loc1.attributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID, _loc1);
        _defaultAvatar = _loc1;
    } // End of the function
    static function initEvergreenAvatars()
    {
        var _loc1 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc1.spritePath = "w.avatarsprite.epf.usingtracetracker";
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.EPF_TRACE_TRACKER_ID, _loc1);
    } // End of the function
    static function initMascotAvatars()
    {
        var _loc2 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc2.spritePath = "w.avatarsprite.mascot.herbert";
        _loc2.speechBubbleOffsetY = -40;
		_loc2.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE, -100, 58);
		com.clubpenguin.engine.avatar.AvatarConfig._model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE, new com.clubpenguin.engine.projectiles.SnowballHitCheck());
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.HERBERT_ID, _loc2);
        var _loc1 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc1.spritePath = "w.avatarsprite.mascot.sasquatch";
        _loc1.nicknameOffsetY = 10;
        _loc1.attachItems = false;
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(35, _loc1);
		var _loc5 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc5.spritePath = "kermit_mascot";
		_loc5.speechBubbleOffsetY = -10;
        _loc5.attachItems = false;
		_loc5.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_EGG, -100, 8);
		com.clubpenguin.engine.avatar.AvatarConfig._model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_EGG, new com.clubpenguin.engine.projectiles.SnowballHitCheck());
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(33, _loc5);
        var _loc6 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc6.spritePath = "invistransform";
		_loc6.speechBubbleOffsetX = 10;
		_loc6.speechBubbleOffsetY = -40;
        _loc6.attachItems = true;
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(36, _loc6);
		var _loc7 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc7.spritePath = "invistransform";
        _loc7.attachItems = true;
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(17, _loc7);
		var _loc8 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc8.spritePath = "invistransform";
        _loc8.attachItems = true;
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(18, _loc8);
		var _loc9 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        _loc9.spritePath = "invistransform";
		_loc9.speechBubbleOffsetX = 50;
        _loc9.speechBubbleOffsetY = 10;
		_loc9.nicknameOffsetY = 800;
        _loc9.shadowScaleX = 0;
        _loc9.shadowScaleY = 0;
        _loc9.attachItems = true;
        com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(19, _loc9);
    } // End of the function
} // End of Class
