dynamic class com.clubpenguin.engine.avatar.model.AvatarAttributesVO
{
    static var _defaultAttributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
    var ignoresBlockLayer;
    var isFloating;
    var isInvisible;
    var spriteAlpha;
    var spriteScale;
    var spriteSpeed;

    function AvatarAttributesVO()
    {
        this.spriteAlpha = 100;
        this.spriteScale = 100;
        this.spriteSpeed = 100;
        this.ignoresBlockLayer = false;
        this.isInvisible = false;
        this.isFloating = false;
    }

    function equalsDefault()
    {
        return this.equals(com.clubpenguin.engine.avatar.model.AvatarAttributesVO._defaultAttributes);
    }

    function equals(other)
    {
        return this.spriteAlpha == other.spriteAlpha && this.spriteScale == other.spriteScale && this.spriteSpeed == other.spriteSpeed && this.ignoresBlockLayer == other.ignoresBlockLayer && this.isInvisible == other.isInvisible && this.isFloating == other.isFloating;
    }

    function clone()
    {
        var __reg2 = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
        __reg2.spriteAlpha = this.spriteAlpha;
        __reg2.spriteScale = this.spriteScale;
        __reg2.spriteSpeed = this.spriteSpeed;
        __reg2.ignoresBlockLayer = this.ignoresBlockLayer;
        __reg2.isInvisible = this.isInvisible;
        __reg2.isFloating = this.isFloating;
        return __reg2;
    }

    function toString()
    {
        var __reg2 = "";
        __reg2 = __reg2 + "AvatarAttributesVO{";
        __reg2 = __reg2 + (" spriteAlpha: " + this.spriteAlpha);
        __reg2 = __reg2 + (", spriteScale: " + this.spriteScale);
        __reg2 = __reg2 + (", spriteSpeed: " + this.spriteSpeed);
        __reg2 = __reg2 + (", ignoresBlockLayer: " + this.ignoresBlockLayer);
        __reg2 = __reg2 + (", isInvisible: " + this.isInvisible);
        __reg2 = __reg2 + (", isFloating: " + this.isFloating);
        __reg2 = __reg2 + "}";
        return __reg2;
    }

}
