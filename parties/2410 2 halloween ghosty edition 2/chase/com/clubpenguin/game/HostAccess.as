package com.clubpenguin.game
{
	public class HostAccess
	{

		private static var $_gameHost:com.clubpenguin.game.ICPGameHost;


		public function HostAccess()
		{
			super();
		}

		public static function setHost(_host:com.clubpenguin.game.ICPGameHost):void
		{
			$_gameHost = _host;
		}

		public static function getHost():com.clubpenguin.game.ICPGameHost
		{
			return $_gameHost;
		}
	}
}