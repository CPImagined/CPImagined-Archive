package com.clubpenguin.games.chase
{
	import flash.display.MovieClip;
	import com.clubpenguin.games.chase.movies.PlayerPuffleMC;
	
	internal class PlayerPuffle extends MovieClip
	{
		public static const CHANCE_INCREASE:Number = 10;
		
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

		public var inAir:Boolean;

		public var randomPrizeID:String;

		public var groundY:Number;

		public var displayingItem:Boolean;

		public var itemEarned:Boolean;

		public var cycleItemWaitD:Number;

		public var cycleItemWaitS:Number;

		public var cycleItemWaitE:Number;

		public var cycleItemWaitN:Number;

		public var lastCycleN:Number;

		public var cycleN:Number;

		public var cyclingPrize:Boolean;

		public var chanceToWin:Number;

		public function PlayerPuffle(param1:MovieClip, param2:Number, param3:Number)
		{
			super();
			this.game = param1;
			this.gameplayHolder = this.game.gameplayHolder;
			this.movie = new PlayerPuffleMC();
			this.gameplayHolder.addChild(this.movie);
			this.startX = param2;
			this.startY = param3;
			this.movie.x = this.startX;
			this.movie.y = this.startY;
			this.Xmouse = this.startX;
			this.Ymouse = this.startY;
			this.mainAction = "gold";
			this.mainChanged = true;
			this.subAction = "run";
			this.subChanged = false;
			this.mainActionFromStart = false;
			this.motionX = 0;
			this.motionY = 0;
			this.dead = false;
			this.inAir = true;
			this.groundY = this.startY;
			this.displayingItem = false;
			this.itemEarned = false;
			this.randomPrizeID = "coins";
			this.cycleItemWaitD = 1;
			this.cycleItemWaitS = this.cycleItemWaitD;
			this.cycleItemWaitE = 3;
			this.cycleItemWaitN = this.cycleItemWaitS;
			this.cyclingPrize = false;
			this.chanceToWin = 1;
			this.movie.setArtMain(this.mainAction);
			this.movie.setArtSub(this.subAction);
			this.movie.art.item.gotoAndStop("hide");
		}

		public function update():void
		{
			if (this.game.gameplayDone)
			{
				this.dispose();
				return;
			}
			
			var playerObj = this.game.objManager.getObj("playerObj");
			if (playerObj != null)
			{
				this.movie.x = (this.movie.x + (playerObj.movie.x - 100)) / 2;
			}
			
			if (this.inAir)
			{
				this.motionY += 2;
			}
			else
			{
				this.movie.y = this.groundY;
			}
			
			if (this.movie.y > this.groundY)
			{
				this.movie.y = this.groundY;
				this.inAir = false;
			}
			
			this.motionY *= 0.98;
			this.movie.y += this.motionY;
			
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
			
			if (this.mainAction == "gold")
			{
				if (this.subChanged == false)
				{
					if (this.movie.art.art.art.currentFrame == this.movie.art.art.art.totalFrames)
					{
						if (this.subAction == "unlock")
						{
							this.subAction = "run";
							this.subChanged = true;
						}
					}
				}
			}
			
			if (this.subChanged)
			{
				this.movie.setArtSub(this.subAction);
				this.subChanged = false;
			}
			
			if (this.displayingItem)
			{
				if (this.cyclingPrize)
				{
					if (this.cycleItemWaitN > 0)
					{
						--this.cycleItemWaitN;
					}
					else if (this.cycleItemWaitS < this.cycleItemWaitE)
					{
						this.cycleItemWaitS += 0.2;
						this.cycleItemWaitN = Math.floor(this.cycleItemWaitS);
						
						this.lastCycleN = this.cycleN;
						
						this.doCycle();
						this.doCycle();
						this.doCycle();
						this.doCycle();
						
						this.movie.art.item.art.art.gotoAndStop(this.cycleN);
					}
					else
					{
						this.cyclingPrize = false;
						
						if (this.randomPrizeID != "coins")
						{
							this.movie.art.item.art.art.gotoAndStop("id" + this.randomPrizeID);
							this.game.getItem();
							this.itemEarned = true;
						}
						else
						{
							this.movie.art.item.art.art.gotoAndStop("coins");
							this.game.coinBonus += 15;
						}
					}
				}
				if (this.movie.art.item.art.currentFrame == this.movie.art.item.art.totalFrames)
				{
					this.movie.art.item.gotoAndStop("hide");
					this.displayingItem = false;
				}
			}
		}
		
		private function doCycle(force:Boolean = false):void
		{
			if (force || this.cycleN == this.lastCycleN)
			{
				this.cycleN = Math.floor(Math.random() * (this.movie.art.item.art.art.totalFrames + 1));
			}
		}

		public function unlockChest():void
		{
			this.subAction = "unlock";
			this.subChanged = true;
			
			this.movie.art.item.gotoAndStop("hide");
			this.movie.art.item.gotoAndStop("show");
			
			this.displayingItem = true;
			this.cyclingPrize = true;
			
			this.cycleItemWaitS = this.cycleItemWaitD;
			this.cycleItemWaitN = this.cycleItemWaitS;
			
			this.doCycle(true);
			this.movie.art.item.art.art.gotoAndStop(this.cycleN);
			
			if (this.itemEarned)
			{
				this.randomPrizeID = "coins";
			}
			else if (Math.floor(Math.random() * 100) < this.chanceToWin)
			{
				this.randomPrizeID = this.game.randomPrizeID.toString();
			}
			else
			{
				this.randomPrizeID = "coins";
				
				// Increase the odds of winning the item.
				this.chanceToWin += CHANCE_INCREASE;
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