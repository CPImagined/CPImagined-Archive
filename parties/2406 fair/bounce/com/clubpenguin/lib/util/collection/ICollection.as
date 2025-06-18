package com.clubpenguin.lib.util.collection{
    import com.clubpenguin.lib.vo.IVO;
    import org.osflash.signals.Signal;

    public interface ICollection {

        function destroy(_arg_1:Boolean=false):void;
        function getType():Class;
        function getSize():int;
        function isEmpty():Boolean;
        function add(_arg_1:IVO):Boolean;
        function removeItem(_arg_1:IVO, _arg_2:Boolean=false):void;
        function remove(_arg_1:Array, _arg_2:Boolean=false):void;
        function clear(_arg_1:Boolean=false):void;
        function getAllItems():Array;
        function getItem(_arg_1:int):IVO;
        function toString():String;
        function getItemAdded():Signal;
        function getItemRemoved():Signal;

    }
}//package com.clubpenguin.lib.util.collection
