package com.clubpenguin.games.engine
{
	import com.clubpenguin.game.ICPGame;
	import com.clubpenguin.game.ICPHost;
	import com.clubpenguin.games.container.Container;
	import com.clubpenguin.games.managers.InputMgr;
	import com.clubpenguin.games.managers.SoundManager;
	import com.clubpenguin.lib.vo.ext.EndGameVOExt;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.disney.coupler.ICouplerHost;
	import com.disney.lib.IDisposable;
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.utils.getTimer;

	public class GameEngine extends MovieClip implements ICPGame,IDisposable
	{
		protected static var _instance:GameEngine;
		
		public var soundManager:SoundManager;

		public var objManager:Container;

		public var hud:Container;
		
		public var inputMgr:InputMgr;
		
		public var levelN:uint;

		public var scoreN:int;

		public var penguinColor:ColorTransform;

		public var paused:Boolean = false;

		public var host:ICPHost;
		
		public var gameConfig:XML;
		
		public var debugDraw:Sprite;
		
		private var __gameEnded:Boolean = false;

		public function GameEngine()
		{
			super();
		}
		
		public static function get instance()
		{
			/*
			By the time this is called, __instance will always be set,
			so we don't need to check if it's undefined.
			*/
			return _instance;
		}
		
		public function setName(_str:String):void
		{
			this.name = _str;
		}
		
		public function startGame():void
		{
			this.soundManager = new SoundManager();
			this.objManager = new Container();
			this.hud = new Container();
			this.inputMgr = new InputMgr(this);
		}
		
		public function loadGame(_data:String, _err:String):void
		{
			// Unknown functionality; never used.
		}

		public function setHost(_hostEnvironment:ICouplerHost):void
		{
			this.host = _hostEnvironment as ICPHost;
		}
		
      	public function setup(_gameConfig:XML = null, _requiresUpdates:Boolean = false):void
		{
			// _requiresUpdates was never used.
			
			this.levelN = XMLUtil.getIntFromConfig(_gameConfig, "startLevel", 1);
			this.scoreN = XMLUtil.getIntFromConfig(_gameConfig, "startScore", 0);
			
			this.gameConfig = _gameConfig;
			
			this.penguinColor = new ColorTransform();
			penguinColor.color = this.host.getPlayerColor();

			this.addEventListener(Event.ENTER_FRAME,this.frameEvent);
		}

		public function getGameLevel():Number
		{
			return this.levelN;
		}

		public function getGameScore():Number
		{
			return this.scoreN;
		}
		
		public function getGameCoins():int
		{
			return int(this.scoreN / 10);
		}
		
		public function isDebugMode():Boolean
		{
			return XMLUtil.getStringFromConfig(this.gameConfig, "debugMode","").length != 0;
		}

		public function endGame():void
		{
			this.dispose();
		}

		public function pauseGame(_state:Boolean):void
		{
			this.paused = _state;
		}

		public function getSaveGame():String
		{
			/*
			Never used, but assumed to be boilerplate
			for something similar to SaveData for AS2
			games (i.e. Puffle Launch).
			*/
			
			return "";
		}

		public function nextLevel():void
		{
			++this.levelN;
		}

		public function frameEvent(evt:Event):void
		{
			if (!this.paused)
			{
				this.updateMain();
			}
			else
			{
				this.pauseHandler();
			}
			
			this.inputMgr.releasePressedKeys();
		}
		
		public function setupDebugDraw($parent:DisplayObjectContainer=null):void
		{
			// A place you can put debug stuff
			if (this.debugDraw == null)
			{
				this.debugDraw = new Sprite();
				this.debugDraw.mouseEnabled = false;
				
				if ($parent == null)
				{
					$parent = this;
				}
				
				$parent.addChild(this.debugDraw);
			}
		}

		public function updateMain():void
		{
			// Override this with game-specific functionality.
		}
		
		public function pauseHandler():void
		{
			// Override this to draw something when paused.
		}
		
		public function getElapsedTime(timestamp:Number, frameTime:Boolean=false):Number
		{
			// Utility function to get the time since a previous call to getTimer.
			
			var now = getTimer();
			
			if (frameTime)
			{
				now /= (1000 / this.stage.frameRate);
			}
			
			return now - timestamp;
		}
		
		public function getEndGameVO():EndGameVOExt
		{
			// Override this function to modify the EndGameVOExt.
			
			var endGameVO = new EndGameVOExt();
			endGameVO.setScore(this.scoreN);
			endGameVO.setShowEndGame(XMLUtil.getStringFromConfig(this.gameConfig, "showEndGame", "1").length != 0);
			return endGameVO;
		}
		
		public function dispose():void
		{
			// Safeguard against multiple calls.
			if (!this.__gameEnded)
			{
				this.__gameEnded = true;
				
				this.removeEventListener(Event.ENTER_FRAME,this.frameEvent);
			
				if (_instance == this)
				{
					_instance = null;
				}
				
				this.inputMgr.dispose();
				this.hud.dispose();
				this.soundManager.dispose();
				this.objManager.dispose();
				
				var endGameVO = this.getEndGameVO();
				this.host.showEndGame(endGameVO);
				endGameVO.dispose();
				
				this.host = null;
				
				this.penguinColor = null;
				
				this.gameConfig = null;
			}
		}
	}
}