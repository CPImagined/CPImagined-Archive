package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.DivingObstacle;

	public class TreasureReturnDivingObstacle extends DivingObstacle
	{
		public function TreasureReturnDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
		}
		
		override public function playerHitMe():void
		{
			// Return a chest if we get here while holding one.
			if (this._player.chest != null)
			{
				trace("Cha ching! Collected a treasure!");
				
				this._engine.soundManager.playIfNotPlaying("treasure_return");
				
				/*
				This is to safeguard against adding score twice
				for the same chest.
				*/
				
				var chest = this._player.chest;
				
				this._player.chest = null;
				
				chest.respawn();
			}
		}
		
		override public function getUniqueName():String
		{
			return "TreasureReturnDivingObstacle";
		}
	}
}