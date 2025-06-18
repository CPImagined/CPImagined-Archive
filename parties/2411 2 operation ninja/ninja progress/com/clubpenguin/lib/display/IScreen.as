//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.display
{
    import flash.events.IEventDispatcher;

    public interface IScreen extends IEventDispatcher 
    {

        function show():void;
        function hide():void;

    }
}//package com.clubpenguin.lib.display
