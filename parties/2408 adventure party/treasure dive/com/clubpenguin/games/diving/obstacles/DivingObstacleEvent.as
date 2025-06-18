package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.DivingObstacle;
	import com.clubpenguin.lib.IDisposable;
	import flash.events.Event;

	public class DivingObstacleEvent extends Event implements IDisposable
	{
		public static const PLAYER_COLLIDE = "DIVING_OBSTACLE_PLAYER_COLLIDE";
		public static const PUFFLE_COLLIDE = "DIVING_OBSTACLE_PUFFLE_COLLIDE";
		
		private var __obstacle:DivingObstacle;
		
		public function DivingObstacleEvent(_type:String, _obstacle:DivingObstacle, _bubbles:Boolean=false, _cancelable:Boolean=false)
		{
			super(_type,_bubbles,_cancelable);
			
			this.__obstacle = _obstacle;
		}
		
		public function get obstacle():DivingObstacle
		{
			return this.__obstacle;
		}

		public override function clone():Event
		{
			return new DivingObstacleEvent(this.type, this.obstacle, this.bubbles, this.cancelable);
		}

		public override function toString():String
		{
			return this.formatToString("DivingObstacleEvent", "type", "__obstacle", "bubbles", "cancelable");
		}

		public function dispose():void
		{
			this.__obstacle = null;
		}
	}
}