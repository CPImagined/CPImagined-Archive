//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    import flash.display.DisplayObjectContainer;

    public interface IMediatorMap 
    {

        function mapView(_arg_1:*, _arg_2:Class, _arg_3:*=null, _arg_4:Boolean=true, _arg_5:Boolean=true):void;
        function unmapView(_arg_1:*):void;
        function createMediator(_arg_1:Object):IMediator;
        function registerMediator(_arg_1:Object, _arg_2:IMediator):void;
        function removeMediator(_arg_1:IMediator):IMediator;
        function removeMediatorByView(_arg_1:Object):IMediator;
        function retrieveMediator(_arg_1:Object):IMediator;
        function hasMapping(_arg_1:*):Boolean;
        function hasMediator(_arg_1:IMediator):Boolean;
        function hasMediatorForView(_arg_1:Object):Boolean;
        function get contextView():DisplayObjectContainer;
        function set contextView(_arg_1:DisplayObjectContainer):void;
        function get enabled():Boolean;
        function set enabled(_arg_1:Boolean):void;

    }
}//package org.robotlegs.core
