//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.AvatarConfig
    {
        static var _model, _defaultAvatar, Party;
        function AvatarConfig () {
        }
        static function initialize(model) {
            _model = model;
            initDefaultAvatar();
            initEvergreenAvatars();
            initMascotAvatars();
			initRoboAvatars();
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
        }
		static function initRoboAvatars()
   {
      Party = _global.getCurrentParty().FutureParty;
      var _loc2_ = ["A","B","C"];
      var _loc3_ = ["grey","blue","green","orange","pink"];
      var _loc4_ = 0;
      while(_loc4_ < _loc2_.length)
      {
         var _loc5_ = _loc2_[_loc4_];
         var _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            var _loc7_ = _loc3_[_loc6_];
            var _loc8_ = 100 + _loc4_ * _loc3_.length + _loc6_;
            var _loc9_ = com.clubpenguin.engine.avatar.AvatarConfig._defaultAvatar.clone();
            _loc9_.spritePath = "w.avatarsprite.robot" + _loc5_ + "_" + _loc7_;
            _loc9_.isSpriteTransformed = true;
            _loc9_.canRevertToDefault = true;
            _loc9_.hasCustomPlayerCard = true;
            _loc9_.defaultTransitionEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_SMALL;
            _loc9_.defaultRevertEffect = com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.SMOKE_POOF_BROWN_SMALL;
            _loc9_.dynamicPlayerCardLabelFunc = com.clubpenguin.util.Delegate.create(Party,Party.getDynamicMechPlayerCardLabel);
            trace("avatar.spritePath" + _loc9_.spritePath);
            _loc9_.nicknameOffsetY = 10;
            _loc9_.attachItems = false;
            com.clubpenguin.engine.avatar.AvatarConfig._model.setAvatarTemplate(_loc8_,_loc9_);
            _loc6_ += 1;
         }
         _loc4_ += 1;
      }
   }
    }
