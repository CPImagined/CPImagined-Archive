package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import com.clubpenguin.games.chase.movies.ColPointMC;
	
	internal class ColPoint extends MovieClip
	{
		private var game:MovieClip;

		public var gameplayHolder:Object;

		public var movie:MovieClip;

		public var mainAction:String;

		public var subAction:String;

		public var mainChanged:Boolean;

		public var subChanged:Boolean;

		public var mainActionFromStart:Boolean;

		public var dead:Boolean;

		public var kind:String;

		public function ColPoint(param1:MovieClip, param4:String)
		{
			super();
			
			this.game = param1;
			
			this.gameplayHolder = this.game.gameplayHolder;
			this.movie = new ColPointMC();
			this.gameplayHolder.addChild(this.movie);
			this.movie.y = 470;
			this.mainAction = "still";
			this.mainChanged = true;
			this.mainActionFromStart = false;
			this.dead = false;
			this.kind = param4;
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
			}
		}

		public function updateYpos(yPos:Number):void
		{
			this.movie.y = yPos;
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