package com.clubpenguin.coupler
{
	import com.clubpenguin.game.HostAccess;
	import com.clubpenguin.game.ICPGame;
	import com.clubpenguin.game.ICPGameHost;
	import com.clubpenguin.game.ICPHost;
	import com.clubpenguin.lib.IDisposable;
	import com.clubpenguin.lib.locale.ILocaleHandler;
	import com.clubpenguin.lib.locale.LocaleHandler;
	import com.clubpenguin.lib.security.ISecurityHandler;
	import com.clubpenguin.lib.security.SecurityHandler;
	import com.clubpenguin.lib.vo.IEndGameVO;
	import com.clubpenguin.lib.vo.IPlayerVO;
	import com.clubpenguin.lib.vo.MPGameVO;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.disney.coupler.*;
	import com.disney.loader.SWFLoader;
	import com.disney.loader.XMLLoader;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import org.osflash.signals.Signal;

	public class GameCouplerCP extends GameCoupler implements ICouplerHost, ICouplerGame, ICPHost, ICPGameHost, ICPGame, IDisposable
	{
		private const DEFAULT_LOCALE:String = "en";

		protected var __contentSchema:XML;

		protected var __context:LoaderContext;

		protected var __defaultContentSchema:XML;

		private var __currentFPS:Number;

		private var __hostFPS:Number;

		protected var __localeHandler:ILocaleHandler;

		protected var __securityHandler:ISecurityHandler;

		public function GameCouplerCP()
		{
			super();
			
			// An empty XML file
			this.__defaultContentSchema = new XML();

			this.__context = new LoaderContext();
			this.__context.applicationDomain = ApplicationDomain.currentDomain;

			if (Security.sandboxType == Security.REMOTE)
			{
				this.__context.securityDomain = SecurityDomain.currentDomain;
			}

			addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
		}

		protected function onAddedToStageHandler(_eventObj:Event):void
		{
			if (_eventObj.target == this)
			{
				trace(this.getUniqueName() + " CRITICAL: Coupler was added to the stage. It is either root or was attached improperly");
				
				removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
			}
		}

		override public function setHost(_host:ICouplerHost):void
		{
			if (_host as ICPHost == null)
			{
				throw this.getUniqueName() + " host is not a valid ICPHost";
			}

			super.setHost(_host);

			removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
			this.generateContentSchema();
		}


		protected function checkSecurity():void
		{
			this.__securityHandler = new SecurityHandler();
			this.__securityHandler.getSecurityCheckSuccess().add(this.onSecurityCheckSuccess);
			this.__securityHandler.doSecurityCheck(this);
		}

		private function onSecurityCheckSuccess():void
		{
			trace(this.getUniqueName() + " security check passed!");
			
			this.generateContentSchema();
		}

		override public function setGame(_game:ICouplerGame):void
		{
			if (_game as ICPGame == null)
			{
				throw this.getUniqueName() + " game is not a valid ICPGame";
			}
			
			super.setGame(_game);
		}

		protected function generateContentSchema():void
		{
			new XMLLoader(this.getBaseConfigPath() + this.getConfigName(),this.onConfigLoaded);
		}
		
		public function getConfigName():String
		{
			// Allow overriding the base XML file
			return "config.xml";
		}

		private function onConfigLoaded(_data:XML):void
		{
			if (_data != null)
			{
				this.__contentSchema = _data;
			}
			else
			{
				this.__contentSchema = this.__defaultContentSchema;
			}
			
			this.sendContentSchema();
		}

		protected function sendContentSchema():void
		{
			if (this.__contentSchema == null)
			{
				throw this.getUniqueName() + " contentSchema is null. Can not proceed.";
			}
			
			this.loadGameAssets();
		}

		protected function loadGameAssets():void
		{
			if (XMLUtil.getStringFromConfig(this.__contentSchema, "gameAssets","").length != 0)
			{
				// Points out another SWF file containing assets to load
				trace(this.getUniqueName() + " loadingGameAssets " + this.__contentSchema.gameAssets);
				
				new SWFLoader(this.getBasePath() + this.__contentSchema.gameAssets,this.onAssetsLoaded,this.__context);
			}
			else
			{
				this.setupGameSpace();
			}
		}

		private function onAssetsLoaded(_content:DisplayObject):void
		{
			trace(this.getUniqueName() + " loaded assets, next: setupGameSpace()");
		
			this.setupGameSpace();
		}

		protected function setupGameSpace():void
		{
			var hostLocaleID:int = 0;
			var configLocaleName:String = null;

			this.__localeHandler = new LocaleHandler();
			this.__localeHandler.setGameURL(this.getBasePath());

			hostLocaleID = this.__host.getLocale();
			if (hostLocaleID != -1)
			{
				this.__localeHandler.setLocaleByID(hostLocaleID);
			}
			else
			{
				// Force a specific locale via the XML (defaults to English)
				configLocaleName = XMLUtil.getStringFromConfig(this.__contentSchema, "gameLocale", this.DEFAULT_LOCALE);
				this.__localeHandler.setLocaleByName(configLocaleName);
			}
			
			// Point out SWF files containing localized assets
			var localeAssets = XMLUtil.getArrayFromConfig(this.__contentSchema, "gameLocaleAssets", []);
			var wantLocaleAssets = localeAssets.length != 0;
			if (wantLocaleAssets)
			{
				trace(this.getUniqueName() + " found locale assets to load");
				
				this.__localeHandler.setLocaleAssetNames(localeAssets);
			}
			
			// Point out XML files containing localized text
			var localeText = XMLUtil.getArrayFromConfig(this.__contentSchema, "gameLocaleText", []);
			var wantLocaleText = localeText.length != 0;
			if (wantLocaleText)
			{
				trace(this.getUniqueName() + " found locale text to load");
				
				this.__localeHandler.setLocaleAssetNames(localeText);
			}
			
			if (wantLocaleAssets || wantLocaleText)
			{
				trace(this.getUniqueName() + " loading locale file");
				
				this.__localeHandler.load(this.onLocaleLoaded);
			}
			else
			{
				trace(this.getUniqueName() + " bypass locale file");
				
				this.onLocaleLoaded(true);
			}
		}

		private function onLocaleLoaded(successful:Boolean):void
		{
			if (successful)
			{
				trace(this.getUniqueName() + " locale loaded ok!");
				
				HostAccess.setHost(this);
				this.setupGame();
				return;
			}
			throw this.getUniqueName() + " unsuccessful locale load!";
		}

		protected function setupGame():void
		{
			trace(this.getUniqueName() + " setupGame()");
		
			try
			{
				this.createGame(this.__contentSchema.gameClass);
			}
			catch (e:Error)
			{
				throw e;
			}
		}

		protected function addGameToHost():void
		{
			if (this.__host == null)
			{
				throw this.getUniqueName() + " Error: Attempted to attach game to a host that has not been set.";
			}
			
			this.__host.addChild(this.__game as DisplayObject);
			this.__game.startGame();
		}

		protected function createGame(_gameClassName:String):void
		{
			var gameClass:Class = null;
			var game:ICPGame = null;
			
			trace(this.getUniqueName() + " trying to create game from " + _gameClassName);
			
			gameClass = loaderInfo.applicationDomain.getDefinition(_gameClassName) as Class;
			game = new gameClass();
			this.prepareGame(game);
		}

		protected function prepareGame(_game:ICPGame):void
		{
			trace(this.getUniqueName() + " Game is " + _game);
		
			_game.setName("mcGameEngine");
			this.setGame(_game as ICouplerGame);
			this.addGameToHost();
			_game.setHost(this.__host as ICouplerHost);
			_game.setup(this.__contentSchema);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
		}

		override public function getUniqueName():String
		{
			return "[GameCouplerClubPenguin" + __uid + "]";
		}

		public function endGame():void
		{
			// This function only gets called by the host to cleanup Metaplace games.
			this.__game.endGame();
		}

		public function getLocale():int
		{
			return this.__localeHandler.getLocaleID();
		}

		public function localizeString(_stringID:String):String
		{
			return this.__localeHandler.getString(_stringID);
		}

		public function localizeImage(_imageID:String):DisplayObject
		{
			return this.__localeHandler.getImage(_imageID);
		}

		public function getPlayerVO():IPlayerVO
		{
			return this.__host.getPlayerVO();
		}

		public function showEndGame(endGameVO:IEndGameVO):void
		{
			this.__host.showEndGame(endGameVO);
		}

		public function getBasePath():String
		{
			return this.__host.getBasePath();
		}

		public function getBaseConfigPath():String
		{
			return this.__host.getBasePath();
		}

		public function showMembershipPrompt(_filename:String, _biTag:String = null):void
		{
			this.__host.showMembershipPrompt(_filename,_biTag);
		}

		public function isMusicMuted():Boolean
		{
			return this.__host.isMusicMuted();
		}

		public function stampEarned(_stampID:int, _isServerSide:Boolean = false):void
		{
			this.__host.stampEarned(_stampID,_isServerSide);
		}

		public function isStampEarned(_stampID:int):Boolean
		{
			return this.__host.isStampEarned(_stampID);
		}

		public function levelComplete(_level:int):void
		{
			this.__host.levelComplete(_level);
		}

		public function levelStart(_level:int):void
		{
			this.__host.levelStart(_level);
		}

		public function requestFPS(_fps:int):Boolean
		{
			var result:Boolean = false;
			if (isNaN(this.__hostFPS))
			{
				this.__hostFPS = (this.__host as DisplayObject).stage.frameRate;
				this.__currentFPS = this.__hostFPS;
			}
			if (this.__currentFPS != _fps)
			{
				this.__currentFPS = _fps;
				(this.__host as DisplayObject).stage.frameRate = this.__currentFPS;
			}
			return this.__currentFPS == _fps;
		}
		
		public function setQuality(_quality:String):void
		{
			(this.__host as DisplayObject).stage.quality = _quality;
		}
		
		public function getQuality():String
		{
			return (this.__host as DisplayObject).stage.quality;
		}

		public function getPlayerColor():int
		{
			return this.__host.getPlayerColor();
		}

		public function purchaseItem(itemID:int):void
		{
			this.__host.purchaseItem(itemID);
		}

		public function getDoesPlayerOwnItem(itemID:int):Signal
		{
			return this.__host.getDoesPlayerOwnItem(itemID);
		}

		public function playMusic(musicID:int):void
		{
			this.__host.playMusic(musicID);
		}

		public function getGameStartParams():Object
		{
			return this.__host.getGameStartParams();
		}

		public function dispose():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
			
			(this.__host as DisplayObject).stage.frameRate = this.__hostFPS;
			
			this.__localeHandler.dispose();
			
			this.endGame();
			
			this.__host = null;
		}

		public function launchMPGame(game:MPGameVO):void
		{
			this.__host.launchMPGame(game);
		}

		public function getResponded():Signal
		{
			return this.__host.getResponded();
		}

		// "s" is PLAY_EXT in AIRTOWER
		public function sendMessage(msgCategory:String,msgType:String,msgArgs:Array=null,extension:String="s"):void
		{
			this.__host.sendMessage(msgCategory,msgType,msgArgs,extension);
		}
		
		private function removedFromStageHandler(evt:Event):void
		{
			this.dispose();
		}
		
		
      public function setup(param1:XML = null, param2:Boolean = false) : void
      {
      }
      
      public function setName(param1:String) : void
      {
      }
      
      public function startGame() : void
      {
      }
      
      public function getGameLevel() : Number
      {
         return 0;
      }
      
      public function getGameScore() : Number
      {
         return 0;
      }
      public function pauseGame(param1:Boolean) : void
      {
      }
      
      public function getSaveGame() : String
      {
         return null;
      }
      public function loadGame(_arg_1:String, _arg_2:String):void
      {
      }
      
	}
}