//Created by Action Script Viewer - https://www.buraks.com/asv
package fl.controls.listClasses
{
    public interface ICellRenderer 
    {

        function set y(_arg_1:Number):void;
        function set x(_arg_1:Number):void;
        function setSize(_arg_1:Number, _arg_2:Number):void;
        function get listData():ListData;
        function set listData(_arg_1:ListData):void;
        function get data():Object;
        function set data(_arg_1:Object):void;
        function get selected():Boolean;
        function set selected(_arg_1:Boolean):void;
        function setMouseState(_arg_1:String):void;

    }
}//package fl.controls.listClasses
