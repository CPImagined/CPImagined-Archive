package com.clubpenguin.games.chase
{
	import com.clubpenguin.games.chase.movies.BgMC;
   	import flash.display.MovieClip;
	
	internal class Bg extends MovieClip
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

		public function Bg(param1:MovieClip, param2:Number, param3:Number)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.bgHolder;
			this.movie = new BgMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = "screen1";
			this.mainChanged = true;
			this.subAction = "still";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
		}

		public function update():void
		{
			if (this.game.gameplayDone)
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