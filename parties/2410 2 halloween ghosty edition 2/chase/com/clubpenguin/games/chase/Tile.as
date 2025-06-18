package com.clubpenguin.games.chase
{
	import com.clubpenguin.games.chase.movies.TileMC;
   	import flash.display.MovieClip;
	
	internal class Tile extends MovieClip
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

		public var t:Number;

		public var Xmouse:Number;

		public var Ymouse:Number;

		public var motionX:Number;

		public var motionY:Number;

		public var dead:Boolean;

		public var playerColChecked:Boolean;

		public var playerFrontChecked:Boolean;

		public var playerBackChecked:Boolean;

		public var colPointP1Checked:Boolean;

		public var colPointP2Checked:Boolean;

		public var colPointP3Checked:Boolean;

		public var colPointP4Checked:Boolean;

		public var colPointP5Checked:Boolean;

		public var colPointGChecked:Boolean;

		public var tempPointP1:Number;

		public var tempPointP2:Number;

		public var tempPointP3:Number;

		public var tempPointP4:Number;

		public var tempPointP5:Number;

		public var tempPointG:Number;

		public var px:Number;

		public var py:Number;

		public var childPlaced:Boolean;

		public var colPointLChecked:Boolean;

		public var colPointRChecked:Boolean;

		public var tempPointL:Number;

		public var tempPointR:Number;

		public var collisionOccured:Boolean;

		public function Tile(param1:MovieClip, param2:Number, param3:Number, param4:String)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.tileHolder;
			this.movie = new TileMC();
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
			this.playerColChecked = false;
			this.playerFrontChecked = false;
			this.playerBackChecked = false;
			this.childPlaced = false;
			this.colPointLChecked = false;
			this.colPointRChecked = false;
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
			
			if (this.mainAction == "ground2")
			{
				this.game.placeObstacle(this,this.movie.x + 230,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 330,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 430,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 530,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground3")
			{
				this.game.placeObstacle(this,this.movie.x + 230,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 330,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 430,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 530,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground4")
			{
				this.game.placeObstacle(this,this.movie.x + 230,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 330,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 430,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 530,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground5")
			{
				this.game.placeObstacle(this,this.movie.x + 230,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 330,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 430,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 530,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground6")
			{
				this.game.placeObstacle(this,this.movie.x + 360,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 460,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 560,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 660,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 760,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 860,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 960,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground7")
			{
				this.game.placeObstacle(this,this.movie.x + 980,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 1080,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 1180,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground8")
			{
				this.game.placeObstacle(this,this.movie.x + 260,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 360,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 460,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 560,this.movie.y + 470,"coin",-90);
			}
			else if (this.mainAction == "ground9")
			{
				this.game.placeObstacle(this,this.movie.x + 345,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 445,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 545,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 645,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 745,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 845,this.movie.y + 470,"coin",-90);
				this.game.placeObstacle(this,this.movie.x + 945,this.movie.y + 470,"coin",-90);
			}
		}

		public function update():void
		{
			if (this.game.gameplayDone)
			{
				this.dispose();
				return;
			}
			
			var colPointLObj = this.game.objManager.getObj("colPointLObj");
			
			this.colPointLChecked = false;
			this.tempPointL = 470 + this.game.gameplayHolder.y;
			this.colCheck(this.shiftPointL, this.colPointLChecked);
			
			if (this.collisionOccured && colPointLObj != null)
			{
				colPointLObj.updateYpos(this.tempPointL);
			}
			
			var colPointRObj = this.game.objManager.getObj("colPointRObj");
			
			this.colPointRChecked = false;
			this.tempPointR = 470 + this.game.gameplayHolder.y;
			this.colCheck(this.shiftPointR, this.colPointRChecked);
			
			if (this.collisionOccured && colPointRObj != null)
			{
				colPointRObj.updateYpos(this.tempPointR);
			}
			
			var playerObj = this.game.objManager.getObj("playerObj");
			
			if (playerObj != null && colPointLObj != null && colPointRObj != null)
			{
				playerObj.groundY = (colPointLObj.movie.y + colPointRObj.movie.y) / 2;
			}
			
			if (playerObj != null && colPointRObj != null)
			{
				playerObj.groundY = colPointRObj.movie.y;
			}
			
			var puffle1Obj = this.game.objManager.getObj("puffle1Obj");
			var puffle2Obj = this.game.objManager.getObj("puffle2Obj");
			var puffle3Obj = this.game.objManager.getObj("puffle3Obj");
			var puffle4Obj = this.game.objManager.getObj("puffle4Obj");
			var puffle5Obj = this.game.objManager.getObj("puffle5Obj");
			var colPointP1Obj = this.game.objManager.getObj("puffle1ColPoint");
			var colPointP2Obj = this.game.objManager.getObj("puffle2ColPoint");
			var colPointP3Obj = this.game.objManager.getObj("puffle3ColPoint");
			var colPointP4Obj = this.game.objManager.getObj("puffle4ColPoint");
			var colPointP5Obj = this.game.objManager.getObj("puffle5ColPoint");
			
			if (puffle1Obj != null && colPointP1Obj != null)
			{
				puffle1Obj.groundY = colPointP1Obj.movie.y;
			}
			if (puffle2Obj != null && colPointP2Obj != null)
			{
				puffle2Obj.groundY = colPointP2Obj.movie.y;
			}
			if (puffle3Obj != null && colPointP3Obj != null)
			{
				puffle3Obj.groundY = colPointP3Obj.movie.y;
			}
			if (puffle4Obj != null && colPointP4Obj != null)
			{
				puffle4Obj.groundY = colPointP4Obj.movie.y;
			}
			if (puffle5Obj != null && colPointP5Obj != null)
			{
				puffle5Obj.groundY = colPointP5Obj.movie.y;
			}
			
			var playerPuffleObj = this.game.objManager.getObj("playerPuffleObj");
			var playerPuffleColPointObj = this.game.objManager.getObj("playerPuffleColPoint");
			
			if (this.game.hasPuffle && playerPuffleObj != null)
			{
				playerPuffleObj.groundY = playerPuffleColPointObj.movie.y;
			}
			
			this.colPointP1Checked = false;
			this.tempPointP1 = 470;
			this.colCheck(this.shiftPointP1, this.colPointP1Checked);
			
			if (this.collisionOccured && colPointP1Obj != null)
			{
				colPointP1Obj.updateYpos(this.tempPointP1);
			}
			
			this.colPointP2Checked = false;
			this.tempPointP2 = 470;
			this.colCheck(this.shiftPointP2, this.colPointP2Checked);
			
			if (this.collisionOccured && colPointP2Obj != null)
			{
				colPointP2Obj.updateYpos(this.tempPointP2);
			}
			
			this.colPointP3Checked = false;
			this.tempPointP3 = 470;
			this.colCheck(this.shiftPointP3, this.colPointP3Checked);
			
			if (this.collisionOccured && colPointP3Obj != null)
			{
				colPointP3Obj.updateYpos(this.tempPointP3);
			}
			
			this.colPointP4Checked = false;
			this.tempPointP4 = 470;
			this.colCheck(this.shiftPointP4, this.colPointP4Checked);
			
			if (this.collisionOccured && colPointP4Obj != null)
			{
				colPointP4Obj.updateYpos(this.tempPointP4);
			}
			
			this.colPointP5Checked = false;
			this.tempPointP5 = 470;
			this.colCheck(this.shiftPointP5, this.colPointP5Checked);
			
			if (this.collisionOccured && colPointP5Obj != null)
			{
				colPointP5Obj.updateYpos(this.tempPointP5);
			}
			
			if (this.game.hasPuffle)
			{
				this.colPointGChecked = false;
				this.tempPointG = 470;
				this.colCheck(this.shiftPointG, this.colPointGChecked);
				
				if (this.collisionOccured && playerPuffleColPointObj != null)
				{
					playerPuffleColPointObj.updateYpos(this.tempPointG);
				}
			}
			
			if (this.childPlaced == false)
			{
				// Place the next Tile.
				if (this.movie.x + this.game.gameplayHolder.x <= 0)
				{
					this.childPlaced = true;
					this.t = Math.floor(Math.random() * 8) + 2;
					this.game.placeTile(this.movie.x + 1520, this.movie.y, "ground" + this.t);
				}
			}
			else if (this.movie.x + this.game.gameplayHolder.x < -1520)
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
		
		private function colCheck(callback:Function, checked:Boolean):void
		{
			this.collisionOccured = false;
			this.p = 0;
			
			while (this.p < 100)
			{
				if (!checked)
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
		
		private function shiftColPoint(tempPoint:String, xStart:Number, xOffset:Number, checked:String):void
		{
			this.px = xStart + this.game.gameplayHolder.x + xOffset * 2;
			this.py = this[tempPoint] + this.game.gameplayHolder.y;
			
			if (this.movie.art.art.collision.hitTestPoint(this.px, this.py - 100, true))
			{
				this[tempPoint] -= 100;
				this.collisionOccured = true;
			}
			else if (this.movie.art.art.collision.hitTestPoint(this.px, this.py - 50, true))
			{
				this[tempPoint] -= 50;
				this.collisionOccured = true;
			}
			else if (this.movie.art.art.collision.hitTestPoint(this.px, this.py - 20, true))
			{
				this[tempPoint] -= 20;
				this.collisionOccured = true;
			}
			else if (this.movie.art.art.collision.hitTestPoint(this.px, this.py - 10, true))
			{
				this[tempPoint] -= 10;
				this.collisionOccured = true;
			}
			else if (this.movie.art.art.collision.hitTestPoint(this.px, this.py - 5, true))
			{
				this[tempPoint] -= 5;
				this.collisionOccured = true;
			}
			else if (this.movie.art.art.collision.hitTestPoint(this.px, this.py - 2, true))
			{
				this[tempPoint] -= 2;
				this.collisionOccured = true;
			}
			else if (this.movie.art.art.collision.hitTestPoint(this.px, this.py, true))
			{
				this[checked] = true;
			}
			else
			{
				this[checked] = true;
			}
		}

		private function shiftPointL():void
		{
			var playerObj = this.game.objManager.getObj("playerObj");
			
			if (playerObj != null)
			{
				this.shiftColPoint("tempPointL", playerObj.movie.x - 10, (playerObj.motionX + playerObj.momentumX), "colPointLChecked");
			}
		}

		private function shiftPointR():void
		{
			var playerObj = this.game.objManager.getObj("playerObj");
			
			if (playerObj != null)
			{
				this.shiftColPoint("tempPointR", playerObj.movie.x + 10, (playerObj.motionX + playerObj.momentumX), "colPointRChecked");
			}
		}

		private function shiftPointP1():void
		{
			var puffle1Obj = this.game.objManager.getObj("puffle1Obj");
			
			if (puffle1Obj != null)
			{
				this.shiftColPoint("tempPointP1", puffle1Obj.movie.x, puffle1Obj.motionX, "colPointP1Checked");
			}
		}

		private function shiftPointP2():void
		{
			var puffle2Obj = this.game.objManager.getObj("puffle2Obj");
			
			if (puffle2Obj != null)
			{
				this.shiftColPoint("tempPointP2", puffle2Obj.movie.x, puffle2Obj.motionX, "colPointP2Checked");
			}
		}

		private function shiftPointP3():void
		{
			var puffle3Obj = this.game.objManager.getObj("puffle3Obj");
			
			if (puffle3Obj != null)
			{
				this.shiftColPoint("tempPointP3", puffle3Obj.movie.x, puffle3Obj.motionX, "colPointP3Checked");
			}
		}

		private function shiftPointP4():void
		{
			var puffle4Obj = this.game.objManager.getObj("puffle4Obj");
			
			if (puffle4Obj != null)
			{
				this.shiftColPoint("tempPointP4", puffle4Obj.movie.x, puffle4Obj.motionX, "colPointP4Checked");
			}
		}

		private function shiftPointP5():void
		{
			var puffle5Obj = this.game.objManager.getObj("puffle5Obj");
			
			if (puffle5Obj != null)
			{
				this.shiftColPoint("tempPointP5", puffle5Obj.movie.x, puffle5Obj.motionX, "colPointP5Checked");
			}
		}

		private function shiftPointG():void
		{
			if (this.game.hasPuffle)
			{
				var playerObj = this.game.objManager.getObj("playerObj");
				var playerPuffleObj = this.game.objManager.getObj("playerPuffleObj");
				
				if (playerObj != null && playerPuffleObj != null)
				{
					this.shiftColPoint("tempPointG", playerPuffleObj.movie.x, playerObj.motionX, "colPointGChecked");
				}
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