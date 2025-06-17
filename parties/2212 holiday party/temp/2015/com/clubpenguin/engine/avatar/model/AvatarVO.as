class com.clubpenguin.engine.avatar.model.AvatarVO
{
   function AvatarVO()
   {
      this.effectTransitionsMap = {};
   }
   function setEffectTransition(avatarId, effect)
   {
      this.effectTransitionsMap[avatarId] = effect == null ? com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT : effect;
   }
   function getEffectTransition(avatarId)
   {
      var _loc2_ = this.effectTransitionsMap[avatarId];
      if(_loc2_ != null)
      {
         return _loc2_;
      }
      return this.defaultTransitionEffect;
   }
   function clearEffectTransitions()
   {
      this.effectTransitionsMap = {};
   }
   function initializeAttributesFromString(features)
   {
      if(features != undefined)
      {
         try
         {
            var _loc2_ = com.clubpenguin.util.JSONParser.parse(features);
            this.attributes.spriteScale = Number(_loc2_.spriteScale);
            this.attributes.spriteSpeed = Number(_loc2_.spriteSpeed);
            this.attributes.ignoresBlockLayer = Boolean(_loc2_.ignoresBlockLayer);
            this.attributes.isInvisible = Boolean(_loc2_.invisible);
            this.attributes.isFloating = Boolean(_loc2_.floating);
         }
         catch(ex)
         {
         }
      }
   }
   function clone()
   {
      var _loc2_ = new com.clubpenguin.engine.avatar.model.AvatarVO();
      _loc2_.avatar_id = this.avatar_id;
      _loc2_.duration = this.duration;
      _loc2_.speechBubbleOffsetY = this.speechBubbleOffsetY;
      _loc2_.speechBubbleOffsetX = this.speechBubbleOffsetX;
      _loc2_.nicknameOffsetY = this.nicknameOffsetY;
      _loc2_.hasTransformEffect = this.hasTransformEffect;
      _loc2_.defaultTransitionEffect = this.defaultTransitionEffect;
      _loc2_.defaultRevertEffect = this.defaultRevertEffect;
      _loc2_.hasCustomPlayerCard = this.hasCustomPlayerCard;
      _loc2_.customPlayerCardBackgroundID = this.customPlayerCardBackgroundID;
      _loc2_.dynamicPlayerCardBackgroundFunc = this.dynamicPlayerCardBackgroundFunc;
      _loc2_.dynamicPlayerCardLabelFunc = this.dynamicPlayerCardLabelFunc;
      _loc2_.hasColorVersions = this.hasColorVersions;
      _loc2_.isSpriteTransformed = this.isSpriteTransformed;
      _loc2_.spritePath = this.spritePath;
      _loc2_.dynamicSpritePathFunc = this.dynamicSpritePathFunc;
      _loc2_.isMemberOnly = this.isMemberOnly;
      _loc2_.attachItems = this.attachItems;
      _loc2_.canRevertToDefault = this.canRevertToDefault;
      _loc2_.revertSoundEffectSymbol = this.revertSoundEffectSymbol;
      _loc2_.shadowScaleX = this.shadowScaleX;
      _loc2_.shadowScaleY = this.shadowScaleY;
      _loc2_.effectTransitionsMap = {};
      for(var _loc3_ in this.effectTransitionsMap)
      {
         _loc2_.effectTransitionsMap[_loc3_] = this.effectTransitionsMap[_loc3_];
      }
      _loc2_.snowball = this.snowball.clone();
      _loc2_.attributes = this.attributes.clone();
      return _loc2_;
   }
   function toString()
   {
      var _loc2_ = "";
      _loc2_ += "AvatarVO{";
      _loc2_ += " avatar_id: " + this.avatar_id;
      _loc2_ += ", duration: " + this.duration;
      _loc2_ += ", speechBubbleOffsetY: " + this.speechBubbleOffsetY;
      _loc2_ += ", speechBubbleOffsetX: " + this.speechBubbleOffsetX;
      _loc2_ += ", nicknameOffsetY: " + this.nicknameOffsetY;
      _loc2_ += ", snowball: " + this.snowball.toString();
      _loc2_ += ", hasTransformEffect: " + this.hasTransformEffect;
      _loc2_ += ", defaultTransitionEffect: " + this.defaultTransitionEffect;
      _loc2_ += ", defaultRevertEffect: " + this.defaultRevertEffect;
      _loc2_ += ", effectTransitionsMap: " + this.effectTransitionsMapToString();
      _loc2_ += ", hasCustomPlayerCard: " + this.hasCustomPlayerCard;
      _loc2_ += ", customPlayerCardBackgroundID: " + this.customPlayerCardBackgroundID;
      _loc2_ += ", dynamicPlayerCardBackgroundFunc: " + this.dynamicPlayerCardBackgroundFunc;
      _loc2_ += ", hasColorVersions: " + this.hasColorVersions;
      _loc2_ += ", isSpriteTransformed: " + this.isSpriteTransformed;
      _loc2_ += ", spritePath: " + this.spritePath;
      _loc2_ += ", isMemberOnly: " + this.isMemberOnly;
      _loc2_ += ", attachItems: " + this.attachItems;
      _loc2_ += ", canRevertToDefault: " + this.canRevertToDefault;
      _loc2_ += ", revertSoundEffectSymbol: " + this.revertSoundEffectSymbol;
      _loc2_ += ", shadowScaleX: " + this.shadowScaleX;
      _loc2_ += ", shadowScaleY: " + this.shadowScaleY;
      _loc2_ += ", attributes: " + this.attributes;
      _loc2_ += "}";
      return _loc2_;
   }
   function effectTransitionsMapToString()
   {
      var _loc2_ = "";
      _loc2_ += "{";
      for(var _loc3_ in this.effectTransitionsMap)
      {
         _loc2_ += _loc3_ + ":" + this.effectTransitionsMap[_loc3_] + " ";
      }
      _loc2_ += "}";
      return _loc2_;
   }
}
