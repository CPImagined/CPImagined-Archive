package com.clubpenguin.lib.util.logging
{
	import org.osmf.logging.Log;
	
	public class GameLog
	{
		public static function initLog():void
		{
			if (Log.loggerFactory == null)
			{
				Log.loggerFactory = new GameLoggerFactory();
			}
		}
		
		public static function dispose():void
		{
			if (Log.loggerFactory != null)
			{
				if (org.osmf.logging.Log.loggerFactory.hasOwnProperty("dispose"))
				{
					org.osmf.logging.Log.loggerFactory["dispose"]();
				}
				
				Log.loggerFactory = null;
			}
		}
	}
}