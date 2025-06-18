package com.clubpenguin.lib.vo
{
	public class MPGameVO
	{
		public var name:String;

		public var mpProduct:String;

		public var worldNamePrefix:String;

		public function MPGameVO(configXML:XML)
		{
			super();
			
			trace("[MPGameVO] (" + configXML.descendants() + ")");
			
			if(!configXML.hasOwnProperty("game"))
			 {
				trace("[MPGameVO] ERROR: configXML missing game");
			 }
			
			if (configXML.game.attribute("gameName"))
			{
				this.name = configXML.game.attribute("gameName");
			}
			else
			{
				trace("[MPGameVO] ERROR: configXML.game missing gameName");
			}
			
			if (configXML.game.attribute("mpProduct"))
			{
				this.mpProduct = configXML.game.attribute("mpProduct");
			}
			else
			{
				trace("[MPGameVO] ERROR: configXML.game missing mpProduct");
			}
			
			if (configXML.game.attribute("worldNamePrefix"))
			{
				this.worldNamePrefix = configXML.game.attribute("worldNamePrefix");
			}
			else
			{
				trace("[MPGameVO] ERROR: configXML.game missing worldNamePrefix");
			}
		}
	}
}