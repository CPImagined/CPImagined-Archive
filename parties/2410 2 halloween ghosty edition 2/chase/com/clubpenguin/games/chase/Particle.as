package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import com.clubpenguin.games.chase.movies.ParticleMC;
	
	internal class Particle extends MovieClip
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

		public var motionX:Number;

		public var motionY:Number;

		public var dead:Boolean;

		public function Particle(param1:MovieClip, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:String)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.particleHolder;
			this.movie = new ParticleMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.movie.art.rotation = param4;
			this.mainAction = param7;
			this.mainChanged = true;
			this.subAction = "still";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = param5;
			this.motionY = Math.abs(param6) * -1;
			this.dead = false;
			this.movie.art.scaleX = 0.2 + Math.floor(Math.random() * 10) / 10;
			this.movie.art.scaleY = this.movie.art.scaleX;
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
			this.movie.art.art.art.gotoAndStop(Math.floor(Math.random() * 6) + 1);
		}

		public function update():void
		{
			if (this.game.gameplayDone)
			{
				this.dispose();
				return;
			}
			
			this.motionY += 2;
			this.motionX *= 0.98;
			this.motionY *= 0.98;
			this.movie.x += this.motionX;
			this.movie.y += this.motionY;
			
			if (this.motionY > 0)
			{
				this.movie.art.scaleX *=  0.9;
			}
			else
			{
				this.movie.art.scaleX *=  0.96;
			}
			
			this.movie.art.scaleY = this.movie.art.scaleX;
			
			if (this.movie.art.scaleX < 0.1)
			{
				this.dispose();
				return;
			}
			
			var playerObj = this.game.objManager.getObj("playerObj");
			if (playerObj != null && this.movie.x < playerObj.movie.x - 760)
			{
				this.dispose();
				return;
			}
			else if (this.movie.y > 600)
			{
				this.dispose();
				return;
			}
			else if (this.movie.y < -20)
			{
				this.dispose();
				return;
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
			
			if (this.subChanged)
			{
				this.movie.setArtSub(this.subAction);
				this.subChanged = false;
			}
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
		}
	}
}