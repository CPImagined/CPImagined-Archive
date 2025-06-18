//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.avatar.model.AvatarAttributesVO
    {
        var spriteAlpha, spriteScale, spriteSpeed, ignoresBlockLayer, isInvisible, isFloating;
        function AvatarAttributesVO () {
            spriteAlpha = 100;
            spriteScale = 100;
            spriteSpeed = 100;
            ignoresBlockLayer = false;
            isInvisible = false;
            isFloating = false;
        }
        function equalsDefault() {
            return(equals(_defaultAttributes));
        }
        function equals(other) {
            return((((((spriteAlpha == other.spriteAlpha) && (spriteScale == other.spriteScale)) && (spriteSpeed == other.spriteSpeed)) && (ignoresBlockLayer == other.ignoresBlockLayer)) && (isInvisible == other.isInvisible)) && (isFloating == other.isFloating));
        }
        function clone() {
            var copy = (new com.clubpenguin.engine.avatar.model.AvatarAttributesVO());
            copy.spriteAlpha = spriteAlpha;
            copy.spriteScale = spriteScale;
            copy.spriteSpeed = spriteSpeed;
            copy.ignoresBlockLayer = ignoresBlockLayer;
            copy.isInvisible = isInvisible;
            copy.isFloating = isFloating;
            return(copy);
        }
        function toString() {
            var out = "";
            out = out + "AvatarAttributesVO{";
            out = out + (" spriteAlpha: " + spriteAlpha);
            out = out + (", spriteScale: " + spriteScale);
            out = out + (", spriteSpeed: " + spriteSpeed);
            out = out + (", ignoresBlockLayer: " + ignoresBlockLayer);
            out = out + (", isInvisible: " + isInvisible);
            out = out + (", isFloating: " + isFloating);
            out = out + "}";
            return(out);
        }
        static var _defaultAttributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
    }
