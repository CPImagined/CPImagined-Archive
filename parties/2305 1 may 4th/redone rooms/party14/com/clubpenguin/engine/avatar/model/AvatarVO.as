//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.model.AvatarVO
    {
        var effectTransitionsMap, defaultTransitionEffect, hasTransformEffect, hasCustomPlayerCard, dynamicPlayerCardLabelFunc, hasColorVersions, isSpriteTransformed, spritePath, dynamicSpritePathFunc, spriteAlpha, spriteScale, duration, ignoresBlockLayer, speechBubbleOffsetY, speechBubbleOffsetX, nicknameOffsetY, isMemberOnly, attachItems, snowball;
        function AvatarVO () {
            effectTransitionsMap = {};
        }
        function setEffectTransition(avatarId, effect) {
            effectTransitionsMap[avatarId] = ((effect != null) ? (effect) : (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT));
        }
        function getEffectTransition(avatarId) {
            var _local_2 = effectTransitionsMap[avatarId];
            if (_local_2 != null) {
                return(_local_2);
            } else {
                return(defaultTransitionEffect);
            }
        }
        function clearEffectTransitions() {
            effectTransitionsMap = {};
        }
        function clone() {
            var _local_2 = new com.clubpenguin.engine.avatar.model.AvatarVO();
            _local_2.hasTransformEffect = hasTransformEffect;
            _local_2.hasCustomPlayerCard = hasCustomPlayerCard;
            _local_2.dynamicPlayerCardLabelFunc = dynamicPlayerCardLabelFunc;
            _local_2.hasColorVersions = hasColorVersions;
            _local_2.defaultTransitionEffect = defaultTransitionEffect;
            _local_2.isSpriteTransformed = isSpriteTransformed;
            _local_2.spritePath = spritePath;
            _local_2.dynamicSpritePathFunc = dynamicSpritePathFunc;
            _local_2.spriteAlpha = spriteAlpha;
            _local_2.spriteScale = spriteScale;
            _local_2.duration = duration;
            _local_2.ignoresBlockLayer = ignoresBlockLayer;
            _local_2.speechBubbleOffsetY = speechBubbleOffsetY;
            _local_2.speechBubbleOffsetX = speechBubbleOffsetX;
            _local_2.nicknameOffsetY = nicknameOffsetY;
            _local_2.isMemberOnly = isMemberOnly;
            _local_2.attachItems = attachItems;
            _local_2.snowball = snowball.clone();
            _local_2.effectTransitionsMap = {};
            for (var _local_3 in effectTransitionsMap) {
                _local_2.effectTransitionsMap[_local_3] = effectTransitionsMap[_local_3];
            }
            return(_local_2);
        }
        function toString() {
            return(((("[AvatarVO{spritePath:" + spritePath) + ", isSpriteTransformed:") + isSpriteTransformed) + "}]");
        }
    }
