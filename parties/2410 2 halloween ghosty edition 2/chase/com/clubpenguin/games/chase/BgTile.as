package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import com.clubpenguin.games.chase.movies.BgTileMC;
	
	internal class BgTile extends MovieClip
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

		public var t:Number;

		public var dead:Boolean;

		public var childPlaced:Boolean;

		public function BgTile(param1:MovieClip, param2:Number, param3:Number, param4:String)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.bgTileHolder;
			this.movie = new BgTileMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.mainAction = param4;
			this.mainChanged = true;
			this.subAction = "still";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.dead = false;
			this.childPlaced = false;
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
			
			if (this.childPlaced == false)
			{
				// Place the next BgTile.
				if (this.movie.x + this.game.bgTileHolder.x <= 0)
				{
					this.childPlaced = true;
					this.t = Math.floor(Math.random() * 5) + 1;
					this.game.placeBgTile(this.movie.x + 760,this.movie.y,"backdrop" + this.t);
				}
			}
			else if (this.movie.x + this.game.bgTileHolder.x < -760)
			{
				// We've gone offscreen so time to disappear.
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