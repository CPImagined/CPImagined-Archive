//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.game.timer
{
    import com.clubpenguin.lib.IDisposable;

    public interface IGameTimer extends IDisposable 
    {

        function register(_arg_1:IGameTimerClient, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=true):Boolean;
        function unregister(_arg_1:IGameTimerClient):Boolean;
        function start():void;
        function stop():void;
        function pause(_arg_1:Boolean):void;

    }
}//package com.clubpenguin.game.timer
