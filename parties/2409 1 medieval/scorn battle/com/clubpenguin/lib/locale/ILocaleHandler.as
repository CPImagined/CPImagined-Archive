package com.clubpenguin.lib.locale{
    import com.clubpenguin.lib.IDisposable;
    import flash.display.DisplayObject;
    import org.osflash.signals.ISignal;

    public interface ILocaleHandler extends IDisposable {

        function getString(_arg_1:String):String;
        function getImage(_arg_1:String, _arg_2:String="locale"):DisplayObject;
        function getSignalLoadComplete():ISignal;
        function setLocaleByID(_arg_1:int):void;
        function setLocaleByName(_arg_1:String):void;
        function load(_arg_1:Function):void;
        function setGameID(_arg_1:int):void;
        function getLocaleID():int;
        function getLocaleName():String;
        function setLocaleAssetNames(_arg_1:Array):void;
        function setGameURL(_arg_1:String):void;

    }
}//package com.clubpenguin.lib.locale
