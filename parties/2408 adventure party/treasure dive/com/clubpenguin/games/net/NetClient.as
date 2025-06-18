package com.clubpenguin.games.net
{
	import com.disney.lib.IUniquelyNamable;
	import com.clubpenguin.game.HostAccess;
	import com.clubpenguin.game.ICPGameHost;
	import com.clubpenguin.lib.IDisposable;
	import com.clubpenguin.games.engine.GameEngine;
	import org.osflash.signals.Signal;

	public class NetClient implements IDisposable,IUniquelyNamable
	{
		public var host:ICPGameHost;

		public var engine:GameEngine;

		public function NetClient()
		{
			super();

			this.host = HostAccess.getHost();

			this.engine = GameEngine.instance;

			Signal(this.host.getResponded()).add(this.onResponded);
		}

		public function dispose():void
		{
			this.engine = null;
			
			this.host.getResponded().remove(this.onResponded);

			this.host = null;
		}
		
		// "s" is PLAY_EXT in AIRTOWER
		public function sendMessage(msgCategory:String, msgType:String, msgArgs:Array = null, extension:String = "s"):void
		{
			this.host.sendMessage(msgCategory, msgType, msgArgs, extension);
		}

		protected function onResponded(msgCategory:String,messageData:Array):void
		{
			trace(this.getUniqueName() + " onResponded - override me to handle messages!");
		}

		public function getUniqueName():String
		{
			return "[NetClient]";
		}
	}
}