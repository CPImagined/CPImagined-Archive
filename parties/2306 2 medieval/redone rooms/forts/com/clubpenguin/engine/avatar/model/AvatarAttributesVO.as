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
            var _local_2 = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
            _local_2.spriteAlpha = spriteAlpha;
            _local_2.spriteScale = spriteScale;
            _local_2.spriteSpeed = spriteSpeed;
            _local_2.ignoresBlockLayer = ignoresBlockLayer;
            _local_2.isInvisible = isInvisible;
            _local_2.isFloating = isFloating;
            return(_local_2);
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "AvatarAttributesVO{";
            _local_2 = _local_2 + (" spriteAlpha: " + spriteAlpha);
            _local_2 = _local_2 + (", spriteScale: " + spriteScale);
            _local_2 = _local_2 + (", spriteSpeed: " + spriteSpeed);
            _local_2 = _local_2 + (", ignoresBlockLayer: " + ignoresBlockLayer);
            _local_2 = _local_2 + (", isInvisible: " + isInvisible);
            _local_2 = _local_2 + (", isFloating: " + isFloating);
            _local_2 = _local_2 + "}";
            return(_local_2);
        }
        static var _defaultAttributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
    }
