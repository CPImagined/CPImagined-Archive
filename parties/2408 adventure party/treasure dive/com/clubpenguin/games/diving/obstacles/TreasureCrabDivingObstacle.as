package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.MovingDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleTypes;
	import mx.utils.DelegateAS3;
	
	public class TreasureCrabDivingObstacle extends MovingDivingObstacle
	{
		private var __chest: TreasureDivingObstacle;
		private var __hasChest:Boolean = true;
		
		public function TreasureCrabDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
			
			// This guy actually disappears upon reaching the edge.
			this.recycleCallback = DelegateAS3.globalDelegate.create(this.despawn);
			
			this.__chest = $spawner.addObstacle(DivingObstacleTypes.DIVING_OBSTACLE_TREASURE, true) as TreasureDivingObstacle;
			
			// Don't fall down while we're holding it.
			this.__chest.shouldFall = false;
			
			/*
			Don't allow grabbing the chest directly
			until this crab no longer has it.
			*/
			this.__chest.grabbable = false;
			
			// Use the alternate chest here.
			this.__chest.gotoAndStop(2);
			
			// Stop additional crabs from spawning from this spawner.
			$spawner.continueSpawning = false;
			
			this.stop();
		}
		
		override public function postInit():void
		{
			this.panSound();
			
			this._engine.soundManager.playIfNotPlaying("crab_push_chest", true);
		}
		
		private function panSound():void
		{
			// Pan sound based on position.
			this._engine.soundManager.changePan("crab_push_chest", this.x / 1000);
		}
		
		override public function playerHitMe():void
		{
			if (this.__hasChest)
			{
				// Grab the chest we're holding.
				this.__hasChest = false;
				
				// Change the animation.
				this.gotoAndStop(2);
				
				// Up the speed slightly.
				this.moveRate = this.moveRate * 1.25;
				
				// Stop the pushing sound.
				this._engine.soundManager.stop("crab_push_chest");
				
				// Now we can safely grab it.
				this.__chest.grabbable = true;
				
				this.__chest.playerHitMe();
				
				this.__chest.shouldFall = true;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.__hasChest)
			{
				this.panSound();
				
				// Bring the chest along with us.
				
				// Position it slightly in front of me.
				this.__chest.x = this.x + 150;
				
				// Bring it down slightly.
				this.__chest.y = this.y + 35;
			}
		}
		
		override public function despawn():void
		{
			// Don't remove the chest if the player has grabbed it at least once.
			if (this.__hasChest)
			{
				if (this.__chest != null)
				{
					/*
					Safeguard against chest being returned before we're gone.
					I don't think this should ever happen but just in case.
					*/
					this._spawner.removeObstacle(this.__chest);
					this.__chest.dispose();
				}
				
				// Safeguard against race conditions.
				this.__hasChest = false;
			}
			this.__chest = null;
			
			this._engine.soundManager.stop("crab_push_chest");
			
			super.despawn();
		}
		
		override public function getUniqueName():String
		{
			return "TreasureCrabDivingObstacle";
		}
	}
}