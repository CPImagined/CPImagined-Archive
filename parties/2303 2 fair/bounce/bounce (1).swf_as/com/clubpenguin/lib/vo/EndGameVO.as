package com.clubpenguin.lib.vo{
    public class EndGameVO implements IEndGameVO {

        private var _score:int = 0;
        private var _roomToJoin:int = -1;
        private var _gameCompletedParams:Object = {};
        private var _isShowEndGame:Boolean = true;


        public function getScore():int{
            return (this._score);
        }

        public function setScore(_arg_1:int):void{
            this._score = _arg_1;
        }

        public function getRoomToJoin():int{
            return (this._roomToJoin);
        }

        public function setRoomToJoin(_arg_1:int):void{
            this._roomToJoin = _arg_1;
        }

        public function getShowEndGame():Boolean{
            return (this._isShowEndGame);
        }

        public function setShowEndGame(_arg_1:Boolean):void{
            this._isShowEndGame = _arg_1;
        }

        public function setGameCompletedParams(_arg_1:Object):void{
            this._gameCompletedParams = _arg_1;
        }

        public function getGameCompletedParams():Object{
            return (this._gameCompletedParams);
        }


    }
}//package com.clubpenguin.lib.vo
