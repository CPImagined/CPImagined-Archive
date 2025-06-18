package com.clubpenguin.games.camera
{
	import com.clubpenguin.lib.IDisposable;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.clubpenguin.games.engine.GameEngine;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.Sprite;

	public class Camera implements IDisposable
	{
		private var _target:DisplayObject = null;
		private var _targetPos:Point = null;
		private var _targetOffset:Point = null;

		private var _parent:DisplayObject = null;

		private var _pos:Point = null;

		private var _viewWidth:Number = 760;
		private var _viewHeight:Number = 480;

		private var _boundsRect:Rectangle = null;
		private var __boundsRectDraw:Sprite = null;

		private var _zoom:Number = 1;
		private var _scrollRate:Number = 0.5;

		private var _lockInPlace:Boolean = false;

		public function Camera()
		{
			this._pos = new Point();

			super();
		}

		public function get target():DisplayObject
		{
			return this._target;
		}

		public function get targetPos():Point
		{
			return this._targetPos;
		}

		public function get targetOffset():Point
		{
			return this._targetOffset;
		}

		public function get parent():DisplayObject
		{
			return this._parent;
		}

		public function get pos():Point
		{
			return this._pos.clone();
		}

		public function get viewWidth():Number
		{
			return this._viewWidth;
		}

		public function get viewHeight():Number
		{
			return this._viewHeight;
		}

		public function get boundsRect():Rectangle
		{
			return this._boundsRect;
		}

		public function get zoom():Number
		{
			return this._zoom;
		}
		
		public function get scrollRate():Number
		{
			return this._scrollRate;
		}

		public function get lockInPlace():Boolean
		{
			return this._lockInPlace;
		}
		

		public function set target($target:DisplayObject):void
		{
			this._target = $target;
		}
		
		public function set targetPos($pos:Point):void
		{
			this._targetPos = $pos;
		}

		public function set targetOffset($offset:Point):void
		{
			this._targetOffset = $offset;
		}

		public function set parent($parent:DisplayObject):void
		{
			this._parent = $parent;
		}

		public function set viewWidth($width:Number):void
		{
			this._viewWidth = $width;
		}

		public function set viewHeight($height:Number):void
		{
			this._viewHeight = $height;
		}

		public function set boundsRect(rect:Rectangle):void
		{
			if (!rect)
			{
				this._boundsRect = null;
				return;
			}

			this._boundsRect = rect.clone();
			
			if (GameEngine.instance.isDebugMode() && XMLUtil.getStringFromConfig(GameEngine.instance.gameConfig, "camBoundsDebug","").length != 0)
			{
				GameEngine.instance.setupDebugDraw();
				
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
				this.__boundsRectDraw.graphics.drawRect(this._boundsRect.x, this._boundsRect.y, this._boundsRect.width, this._boundsRect.height);
				this.__boundsRectDraw.graphics.endFill();
			}
		}

		public function set zoom($zoom:Number):void
		{
			if ($zoom <= 0)
			{
				return;
			}

			this._zoom = $zoom;
		}
		
		public function set scrollRate(rate:Number):void
		{
			if (rate <= 0)
			{
				return;
			}

			this._scrollRate = rate;
		}

		public function set lockInPlace(lock:Boolean):void
		{
			this._lockInPlace = lock;
		}

		public function dispose():void
		{
			this._target = null;
			this._targetPos = null;
			this._targetOffset = null;
			
			if (this.__boundsRectDraw != null)
			{
				this.__boundsRectDraw.parent.removeChild(this.__boundsRectDraw);
				this.__boundsRectDraw = null;
			}
			
			this._parent = null;

			this._pos = null;

			this._boundsRect = null;
		}

		public function jumpToTargetPos():void
		{
			this.update(true);
		}

		public function update(forceUpdate:Boolean = false):void
		{
			if (this._lockInPlace && !forceUpdate)
			{
				return;
			}

			var widthOffset = 0.5 * this._viewWidth / this._zoom;
			var heightOffset = 0.5 * this._viewHeight / this._zoom;
			
			var newPos: Point;

			if (this._target)
			{
				newPos = new Point(this._target.x, this._target.y);
			}
			else
			{
				newPos = this._targetPos.clone();
			}
			
			if (newPos)
			{
				if (this._targetOffset)
				{
					newPos = newPos.add(this._targetOffset);
				}
				
				if (this._boundsRect)
				{
					var leftBound = this._boundsRect.left + widthOffset;
					var rightBound = this._boundsRect.right - widthOffset;
					var topBound = this._boundsRect.top + heightOffset;
					var bottomBound = this._boundsRect.bottom - heightOffset;
	
					if (newPos.x < leftBound)
					{
						newPos.x = leftBound;
					}
					else if (newPos.x > rightBound)
					{
						newPos.x = rightBound;
					}
	
					if (newPos.y < topBound)
					{
						newPos.y = topBound;
					}
					else if (newPos.y > bottomBound)
					{
						newPos.y = bottomBound;
					}
				}
				
				if (forceUpdate || Math.sqrt(newPos.subtract(this._pos).length) > this._scrollRate)
				{
					this._pos = newPos;
	
					var viewPos = this._pos.clone();
					viewPos.x -= widthOffset;
					viewPos.y -= heightOffset;
					viewPos.x *= -1;
					viewPos.y *= -1;
	
					this._parent.x = viewPos.x * this._zoom;
					this._parent.y = viewPos.y * this._zoom;
					this._parent.scaleX = this._zoom;
					this._parent.scaleY = this._zoom;
				}
			}
		}
	}
}