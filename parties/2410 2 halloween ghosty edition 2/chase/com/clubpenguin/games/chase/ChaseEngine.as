package com.clubpenguin.games.chase
{
	import com.clubpenguin.games.engine.GameEngine;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.*;
	import flash.ui.Keyboard;
	import com.clubpenguin.lib.vo.ext.EndGameVOExt;
	import org.osmf.logging.Log;
	import com.clubpenguin.games.container.Container;
	import com.clubpenguin.lib.util.xml.XMLUtil;

	public class ChaseEngine extends GameEngine
	{
		public static const PUFFLE_POINTS:Number = 20;
		
		public static const DEFAULT_ITEM_ID:Number = 93050;
		
		public var gameplayHolder:MovieClip;
		
		public var bgHolder:MovieClip;
		
		public var bgTileHolder:MovieClip;
		
		public var particleHolder:MovieClip;
		
		public var tileHolder:MovieClip;
		
		public var obstacleHolder:MovieClip;
		
		public var foregroundHolder:MovieClip;
		
		public var hudHolder:MovieClip;
		
		public var camPosX:Number;
      	
      	public var camPosY:Number;
      	
      	public var shakeCam:Boolean;
      	
      	public var lastCamPosX:Number;
      	
      	public var lastCamPosY:Number;
		
		public var timeRemainingN:Number;

		public var delayEnd:Boolean;

		public var delayEndN:Number;

		public var hasPuffle:Boolean;

		public var tutorialDone:Boolean;

		public var existingPufflesN:Number;

		public var speedUpPuffles:Boolean;

		public var chestWaitN:Number;

		public var chestWaitD:Number;

		public var coinsCollected:int;

		public var coinBonus:int;

		public var pufflesCaught:int;

		public var gameplayDone:Boolean;

		public var keyId:Number;

		public var randomPrizeID:Number;

		public var itemCollected:Boolean;

		public var puffleColor:String;
		
		public var uniqueNum:int = 0;

		public function ChaseEngine()
		{
			super();
		}

		override public function setup(_gameConfig:XML=null,_requiresUpdates:Boolean=false):void
		{
			super.setup(_gameConfig,_requiresUpdates);

			var gameStartParams:Object = this.host.getGameStartParams();

			this.gameplayDone = false;

			this.paused = true;

			this.camPosX = 0;
			this.lastCamPosX = 0;

			this.timeRemainingN = 24 * 45;

			this.delayEnd = false;
			this.delayEndN = 24 * 3;

			this.tutorialDone = false;

			this.shakeCam = false;

			this.existingPufflesN = 0;
			this.speedUpPuffles = false;

			this.chestWaitD = 2;
			this.chestWaitN = this.chestWaitD;

			this.coinsCollected = 0;
			this.coinBonus = 0;
			this.pufflesCaught = 0;

			this.hasPuffle = gameStartParams.useGhostPuffle == null ? false : Boolean(gameStartParams.useGhostPuffle);

			this.randomPrizeID = gameStartParams.itemId == null ? DEFAULT_ITEM_ID : gameStartParams.itemId;
			Log.getLogger(this.getUniqueName()).debug("randomPrizeID: " + this.randomPrizeID);
			
			// Prevent some other item from being given.
			if (this.randomPrizeID < 93045 || this.randomPrizeID > 93050)
			{
				this.randomPrizeID = DEFAULT_ITEM_ID;
			}

			this.keyId = gameStartParams.keyId;
			Log.getLogger(this.getUniqueName()).debug("keyId: " + this.keyId);
			
			switch (this.keyId)
			{
				case 11:
					this.puffleColor = "green";
					break;
				case 12:
					this.puffleColor = "yellow";
					break;
				case 13:
					this.puffleColor = "red";
					break;
				case 14:
					this.puffleColor = "blue";
					break;
				case 15:
					this.puffleColor = "purple";
					break;
				default:
					this.puffleColor = "green";
					break;
			}
			Log.getLogger(this.getUniqueName()).debug("puffleColor: " + this.puffleColor);
			
			this.soundManager.addObject(new SNDgameFail(), "gameFail");
			this.soundManager.addObject(new SNDgameMusicAmb(), "gameMusicAmb");
			this.soundManager.addObject(new SNDgameSuccess(), "gameSuccess");
			this.soundManager.addObject(new SNDmenuMusicAmb(), "menuMusicAmb");
			this.soundManager.addObject(new SNDcoinCollect(), "coinCollect");
			this.soundManager.addObject(new SNDgameStartSiren(), "gameStartSiren");
			this.soundManager.addObject(new SNDfootstep01(), "footstep01");
			this.soundManager.addObject(new SNDfootstep02(), "footstep02");
			this.soundManager.addObject(new SNDfootstep03(), "footstep03");
			this.soundManager.addObject(new SNDfootstep04(), "footstep04");
			this.soundManager.addObject(new SNDskidStop01(), "skidStop01");
			this.soundManager.addObject(new SNDskidStop02(), "skidStop02");
			this.soundManager.addObject(new SNDslideLoop(), "slideLoop");
			this.soundManager.addObject(new SNDslideStart01(), "slideStart01");
			this.soundManager.addObject(new SNDslideStart02(), "slideStart02");
			this.soundManager.addObject(new SNDpuffleBounce(), "puffleBounce");
			this.soundManager.addObject(new SNDpuffleCatch(), "puffleCatch");
			this.soundManager.addObject(new SNDpuffleRunAway(), "puffleRunAway");
			this.soundManager.addObject(new SNDpuffleTreasureCollect(), "treasureCollect");
			
			this.bgHolder = new MovieClip();
			this.addChild(this.bgHolder);
			
			this.bgTileHolder = new MovieClip();
			this.addChild(this.bgTileHolder);
			
			this.gameplayHolder = new MovieClip();
			this.addChild(this.gameplayHolder);
			
			this.tileHolder = new MovieClip();
			this.gameplayHolder.addChild(this.tileHolder);
			
			this.particleHolder = new MovieClip();
			this.addChild(this.particleHolder);
			
			this.hudHolder = new MovieClip();
			this.addChild(this.hudHolder);
			
			this.objManager.addObject(new Bg(this, 0, 0), "bgObj");
			
			this.obstacleHolder = new MovieClip();
         	this.gameplayHolder.addChild(this.obstacleHolder);
			
			var playerObj = new Player(this, 240, 169.5);
			this.objManager.addObject(playerObj, "playerObj");
			
			this.addColPoint("back", "colPointLObj");
			this.addColPoint("front", "colPointRObj");
			
			this.addColPoint("front", "colPointRObj");
			
			var playerPuffleObj;
			if (this.hasPuffle)
			{
				playerPuffleObj = new PlayerPuffle(this, 140, 170);
				this.objManager.addObject(playerPuffleObj, "playerPuffleObj");
			}

			var puffle1Obj = new Puffle(this, 1000, 200, "puffle1",this.puffleColor);
			this.objManager.addObject(puffle1Obj, "puffle1Obj");
			var puffle2Obj = new Puffle(this, 1400, 200, "puffle2",this.puffleColor);
			this.objManager.addObject(puffle2Obj, "puffle2Obj");
			var puffle3Obj = new Puffle(this, 1800, 200, "puffle3",this.puffleColor);
			this.objManager.addObject(puffle3Obj, "puffle3Obj");
			var puffle4Obj = new Puffle(this, 2200, 200, "puffle4",this.puffleColor);
			this.objManager.addObject(puffle4Obj, "puffle4Obj");
			var puffle5Obj = new Puffle(this, 2600, 200, "puffle5",this.puffleColor);
			this.objManager.addObject(puffle5Obj, "puffle5Obj");
			
			this.hud.addObject(new Hud(this,0,0), "hudObj");
			
			this.addColPoint("puffle1", "puffle1ColPoint");
			this.addColPoint("puffle2", "puffle2ColPoint");
			this.addColPoint("puffle3", "puffle3ColPoint");
			this.addColPoint("puffle4", "puffle4ColPoint");
			this.addColPoint("puffle5", "puffle5ColPoint");

			if (this.hasPuffle)
			{
				this.addColPoint("playerPuffle", "playerPuffleColPoint");
			}

			this.placeBgTile(0, 0, "backdrop1");
			this.placeTile(0, 0, "ground1");

			this.hud.addObject(new Popup(this, 0, 0, "pressDown"), "pressDownPopup");

			this.updateCam();

			this.configureCloseButton();

			this.playMenuMusic();
		}

		private function configureCloseButton():void
		{
			Log.getLogger(this.getUniqueName()).debug("add close button");

			var closeBtn:CloseButton = new CloseButton();
			this.addChild(closeBtn);
			closeBtn.x = stage.stageWidth - 15;
			closeBtn.y = 15;
			closeBtn.addEventListener(MouseEvent.CLICK,this.closeGame);
		}

		override public function pauseHandler():void
		{
			if (!this.tutorialDone)
			{
				if (this.inputMgr.isKeyDown(Keyboard.DOWN) || this.inputMgr.isKeyDown(Keyboard.S))
				{
					this.paused = false;
					this.tutorialDone = true;

					this.stopMenuMusic();
					this.playGameMusic();

					this.playSoundEffect("gameStartSiren");
				}
				
				this.hud.updateAll();
			
				this.purgeInactiveGameObjects();
			}
		}

		override public function updateMain():void
		{
			if (this.timeRemainingN > 0)
			{
				--this.timeRemainingN;
			}
			else if (!this.speedUpPuffles)
			{
				this.speedUpPuffles = true;
			}
			
			if (!this.delayEnd)
			{
				if (this.existingPufflesN < 1 && !this.isEndless())
				{
					this.delayEnd = true;
				}
			}
			
			var playerObj = this.objManager.getObj("playerObj");
			
			if (this.delayEnd)
			{
				if (this.delayEndN > 0)
				{
					--this.delayEndN;

					if (this.delayEndN > 12)
					{
						if (playerObj.pufflesCaughtN >= 5)
						{
							this.delayEndN = 12;
						}
					}
				}
				else if (playerObj.pufflesCaughtN > 0)
				{
					this.gameDone("win");
				}
				else
				{
					this.gameDone("lose");
				}
			}

			this.updateCam();
			this.shakeCam = false;
			
			this.objManager.updateAll();
			this.hud.updateAll();
			
			this.purgeInactiveGameObjects();
		}
		
		private function purgeObjects(container:Container):void
		{
			for (var objName in container.objects)
			{
				var object = container.objects[objName];
				
				if (object.hasOwnProperty("dead") && object.dead)
				{
					container.removeObject(objName);
					
					object.cleanupAttribs();
				}
			}
		}
		
		private function purgeInactiveGameObjects():void
		{
			this.purgeObjects(this.objManager);
			this.purgeObjects(this.hud);
		}

		public function updateCam():void
		{
			this.lastCamPosX = this.gameplayHolder.x;
			
			var playerObj = this.objManager.getObj("playerObj");
			this.camPosX = playerObj.movie.x * -1 + 240;

			if (this.camPosX < this.lastCamPosX)
			{
				this.gameplayHolder.x = this.camPosX;
				this.bgTileHolder.x = this.camPosX / 4;
				this.particleHolder.x = this.gameplayHolder.x;
			}

			if (this.shakeCam)
			{
				if (this.camPosY == 0)
				{
					this.camPosY = 0.1 * playerObj.motionX + playerObj.momentumX;
				}
				else
				{
					this.camPosY = 0;
				}
			}
			else
			{
				this.camPosY = 0;
			}

			this.gameplayHolder.y = this.camPosY;
		}

		public function playGameMusic():void
		{
			if (!this.host.isMusicMuted())
			{
				this.playSoundEffect("gameMusicAmb", true);
			}
		}

		public function stopGameMusic():void
		{
			this.soundManager.stop("gameMusicAmb");
		}

		public function playMenuMusic():void
		{
			if (!this.host.isMusicMuted())
			{
				this.playSoundEffect("menuMusicAmb", true);
			}
		}
		
		public function stopMenuMusic():void
		{
			this.soundManager.stop("menuMusicAmb");
		}

		public function playSoundEffect(sfxName:String, loop:Boolean = false):void
		{
			this.soundManager.play(sfxName, loop);
		}
		
		public function stopSlideLoop():void
		{
			this.soundManager.stop("slideLoop");
		}
		
		public function uniqueObjectName(objName: String):String
		{
			++this.uniqueNum;
			return objName + "-" + this.uniqueNum;
		}
		
		public function addColPoint(colType:String, instName:String):void
		{
			this.objManager.addObject(new ColPoint(this, colType), instName);
		}
		
		public function placeBgTile(startX:Number, startY:Number, mainAction:String):void
		{
			this.objManager.addObject(new BgTile(this, startX, startY, mainAction), this.uniqueObjectName("bgTile"));
		}

		public function placeTile(startX:Number, startY:Number, mainAction:String):void
		{
			var tileObj = new Tile(this, startX, startY, mainAction);
			this.objManager.addObject(tileObj, this.uniqueObjectName("tile"));

			if (this.chestWaitN > 0)
			{
				--this.chestWaitN;
			}
			else
			{
				this.chestWaitN = this.chestWaitD;
				this.placeObstacle(tileObj, tileObj.movie.x + 1420, tileObj.movie.y + 470, "chest", 0);
			}
		}

		public function placeObstacle(parentTile:Object, startX:Number, startY:Number, mainAction:String, offsetY:Number):void
		{
			this.objManager.addObject(new Obstacle(this, startX, startY, mainAction, parentTile, offsetY), this.uniqueObjectName("obstacle"));
		}

		public function placeParticle(startX:Number, startY:Number, movieArtRotation:Number, motionX:Number, motionY:Number, mainAction:String):void
		{
			this.objManager.addObject(new Particle(this, startX, startY, movieArtRotation, motionX, motionY, mainAction), this.uniqueObjectName("particle"));
		}
		
		public function isEndless():Boolean
		{
			return this.isDebugMode() && XMLUtil.getStringFromConfig(this.gameConfig, "endlessDebug", "").length != 0;
		}

		public function gameDone(doneState:String):void
		{
			var hudObj = this.hud.getObj("hudObj");
			
			this.paused = true;

			this.soundManager.stopAll();
			
			if (doneState == "lose")
			{
				hudObj.mainAction = "lose";
				hudObj.movie.setArtMain(hudObj.mainAction);
				hudObj.updatePuffles(this.pufflesCaught);

				this.playSoundEffect("gameFail");
			}
			else if (doneState == "win")
			{
				hudObj.mainAction = "win";
				hudObj.movie.setArtMain(hudObj.mainAction);
				hudObj.updatePuffles(this.pufflesCaught);
				
				hudObj.movie.art.art.art.puffle1.gotoAndStop(this.puffleColor);
				hudObj.movie.art.art.art.puffle2.gotoAndStop("hide");
				hudObj.movie.art.art.art.puffle3.gotoAndStop("hide");
				hudObj.movie.art.art.art.puffle4.gotoAndStop("hide");
				hudObj.movie.art.art.art.puffle5.gotoAndStop("hide");


				if (this.pufflesCaught > 0)
				{
					hudObj.movie.art.art.art.puffle1.gotoAndStop(this.puffleColor);
				}
				if (this.pufflesCaught > 1)
				{
					hudObj.movie.art.art.art.puffle2.gotoAndStop(this.puffleColor);
				}
				if (this.pufflesCaught > 2)
				{
					hudObj.movie.art.art.art.puffle3.gotoAndStop(this.puffleColor);
				}
				if (this.pufflesCaught > 3)
				{
					hudObj.movie.art.art.art.puffle4.gotoAndStop(this.puffleColor);
				}
				if (this.pufflesCaught > 4)
				{
					hudObj.movie.art.art.art.puffle5.gotoAndStop(this.puffleColor);
				}

				if (this.hasPuffle)
				{
					hudObj.movie.art.art.art.playerpuffle.gotoAndStop("show");
				}
				else
				{
					hudObj.movie.art.art.art.playerpuffle.gotoAndStop("hide");
				}

				this.playSoundEffect("gameSuccess");
			}
			
			this.gameplayDone = true;
			
			if (this.itemCollected)
			{
				this.host.purchaseItem(this.randomPrizeID);
			}

			setTimeout(this.closeGame, 5000);
		}

		public function getUniqueName():String
		{
			return "ChaseEngine";
		}

		public function getItem():void
		{
			Log.getLogger(this.getUniqueName()).debug("got item prize");

			this.itemCollected = true;
		}

		private function adjustScore():void
		{
			this.scoreN = this.coinsCollected + this.pufflesCaught * PUFFLE_POINTS + this.coinBonus;
		}

		public override function getEndGameVO():EndGameVOExt
		{
			this.adjustScore();

			Log.getLogger(this.getUniqueName()).debug("coins collected: " + this.coinsCollected + 
													  "\ncoins won from chests: " + this.coinBonus + 
													  "\npuffles caught: " + this.pufflesCaught + 
													  "\ntotal coins earned: " + this.scoreN + 
													  "\ngame done: " + this.gameplayDone + 
													  "\nkey id: " + this.keyId + 
													  "\nuseGoldPuffle: " + this.hasPuffle + 
													  "\nitemCollected: " + this.itemCollected + 
													  "\nrandomPrizeID: " + this.randomPrizeID);

			var endGameVO = super.getEndGameVO();
			
			var gameCompletedParams = {
				"useGoldPuffle": this.hasPuffle,
				"coinsEarned": Number(this.scoreN),
				"coinBonus": this.coinBonus,
				"pufflesCollected": this.pufflesCaught,
				"itemId": !this.itemCollected ? null : this.randomPrizeID,
				"gameCompleted": this.gameplayDone
			};
			
			// Unlocking the key now only requires 3 ghosts.
			if (this.pufflesCaught > 2)
			{
				switch (this.keyId)
				{
					case 11:
						gameCompletedParams.key11Found = true;
						break;
					case 12:
						gameCompletedParams.key12Found = true;
						break;
					case 13:
						gameCompletedParams.key13Found = true;
						break;
					case 14:
						gameCompletedParams.key14Found = true;
						break;
					case 15:
						break;
					default:
						gameCompletedParams.noKeyFound = true;
						break;
				}
			}
			else
			{
				switch (this.keyId)
				{
					case 11:
						gameCompletedParams.key11NotFound = true;
						break;
					case 12:
						gameCompletedParams.key12NotFound = true;
						break;
					case 13:
						gameCompletedParams.key13NotFound = true;
						break;
					case 14:
						gameCompletedParams.key14NotFound = true;
						break;
					case 15:
						break;
					default:
						gameCompletedParams.noKeyNotFound = true;
						break;
				}
			}

			endGameVO.setGameCompletedParams(gameCompletedParams);
			return endGameVO;
		}
		
		public function closeGame(evt:Event = null):void
		{
			this.dispose();
		}
		
		override public function dispose():void
		{
			this.paused = true;
			
			this.gameplayHolder = null;
			this.bgHolder = null;
			this.bgTileHolder = null;
			this.tileHolder = null;
			this.particleHolder = null;
			this.obstacleHolder = null;
			this.foregroundHolder = null;
			this.hudHolder = null;
			
			super.dispose();
		}
	}
}