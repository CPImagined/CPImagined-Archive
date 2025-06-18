//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.model.AvatarVO
    {
        var effectTransitionsMap, defaultTransitionEffect, attributes, avatar_id, duration, speechBubbleOffsetY, speechBubbleOffsetX, nicknameOffsetY, hasTransformEffect, defaultRevertEffect, hasCustomPlayerCard, customPlayerCardBackgroundID, dynamicPlayerCardBackgroundFunc, dynamicPlayerCardLabelFunc, hasColorVersions, isSpriteTransformed, spritePath, dynamicSpritePathFunc, isMemberOnly, attachItems, canRevertToDefault, revertSoundEffectSymbol, shadowScaleX, shadowScaleY, snowball;
        function AvatarVO () {
            effectTransitionsMap = {};
        }
        function setEffectTransition(avatarId, effect) {
            effectTransitionsMap[avatarId] = ((effect != null) ? (effect) : (com.clubpenguin.engine.avatar.effect.AvatarEffectEnum.NO_EFFECT));
        }
        function getEffectTransition(avatarId) {
            var effect = effectTransitionsMap[avatarId];
            if (effect != null) {
                return(effect);
            } else {
                return(defaultTransitionEffect);
            }
        }
        function clearEffectTransitions() {
            effectTransitionsMap = {};
        }
        function initializeAttributesFromString(features) {
            if (features != undefined) {
                try {
                    var newFeatures = com.clubpenguin.util.JSONParser.parse(features);
                    attributes.spriteScale = Number(newFeatures.spriteScale);
                    attributes.spriteSpeed = Number(newFeatures.spriteSpeed);
                    attributes.ignoresBlockLayer = Boolean(newFeatures.ignoresBlockLayer);
                    attributes.isInvisible = Boolean(newFeatures.invisible);
                    attributes.isFloating = Boolean(newFeatures.floating);
                } catch(ex) {
                }
            }
        }
        function clone() {
            var copy = (new com.clubpenguin.engine.avatar.model.AvatarVO());
            copy.avatar_id = avatar_id;
            copy.duration = duration;
            copy.speechBubbleOffsetY = speechBubbleOffsetY;
            copy.speechBubbleOffsetX = speechBubbleOffsetX;
            copy.nicknameOffsetY = nicknameOffsetY;
            copy.hasTransformEffect = hasTransformEffect;
            copy.defaultTransitionEffect = defaultTransitionEffect;
            copy.defaultRevertEffect = defaultRevertEffect;
            copy.hasCustomPlayerCard = hasCustomPlayerCard;
            copy.customPlayerCardBackgroundID = customPlayerCardBackgroundID;
            copy.dynamicPlayerCardBackgroundFunc = dynamicPlayerCardBackgroundFunc;
            copy.dynamicPlayerCardLabelFunc = dynamicPlayerCardLabelFunc;
            copy.hasColorVersions = hasColorVersions;
            copy.isSpriteTransformed = isSpriteTransformed;
            copy.spritePath = spritePath;
            copy.dynamicSpritePathFunc = dynamicSpritePathFunc;
            copy.isMemberOnly = isMemberOnly;
            copy.attachItems = attachItems;
            copy.canRevertToDefault = canRevertToDefault;
            copy.revertSoundEffectSymbol = revertSoundEffectSymbol;
            copy.shadowScaleX = shadowScaleX;
            copy.shadowScaleY = shadowScaleY;
            copy.effectTransitionsMap = {};
            for (var avatarId in effectTransitionsMap) {
                copy.effectTransitionsMap[avatarId] = effectTransitionsMap[avatarId];
            }
            copy.snowball = snowball.clone();
            copy.attributes = attributes.clone();
            return(copy);
        }
        function toString() {
            var out = "";
            out = out + "AvatarVO{";
            out = out + (" avatar_id: " + avatar_id);
            out = out + (", duration: " + duration);
            out = out + (", speechBubbleOffsetY: " + speechBubbleOffsetY);
            out = out + (", speechBubbleOffsetX: " + speechBubbleOffsetX);
            out = out + (", nicknameOffsetY: " + nicknameOffsetY);
            out = out + (", snowball: " + snowball.toString());
            out = out + (", hasTransformEffect: " + hasTransformEffect);
            out = out + (", defaultTransitionEffect: " + defaultTransitionEffect);
            out = out + (", defaultRevertEffect: " + defaultRevertEffect);
            out = out + (", effectTransitionsMap: " + effectTransitionsMapToString());
            out = out + (", hasCustomPlayerCard: " + hasCustomPlayerCard);
            out = out + (", customPlayerCardBackgroundID: " + customPlayerCardBackgroundID);
            out = out + (", dynamicPlayerCardBackgroundFunc: " + dynamicPlayerCardBackgroundFunc);
            out = out + (", hasColorVersions: " + hasColorVersions);
            out = out + (", isSpriteTransformed: " + isSpriteTransformed);
            out = out + (", spritePath: " + spritePath);
            out = out + (", isMemberOnly: " + isMemberOnly);
            out = out + (", attachItems: " + attachItems);
            out = out + (", canRevertToDefault: " + canRevertToDefault);
            out = out + (", revertSoundEffectSymbol: " + revertSoundEffectSymbol);
            out = out + (", shadowScaleX: " + shadowScaleX);
            out = out + (", shadowScaleY: " + shadowScaleY);
            out = out + (", attributes: " + attributes);
            out = out + "}";
            return(out);
        }
        function effectTransitionsMapToString() {
            var out = "";
            out = out + "{";
            for (var key in effectTransitionsMap) {
                out = out + (((key + ":") + effectTransitionsMap[key]) + " ");
            }
            out = out + "}";
            return(out);
        }
    }
