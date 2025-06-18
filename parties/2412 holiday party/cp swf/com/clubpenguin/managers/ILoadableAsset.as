//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.managers
{
    public interface ILoadableAsset 
    {

        function set isExternal(_arg_1:Boolean):void;
        function get isExternal():Boolean;
        function set isAbsoluteURL(_arg_1:Boolean):void;
        function get isAbsoluteURL():Boolean;
        function set url(_arg_1:String):void;
        function get url():String;
        function getID():String;

    }
}//package com.clubpenguin.managers
