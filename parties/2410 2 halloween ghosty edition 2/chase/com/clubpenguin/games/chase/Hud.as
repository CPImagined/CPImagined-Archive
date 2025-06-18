package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import com.clubpenguin.games.chase.movies.HudMC;
	import fl.motion.Color;
	import fl.motion.easing.Back;
	
	internal class Hud extends MovieClip
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
		
		public var n:Number;

		public var dead:Boolean;

		public var penguinColor:Color;

		public var maxPuffleDistance:Number;

		public var maxRadarLength:Number;

		public function Hud(param1:MovieClip, param2:Number, param3:Number)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.hudHolder;
			this.movie = new HudMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = "gameplay";
			this.mainChanged = false;
			this.subAction = "still";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.maxPuffleDistance = 3000;
			this.maxRadarLength = 310;
			this.penguinColor = new Color();
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
			this.updatePuffles(0);
			this.updateRadar();
		}

		public function update():void
		{
			if (this.mainChanged == false)
			{
				if (this.mainAction == "gameplay")
				{
					this.updateRadar();
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
			
			if (this.subChanged)
			{
				this.movie.setArtSub(this.subAction);
				this.subChanged = false;
			}
		}
		
		private function updateRadarPuffle(radarPuffleMc:MovieClip, escapeCallback:Function, puffleX:Number, playerX:Number):void
		{
			if (puffleX > playerX)
			{
				this.n = puffleX - playerX;
				this.n /=  this.maxPuffleDistance;
				this.n = this.maxRadarLength * this.n;
				if (this.n <= 0)
				{
					this.n = 0;
				}
				else if (this.n > this.maxRadarLength)
				{
					this.n = this.maxRadarLength;
					escapeCallback();
					radarPuffleMc.gotoAndStop("hide");
				}
				radarPuffleMc.x = this.n;
			}
		}

		private function updateRadar():void
		{
			var playerObj = this.game.objManager.getObj("playerObj");
			
			this.penguinColor.color = this.game.penguinColor.color;
			this.movie.art.art.radar.player.skin.transform.colorTransform = this.penguinColor;
			
			if (playerObj.pufflesCaughtN < 1)
			{
				var puffle1Obj = this.game.objManager.getObj("puffle1Obj");
				
				if (puffle1Obj != null && puffle1Obj.dead == false)
				{
					this.updateRadarPuffle(this.movie.art.art.radar.puffle1, puffle1Obj.escapePenguin, puffle1Obj.movie.x, playerObj.movie.x);
				}
				else
				{
					this.movie.art.art.radar.puffle1.gotoAndStop("hide");
				}
			}
			if (playerObj.pufflesCaughtN < 2)
			{
				var puffle2Obj = this.game.objManager.getObj("puffle2Obj");
				
				if (puffle2Obj != null && puffle2Obj.dead == false)
				{
					this.updateRadarPuffle(this.movie.art.art.radar.puffle2, puffle2Obj.escapePenguin, puffle2Obj.movie.x, playerObj.movie.x);
				}
				else
				{
					this.movie.art.art.radar.puffle2.gotoAndStop("hide");
				}
			}
			if (playerObj.pufflesCaughtN < 3)
			{
				var puffle3Obj = this.game.objManager.getObj("puffle3Obj");
				
				if (puffle3Obj != null && puffle3Obj.dead == false)
				{
					this.updateRadarPuffle(this.movie.art.art.radar.puffle3, puffle3Obj.escapePenguin, puffle3Obj.movie.x, playerObj.movie.x);
				}
				else
				{
					this.movie.art.art.radar.puffle3.gotoAndStop("hide");
				}
			}
			if (playerObj.pufflesCaughtN < 4)
			{
				var puffle4Obj = this.game.objManager.getObj("puffle4Obj");
				
				if (puffle4Obj != null && puffle4Obj.dead == false)
				{
					this.updateRadarPuffle(this.movie.art.art.radar.puffle4, puffle4Obj.escapePenguin, puffle4Obj.movie.x, playerObj.movie.x);
				}
				else
				{
					this.movie.art.art.radar.puffle4.gotoAndStop("hide");
				}
			}
			if (playerObj.pufflesCaughtN < 5)
			{
				var puffle5Obj = this.game.objManager.getObj("puffle5Obj");
				
				if (puffle5Obj != null && puffle5Obj.dead == false)
				{
					this.updateRadarPuffle(this.movie.art.art.radar.puffle5, puffle5Obj.escapePenguin, puffle5Obj.movie.x, playerObj.movie.x);
				}
				else
				{
					this.movie.art.art.radar.puffle5.gotoAndStop("hide");
				}
			}
		}
		
		private function updatePuffleCaught(numCaught:Number, numCaughtThreshold:Number, puffleCaughtMc:MovieClip, radarPuffleMc:MovieClip, puffleObj:Object):void
		{
			if (numCaught >= numCaughtThreshold)
			{
				if (numCaughtThreshold == 1)
				{
					this.movie.art.art.chip.gotoAndStop(this.game.puffleColor);
				}
				
				puffleCaughtMc.gotoAndStop("caught");
				radarPuffleMc.gotoAndStop("hide");
			}
			else
			{
				if (numCaughtThreshold == 1)
				{
					this.movie.art.art.chip.gotoAndStop("empty");
				}
				
				puffleCaughtMc.gotoAndStop("lost");
				
				if (puffleObj != null && puffleObj.dead)
				{
					radarPuffleMc.gotoAndStop("hide");
				}
				else if (puffleObj == null)
				{
					radarPuffleMc.gotoAndStop("hide");
				}
				else
				{
					radarPuffleMc.gotoAndStop("show");
				}
			}
		}

		public function updatePuffles(numCaught:Number):void
		{
			if (this.mainAction == "gameplay" || this.mainAction == "win" || this.mainAction == "lose")
			{
				if (this.mainChanged == false)
				{
					this.penguinColor.color = this.game.penguinColor.color;
					this.movie.art.art.radar.player.skin.transform.colorTransform = this.penguinColor;
					
					if (this.mainAction == "win" || this.mainAction == "lose")
					{
						this.penguinColor.color = this.game.penguinColor.color;
						this.movie.art.art.art.skin.transform.colorTransform = this.penguinColor;
					}
					
					var puffle1Obj = this.game.objManager.getObj("puffle1Obj");
					this.updatePuffleCaught(numCaught, 1, this.movie.art.art.chip.puffle1, this.movie.art.art.radar.puffle1, puffle1Obj);
					
					var puffle2Obj = this.game.objManager.getObj("puffle2Obj");
					this.updatePuffleCaught(numCaught, 2, this.movie.art.art.chip.puffle2, this.movie.art.art.radar.puffle2, puffle2Obj);
					
					var puffle3Obj = this.game.objManager.getObj("puffle3Obj");
					this.updatePuffleCaught(numCaught, 3, this.movie.art.art.chip.puffle3, this.movie.art.art.radar.puffle3, puffle3Obj);
					
					var puffle4Obj = this.game.objManager.getObj("puffle4Obj");
					this.updatePuffleCaught(numCaught, 4, this.movie.art.art.chip.puffle4, this.movie.art.art.radar.puffle4, puffle4Obj);
					
					var puffle5Obj = this.game.objManager.getObj("puffle5Obj");
					this.updatePuffleCaught(numCaught, 5, this.movie.art.art.chip.puffle5, this.movie.art.art.radar.puffle5, puffle5Obj);
				}
			}
		}

		public function dispose():void
		{
			this.dead = true;
			this.gameplayHolder.removeChild(this.movie);
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