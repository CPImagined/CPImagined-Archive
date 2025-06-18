//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    import flash.events.IEventDispatcher;

    public interface IEventMap 
    {

        function mapListener(_arg_1:IEventDispatcher, _arg_2:String, _arg_3:Function, _arg_4:Class=null, _arg_5:Boolean=false, _arg_6:int=0, _arg_7:Boolean=true):void;
        function unmapListener(_arg_1:IEventDispatcher, _arg_2:String, _arg_3:Function, _arg_4:Class=null, _arg_5:Boolean=false):void;
        function unmapListeners():void;

    }
}//package org.robotlegs.core
