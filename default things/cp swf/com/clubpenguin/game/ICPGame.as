//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.game
{
    import com.disney.coupler.ICouplerGame;

    public interface ICPGame extends ICouplerGame 
    {

        function setup(_arg_1:XML=null, _arg_2:Boolean=false):void;
        function setName(_arg_1:String):void;
        function startGame():void;
        function getGameLevel():Number;
        function getGameScore():Number;
        function endGame():void;
        function pauseGame(_arg_1:Boolean):void;
        function getSaveGame():String;
        function loadGame(_arg_1:String, _arg_2:String):void;

    }
}//package com.clubpenguin.game
