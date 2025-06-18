package com.disney.coupler
{
	import com.disney.lib.IUniquelyNamable;
	import flash.display.Sprite;
	import org.osmf.logging.Log;

	public class GameCoupler extends Sprite implements ICouplerGame,ICouplerHost,IUniquelyNamable
	{
		private static var $_instanceCount:int = -1;

		protected var __uid:int;

		protected var __game:Object;

		protected var __host:Object;

		public function GameCoupler()
		{
			super();
			
			this.__uid = ++$_instanceCount;
		}

		public function setHost(_host:ICouplerHost):void
		{
			if (_host as ICouplerHost != null)
			{
				this.__host = _host;
				return;
			}
			Log.getLogger("Domains").fatal("Host is not a valid ICouplerHost!");
		}

		public function setGame(_game:ICouplerGame):void
		{
			if (_game as ICouplerGame != null)
			{
				this.__game = _game;
				return;
			}
			Log.getLogger("Domains").fatal("Game is not a valid ICouplerGame!");
		}

		public function getUniqueName():String
		{
			return "GameCoupler" + this.__uid;
		}
	}
}