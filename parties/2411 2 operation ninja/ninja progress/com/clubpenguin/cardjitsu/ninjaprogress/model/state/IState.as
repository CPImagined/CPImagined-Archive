//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model.state
{
    import flash.events.IEventDispatcher;

    public interface IState extends IEventDispatcher 
    {

        function enter():void;
        function exit():void;
        function destroy():void;

    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model.state
