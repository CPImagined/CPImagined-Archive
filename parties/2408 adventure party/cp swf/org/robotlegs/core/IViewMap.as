//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    import flash.display.DisplayObjectContainer;

    public interface IViewMap 
    {

        function mapPackage(_arg_1:String):void;
        function unmapPackage(_arg_1:String):void;
        function hasPackage(_arg_1:String):Boolean;
        function mapType(_arg_1:Class):void;
        function unmapType(_arg_1:Class):void;
        function hasType(_arg_1:Class):Boolean;
        function get contextView():DisplayObjectContainer;
        function set contextView(_arg_1:DisplayObjectContainer):void;
        function get enabled():Boolean;
        function set enabled(_arg_1:Boolean):void;

    }
}//package org.robotlegs.core
