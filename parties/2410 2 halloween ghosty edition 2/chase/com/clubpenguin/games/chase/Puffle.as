package com.clubpenguin.games.chase
{
	import com.clubpenguin.games.chase.movies.PuffleMC;
   	import flash.display.MovieClip;
	
	internal class Puffle extends MovieClip
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

		public var Xmouse:Number;

		public var Ymouse:Number;

		public var motionX:Number;

		public var motionY:Number;

		public var dead:Boolean;

		public var moveSpeed:Number;

		public var groundY:Number;

		public var kind:String;

		public var f:Number;

		public var onScreen:Boolean;

		public function Puffle(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:String)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.gameplayHolder;
			this.movie = new PuffleMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = param5;
			this.mainChanged = true;
			this.subAction = "run";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.groundY = this.startY;
			this.kind = param4;
			++this.game.existingPufflesN;
			this.onScreen = false;
			
			if (this.kind == "puffle1")
			{
				this.moveSpeed = 4;
			}
			else if (this.kind == "puffle2")
			{
				this.moveSpeed = 4.2;
			}
			else if (this.kind == "puffle3")
			{
				this.moveSpeed = 4.4;
			}
			else if (this.kind == "puffle4")
			{
				this.moveSpeed = 4.6;
			}
			else if (this.kind == "puffle5")
			{
				this.moveSpeed = 4.7;
			}
		}

		public function update():void
		{
			if (this.game.gameplayDone)
			{
				this.dispose();
				return;
			}
			
			if (this.game.speedUpPuffles)
			{
				this.moveSpeed *= 1.0005;
			}
			
			var playerObj = this.game.objManager.getObj("playerObj");
			if (playerObj != null && this.movie.x > playerObj.movie.x && this.movie.x + this.game.gameplayHolder.x < 728)
			{
				this.onScreen = true;
			}
			else
			{
				if (this.onScreen)
				{
					this.game.playSoundEffect("puffleRunAway");
				}
				this.onScreen = false;
			}
			
			if (this.onScreen)
			{
				if (this.dead == false)
				{
					if (this.subAction == "run")
					{
						this.f = this.movie.art.art.art.currentFrame;
						if (this.f == 3 || this.f == 12 || this.f == 21 || this.f == 30 || this.f == 39 || this.f == 48 || this.f == 57)
						{
							this.game.playSoundEffect("puffleBounce");
						}
					}
				}
			}
			
			this.movie.y = this.groundY;
			this.motionX += this.moveSpeed;
			
			if (playerObj != null && this.movie.x <= playerObj.movie.x + 20)
			{
				playerObj.catchPuffle();
				this.game.playSoundEffect("puffleCatch");
				this.dispose();
				return;
			}
			
			this.motionX *= 0.9;
			this.movie.x += this.motionX;
			
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
			
			if (this.subChanged)
			{
				this.movie.setArtSub(this.subAction);
				this.subChanged = false;
			}
		}

		public function escapePenguin():void
		{
			this.dispose();
		}

		public function dispose():void
		{
			if (this.dead == false)
			{
				--this.game.existingPufflesN;
				this.dead = true;
				this.gameplayHolder.removeChild(this.movie);
			}
		}
		
		public function cleanupAttribs():void
		{
			this.game = null;
			this.gameplayHolder = null;
			this.movie = null;
		}
	}
}