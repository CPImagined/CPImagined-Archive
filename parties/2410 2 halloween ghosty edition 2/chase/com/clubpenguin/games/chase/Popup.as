package com.clubpenguin.games.chase
{
	import com.clubpenguin.games.chase.movies.PopupMC;
   	import fl.motion.Color;
   	import flash.display.MovieClip;
   	import flash.events.Event;
	
	internal class Popup extends MovieClip
	{
		private var game:MovieClip;

		public var gameplayHolder:Object;

		public var movie:MovieClip;

		public var startX:Number;

		public var startY:Number;

		public var mainAction:String;

		public var mainChanged:Boolean;

		public var mainActionFromStart:Boolean;

		public var Xmouse:Number;

		public var Ymouse:Number;

		public var motionX:Number;

		public var motionY:Number;

		public var dead:Boolean;

		public var penguinColor:Color;

		public function Popup(param1:MovieClip, param2:Number, param3:Number, param4:String)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.hudHolder;
			this.movie = new PopupMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = param4;
			this.mainChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.penguinColor = new Color();
			this.movie.setArtMain(this.mainAction);
			this.penguinColor.color = this.game.penguinColor.color;
			this.movie.art.art.art.skin.transform.colorTransform = this.penguinColor;
		}

		public function update():void
		{
			if (this.game.gameplayDone || this.game.tutorialDone)
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

		public function dispose(evt:Event = null):void
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