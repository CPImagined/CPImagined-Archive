package com.clubpenguin.lib.util.logging
{
	import org.osmf.logging.Logger;
	import flash.external.ExternalInterface;
	
	internal class GameLogger extends Logger
	{
		public var flagBits:Number = 0;
		
		public function GameLogger(category:String, startingFlagBits:Number)
		{
			super(category);
			
			this.flagBits = startingFlagBits;
		}
		
		public function loggingEnabled(levelFlag:Number):Boolean
		{
			return (this.flagBits & levelFlag) != 0;
		}
		
		override public function debug(message:String, ...rest):void
		{
			if (this.loggingEnabled(GameLoggerConsts.FLAG_DEBUG))
			{
				this.writeOut(this.formatMessage(GameLoggerConsts.LEVEL_DEBUG, message));
			}
		}
		
		override public function info(message:String, ...rest):void
		{
			if (this.loggingEnabled(GameLoggerConsts.FLAG_INFO))
			{
				this.writeOut(this.formatMessage(GameLoggerConsts.LEVEL_INFO, message));
			}
		}
		
		override public function warn(message:String, ...rest):void
		{
			if (this.loggingEnabled(GameLoggerConsts.FLAG_WARN))
			{
				this.writeOut(this.formatMessage(GameLoggerConsts.LEVEL_WARN, message));
			}
		}
		
		override public function error(message:String, ...rest):void
		{
			if (this.loggingEnabled(GameLoggerConsts.FLAG_ERROR))
			{
				this.writeOut(this.formatMessage(GameLoggerConsts.LEVEL_ERROR, message));
			}
		}
		
		override public function fatal(message:String, ...rest):void
		{
			var throwException = true;
			
			if (rest.length)
			{
				throwException = rest[0];
			}
			
			if (throwException)
			{
				// Throw an exception regardless of flag.
				throw this.formatCategoryLevelMessage(GameLoggerConsts.LEVEL_FATAL, message);
			}
			else if (this.loggingEnabled(GameLoggerConsts.FLAG_FATAL))
			{
				this.writeOut(this.formatMessage(GameLoggerConsts.LEVEL_FATAL, message));
			}
		}
		
		// Based on TraceLogger
		private function formatMessage(level:String, message:String):String
		{
			var date = new Date();
			
			return date.toLocaleString() + "." + this.leadingZeros(date.milliseconds) + " " + this.formatCategoryLevelMessage(level, message);
		}
		
		private function formatCategoryLevelMessage(level:String, message:String):String
		{
			return "[" + this.category + "] [" + level + "] " + message;
		}
		
		private function writeOut(message:String):void
		{
			// Try to write to the browser console.
			if (ExternalInterface.available)
			{
				ExternalInterface.call("console.log", message);
			}
			
			// trace the message
			trace(message);
		}
		
		private function leadingZeros(x:Number):String
		{
			if (x < 10)
			{
				return "00" + x.toString();
			}
			
			if (x < 100)
			{
				return "0" + x.toString();
			}
			
			return x.toString();
		}
	}
}