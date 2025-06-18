package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import com.clubpenguin.lib.util.math.MathUtil;
	import com.clubpenguin.games.chase.movies.PlayerMC;
	import fl.motion.Color;

	internal class Player extends MovieClip
	{
		private var game:MovieClip;

		public var gameplayHolder:Object;

		public var movie:MovieClip;

		public var startX:Number;

		public var startY:Number;

		public var mainAction:String;

		public var subAction:String;

		public var mainChanged:Boolean;

		public var subChanged:Boolean;

		public var mainActionFromStart:Boolean;

		public var f:Number;

		public var angle:Number;

		public var Xmouse:Number;

		public var Ymouse:Number;

		public var motionX:Number;

		public var motionY:Number;

		public var dead:Boolean;

		public var penguinColor:Color;

		public var moveSpeed:Number;

		public var jumpSpeed:Number;

		public var prevPosX1:Number;

		public var prevPosY1:Number;

		public var momentumX:Number;

		public var momentumY:Number;

		public var groundY:Number;

		public var catchingPuffle:Boolean;

		public var pufflesCaughtN:Number;

		public var lastRot:Number;

		public var recoverWaitN:Number;

		public var footSoundN:Number;

		public var footSoundL:Number;

		public var slideTimeN:Number;

		public var slideStartN:Number;

		public var skidTimeN:Number;

		public var skidStartN:Number;

		public function Player(param1:MovieClip, param2:Number, param3:Number)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.gameplayHolder;
			this.movie = new PlayerMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = "normal";
			this.mainChanged = true;
			this.subAction = "sit";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.moveSpeed = 1;
			this.jumpSpeed = 30;
			this.prevPosX1 = this.movie.x;
			this.prevPosY1 = this.movie.y;
			this.momentumX = 0;
			this.groundY = this.startY;
			this.catchingPuffle = false;
			this.pufflesCaughtN = 0;
			this.lastRot = 0;
			this.recoverWaitN = 2;
			this.footSoundL = 1;
			this.footSoundN = 1;
			this.slideTimeN = 0;
			this.slideStartN = 1;
			this.skidTimeN = 0;
			this.skidStartN = 1;
			this.penguinColor = new Color();
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
			this.penguinColor.color = this.game.penguinColor.color;
			this.movie.art.art.art.skin.transform.colorTransform = this.penguinColor;
		}

		public function update():void
		{
			if (this.game.gameplayDone)
			{
				this.dispose();
				return;
			}
			
			this.motionX *= 0.95;
			this.motionY *= 0.98;
			this.momentumX *= 0.98;
			
			if (this.momentumX < -14)
			{
				this.momentumX = -14;
			}
			if (this.momentumX < -6)
			{
				if (this.subAction == "run")
				{
					if (this.motionX < 8)
					{
						this.motionX *= 1.2;
					}
				}
			}
			
			if (this.motionX + this.momentumX > 0)
			{
				this.movie.x += this.motionX + this.momentumX;
			}
			
			if (this.motionX + this.momentumX > 0)
			{
				this.movie.y = this.groundY;
			}
			
			this.momentumX += this.motionX / 100;
			
			this.findGroundAngle();
			
			if (this.motionX + this.momentumX > 0)
			{
				this.lastRot = this.movie.rotation;
				this.movie.rotation = (this.lastRot + this.angle) / 2;
			}
			
			if (this.angle > 0)
			{
				this.momentumX += this.angle / 40;
			}
			else if (this.angle < 0)
			{
				this.momentumX += this.angle / 20;
			}
			
			if (this.game.inputMgr.isKeyDown(Keyboard.DOWN) || this.game.inputMgr.isKeyDown(Keyboard.S))
			{
				this.findGroundAngle();
				
				if (this.angle < 0)
				{
					if (this.motionX + this.momentumX > -1)
					{
						this.motionX += this.angle / 5;
						this.momentumX += this.angle / 10;
					}
				}
				else
				{
					this.motionX += this.angle / 10;
					this.momentumX += this.angle / 20;
				}
				
				if (this.catchingPuffle == false)
				{
					if (this.angle < -3)
					{
						if (this.subAction != "sit2")
						{
							this.subAction = "sit2";
							this.subChanged = true;
						}
						
						this.recoverWaitN = 2;
						
						if (this.motionX + this.momentumX > 1)
						{
							this.game.shakeCam = true;
							
							// Spawn 2 particles
							var particleN = 0;
							while (particleN < 2)
							{
								var startX = this.movie.x + Math.floor(Math.random() * 20) + 10;
								var startY = this.movie.y + 10;
								var motionX = this.motionX + this.momentumX + Math.random() * 0.6
								var motionY = Math.floor(Math.random() * 20) - 30;
								
								this.game.placeParticle(startX, startY, 0, motionX, motionY, "snow");
								
								particleN++;
							}
						}
					}
					else
					{
						if (this.subAction == "sit2")
						{
							if (this.recoverWaitN > 0)
							{
								--this.recoverWaitN;
							}
							else
							{
								this.subAction = "recover";
								this.subChanged = true;
							}
						}
						if (this.subAction != "recover" && this.subAction != "sit2")
						{
							if (this.subAction != "sit")
							{
								this.subAction = "sit";
								this.subChanged = true;
							}
						}
					}
				}
			}
			else if (this.catchingPuffle == false)
			{
				if (this.subAction != "run")
				{
					this.subAction = "run";
					this.subChanged = true;
				}
			}
			
			this.motionX += this.moveSpeed;
			
			if (this.subAction == "sit")
			{
				++this.slideTimeN;
				
				if (this.slideTimeN == 1)
				{
					if (this.slideStartN == 1)
					{
						this.game.playSoundEffect("slideStart01");
						this.slideStartN = 2;
					}
					else
					{
						this.game.playSoundEffect("slideStart02");
						this.slideStartN = 1;
					}
				}
				else if (this.slideTimeN == 10)
				{
					this.game.playSoundEffect("slideLoop", true);
				}
			}
			else if (this.subAction == "sit2")
			{
				this.stopSlideSfx();
				
				++this.skidTimeN;
				
				if (this.skidTimeN == 1)
				{
					if (this.skidStartN == 1)
					{
						this.game.playSoundEffect("skidStop01");
						this.skidStartN = 2;
					}
					else
					{
						this.game.playSoundEffect("skidStop02");
						this.skidStartN = 1;
					}
				}
			}
			else
			{
				this.stopSlideSfx();
				
				this.skidTimeN = 0;
			}
			
			if (this.subAction == "run")
			{
				this.f = this.movie.art.art.art.currentFrame;
				if (this.f == 5 || this.f == 13 || this.f == 21 || this.f == 29 || this.f == 37 || this.f == 45 || this.f == 53 || this.f == 61)
				{
					this.footSoundL = this.footSoundN;
					this.pickFootstepSfx();
					this.pickFootstepSfx();
					this.pickFootstepSfx();
					this.pickFootstepSfx();
					
					this.game.playSoundEffect("footstep0" + this.footSoundN.toString());
				}
			}
			
			if (Math.abs(this.motionX) > 24)
			{
				this.motionX *= 0.9;
			}
			
			if (this.movie.x - 20 < this.game.gameplayHolder.x * -1)
			{
				this.movie.x = this.game.gameplayHolder.x * -1 + 20;
				this.motionX = Math.abs(this.motionX + this.momentumX) / 2;
				this.momentumX = 0;
			}
			
			if (this.mainChanged)
			{
				this.movie.setArtMain(this.mainAction);
				if (this.mainActionFromStart)
				{
					this.mainActionFromStart = false;
					this.movie.setArtMain("hide");
					this.movie.setArtMain(this.mainAction);
				}
				this.mainChanged = false;
				this.subChanged = true;
			}
			
			if (this.mainAction == "normal")
			{
				if (this.subChanged == false)
				{
					if (this.movie.art.art.art.currentFrame == this.movie.art.art.art.totalFrames)
					{
						if (this.subAction == "catch")
						{
							if (this.game.inputMgr.isKeyDown(Keyboard.DOWN) || this.game.inputMgr.isKeyDown(Keyboard.S))
							{
								this.subAction = "catchSit";
							}
							else
							{
								this.subAction = "catchRun";
							}
							this.subChanged = true;
						}
						else if (this.subAction == "catchRun")
						{
							this.subAction = "run";
							this.subChanged = true;
							this.catchingPuffle = false;
						}
						else if (this.subAction == "catchSit")
						{
							this.subAction = "sit";
							this.subChanged = true;
							this.catchingPuffle = false;
						}
						else if (this.subAction == "recover")
						{
							this.findGroundAngle();
							
							if (this.angle < -3)
							{
								this.subAction = "sit2";
								this.subChanged = true;
							}
							else
							{
								this.subAction = "sit";
								this.subChanged = true;
							}
						}
					}
				}
			}
			
			if (this.subChanged)
			{
				this.movie.setArtSub(this.subAction);
				this.subChanged = false;
				this.penguinColor.color = this.game.penguinColor.color;
				this.movie.art.art.art.skin.transform.colorTransform = this.penguinColor;
			}
		}
		
		private function pickFootstepSfx():void
		{
			if (this.footSoundN == this.footSoundL)
			{
				this.footSoundN = Math.floor(Math.random() * 4) + 1;
			}
		}
		
		private function stopSlideSfx():void
		{
			if (this.slideTimeN > 0)
			{
				this.game.stopSlideLoop();
			}
			this.slideTimeN = 0;
		}

		public function catchPuffle():void
		{
			this.catchingPuffle = true;
			this.subAction = "catch";
			this.subChanged = true;
			++this.pufflesCaughtN;
			
			var hudObj = this.game.hud.getObj("hudObj");
			if (hudObj != null)
			{
				hudObj.updatePuffles(this.pufflesCaughtN);
			}
			this.game.pufflesCaught = this.pufflesCaughtN;
		}

		public function getCoin():void
		{
			if (this.motionX + this.momentumX <= 0)
			{
				this.momentumX += this.motionX + this.momentumX + 15;
			}
			if (this.motionX + this.momentumX < 20)
			{
				this.momentumX += 5;
			}
		}

		public function findGroundAngle():void
		{
			var colPointLObj = this.game.objManager.getObj("colPointLObj");
			var colPointRObj = this.game.objManager.getObj("colPointRObj");
			
			this.angle = MathUtil.findAngle(0, colPointLObj.movie.y, 20, colPointRObj.movie.y);
			
			// This is some hot fudge.
			this.angle += 10;
		}

		public function dispose():void
		{
			if (this.dead == false)
			{
				this.dead = true;
				this.gameplayHolder.removeChild(this.movie);
			}
		}
		
		public function cleanupAttribs():void
		{
			this.game = null;
			this.gameplayHolder = null;
			this.movie = null;
			this.penguinColor = null;
		}
	}
}