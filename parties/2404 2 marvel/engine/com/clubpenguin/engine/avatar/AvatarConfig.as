//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.AvatarConfig
    {
        static var _model, _defaultAvatar, SnowballEnum, check, avatarConfig, snowballTypes, flags;
        function AvatarConfig () {
        }
        static function initialize(model) {
            _model = model;
            initDefaultAvatar();
            initEvergreenAvatars();
			initPowerGloves();
            initMascotAvatars();
        }
        static function initDefaultAvatar() {
            var _local_1;
            var _local_4 = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
            var _local_2 = com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_NORMAL;
            var _local_3 = new com.clubpenguin.engine.projectiles.vo.SnowballVO(_local_2, -100, 20);
            _model.setSnowballHitCheck(_local_2, _local_4);
            _local_1 = new com.clubpenguin.engine.avatar.model.AvatarVO();
            _local_1.spritePath = "penguin";
            _local_1.isSpriteTransformed = false;
            _local_1.isMemberOnly = false;
            _local_1.duration = 0;
            _local_1.snowball = _local_3;
            _local_1.hasTransformEffect = true;
            _local_1.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
            _local_1.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT;
            _local_1.hasCustomPlayerCard = false;
            _local_1.customPlayerCardBackgroundID = -1;
            _local_1.hasColorVersions = false;
            _local_1.attachItems = true;
            _local_1.canRevertToDefault = false;
            _local_1.revertSoundEffectSymbol = null;
            _local_1.speechBubbleOffsetX = 0;
            _local_1.speechBubbleOffsetY = 0;
            _local_1.nicknameOffsetY = 0;
            _local_1.shadowScaleX = 100;
            _local_1.shadowScaleY = 100;
            _local_1.attributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
            _model.setAvatarTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.DEFAULT_ID, _local_1);
            _defaultAvatar = _local_1;
        }
        static function initEvergreenAvatars() {
            var _local_1 = _defaultAvatar.clone();
            _local_1.spritePath = "w.avatarsprite.epf.usingtracetracker";
            _model.setAvatarTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.EPF_TRACE_TRACKER_ID, _local_1);
        }
        static function initMascotAvatars() {
			var _local_2 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_2.spritePath = "w.avatarsprite.mascot.herbert";
        	_local_2.speechBubbleOffsetY = -40;
			_local_2.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE, -100, 58);
			com.clubpenguin.engine.avatar.AvatarConfig._model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE, new com.clubpenguin.engine.projectiles.SnowballHitCheck());
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(com.clubpenguin.engine.avatar.transformation.AvatarTypeEnum.HERBERT_ID, _local_2);
        	var _local_1 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_1.spritePath = "w.avatarsprite.mascot.sasquatch";
        	_local_1.nicknameOffsetY = 10;
        	_local_1.attachItems = false;
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(35, _local_1);
			var _local_5 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_5.spritePath = "kermit_mascot";
			_local_5.speechBubbleOffsetY = -10;
        	_local_5.attachItems = false;
			_local_5.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_EGG, -100, 8);
			com.clubpenguin.engine.avatar.AvatarConfig._model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_EGG, new com.clubpenguin.engine.projectiles.SnowballHitCheck());
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(33, _local_5);
        	var _local_6 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_6.spritePath = "invistransform";
			_local_6.speechBubbleOffsetX = 10;
			_local_6.speechBubbleOffsetY = -40;
        	_local_6.attachItems = true;
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(36, _local_6);
			var _local_7 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_7.spritePath = "invistransform";
        	_local_7.attachItems = true;
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(17, _local_7);
			var _local_8 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_8.spritePath = "invistransform";
        	_local_8.attachItems = true;
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(18, _local_8);
			var _local_9 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
        	_local_9.spritePath = "invistransform";
			_local_9.speechBubbleOffsetX = 50;
        	_local_9.speechBubbleOffsetY = 10;
			_local_9.nicknameOffsetY = 800;
        	_local_9.shadowScaleX = 0;
        	_local_9.shadowScaleY = 0;
        	_local_9.attachItems = true;
        	com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(19, _local_9);
			var _local_3 = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
			_local_3.spritePath = "protobot_mascot";
			_local_3.isSpriteTransformed = true;
			_local_3.attachItems = false;
			_local_3.speechBubbleOffsetY = -90;
			_local_3.shadowScaleX = 200;
			_local_3.shadowScaleY = 200;
			_local_3.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE, 0, 100);
			com.clubpenguin.engine.avatar.AvatarConfig._model.setSnowballHitCheck(com.clubpenguin.engine.projectiles.SnowballEnum.SNOW_BALL_LARGE, new com.clubpenguin.engine.projectiles.SnowballHitCheck());
			com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(14, _local_3);
        }
		static function initPowerGloves() {
			SnowballEnum = com.clubpenguin.engine.projectiles.SnowballEnum;
			check = new com.clubpenguin.engine.projectiles.SnowballHitCheck();
			avatarConfig = com.clubpenguin.engine.avatar.AvatarConfig;
			snowballTypes = [{type:"ballice",index:50,flag:"FLAG_HAS_TAIL"},{type:"ballelectric",index:51,flag:"FLAG_HAS_TAIL"},{type:"ballfire",index:52,flag:"FLAG_HAS_TAIL"},{type:"ballCrystalShards",index:53,flag:"FLAG_HAS_TAIL"},{type:"ballSlime",index:54,flag:"FLAG_HAS_TAIL"},{type:"ballLaser",index:55,flag:"FLAG_HAS_TAIL"},{type:"ballTelekinetic",index:56,flag:"FLAG_HAS_TAIL"},{type:"ballTornado",index:57,flag:"FLAG_HAS_TAIL"},{type:"ballTeleport",index:58,flag:"FLAG_NONE"},{type:"ballSonic",index:59,flag:"FLAG_HAS_TAIL"},{type:"ballStomp",index:60,flag:"FLAG_IS_FIXED"},{type:"ballFixing",index:61,flag:"FLAG_CONSTRUCTIVE"},{type:"ball_large",index:62,flag:"FLAG_DESTRUCTIVE"},{type:"ballFish",index:63,flag:"FLAG_ORIGIN_AT_CENTER"},{type:"ballFood",index:64,flag:"FLAG_ORIGIN_AT_CENTER"}];
			var i = 0;
			while(i < snowballTypes.length) {
				var snowballType = snowballTypes[i];
					var _loc1_ = avatarConfig._defaultAvatar.clone();
					var snowball = SnowballEnum["SNOW_" + snowballType.type] = new SnowballEnum(snowballType.type,SnowballEnum[snowballType.flag]);
					switch(snowballType.type) {
						case "ballCrystalShards":
							flags = SnowballEnum.FLAG_HAS_TAIL | SnowballEnum.FLAG_ORIGIN_AT_HEAD;
							break;
						case "ballLaser":
							flags = SnowballEnum.FLAG_HAS_TAIL | SnowballEnum.FLAG_IS_FIXED | SnowballEnum.FLAG_ORIGIN_AT_HEAD | SnowballEnum.FLAG_INTELLIGENT_DEPTH_SORT | SnowballEnum.FLAG_DELAY_ANIM_START;
							break;
						case "ballSonic":
						case "ballTelekinetic":
							flags = SnowballEnum.FLAG_HAS_TAIL | SnowballEnum.FLAG_ORIGIN_AT_CENTER | SnowballEnum.FLAG_INTELLIGENT_DEPTH_SORT | SnowballEnum.FLAG_DELAY_ANIM_START;
							break;
						case "ballTornado":
							flags = SnowballEnum.FLAG_HAS_TAIL | SnowballEnum.FLAG_DESTRUCTIVE;
							break;
						case "ballStomp":
							flags = SnowballEnum.FLAG_IS_FIXED | SnowballEnum.FLAG_DESTRUCTIVE;
							break;
						default:
							flags = SnowballEnum[snowballType.flag];
							break;
					}
					snowball = SnowballEnum["SNOW_" + snowballType.type] = new SnowballEnum(snowballType.type,flags);
					trace("snowball enum " + snowball);
					_loc1_.snowball = new com.clubpenguin.engine.projectiles.vo.SnowballVO(snowball,-100,20);
					avatarConfig._model.setSnowballHitCheck(snowball,check);
					avatarConfig._model.setAvatarTemplate(snowballType.index,_loc1_);
					i++;
				}
		}
    }
