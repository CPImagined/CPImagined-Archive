package com.clubpenguin.games.camera
{
	import com.disney.lib.IDisposable;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.clubpenguin.games.engine.GameEngine;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Sprite;

	public class Camera implements IDisposable
	{
		private var __target:DisplayObject = null;
		private var __targetPos:Point = null;
		private var __targetOffset:Point = null;

		private var __parent:DisplayObject = null;

		private var __pos:Point = null;

		private var __viewWidth:Number = 760;
		private var __viewHeight:Number = 480;

		private var __boundsRect:Rectangle = null;
		private var __boundsRectDraw:Sprite = null;

		private var __zoom:Number = 1;
		
		private var __scrollFallOff:Number = 1;

		private var __lockInPlace:Boolean = false;
		
		private var __loopVertically:Boolean = false;
		private var __loopHorizontally:Boolean = false;

		public function Camera()
		{
			this.__pos = new Point();

			super();
		}

		public function get target():DisplayObject
		{
			return this.__target;
		}

		public function get targetPos():Point
		{
			return this.__targetPos;
		}

		public function get targetOffset():Point
		{
			return this.__targetOffset;
		}

		public function get parent():DisplayObject
		{
			return this.__parent;
		}

		public function get pos():Point
		{
			return this.__pos.clone();
		}

		public function get viewWidth():Number
		{
			return this.__viewWidth;
		}

		public function get viewHeight():Number
		{
			return this.__viewHeight;
		}

		public function get boundsRect():Rectangle
		{
			return this.__boundsRect;
		}

		public function get zoom():Number
		{
			return this.__zoom;
		}

		public function get lockInPlace():Boolean
		{
			return this.__lockInPlace;
		}

		public function set target($target:DisplayObject):void
		{
			this.__target = $target;
		}
		
		public function set targetPos($pos:Point):void
		{
			this.__targetPos = $pos;
		}

		public function set targetOffset($offset:Point):void
		{
			this.__targetOffset = $offset;
		}

		public function set parent($parent:DisplayObject):void
		{
			this.__parent = $parent;
		}

		public function set viewWidth($width:Number):void
		{
			this.__viewWidth = $width;
		}

		public function set viewHeight($height:Number):void
		{
			this.__viewHeight = $height;
		}
		
		public function set loopVertically($loop:Boolean):void
		{
			this.__loopVertically = $loop;
		}
		
		public function set loopHorizontally($loop:Boolean):void
		{
			this.__loopHorizontally = $loop;
		}

		public function set boundsRect(rect:Rectangle):void
		{
			if (!rect)
			{
				this.__boundsRect = null;
				return;
			}

			this.__boundsRect = rect.clone();
			
			if (GameEngine.instance.isDebugMode() && XMLUtil.getStringFromConfig(GameEngine.instance.gameConfig, "camBoundsDebug","").length != 0 && GameEngine.instance.debugDraw != null)
			{
				// Create a child so we can clear graphics on it.
				if (this.__boundsRectDraw == null)
				{
					this.__boundsRectDraw = new Sprite();
					this.__boundsRectDraw.mouseEnabled = false;
					GameEngine.instance.debugDraw.addChild(this.__boundsRectDraw);
				}
				else
				{
					this.__boundsRectDraw.graphics.clear();
				}
				
				this.__boundsRectDraw.graphics.beginFill(0x000000, 0.25);
				this.__boundsRectDraw.graphics.drawRect(this.__boundsRect.x, this.__boundsRect.y, this.__boundsRect.width, this.__boundsRect.height);
				this.__boundsRectDraw.graphics.endFill();
			}
		}

		public function set zoom($zoom:Number):void
		{
			if ($zoom <= 0)
			{
				return;
			}

			this.__zoom = $zoom;
		}
		
		public function set scrollFallOff($fallOff:Number):void
		{
			if ($fallOff < 1)
			{
				return;
			}
			
			this.__scrollFallOff = $fallOff;
		}

		public function set lockInPlace(lock:Boolean):void
		{
			this.__lockInPlace = lock;
		}

		public function dispose():void
		{
			this.__target = null;
			this.__targetPos = null;
			this.__targetOffset = null;
			
			if (this.__boundsRectDraw != null)
			{
				this.__boundsRectDraw.parent.removeChild(this.__boundsRectDraw);
				this.__boundsRectDraw = null;
			}
			
			this.__parent = null;

			this.__pos = null;

			this.__boundsRect = null;
		}

		public function jumpToTargetPos():void
		{
			this.update(true);
		}

		public function update(forceUpdate:Boolean = false):void
		{
			if (this.__lockInPlace && !forceUpdate)
			{
				return;
			}

			var widthOffset = 0.5 * this.__viewWidth / this.__zoom;
			var heightOffset = 0.5 * this.__viewHeight / this.__zoom;
			
			var newPos: Point;

			if (this.__target)
			{
				newPos = new Point(this.__target.x, this.__target.y);
			}
			else
			{
				newPos = this.__targetPos.clone();
			}
			
			if (newPos)
			{
				if (this.__targetOffset)
				{
					newPos = newPos.add(this.__targetOffset);
				}
				
				if (this.__boundsRect)
				{
					var leftBound = this.__boundsRect.left + widthOffset;
					var rightBound = this.__boundsRect.right - widthOffset;
					
					if (this.__loopHorizontally)
					{
						if (newPos.x < leftBound)
						{
							newPos.x = rightBound;
						}
						else if (newPos.x > rightBound)
						{
							newPos.x = leftBound;
						}
					}
					else
					{
						if (newPos.x < leftBound)
						{
							newPos.x = leftBound;
						}
						else if (newPos.x > rightBound)
						{
							newPos.x = rightBound;
						}
					}
					
					var topBound = this.__boundsRect.top + heightOffset;
					var bottomBound = this.__boundsRect.bottom - heightOffset;
					
					if (this.__loopVertically)
					{
						if (newPos.y < topBound)
						{
							newPos.y = bottomBound;
						}
						else if (newPos.y > bottomBound)
						{
							newPos.y = topBound;
						}
					}
					else
					{
						if (newPos.y < topBound)
						{
							newPos.y = topBound;
						}
						else if (newPos.y > bottomBound)
						{
							newPos.y = bottomBound;
						}
					}
				}
				
				var compareOffset = Math.sqrt(newPos.subtract(this.__pos).length);
				
				if (this.__scrollFallOff)
				{
					compareOffset *= this.__scrollFallOff;
				}
				
				if (forceUpdate || compareOffset > 0.1)
				{
					this.__pos = newPos;
	
					var viewPos = this.__pos.clone();
					viewPos.x -= widthOffset;
					viewPos.y -= heightOffset;
					viewPos.x *= -1;
					viewPos.y *= -1;
	
					this.__parent.x = viewPos.x * this.__zoom;
					this.__parent.y = viewPos.y * this.__zoom;
					this.__parent.scaleX = this.__zoom;
					this.__parent.scaleY = this.__zoom;
				}
			}
		}
	}
}