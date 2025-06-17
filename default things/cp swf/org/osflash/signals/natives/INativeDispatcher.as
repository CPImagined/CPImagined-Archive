//Created by Action Script Viewer - https://www.buraks.com/asv
package org.osflash.signals.natives
{
    import flash.events.IEventDispatcher;
    import flash.events.Event;

    public interface INativeDispatcher 
    {

        function get target():IEventDispatcher;
        function dispatch(_arg_1:Event):Boolean;
        function get eventType():String;
        function get eventClass():Class;

    }
}//package org.osflash.signals.natives
