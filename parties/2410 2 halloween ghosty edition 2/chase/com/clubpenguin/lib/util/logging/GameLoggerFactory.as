package com.clubpenguin.lib.util.logging
{
	import com.disney.lib.IDisposable;
	import flash.utils.Dictionary;
	import org.osmf.logging.LoggerFactory;
	import org.osmf.logging.Logger;

	internal class GameLoggerFactory extends LoggerFactory implements IDisposable
	{
		private var loggers:Dictionary;
		
		// Global defaults for logger flags
		private var __flagBits:Number = ~GameLoggerConsts.FLAG_DEBUG;
		
		public function GameLoggerFactory()
		{
			super();
			
			this.loggers = new Dictionary();
		}
		
		// Based on TraceLoggerFactory
		override public function getLogger(category:String):Logger
		{
			var logger = this.loggers[category];
			
			if (logger == null)
			{
				logger = new GameLogger(category, this.__flagBits);
				
				this.loggers[category] = logger;
			}
			
			return logger;
		}
		
		public function set flagBits($bits:Number):void
		{
			this.__flagBits = $bits;
			
			// Set all loggers to match these flags.
			for each (var logger in this.loggers)
			{
				logger.flagBits = $bits;
			}
		}
		
		public function get flagBits():Number
		{
			return this.__flagBits;
		}
		
		public function dispose():void
		{
			// Cleanup to prevent memory leaks.
			this.loggers = null;
		}
	}
}