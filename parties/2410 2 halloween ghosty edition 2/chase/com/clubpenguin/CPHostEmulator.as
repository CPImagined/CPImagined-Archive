package com.clubpenguin
{
	import com.disney.lib.IUniquelyNamable;
	import com.clubpenguin.game.ICPHost;
	import com.clubpenguin.game.ICPMultiplayer;
	import com.clubpenguin.lib.vo.IEndGameVO;
	import com.clubpenguin.lib.vo.IPlayerVO;
	import com.clubpenguin.lib.vo.MPGameVO;
	import com.disney.coupler.ICouplerGame;
	import com.clubpenguin.lib.util.logging.GameLog;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.net.URLRequest;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	public class CPHostEmulator extends Sprite implements ICPHost,ICPMultiplayer,IUniquelyNamable
	{
		protected var __hostedGameName:String;

		protected var __hostedGame:ICouplerGame;

		public function CPHostEmulator()
		{
			super();
			
			GameLog.initLog();
			
			this.__hostedGameName = this.getHostGameName();
			
			this.loadAsEmulator();
		}

		protected function getHostGameName():String
		{
			// This is the filename.swf
			Log.getLogger(this.getUniqueName()).fatal("You must override getHostGameName() in your emulator implementation!");
			
			return "";
		}
		
		public function getUniqueName():String
		{
			return "CPHostEmulator";
		}
		
		private function loadAsEmulator():void
		{
			var mcl:Loader = null;
			var gameToLoad:URLRequest = null;
			
			Log.getLogger(this.getUniqueName()).debug("Going to load: " + this.__hostedGameName);

			gameToLoad = new URLRequest(this.__hostedGameName);
			mcl = new Loader();
			mcl.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete,false,0,true);
			mcl.load(gameToLoad);
		}

		private function onLoadComplete(_eventObj:Event):void
		{
			var ldi:LoaderInfo = null;
			ldi = _eventObj.target as LoaderInfo;
			this.__hostedGame = ldi.content as ICouplerGame;
			this.__hostedGame.setHost(this);
		}

		public function getLocale():int
		{
			/*
			Override to force a language
			-1: Use locale from config or default to English if undefined.
			0: Default if function not defined at all; should never be 0.
			1: English
			2: Portuguese
			3: French
			4: Spanish
			5: Dutch
			6: Russian
			*/
			return -1;
		}

		public function getPlayerVO():IPlayerVO
		{
			// Override with a dummy PlayerVO to test various things.
			return null;
		}

		public function showEndGame(endGameVO:IEndGameVO):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating showing the end game screen.");
		}

		public function getBasePath():String
		{
			return "";
		}

		public function getBaseConfigPath():String
		{
			return "";
		}

		public function showMembershipPrompt(_filename:String, _biTag:String = null):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating showing a membership prompt.");
		}

		public function isMusicMuted():Boolean
		{
			return false;
		}

		public function stampEarned(_stampID:int, _isServerSide:Boolean = false):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating a stamp earned\tgot stamp: " + _stampID + " server sided: " + _isServerSide);
		}

		public function isStampEarned(stampID:int):Boolean
		{
			// Override to test stamps
			return true;
		}

		public function levelComplete(_level:int):void
		{
			Log.getLogger(this.getUniqueName()).info("Level completed: " + _level);
		}

		public function levelStart(_level:int):void
		{
			Log.getLogger(this.getUniqueName()).info("Level started: " + _level);
		}

		public function requestFPS(_fps:int):Boolean
		{
			return false;
		}
		
		public function setQuality(_qual:String):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating quality set: " + _qual);
		}
		
		public function getQuality():String
		{
			return StageQuality.HIGH;
		}

		public function getPlayerColor():int
		{
			// Override to test how different colors look.
			return 0;
		}

		public function purchaseItem(itemID:int):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating an item purchase: " + itemID);
		}

		public function getDoesPlayerOwnItem(itemID:int):Signal
		{
			return new Signal(int,Boolean);
		}

		public function playMusic(musicID:int):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating playing music: " + musicID);
		}

		public function getGameStartParams():Object
		{
			// Override if you need to start the game with various parameters.
			return {};
		}

		public function launchMPGame(game:MPGameVO):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating launching the Metaplace environment.");
		}

		public function getResponded():ISignal
		{
			return new Signal(String,Array);
		}

		// "s" is PLAY_EXT in AIRTOWER
		public function sendMessage(msgCategory:String, msgType:String, msgArgs:Array = null, extension:String = "s"):void
		{
			Log.getLogger(this.getUniqueName()).info("Emulating a message:\tcategory: " + msgCategory + " type: " + msgType + " args: " + msgArgs + " ext: " + extension);
		}
	}
}