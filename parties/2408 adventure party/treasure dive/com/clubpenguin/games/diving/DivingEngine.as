package com.clubpenguin.games.diving
{
	import com.clubpenguin.games.engine.GameEngine;
	import com.clubpenguin.games.diving.Player;
	import com.clubpenguin.games.diving.gui.TitleMC;
	import com.clubpenguin.games.diving.gui.EndMC;
	import com.clubpenguin.games.diving.gui.GameHUD;
	import com.clubpenguin.games.diving.Environment;
	import com.clubpenguin.games.diving.Puffle;
	import com.clubpenguin.games.diving.BubbleContainer;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleMgr;
	import com.clubpenguin.games.camera.Camera;
	import com.clubpenguin.games.diving.sfx.SubPing;
	import com.clubpenguin.games.diving.sfx.HitFish;
	import com.clubpenguin.games.diving.sfx.TreasureReturn;
	import com.clubpenguin.games.diving.sfx.ChestThump;
	import com.clubpenguin.games.diving.sfx.ChestGrab;
	import com.clubpenguin.games.diving.sfx.CrabPushChest;
	import com.clubpenguin.games.diving.sfx.TimerWarning;
	import com.clubpenguin.games.diving.sfx.TimerDone;
	import com.clubpenguin.games.diving.sfx.BackgroundMusic;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.Sprite;

	public class DivingEngine extends GameEngine
	{
		public static const GAME_STATE_TITLE:uint = 0;
		public static const GAME_STATE_PLAY:uint = 1;
		public static const GAME_STATE_END:uint = 2;
		
		public var scoreThisRound:int = 0;

		public var gameState:uint;
		
		public var obstacleMgr:DivingObstacleMgr;
		
		public var hasBrownPuffle:Boolean = false;
		
		public var wallBounds:Rectangle;

		public function DivingEngine()
		{
			GameEngine._instance = this;

			super();
		}
		
		public static function get instance()
		{
			return GameEngine.instance;
		}

		override public function setup(_gameConfig:XML = null, param2:Boolean = false):void
		{
			super.setup(_gameConfig);
			
			// Setup all the sfx
			this.soundManager.addObject(new SubPing(), "sub_ping");
			this.soundManager.addObject(new HitFish(), "hit_fish");
			this.soundManager.addObject(new TreasureReturn(), "treasure_return");
			this.soundManager.addObject(new ChestThump(), "chest_thump");
			this.soundManager.addObject(new ChestGrab(), "chest_grab");
			this.soundManager.addObject(new CrabPushChest(), "crab_push_chest");
			this.soundManager.addObject(new TimerWarning(), "timer_warning");
			this.soundManager.addObject(new TimerDone(), "timer_done");
			this.soundManager.addObject(new BackgroundMusic(), "bgm");
			
			this.soundManager.changeVolume("bgm", 0.45);
			this.soundManager.changeVolume("sub_ping", 0.65);
			this.soundManager.changeVolume("hit_fish", 0.5);
			
			/*
			This is the root for the camera; the GUI is parented
			to the engine itself so it doesn't move.
			*/
			
			var sceneRoot = new Sprite();
			
			this.addChild(sceneRoot);

			var player = new Player();
			var titleMc = new TitleMC();
			var endMc = new EndMC();
			var mainHud = new GameHUD();
			var environmentMc = new Environment();
			var cam = new Camera();
			var bubbleContainer = new BubbleContainer();
			
			this.objManager.addObject(cam, "camera");
			
			this.hud.addObject(titleMc, "title");
			this.addChild(titleMc);
			
			this.hud.addObject(mainHud, "mainHud");
			this.addChild(mainHud);
			
			this.hud.addObject(endMc, "end");
			this.addChild(endMc);

			this.objManager.addObject(environmentMc, "environment");
			sceneRoot.addChild(environmentMc);

			this.objManager.addObject(player, "player");
			sceneRoot.addChild(player);
			
			this.objManager.addObject(bubbleContainer, "bubbleMgr");
			
			this.obstacleMgr = new DivingObstacleMgr();
			
			// Check if we're walking a brown puffle.
			var gameStartParams = this.host.getGameStartParams();
			this.hasBrownPuffle = gameStartParams.hasBrownPuffle == null ? false : Boolean(gameStartParams.hasBrownPuffle);
			
			if (this.hasBrownPuffle)
			{
				var puffle = new Puffle();
				this.objManager.addObject(puffle, "puffle");
				sceneRoot.addChild(puffle);
			}
			
			cam.target = player;
			cam.parent = sceneRoot;
			cam.zoom = XMLUtil.getFloatFromConfig(_gameConfig, "cameraZoom", 1.0);
			cam.scrollRate = XMLUtil.getFloatFromConfig(_gameConfig, "cameraScrollRate", 0.5);
			
			var boundsInfo = XMLUtil.getArrayFromConfig(_gameConfig, "camBoundsInfo", []);
			if (boundsInfo.length != 0)
			{
				cam.boundsRect = new Rectangle(boundsInfo[0], boundsInfo[1], boundsInfo[2], boundsInfo[3]);
			}
			
			boundsInfo = XMLUtil.getArrayFromConfig(_gameConfig, "wallBoundsInfo", []);
			if (boundsInfo.length != 0)
			{
				this.wallBounds = new Rectangle(boundsInfo[0], boundsInfo[1], boundsInfo[2], boundsInfo[3]);
			}
			
			if (this.isDebugMode() && XMLUtil.getStringFromConfig(_gameConfig, "wallBoundsDebug","").length != 0)
			{
				this.setupDebugDraw();
				
				this.debugDraw.graphics.beginFill(0x000000, 0.25);
				this.debugDraw.graphics.drawRect(this.wallBounds.x, this.wallBounds.y, this.wallBounds.width, this.wallBounds.height);
				this.debugDraw.graphics.endFill();
			}
			
			var spawnerInfo = XMLUtil.getArrayFromConfig(_gameConfig, "spawnerInfo", []);
			for each (var info in spawnerInfo)
			{
				var attrs = new Array();
				
				for each (var attr in info.children())
				{
					attrs.push(attr);
				}
				
				this.obstacleMgr.addSpawner(new Point(attrs[0], attrs[1]), attrs[2], attrs[3], attrs[4], attrs[5], attrs[6]);
			}

			this.setGameState(GAME_STATE_TITLE);
		}

		public function setGameState(gameState:uint):void
		{
			this.gameState = gameState;

			var player = this.objManager.getObj("player");
			var puffle = this.objManager.getObj("puffle");
			var titleMc = this.hud.getObj("title");
			var mainHud = this.hud.getObj("mainHud");
			var endMc = this.hud.getObj("end");
			var environmentMc = this.objManager.getObj("environment");
			var bubbleMgr = this.objManager.getObj("bubbleMgr");

			// This logic only needs to be ran once so it is outside the main loop.
			switch (this.gameState)
			{
				case GAME_STATE_TITLE:
					this.soundManager.playIfNotPlaying("bgm", true);
					titleMc.visible = true;
					player.visible = false;
					mainHud.visible = false;
					endMc.visible = false;
					environmentMc.visible = false;
					
					titleMc.instructions.puffle_txt.visible = false;
					titleMc.instructions.puffle_mc.visible = false;
					
					if (this.hasBrownPuffle)
					{
						puffle.visible = false;
						titleMc.instructions.puffle_txt.visible = true;
						titleMc.instructions.puffle_mc.visible = true;
					}
					
					break;
				case GAME_STATE_PLAY:
					this.addScore(0);
					
					player.reset();
					this.obstacleMgr.resetSpawners();
				
					titleMc.visible = false;
					player.visible = true;
					mainHud.visible = true;
					endMc.visible = false;
					
					if (this.hasBrownPuffle)
					{
						puffle.reset();
						
						puffle.visible = true;
					}
					
					environmentMc.visible = true;
					
					// Kickoff the spawners.
					this.obstacleMgr.startSpawners();
					
					// Kickoff the timer.
					mainHud.startTimer();
					break;
				case GAME_STATE_END:
					titleMc.visible = false;
					
					// Stop the blinking so not visible.
					player.stopBlinking();
					
					/*
					Detach chest so the dummy animation
					chest isn't leftover.
					*/
					player.chest = null;
					
					// Get rid of every bubble.
					bubbleMgr.removeAllBubbles();
					
					// Reset in case the player wants to play again.
					this.obstacleMgr.removeObstacles();
					this.obstacleMgr.resetSpawners();
					
					player.visible = false;
					mainHud.visible = false;
					
					// Give the player their results.
					endMc.tallyResults();
					
					endMc.visible = true;
					endMc.play();
					
					if (this.hasBrownPuffle)
					{
						puffle.visible = false;
					}
					
					environmentMc.visible = false;
					break;
			}
		}
		
		public function addScore(score: int):void
		{
			if (score == 0)
			{
				// Reset
				this.scoreThisRound = 0;
			}
			else
			{
				this.scoreThisRound += score;
				
				this.scoreN += score;
			}
			
			this.hud.getObj("mainHud").score_txt.text = this.scoreThisRound;
		}
		
		public function get timeLeft():Number
		{
			return this.hud.getObj("mainHud").timeLeft;
		}

		override public function updateMain():void
		{
			switch (this.gameState)
			{
				case GAME_STATE_TITLE:
					break;
				case GAME_STATE_PLAY:
					var player = this.objManager.getObj("player");
					var cam = this.objManager.getObj("camera");
					var bubbleMgr = this.objManager.getObj("bubbleMgr");

					player.update();
					
					if (this.hasBrownPuffle)
					{
						this.objManager.getObj("puffle").update();
					}
					
					cam.update();
					
					this.obstacleMgr.updateAll();
					bubbleMgr.updateAll();
					break;
				case GAME_STATE_END:
					break;
			}
		}
		
		override public function dispose():void
		{
			this.obstacleMgr.dispose();
			
			super.dispose();
		}
	}
}