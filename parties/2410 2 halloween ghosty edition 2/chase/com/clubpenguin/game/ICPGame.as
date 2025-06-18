package com.clubpenguin.game
{
	import com.disney.coupler.ICouplerGame;

	public interface ICPGame extends ICouplerGame
	{
		function setup(_gameConfig:XML=null, _requiresUpdates:Boolean=false):void;

		function setName(_str:String):void;

		function startGame():void;

		function getGameLevel():Number;

		function getGameScore():Number;

		function endGame():void;

		function pauseGame(_state:Boolean):void;

		function getSaveGame():String;
		
		function loadGame(_data:String, _err:String):void;
	}
}