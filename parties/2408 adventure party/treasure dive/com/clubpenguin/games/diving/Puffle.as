package com.clubpenguin.games.diving
{
	import com.clubpenguin.games.object.GameObject;
	import com.clubpenguin.games.diving.Player;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleEvent;
	import com.clubpenguin.games.diving.obstacles.MovingDivingObstacle;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleTypes;
	import com.clubpenguin.lib.util.math.MathUtil;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import mx.utils.DelegateAS3;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Puffle extends GameObject
	{
		public static const STATE_IDLE:uint = 0;
		public static const STATE_ATTACK:uint = 1;
		
		public var sub:MovieClip;
		
		public var radar_bounds:MovieClip;
		
		private var __player:Player;
		
		private var __fishTarget:MovingDivingObstacle;
		
		private var __fishAwareOf:Array;
		
		// Uninitialized state
		private var __state:uint = 10;
		
		private var __movementSpeed:Number;
		private var __velocity:Point;
		private var __velocityZeroThreshold:Number;
		private var __puffleXOffset:Number;
		private var __puffleYOffset:Number;
		private var __fishZoomAwaySpeed:Number;
		
		private var __attackOnCooldown:Boolean = false;
		private var __attackCooldownTimer:Timer;
		
		private var __bounceBack:Number;
		
		public function Puffle()
		{
			super();
			
			this.__player = this._engine.objManager.getObj("player");
			
			this.__movementSpeed = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "puffleMovementSpeed", 5.0);
			this.__fishZoomAwaySpeed = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "puffleFishZoomAwaySpeed", 15);
			this.__velocityZeroThreshold = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "velocityZeroThreshold", 0.0);
			
			this.__bounceBack = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "boundsBounceBack", 5.0);
			
			var puffleOffset = XMLUtil.getArrayFromConfig(this._engine.gameConfig, "puffleOffset", [0, 0]);
			this.__puffleXOffset = puffleOffset[0];
			this.__puffleYOffset = puffleOffset[1];
			
			this.__fishAwareOf = new Array();
			
			this.__attackCooldownTimer = new Timer(1000, XMLUtil.getIntFromConfig(this._engine.gameConfig, "puffleAttackCooldownCycles", 1));
			this.__attackCooldownTimer.addEventListener(TimerEvent.TIMER, this.chargeUp);
			this.__attackCooldownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cooldownDone);
			
			this.addEventListener(DivingObstacleEvent.PUFFLE_COLLIDE, this.collideHandler);
			
			// Choose an initial direction.
			this.doChangeDirection();
			
			this.setState(STATE_IDLE);
			
			this.sub.energy_indicator.gotoAndStop(XMLUtil.getIntFromConfig(this._engine.gameConfig, "puffleAttackCooldownCycles", 1) + 1);
		}
		
		public function reset():void
		{
			var startPos = XMLUtil.getArrayFromConfig(this._engine.gameConfig, "startPos", [0, 0, 0]);
			this.x = startPos[0] + this.__puffleXOffset;
			this.y = startPos[1] + this.__puffleYOffset;
		}
		
		private function doChangeDirection(angle:Number=1000):void
		{
			if (angle == 1000)
			{
				// Pick any angle.
				angle = MathUtil.randomRange(-180, 180);
			}
			
			this.__velocity = MathUtil.findMotionFromAngle(angle, this.__movementSpeed);
		}
		
		private function facePlayer():void
		{
			// Always face the player.
			this.doChangeDirection(MathUtil.findAngle(this.x, this.y, this.__player.x + this.__puffleXOffset, __player.y + this.__puffleYOffset));
			
			// Drop off velocity as we get closer.
			var dist = MathUtil.findDistance(this.x, this.y, this.__player.x + this.__puffleXOffset, this.__player.y + this.__puffleYOffset);
			this.__velocity.x *= (dist / 100);
			this.__velocity.y *= (dist / 100);
		}
		
		override public function getUniqueName():String
		{
			return "Puffle";
		}
		
		private function collideHandler(evt:DivingObstacleEvent):void
		{
			// Become aware of fish.
			var obstacle = evt.obstacle;
			
			// Make sure it's actually a fish and that we don't already know about it.
			if (obstacle.obstacleType <= DivingObstacleTypes.DIVING_OBSTACLE_MULLET && this.__fishAwareOf.indexOf(obstacle) == -1)
			{
				this.__fishAwareOf.push(obstacle);
			}
		}
		
		private function chargeUp(evt:TimerEvent):void
		{
			this.sub.energy_indicator.gotoAndStop(this.__attackCooldownTimer.currentCount + 1);
		}
		
		private function cooldownDone(evt:TimerEvent):void
		{
			trace(this.getUniqueName() + " attack cooldown done.");
			
			this.__attackOnCooldown = false;
			
			this.sub.satellite.play();
			
			this.__attackCooldownTimer.reset();
		}
		
		private function findClosestFish():MovingDivingObstacle
		{
			var dist = 10000000;
			var fishTarget: MovingDivingObstacle = null;
			
			// Look for the closest fish.
			for each (var fish in this.__fishAwareOf)
			{
				// Use distance from player to get even closer.
				var distToFish = Math.abs(MathUtil.findDistance(this.__player.x, this.__player.y, fish.x, fish.y));
				if (distToFish < dist)
				{
					dist = distToFish;
					fishTarget = fish;
				}
			}
			
			return fishTarget;
		}
		
		private function doAttack():void
		{
			if (this.__fishTarget != null)
			{
				var spawnX = this.__fishTarget.spawnX;
				
				// Make sure spawner isn't null (the spawner is null if the fish is already cleaning up).
				if (spawnX != 0)
				{
					trace(this.getUniqueName() + " attacking target!");
					
					// Pan sound based on position.
					this._engine.soundManager.changePan("sub_ping", this.x / 1000);
					this._engine.soundManager.playIfNotPlaying("sub_ping");
					
					// Add the cooldown.
					this.__attackOnCooldown = true;
					this.sub.energy_indicator.gotoAndStop(1);
					this.sub.satellite.stop();
					this.__attackCooldownTimer.start();
					
					// Prevent this fish from ramming into the player as it swims offscreen.
					this.__fishTarget.testForPlayer = false;
					
					// Despawn the fish the next time it reaches the edge.
					this.__fishTarget.recycleCallback = DelegateAS3.globalDelegate.create(this.__fishTarget.despawn);
					
					// Make the fish zoom away in fear and also turn around.
					this.__fishTarget.moveRate = this.__fishZoomAwaySpeed;
					
					this.__fishTarget = null;
				}
			}
			
			this.setState(STATE_IDLE);
		}
		
		private function setState($state:uint):void
		{
			if (this.__state != $state)
			{
				this.__state = $state;
	
				// This logic only needs to be ran once so it is outside the main loop.
				switch (this.__state)
				{
					case STATE_IDLE:
						// Reset known fish.
						this.__fishAwareOf = new Array();
						break;
					case STATE_ATTACK:
						this.doAttack();
						break;
				}
			}
		}
		
		override public function update():void
		{
			/*
			Cap it off if we get too close to 0.
			we're using floating point values that are too imprecise to reach 0 themselves.
			*/
			if (Math.abs(this.__velocity.x) < this.__velocityZeroThreshold)
			{
				this.__velocity.x = 0.0;
			}
			if (Math.abs(this.__velocity.y) < this.__velocityZeroThreshold)
			{
				this.__velocity.y = 0.0;
			}
			
			// Occasionally spawn bubbles.
			if (this._engine.timeLeft % 10 == 0)
			{
				this._engine.objManager.getObj("bubbleMgr").addOrMoveBubbles(this.parent, new Point(this.x, this.y), "puffleBubbles");
			}
			
			switch(this.__state)
			{
				case STATE_IDLE:
					// Skip attack if cooling down.
					if (!this.__attackOnCooldown)
					{
						var fishTarget = this.findClosestFish();
				
						if (fishTarget != null)
						{
							// Found a fish to target!
							this.__fishTarget = fishTarget;
							
							this.setState(STATE_ATTACK);
						}
					}
					break;
				case STATE_ATTACK:
					break;
			}
			
			this.facePlayer();
			
			this.x += this.__velocity.x;
			this.y += this.__velocity.y;
			
			// Keep below the top.
			if (this._engine.wallBounds && this.y < this._engine.wallBounds.top)
			{
				this.y += this.__bounceBack;
			}
		}
		
		override public function dispose():void
		{
			this.removeEventListener(DivingObstacleEvent.PUFFLE_COLLIDE, this.collideHandler);
			
			this.__attackCooldownTimer.removeEventListener(TimerEvent.TIMER, this.chargeUp);
			this.__attackCooldownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cooldownDone);
			this.__attackCooldownTimer.stop();
			this.__attackCooldownTimer = null;
			
			this.__fishAwareOf = null;
			
			this.__player = null;
			
			this.__fishTarget = null;
			
			this.__velocity = null;
			
			super.dispose();
		}
	}
}