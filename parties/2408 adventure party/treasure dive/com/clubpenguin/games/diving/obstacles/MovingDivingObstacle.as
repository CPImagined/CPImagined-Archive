package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.DivingObstacle;
	import com.clubpenguin.lib.util.xml.XMLUtil;

	public class MovingDivingObstacle extends DivingObstacle
	{
		private var __moveRate:Number;
		protected var _direction:int = 0;
		
		private var __recycleCallback:Function;
		
		protected var _despawnX:Number;
		
		public function MovingDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
			
			this._despawnX = this._spawner.x * -1;
			
			// Allow customization for cases like bigger fish moving slower.
			this.__moveRate = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "moveRate-" + this.getUniqueName(), 15);
		}
		
		public function set moveRate($moveRate:Number):void
		{
			// Used by the puffle.
			this.__moveRate = $moveRate;
		}
		
		public function get moveRate():Number
		{
			return(this.__moveRate);
		}
		
		public function get despawnX():Number
		{
			return this._despawnX;
		}
		
		public function get spawnX():Number
		{
			if (this._spawner != null)
			{
				return this._spawner.x;
			}
			return 0;
		}
		
		public function set direction(dir:int):void
		{
			this._direction = dir;
			
			// Make these appear to face the right way.
			this.scaleX = this._direction;
		}
		
		public function get direction():int
		{
			return this._direction;
		}
		
		override public function getUniqueName():String
		{
			return "MovingDivingObstacle";
		}
		
		public function set recycleCallback(callback:Function):void
		{
			this.__recycleCallback = callback;
		}
		
		protected function get conditionComparator():Number
		{
			// Subclasses may want to redefine this.
			return this.x;
		}
		
		override public function update():void
		{
			super.update();
			
			// We will consider 0 invalid.
			if (this._direction != 0)
			{
				this.x += this.__moveRate * this._direction;
				
				// Choose the right one.
				var condition;
				if (this._direction == 1)
				{
					condition = this.conditionComparator >= this._despawnX;
				}
				else
				{
					condition = this.conditionComparator <= this._despawnX;
				}
			
				if (condition)
				{
					if (this.__recycleCallback != null)
					{
						this.__recycleCallback();
					}
					else
					{
						// Default recycle action is to go back to the spawner.
						this.x = this._spawner.x;
					}
				}
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			this.__recycleCallback = null;
		}
	}
}