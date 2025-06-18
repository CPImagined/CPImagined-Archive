//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.events.IEventDispatcher;
    import flash.text.TextField;

    public interface ILocalTextField extends IEventDispatcher 
    {

        function disableFontEmbedding():void;
        function get allowEmbededFonts():Boolean;
        function get name():String;
        function set name(_arg_1:String):void;
        function get fontAlias():String;
        function set fontAlias(_arg_1:String):void;
        function get groupName():String;
        function set groupName(_arg_1:String):void;
        function get absoluteGroupName():String;
        function get isInGroup():Boolean;
        function get token():String;
        function set token(_arg_1:String):void;
        function get status():String;
        function set status(_arg_1:String):void;
        function get text():String;
        function set text(_arg_1:String):void;
        function get textField():TextField;
        function set textField(_arg_1:TextField):void;
        function replaceTextField(_arg_1:TextField):void;
        function get verticalAlignment():String;
        function set verticalAlignment(_arg_1:String):void;
        function get rendered():Boolean;
        function set rendered(_arg_1:Boolean):void;
        function get componentVersion():String;
        function set componentVersion(_arg_1:String):void;
        function get width():Number;
        function get height():Number;
        function get textBounds():TextBounds;
        function setProperty(_arg_1:String, _arg_2:*):void;
        function getProperty(_arg_1:String):*;

    }
}//package com.clubpenguin.tools.localtext.core
