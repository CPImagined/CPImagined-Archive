//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.model.AvatarVO
    {
        var effectTransitionsMap, defaultTransitionEffect, attributes, avatar_id, duration, speechBubbleOffsetY, speechBubbleOffsetX, nicknameOffsetY, hasTransformEffect, hasCustomPlayerCard, customPlayerCardBackgroundID, dynamicPlayerCardBackgroundFunc, dynamicPlayerCardLabelFunc, hasColorVersions, isSpriteTransformed, spritePath, dynamicSpritePathFunc, isMemberOnly, attachItems, canRevertToDefault, shadowScaleX, shadowScaleY, snowball;
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
        function initializeAttributesFromString(features) {
            if (features != undefined) {
                var _local_2 = com.clubpenguin.util.JSONParser.parse(features);
                attributes.spriteScale = Number(_local_2.spriteScale);
                attributes.spriteSpeed = Number(_local_2.spriteSpeed);
                attributes.ignoresBlockLayer = Boolean(_local_2.ignoresBlockLayer);
                attributes.isInvisible = Boolean(_local_2.invisible);
                attributes.isFloating = Boolean(_local_2.floating);
            }
        }
        function clone() {
            var _local_2 = new com.clubpenguin.engine.avatar.model.AvatarVO();
            _local_2.avatar_id = avatar_id;
            _local_2.duration = duration;
            _local_2.speechBubbleOffsetY = speechBubbleOffsetY;
            _local_2.speechBubbleOffsetX = speechBubbleOffsetX;
            _local_2.nicknameOffsetY = nicknameOffsetY;
            _local_2.hasTransformEffect = hasTransformEffect;
            _local_2.defaultTransitionEffect = defaultTransitionEffect;
            _local_2.hasCustomPlayerCard = hasCustomPlayerCard;
            _local_2.customPlayerCardBackgroundID = customPlayerCardBackgroundID;
            _local_2.dynamicPlayerCardBackgroundFunc = dynamicPlayerCardBackgroundFunc;
            _local_2.dynamicPlayerCardLabelFunc = dynamicPlayerCardLabelFunc;
            _local_2.hasColorVersions = hasColorVersions;
            _local_2.isSpriteTransformed = isSpriteTransformed;
            _local_2.spritePath = spritePath;
            _local_2.dynamicSpritePathFunc = dynamicSpritePathFunc;
            _local_2.isMemberOnly = isMemberOnly;
            _local_2.attachItems = attachItems;
            _local_2.canRevertToDefault = canRevertToDefault;
            _local_2.shadowScaleX = shadowScaleX;
            _local_2.shadowScaleY = shadowScaleY;
            _local_2.effectTransitionsMap = {};
            for (var _local_3 in effectTransitionsMap) {
                _local_2.effectTransitionsMap[_local_3] = effectTransitionsMap[_local_3];
            }
            _local_2.snowball = snowball.clone();
            _local_2.attributes = attributes.clone();
            return(_local_2);
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "AvatarVO{";
            _local_2 = _local_2 + (" avatar_id: " + avatar_id);
            _local_2 = _local_2 + (", duration: " + duration);
            _local_2 = _local_2 + (", speechBubbleOffsetY: " + speechBubbleOffsetY);
            _local_2 = _local_2 + (", speechBubbleOffsetX: " + speechBubbleOffsetX);
            _local_2 = _local_2 + (", nicknameOffsetY: " + nicknameOffsetY);
            _local_2 = _local_2 + (", snowball: " + snowball.toString());
            _local_2 = _local_2 + (", hasTransformEffect: " + hasTransformEffect);
            _local_2 = _local_2 + (", defaultTransitionEffect: " + defaultTransitionEffect);
            _local_2 = _local_2 + (", effectTransitionsMap: " + effectTransitionsMapToString());
            _local_2 = _local_2 + (", hasCustomPlayerCard: " + hasCustomPlayerCard);
            _local_2 = _local_2 + (", customPlayerCardBackgroundID: " + customPlayerCardBackgroundID);
            _local_2 = _local_2 + (", dynamicPlayerCardBackgroundFunc: " + dynamicPlayerCardBackgroundFunc);
            _local_2 = _local_2 + (", hasColorVersions: " + hasColorVersions);
            _local_2 = _local_2 + (", isSpriteTransformed: " + isSpriteTransformed);
            _local_2 = _local_2 + (", spritePath: " + spritePath);
            _local_2 = _local_2 + (", isMemberOnly: " + isMemberOnly);
            _local_2 = _local_2 + (", attachItems: " + attachItems);
            _local_2 = _local_2 + (", canRevertToDefault: " + canRevertToDefault);
            _local_2 = _local_2 + (", attributes: " + attributes);
            _local_2 = _local_2 + "}";
            return(_local_2);
        }
        function effectTransitionsMapToString() {
            var _local_2 = "";
            _local_2 = _local_2 + "{";
            for (var _local_3 in effectTransitionsMap) {
                _local_2 = _local_2 + (((_local_3 + ":") + effectTransitionsMap[_local_3]) + " ");
            }
            _local_2 = _local_2 + "}";
            return(_local_2);
        }
    }
