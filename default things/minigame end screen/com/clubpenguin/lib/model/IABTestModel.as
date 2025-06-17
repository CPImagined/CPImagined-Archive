//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.model
{
    import org.osflash.signals.Signal;

    public interface IABTestModel 
    {

        function setAllTestData(_arg_1:Object):void;
        function getAllTestData():Object;
        function setTestDataByName(_arg_1:String, _arg_2:Object):void;
        function getTestDataByName(_arg_1:String):Object;
        function parameterExists(_arg_1:String, _arg_2:String):Boolean;
        function getParameterByName(_arg_1:String, _arg_2:String):*;
        function get onUpdate():Signal;

    }
}//package com.clubpenguin.lib.model
