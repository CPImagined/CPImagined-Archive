//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.core
{
    import flash.system.ApplicationDomain;

    public interface IReflector 
    {

        function classExtendsOrImplements(_arg_1:Object, _arg_2:Class, _arg_3:ApplicationDomain=null):Boolean;
        function getClass(_arg_1:*, _arg_2:ApplicationDomain=null):Class;
        function getFQCN(_arg_1:*, _arg_2:Boolean=false):String;

    }
}//package org.robotlegs.core
