package com.clubpenguin.lib.vo
{
	public interface IEndGameVO
	{
		function getScore():int;

		function setScore(score:int):void;

		function getRoomToJoin():int;

		function setRoomToJoin(roomId:int):void;

		function getShowEndGame():Boolean;

		function setShowEndGame(show:Boolean):void;

		function setGameCompletedParams(params:Object):void;

		function getGameCompletedParams():Object;
	}
}