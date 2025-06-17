//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    import flash.system.ApplicationDomain;

    public interface IInjector 
    {

        function mapValue(_arg_1:Class, _arg_2:Object, _arg_3:String=""):*;
        function mapClass(_arg_1:Class, _arg_2:Class, _arg_3:String=""):*;
        function mapSingleton(_arg_1:Class, _arg_2:String=""):*;
        function mapSingletonOf(_arg_1:Class, _arg_2:Class, _arg_3:String=""):*;
        function mapRule(_arg_1:Class, _arg_2:*, _arg_3:String=""):*;
        function injectInto(_arg_1:Object):void;
        function instantiate(_arg_1:Class):*;
        function getInstance(_arg_1:Class, _arg_2:String=""):*;
        function createChild(_arg_1:ApplicationDomain=null):IInjector;
        function unmap(_arg_1:Class, _arg_2:String=""):void;
        function hasMapping(_arg_1:Class, _arg_2:String=""):Boolean;
        function get applicationDomain():ApplicationDomain;
        function set applicationDomain(_arg_1:ApplicationDomain):void;

    }
}//package org.robotlegs.core
