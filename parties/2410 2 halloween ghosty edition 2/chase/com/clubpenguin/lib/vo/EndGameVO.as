package com.clubpenguin.lib.vo
{
	public class EndGameVO implements IEndGameVO
	{
		private var _score:int = 0;

		private var _roomToJoin:int = -1;

		private var _gameCompletedParams:Object;

		private var _isShowEndGame:Boolean = true;

		public function EndGameVO()
		{
			super();
		
			this._gameCompletedParams = {};
		}

		public function getScore():int
		{
			return this._score;
		}

		public function setScore(score:int):void
		{
			this._score = score;
		}

		public function getRoomToJoin():int
		{
			return this._roomToJoin;
		}

		public function setRoomToJoin(roomId:int):void
		{
			this._roomToJoin = roomId;
		}

		public function getShowEndGame():Boolean
		{
			return this._isShowEndGame;
		}

		public function setShowEndGame(show:Boolean):void
		{
			this._isShowEndGame = show;
		}

		public function setGameCompletedParams(params:Object):void
		{
			this._gameCompletedParams = params;
		}

		public function getGameCompletedParams():Object
		{
			return this._gameCompletedParams;
		}
	}
}