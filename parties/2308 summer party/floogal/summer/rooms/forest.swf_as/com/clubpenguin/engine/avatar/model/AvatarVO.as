dynamic class com.clubpenguin.engine.avatar.model.AvatarVO
{
    var attachItems;
    var attributes;
    var avatar_id;
    var canRevertToDefault;
    var customPlayerCardBackgroundID;
    var defaultRevertEffect;
    var defaultTransitionEffect;
    var duration;
    var dynamicPlayerCardBackgroundFunc;
    var dynamicPlayerCardLabelFunc;
    var dynamicSpritePathFunc;
    var effectTransitionsMap;
    var hasColorVersions;
    var hasCustomPlayerCard;
    var hasTransformEffect;
    var isMemberOnly;
    var isSpriteTransformed;
    var nicknameOffsetY;
    var revertSoundEffectSymbol;
    var shadowScaleX;
    var shadowScaleY;
    var snowball;
    var speechBubbleOffsetX;
    var speechBubbleOffsetY;
    var spritePath;

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
        var __reg2 = this.effectTransitionsMap[avatarId];
        if (__reg2 != null) 
        {
            return __reg2;
        }
        return this.defaultTransitionEffect;
    }

    function clearEffectTransitions()
    {
        this.effectTransitionsMap = {};
    }

    function initializeAttributesFromString(features)
    {
        if (features != undefined) 
        {
            var __reg2 = com.clubpenguin.util.JSONParser.parse(features);
            this.attributes.spriteScale = Number(__reg2.spriteScale);
            this.attributes.spriteSpeed = Number(__reg2.spriteSpeed);
            this.attributes.ignoresBlockLayer = Boolean(__reg2.ignoresBlockLayer);
            this.attributes.isInvisible = Boolean(__reg2.invisible);
            this.attributes.isFloating = Boolean(__reg2.floating);
            return;
        }
    }

    function clone()
    {
        var __reg2 = new com.clubpenguin.engine.avatar.model.AvatarVO();
        __reg2.avatar_id = this.avatar_id;
        __reg2.duration = this.duration;
        __reg2.speechBubbleOffsetY = this.speechBubbleOffsetY;
        __reg2.speechBubbleOffsetX = this.speechBubbleOffsetX;
        __reg2.nicknameOffsetY = this.nicknameOffsetY;
        __reg2.hasTransformEffect = this.hasTransformEffect;
        __reg2.defaultTransitionEffect = this.defaultTransitionEffect;
        __reg2.defaultRevertEffect = this.defaultRevertEffect;
        __reg2.hasCustomPlayerCard = this.hasCustomPlayerCard;
        __reg2.customPlayerCardBackgroundID = this.customPlayerCardBackgroundID;
        __reg2.dynamicPlayerCardBackgroundFunc = this.dynamicPlayerCardBackgroundFunc;
        __reg2.dynamicPlayerCardLabelFunc = this.dynamicPlayerCardLabelFunc;
        __reg2.hasColorVersions = this.hasColorVersions;
        __reg2.isSpriteTransformed = this.isSpriteTransformed;
        __reg2.spritePath = this.spritePath;
        __reg2.dynamicSpritePathFunc = this.dynamicSpritePathFunc;
        __reg2.isMemberOnly = this.isMemberOnly;
        __reg2.attachItems = this.attachItems;
        __reg2.canRevertToDefault = this.canRevertToDefault;
        __reg2.revertSoundEffectSymbol = this.revertSoundEffectSymbol;
        __reg2.shadowScaleX = this.shadowScaleX;
        __reg2.shadowScaleY = this.shadowScaleY;
        __reg2.effectTransitionsMap = {};
        for (var __reg3 in this.effectTransitionsMap) 
        {
            __reg2.effectTransitionsMap[__reg3] = this.effectTransitionsMap[__reg3];
        }
        __reg2.snowball = this.snowball.clone();
        __reg2.attributes = this.attributes.clone();
        return __reg2;
    }

    function toString()
    {
        var __reg2 = "";
        __reg2 = __reg2 + "AvatarVO{";
        __reg2 = __reg2 + (" avatar_id: " + this.avatar_id);
        __reg2 = __reg2 + (", duration: " + this.duration);
        __reg2 = __reg2 + (", speechBubbleOffsetY: " + this.speechBubbleOffsetY);
        __reg2 = __reg2 + (", speechBubbleOffsetX: " + this.speechBubbleOffsetX);
        __reg2 = __reg2 + (", nicknameOffsetY: " + this.nicknameOffsetY);
        __reg2 = __reg2 + (", snowball: " + this.snowball.toString());
        __reg2 = __reg2 + (", hasTransformEffect: " + this.hasTransformEffect);
        __reg2 = __reg2 + (", defaultTransitionEffect: " + this.defaultTransitionEffect);
        __reg2 = __reg2 + (", defaultRevertEffect: " + this.defaultRevertEffect);
        __reg2 = __reg2 + (", effectTransitionsMap: " + this.effectTransitionsMapToString());
        __reg2 = __reg2 + (", hasCustomPlayerCard: " + this.hasCustomPlayerCard);
        __reg2 = __reg2 + (", customPlayerCardBackgroundID: " + this.customPlayerCardBackgroundID);
        __reg2 = __reg2 + (", dynamicPlayerCardBackgroundFunc: " + this.dynamicPlayerCardBackgroundFunc);
        __reg2 = __reg2 + (", hasColorVersions: " + this.hasColorVersions);
        __reg2 = __reg2 + (", isSpriteTransformed: " + this.isSpriteTransformed);
        __reg2 = __reg2 + (", spritePath: " + this.spritePath);
        __reg2 = __reg2 + (", isMemberOnly: " + this.isMemberOnly);
        __reg2 = __reg2 + (", attachItems: " + this.attachItems);
        __reg2 = __reg2 + (", canRevertToDefault: " + this.canRevertToDefault);
        __reg2 = __reg2 + (", revertSoundEffectSymbol: " + this.revertSoundEffectSymbol);
        __reg2 = __reg2 + (", shadowScaleX: " + this.shadowScaleX);
        __reg2 = __reg2 + (", shadowScaleY: " + this.shadowScaleY);
        __reg2 = __reg2 + (", attributes: " + this.attributes);
        __reg2 = __reg2 + "}";
        return __reg2;
    }

    function effectTransitionsMapToString()
    {
        var __reg2 = "";
        __reg2 = __reg2 + "{";
        for (var __reg3 in this.effectTransitionsMap) 
        {
            __reg2 = __reg2 + (__reg3 + ":" + this.effectTransitionsMap[__reg3] + " ");
        }
        __reg2 = __reg2 + "}";
        return __reg2;
    }

}
