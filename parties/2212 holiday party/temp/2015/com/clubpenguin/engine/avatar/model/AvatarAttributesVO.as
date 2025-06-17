class com.clubpenguin.engine.avatar.model.AvatarAttributesVO
{
   static var _defaultAttributes = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
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
      var _loc2_ = new com.clubpenguin.engine.avatar.model.AvatarAttributesVO();
      _loc2_.spriteAlpha = this.spriteAlpha;
      _loc2_.spriteScale = this.spriteScale;
      _loc2_.spriteSpeed = this.spriteSpeed;
      _loc2_.ignoresBlockLayer = this.ignoresBlockLayer;
      _loc2_.isInvisible = this.isInvisible;
      _loc2_.isFloating = this.isFloating;
      return _loc2_;
   }
   function toString()
   {
      var _loc2_ = "";
      _loc2_ += "AvatarAttributesVO{";
      _loc2_ += " spriteAlpha: " + this.spriteAlpha;
      _loc2_ += ", spriteScale: " + this.spriteScale;
      _loc2_ += ", spriteSpeed: " + this.spriteSpeed;
      _loc2_ += ", ignoresBlockLayer: " + this.ignoresBlockLayer;
      _loc2_ += ", isInvisible: " + this.isInvisible;
      _loc2_ += ", isFloating: " + this.isFloating;
      _loc2_ += "}";
      return _loc2_;
   }
}
