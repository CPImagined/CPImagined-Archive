class com.clubpenguin.engine.projectiles.vo.SnowballVO
{
   function SnowballVO(type, maxHeightOffset, wait, duration, showAnimation, alpha, scale)
   {
      this._type = type;
      this._maxHeightOffset = maxHeightOffset;
      this._wait = wait;
      this._duration = duration == undefined ? -1 : duration;
      this._showAnimation = showAnimation == undefined ? true : showAnimation;
      this._alpha = alpha == undefined ? 100 : alpha;
      this._scale = scale == undefined ? 100 : scale;
   }
   function set type(snowballType)
   {
      this._type = snowballType;
   }
   function get type()
   {
      return this._type;
   }
   function get maxHeightOffset()
   {
      return this._maxHeightOffset;
   }
   function get wait()
   {
      return this._wait;
   }
   function get duration()
   {
      return this._duration;
   }
   function get showAnimation()
   {
      return this._showAnimation;
   }
   function get alpha()
   {
      return this._alpha;
   }
   function get scale()
   {
      return this._scale;
   }
   function clone()
   {
      return new com.clubpenguin.engine.projectiles.vo.SnowballVO(this._type,this._maxHeightOffset,this._wait,this._duration,this._showAnimation,this._alpha,this._scale);
   }
   function toString()
   {
      return "[" + this._type + "|" + this._maxHeightOffset + "|" + this._wait + "|" + this._duration + "|" + this._showAnimation + "|" + this._alpha + "|" + this._scale + "]";
   }
}
