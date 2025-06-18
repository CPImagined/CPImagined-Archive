package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import com.clubpenguin.lib.util.math.MathUtil;
	import com.clubpenguin.games.chase.movies.ObstacleMC;

	internal class Obstacle extends MovieClip
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
		
		public var p:Number;

		public var Xmouse:Number;

		public var Ymouse:Number;

		public var motionX:Number;

		public var motionY:Number;

		public var dead:Boolean;

		public var groundY:Number;

		public var kind:String;

		public var parentTile:Object;

		public var colPointChecked:Boolean;

		public var tempPointL:Number;

		public var tempPointR:Number;

		public var collisionOccured:Boolean;

		public var px:Number;

		public var py:Number;

		public var offsetY:Number;

		public function Obstacle(param1:MovieClip, param2:Number, param3:Number, param4:String, param5:Object, param6:Number)
		{
			super();
			
			this.game = param1;
			
			if (param4 == "chest")
			{
				this.gameplayHolder = this.game.obstacleHolder;
			}
			else
			{
				this.gameplayHolder = this.game.gameplayHolder;
			}
			
			this.movie = new ObstacleMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = param4;
			this.mainChanged = true;
			this.subAction = "still";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.groundY = this.startY;
			this.kind = param4;
			this.parentTile = param5;
			this.tempPointL = 470;
			this.tempPointR = 470;
			this.offsetY = param6;
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
			this.positionObstacle();
		}

		public function update():void
		{
			if (this.collisionOccured == false)
			{
				this.positionObstacle();
			}
			
			if (this.movie.x + this.game.gameplayHolder.x < -1520)
			{
				// We've gone offscreen so time to disappear.
				this.dispose();
				return;
			}
			else if (this.game.gameplayDone)
			{
				this.dispose();
				return;
			}
			
			if (this.kind == "coin")
			{
				if (this.subAction == "still")
				{
					var playerObj = this.game.objManager.getObj("playerObj");
					
					if (playerObj != null && this.movie.x < playerObj.movie.x)
					{
						var dist = MathUtil.findDistance(this.movie.x,this.movie.y,playerObj.movie.x,playerObj.movie.y - 30);
						if (dist < 100)
						{
							if (playerObj.subAction == "run" || playerObj.subAction == "catch" || playerObj.subAction == "catchRun")
							{
								this.subAction = "poof";
								this.subChanged = true;
								playerObj.getCoin();
								++this.game.coinsCollected;
								this.game.playSoundEffect("coinCollect");
							}
						}
					}
				}
			}
			else if (this.kind == "chest")
			{
				if (this.game.hasPuffle)
				{
					var playerPuffleObj = this.game.objManager.getObj("playerPuffleObj");
					
					if (playerPuffleObj != null && this.movie.x < playerPuffleObj.movie.x + 60)
					{
						if (this.subAction == "still")
						{
							this.subAction = "poof";
							this.subChanged = true;
							playerPuffleObj.unlockChest();
							this.game.playSoundEffect("treasureCollect");
						}
					}
				}
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
			
			if (this.mainAction == "coin")
			{
				if (this.subChanged == false)
				{
					if (this.movie.art.art.art.currentFrame == this.movie.art.art.art.totalFrames)
					{
						if (this.subAction == "poof")
						{
							this.dispose();
							return;
						}
					}
				}
			}
			else if (this.mainAction == "chest")
			{
				if (this.subChanged == false)
				{
					if (this.movie.art.art.art.currentFrame == this.movie.art.art.art.totalFrames)
					{
						if (this.subAction == "poof")
						{
							this.dispose();
							return;
						}
					}
				}
			}
			
			if (this.subChanged)
			{
				this.movie.setArtSub(this.subAction);
				this.subChanged = false;
			}
		}
		
		private function colCheck(callback:Function):void
		{
			this.colPointChecked = false;
			this.collisionOccured = false;
			this.p = 0;
			
			while (this.p < 100)
			{
				if (this.colPointChecked == false)
				{
					callback();
				}
				else
				{
					this.p += 100;
				}
				
				++this.p;
			}
		}
		
		private function shiftColPoint(tempPoint:String):void
		{
			this.px = this.movie.x + this.game.gameplayHolder.x;
			this.py = this[tempPoint] + this.game.gameplayHolder.y;
			
			var offset;
			if (this[tempPoint] == this.tempPointL)
			{
				offset = this.px - 10;
			}
			else
			{
				offset = this.px + 10;
			}
			
			if (this.parentTile.movie.art.hitTestPoint(offset, this.py - 100, true))
			{
				this[tempPoint] -= 100;
				this.collisionOccured = true;
			}
			else if (this.parentTile.movie.art.hitTestPoint(offset, this.py - 50, true))
			{
				this[tempPoint] -= 50;
				this.collisionOccured = true;
			}
			else if (this.parentTile.movie.art.hitTestPoint(offset, this.py - 20, true))
			{
				this[tempPoint] -= 20;
				this.collisionOccured = true;
			}
			else if (this.parentTile.movie.art.hitTestPoint(offset, this.py - 10, true))
			{
				this[tempPoint] -= 10;
				this.collisionOccured = true;
			}
			else if (this.parentTile.movie.art.hitTestPoint(offset, this.py - 5, true))
			{
				this[tempPoint] -= 5;
				this.collisionOccured = true;
			}
			else if (this.parentTile.movie.art.hitTestPoint(offset, this.py - 2, true))
			{
				this[tempPoint] -= 2;
				this.collisionOccured = true;
			}
			else if (this.parentTile.movie.art.hitTestPoint(offset, this.py, true))
			{
				this.colPointChecked = true;
			}
			else
			{
				this.colPointChecked = true;
			}
		}

		private function positionObstacle():void
		{
			this.tempPointL = 470;
			this.colCheck(this.shiftPointL);
			
			this.tempPointR = 470;
			this.colCheck(this.shiftPointR);
			
			this.movie.y = (this.tempPointL + this.tempPointR) / 2;
			this.movie.y += this.offsetY;
			
			if (this.kind == "chest")
			{
				var angle = MathUtil.findAngle(-10, this.tempPointL, 10, this.tempPointR);
				this.movie.rotation = angle;
			}
		}

		private function shiftPointL():void
		{
			this.shiftColPoint("tempPointL");
		}

		private function shiftPointR():void
		{
			this.shiftColPoint("tempPointR");
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
			this.parentTile = null;
		}
	}
}