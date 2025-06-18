package com.clubpenguin.games.diving
{
	import com.clubpenguin.games.object.GameObject;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleEvent;
	import com.clubpenguin.games.diving.obstacles.TreasureDivingObstacle;
	import com.clubpenguin.lib.util.math.MathUtil;
	import com.clubpenguin.lib.util.xml.XMLUtil;
  	import fl.motion.Color;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class Player extends GameObject
	{
		public var velocity:Point;
		public var rotateVelocity:Number;
		
		private var __velocityForward:Number;
		private var __velocityBackward:Number;
		private var __velocityFalloff:Number;
		private var __velocityZeroThreshold:Number;

		private var __rotateVelocityAdd:Number;
		private var __rotateVelocityFalloff:Number;
		private var __rotateVelocityZeroThreshold:Number;
		
		private var __hitCooldownTimer:Timer;
		private var __invincibilityCycles:Number;
		private var __stunned:Boolean = false;
		private var __blinkTimer:Timer;
		
		private var __chest:TreasureDivingObstacle = null;
		
		private var __bounceBack:Number;
		private var __hitBounceBack:Number;

		public function Player()
		{
			super();
			
			this.__velocityForward = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "velocityForward", 1.0);
			this.__velocityBackward = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "velocityBackward", 1.0);
			this.__velocityFalloff = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "velocityFalloff", 1.0);
			this.__velocityZeroThreshold = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "velocityZeroThreshold", 0.0);

			this.__rotateVelocityAdd = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "rotateVelocityAdd", 1.0);
			this.__rotateVelocityFalloff = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "rotateVelocityFalloff", 1.0);
			this.__rotateVelocityZeroThreshold = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "rotateVelocityZeroThreshold", 0.0);
			
			this.__invincibilityCycles = XMLUtil.getIntFromConfig(this._engine.gameConfig, "movementUnlockCycles", 1);
			this.__hitCooldownTimer = new Timer(1000, XMLUtil.getIntFromConfig(this._engine.gameConfig, "hitCooldownCycles", 1));
			this.__hitCooldownTimer.addEventListener(TimerEvent.TIMER, this.hitStunDone);
			this.__hitCooldownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cooldownDone);
			
			this.__blinkTimer = new Timer(XMLUtil.getIntFromConfig(this._engine.gameConfig, "blinkRate", 100));
			this.__blinkTimer.addEventListener(TimerEvent.TIMER, this.doBlink);
			
			this.__bounceBack = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "boundsBounceBack", 5.0);
			
			this.__hitBounceBack = XMLUtil.getFloatFromConfig(this._engine.gameConfig, "hitBounceBack", 5.0);
			
			this.addEventListener(DivingObstacleEvent.PLAYER_COLLIDE, this.collideHandler);
			
			this.stop();
			
			trace("Setting penguin colour...");
			
			this.setColour();
		}

		public function setColour():void
		{
			if (this._engine.penguinColor != 0)
			{
			
				var penguinColor: Color = new Color();
				penguinColor.color = this._engine.penguinColor;
				this.mc.tank_mc.colour_mc.transform.colorTransform = penguinColor;
				this.mc.strap_mc.colour_mc.transform.colorTransform = penguinColor;
				this.mc.arml_mc.colour_mc.transform.colorTransform = penguinColor;
				this.mc.armr_mc.colour_mc.transform.colorTransform = penguinColor;
			}
		}

		public function reset():void
		{
			var startPos = XMLUtil.getArrayFromConfig(this._engine.gameConfig, "startPos", [0, 0, 0]);
			this.x = startPos[0];
			this.y = startPos[1];
			this.rotation = startPos[2];
			
			this.velocity = new Point();
			this.rotateVelocity = 0.0;
		}

		override public function update():void
		{
			this.velocity.x *= this.__velocityFalloff;
			this.velocity.y *= this.__velocityFalloff;
			
			this.rotateVelocity *= this.__rotateVelocityFalloff;
			
			/*
			Cap it off if we get too close to 0.
			we're using floating point values that are too imprecise to reach 0 themselves.
			*/
			if (Math.abs(this.velocity.x) < this.__velocityZeroThreshold)
			{
				this.velocity.x = 0.0;
			}
			if (Math.abs(this.velocity.y) < this.__velocityZeroThreshold)
			{
				this.velocity.y = 0.0;
			}
			
			// Occasionally spawn bubbles.
			if (this._engine.timeLeft % 5 == 0)
			{
				this._engine.objManager.getObj("bubbleMgr").addOrMoveBubbles(this.parent, new Point(this.x, this.y), "playerBubbles");
			}
			
			if (!this.__stunned)
			{
				var moveUp = this._engine.inputMgr.isKeyDown(Keyboard.UP) || this._engine.inputMgr.isKeyDown(Keyboard.W);
				var moveDown = this._engine.inputMgr.isKeyDown(Keyboard.DOWN) || this._engine.inputMgr.isKeyDown(Keyboard.S);
	
				if (moveUp || moveDown)
				{
					var angle = MathUtil.findAngle2(MathUtil.deg2Rad(this.rotation));
		
					var newVelocity = MathUtil.findMotionFromAngle(angle, -this.__velocityForward);
		
					if (moveDown)
					{
						newVelocity.x *= -this.__velocityBackward;
						newVelocity.y *= -this.__velocityBackward;
					}
					
					this.velocity.x += newVelocity.x;
					this.velocity.y += newVelocity.y;
					this.determineAnim("move");
					//trace("moveUp/moveDown determineAnim move");
				}
				else
				{
					this.determineAnim("idle");
					//trace("not moveUp/moveDown determineAnim idle");
				}
			}
			else
			{
				this.determineAnim("idle");
				//trace("stunned determineAnim idle");
			}

			// Also cap rotation velocity if we get too close to 0.
			if (Math.abs(this.rotateVelocity) < this.__rotateVelocityZeroThreshold)
			{
				this.rotateVelocity = 0.0;
			}
			
			if (!this.__stunned)
			{
				if (this._engine.inputMgr.isKeyDown(Keyboard.LEFT) || this._engine.inputMgr.isKeyDown(Keyboard.A))
				{
					this.rotateVelocity -= this.__rotateVelocityAdd;
				}
				else if (this._engine.inputMgr.isKeyDown(Keyboard.RIGHT) || this._engine.inputMgr.isKeyDown(Keyboard.D))
				{
					this.rotateVelocity += this.__rotateVelocityAdd;
				}
			}
			
			this.rotation += this.rotateVelocity;
			
			this.x = this.x - this.velocity.x;
			this.y = this.y - this.velocity.y;
			
			// Keep inside the bounds.
			if (this._engine.wallBounds)
			{
				if (this.x < this._engine.wallBounds.left)
				{
					this.x += this.__bounceBack;
				}
				else if (this.x > this._engine.wallBounds.right)
				{
					this.x -= this.__bounceBack;
				}
				
				if (this.y > this._engine.wallBounds.bottom)
				{
					this.y -= this.__bounceBack;
				}
				else if (this.y < this._engine.wallBounds.top)
				{
					this.y += this.__bounceBack;
				}
			}
		}
		
		private function determineAnim($type:String):void
		{
			switch ($type)
			{
				case "idle":
					if (this.__chest == null)
					{
						this.gotoAndStop("idle");
						this.setColour();
						//trace("determineAnim () -> idle");
						break;
					}
					else
					{
						this.gotoAndStop("treasure_idle");
						this.setColour();
						this.mc.treasure_mc.gotoAndStop(this.__chest.currentFrame);
						//trace("determineAnim () -> treasure idle");
						break;
					};
				case "move":
					if (this.__chest == null)
					{
						this.gotoAndStop("move");
						this.setColour();
						//trace("determineAnim () -> move");
						break;
					}
					else
					{
						this.gotoAndStop("treasure_move");
						this.setColour();
						this.mc.treasure_mc.gotoAndStop(this.__chest.currentFrame);
						//trace("determineAnim () -> treasure_move");
						break;
					};
				default:
					this.gotoAndStop("idle");
					this.setColour();
					break;
			}
		}
		
		override public function getUniqueName():String
		{
			return "Player";
		}
		
		private function collideHandler(evt:DivingObstacleEvent):void
		{
			if (!this.__hitCooldownTimer.running)
			{
				evt.obstacle.playerHitMe();
			}
		}
				
		public function hitStun():void
		{
			trace("Player stunned!");
			
			// Pan sound based on position.
			this._engine.soundManager.changePan("hit_fish", this.x / 1000);
			this._engine.soundManager.playIfNotPlaying("hit_fish");
			
			this.velocity.x *= -this.__hitBounceBack;
			this.velocity.y *= -this.__hitBounceBack;
			
			this.__stunned = true;
			
			if (this.chest != null)
			{
				// Drop our currently held chest.
				this.chest = null;
			}
			
			this.__hitCooldownTimer.start();
		}
		
		private function hitStunDone(evt: TimerEvent):void
		{
			if (this.__hitCooldownTimer.currentCount == this.__invincibilityCycles)
			{
				if (this.__stunned)
				{
					this.__stunned = false;
					
					// Blink to indicate invincibility.
					this.startBlinking();
				
					trace("Player unstunned!");
				}
			}
		}
		
		private function startBlinking():void
		{
			if (!this.__blinkTimer.running)
			{
				this.__blinkTimer.start();
			}
		}
		
		public function stopBlinking():void
		{
			this.__blinkTimer.reset();
			
			// Make sure we're visible again.
			if (!this.visible)
			{
				this.visible = true;
			}
		}
		
		private function doBlink(evt:TimerEvent):void
		{
			this.visible = !this.visible;
		}
		
		private function cooldownDone(evt:TimerEvent):void
		{
			trace("Player collide cooldown done.");
			
			this.stopBlinking();
			
			this.__hitCooldownTimer.reset();
		}
		
		public function get chest():TreasureDivingObstacle
		{
			return this.__chest;
		}
		
		public function set chest($chest:TreasureDivingObstacle):void
		{
			this.__chest = $chest;
		}

		override public function dispose():void
		{
			this.removeEventListener(DivingObstacleEvent.PLAYER_COLLIDE, this.collideHandler);
			
			this.__hitCooldownTimer.removeEventListener(TimerEvent.TIMER, this.hitStunDone);
			this.__hitCooldownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cooldownDone);
			this.__hitCooldownTimer.stop();
			this.__hitCooldownTimer = null;
			
			this.__blinkTimer.removeEventListener(TimerEvent.TIMER, this.doBlink);
			this.__blinkTimer.stop();
			this.__blinkTimer = null;
			
			this.velocity = null;
			
			this.__velocityForward = 0.0;
			this.__velocityBackward = 0.0;
			this.__velocityFalloff = 0.0;
			this.__velocityZeroThreshold = 0.0;
			
			this.rotateVelocity = 0.0;
			
			this.__rotateVelocityAdd = 0.0;
			this.__rotateVelocityFalloff = 0.0;
			this.__rotateVelocityZeroThreshold = 0.0;
			
			this.__bounceBack = 0.0;
			
			this.__chest = null;
			
			super.dispose();
		}
	}

}