package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.Player;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleEvent;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleSpawner;
	import com.clubpenguin.games.object.GameObject;
	import com.disney.lib.IUniquelyNamable;

	public class DivingObstacle extends GameObject
	{
		protected var _player:Player;
		
		protected var _spawner:DivingObstacleSpawner;
		
		protected var _testForPlayer:Boolean = true;
		
		public function DivingObstacle($spawner:DivingObstacleSpawner)
		{
			super();
			
			this._spawner = $spawner;
			
			this._player = this._engine.objManager.getObj("player");
		}
		
		public function postInit():void
		{
			// Override to do stuff after being positioned.
		}
		
		override public function update():void
		{
			if (this._testForPlayer && this.collTestObj.hitTestObject(this._player.collTestObj))
			{
				this._player.dispatchEvent(new DivingObstacleEvent(DivingObstacleEvent.PLAYER_COLLIDE, this));
			}
			else if (this._engine.hasBrownPuffle)
			{
				var puffle = this._engine.objManager.getObj("puffle");
			
				if (this.collTestObj.hitTestObject(puffle.collTestObj))
				{
					puffle.dispatchEvent(new DivingObstacleEvent(DivingObstacleEvent.PUFFLE_COLLIDE, this));
				}
			}
		}
		
		public function despawn():void
		{
			this._spawner.removeObstacle(this);
			
			this.dispose();
		}
		
		public function get obstacleType():uint
		{
			return this._spawner.obstacleType;
		}
		
		public function set testForPlayer(test:Boolean):void
		{
			this._testForPlayer = test;
		}
		
		public function playerHitMe():void
		{
			this._player.hitStun();
		}
		
		override public function getUniqueName():String
		{
			return "DivingObstacle";
		}
		
		override public function dispose():void
		{
			this._spawner = null;
			
			this._player = null;
			
			super.dispose();
		}
	}
}