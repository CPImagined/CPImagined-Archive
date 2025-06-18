package com.clubpenguin.lib.vo{
    public interface IEndGameVO {

        function getScore():int;
        function setScore(_arg_1:int):void;
        function getRoomToJoin():int;
        function setRoomToJoin(_arg_1:int):void;
        function getShowEndGame():Boolean;
        function setShowEndGame(_arg_1:Boolean):void;
        function setGameCompletedParams(_arg_1:Object):void;
        function getGameCompletedParams():Object;

    }
}//package com.clubpenguin.lib.vo
