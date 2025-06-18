package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.MovingDivingObstacle;

	public class SharkDivingObstacle extends MovingDivingObstacle
	{
		public function SharkDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
		}
		
		override public function getUniqueName():String
		{
			return "SharkDivingObstacle";
		}
	}
}