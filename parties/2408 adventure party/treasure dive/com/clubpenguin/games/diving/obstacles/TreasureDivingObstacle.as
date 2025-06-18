package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.obstacles.DivingObstacle;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.clubpenguin.lib.util.math.MathUtil;
	import flash.geom.Point;

	public class TreasureDivingObstacle extends DivingObstacle
	{
		private static var $_instanceCount:int = -1;

		public var uid:int;
		
		private var __fallRate:Number;
		private var __shouldFall:Boolean = true;
		private var __grabbable:Boolean = true;
		
		private var __score:uint = 0;
		private var __bigScore:uint = 0;
		
		public function TreasureDivingObstacle($spawner:DivingObstacleSpawner)
		{
			super($spawner);
			
			this.uid = ++$_instanceCount;
			
			this.__score = XMLUtil.getIntFromConfig(this._engine.gameConfig, "treasureScore", 50);
			this.__bigScore = XMLUtil.getIntFromConfig(this._engine.gameConfig, "bigTreasureScore", 150);
			
			this.__fallRate = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "treasureChestFallRate", 5);
			this.visible = true;
			
			this.chest.addFrameScript(77, this.spawnBubbles);
			
			this.stop();
		}
		
		private function spawnBubbles():void
		{
			// Don't spawn bubbles if invisible
			if (this._engine != null && this.visible)
			{
				this._engine.objManager.getObj("bubbleMgr").addOrMoveBubbles(this.parent, new Point(this.x, this.y - 50), "treasureBubbles-" + this.uid);
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (this._player.chest != null && this._player.chest.uid == this.uid)
			{
				this.x = this._player.x;
				this.y = this._player.y;
				this.visible = false;
			}
			else if (this.__shouldFall && this.y != this._spawner.y)
			{
				// Fall down but not below the spawner so we don't fall out.
				this.y = Math.min(this.y + this.__fallRate, this._spawner.y);
				
				this.visible = true;
				
				// Only play once it hits the ground.
				if (this.y == this._spawner.y)
				{
					// Pan sound based on position.
					this._engine.soundManager.changePan("chest_thump", this.x / 1000);
					this._engine.soundManager.play("chest_thump");
				}
			}
		}
		
		public function set shouldFall($shouldFall:Boolean):void
		{
			this.__shouldFall = $shouldFall;
		}
		
		public function set grabbable($grabbable:Boolean):void
		{
			this.__grabbable = $grabbable;
		}
		
		public function respawn():void
		{
			if (this.currentFrame == 2)
			{
				this._engine.addScore(this.__bigScore);
				
				// Type 2 doesn't respawn.
				this.despawn();
			}
			else
			{
				this._engine.addScore(this.__score);
				
				this.x = this._spawner.x;
				this.y = this._spawner.y;
				this.visible = true;
			}
		}
		
		override public function playerHitMe():void
		{
			// Always allow grabbing a type 2 chest.
			if (this.__grabbable && (this._player.chest == null || (this.currentFrame == 2 && this._player.chest != this)))
			{
				// Stick to player if we don't have a chest.
				this._player.chest = this;
				
				// Pan sound based on position.
				this._engine.soundManager.changePan("chest_grab", this.x / 1000);
				this._engine.soundManager.playIfNotPlaying("chest_grab");
			}
		}
		
		override public function getUniqueName():String
		{
			return "TreasureDivingObstacle";
		}
	}
}