package com.clubpenguin.lib.vo
{
	import org.osmf.logging.Log;

	public class MPGameVO
	{
		public var name:String;

		public var mpProduct:String;

		public var worldNamePrefix:String;

		public function MPGameVO(configXML:XML)
		{
			super();
			
			Log.getLogger("MPGameVO").debug("(" + configXML.descendants() + ")");
			
			if(!configXML.hasOwnProperty("game"))
			{
				Log.getLogger("MPGameVO").error("configXML missing game");
			}
			
			if (configXML.game.attribute("gameName"))
			{
				this.name = configXML.game.attribute("gameName");
			}
			else
			{
				Log.getLogger("MPGameVO").error("configXML.game missing gameName");
			}
			
			if (configXML.game.attribute("mpProduct"))
			{
				this.mpProduct = configXML.game.attribute("mpProduct");
			}
			else
			{
				Log.getLogger("MPGameVO").error("configXML.game missing mpProduct");
			}
			
			if (configXML.game.attribute("worldNamePrefix"))
			{
				this.worldNamePrefix = configXML.game.attribute("worldNamePrefix");
			}
			else
			{
				Log.getLogger("MPGameVO").error("configXML.game missing worldNamePrefix");
			}
		}
	}
}