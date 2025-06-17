package com.clubpenguin.tools.localtext.core
{
    import flash.text.*;

    public interface ILocalTextField extends IEventDispatcher
    {

        public function ILocalTextField();

        function disableFontEmbedding() : void;

        function get allowEmbededFonts() : Boolean;

        function get name() : String;

        function set name(param1:String) : void;

        function get fontAlias() : String;

        function set fontAlias(param1:String) : void;

        function get groupName() : String;

        function set groupName(param1:String) : void;

        function get absoluteGroupName() : String;

        function get isInGroup() : Boolean;

        function get token() : String;

        function set token(param1:String) : void;

        function get status() : String;

        function set status(param1:String) : void;

        function get text() : String;

        function set text(param1:String) : void;

        function get textField() : TextField;

        function set textField(param1:TextField) : void;

        function replaceTextField(param1:TextField) : void;

        function get verticalAlignment() : String;

        function set verticalAlignment(param1:String) : void;

        function get rendered() : Boolean;

        function set rendered(param1:Boolean) : void;

        function get componentVersion() : String;

        function set componentVersion(param1:String) : void;

        function get width() : Number;

        function get height() : Number;

        function get textBounds() : TextBounds;

        function setProperty(param1:String, param2) : void;

        function getProperty(param1:String);

    }
}
