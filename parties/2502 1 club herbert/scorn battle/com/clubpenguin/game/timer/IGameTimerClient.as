package com.clubpenguin.game.timer{
    public interface IGameTimerClient {

        function update(_arg_1:int, _arg_2:Boolean=false):void;
        function hasTimerClientID():Boolean;
        function getTimerClientID():int;
        function setTimerClientID(_arg_1:int):void;
        function getUpdateFrequency():Number;

    }
}//package com.clubpenguin.game.timer
