package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.MovingDivingObstacle;

	public class MulletDivingObstacle extends MovingDivingObstacle
	{
		public function MulletDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
		}
		
		override public function getUniqueName():String
		{
			return "MulletDivingObstacle";
		}
	}
}