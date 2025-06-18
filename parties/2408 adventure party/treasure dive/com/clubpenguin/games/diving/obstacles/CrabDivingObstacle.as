package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.MovingDivingObstacle;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.clubpenguin.lib.util.math.MathUtil;
	import mx.utils.DelegateAS3;

	public class CrabDivingObstacle extends MovingDivingObstacle
	{
		private var __directionSwitchMin:Number;
		private var __directionSwitchMax:Number;
		
		public function CrabDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
			
			this.__directionSwitchMin = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "crabDirectionSwitchMin", 150);
			this.__directionSwitchMax = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "crabDirectionSwitchMax", 200);
			
			
			// We don't want to respawn at the spawner; instead, simply go the other way.
			this.recycleCallback = DelegateAS3.globalDelegate.create(this.pickNewDirection, [true]);
		}
		
		override public function postInit():void
		{
			// Make them go opposite directions based on their spawn order.
			this.pickNewDirection((this._spawner.obstacles.indexOf(this) + 1) % 2 == 0);
		}
		
		private function pickNewDirection(flipDirection:Boolean=false):void
		{
			if (flipDirection)
			{
				this.direction *= -1;
			}
			trace(flipDirection);
			
			this._despawnX = MathUtil.randomRange(this.__directionSwitchMin, this.__directionSwitchMax) * this._direction;
		}
		
		override protected function get conditionComparator():Number
		{
			// If far enough away from spawner, switch positions.
			return this.x - this._spawner.x;
		}
		
		override public function getUniqueName():String
		{
			return "CrabDivingObstacle";
		}
	}
}