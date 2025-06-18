package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.MovingDivingObstacle;

	public class FluffyDivingObstacle extends MovingDivingObstacle
	{
		public function FluffyDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
		}
		
		override public function getUniqueName():String
		{
			return "FluffyDivingObstacle";
		}
	}
}