package com.clubpenguin.tools.localtext.core
{
    import __AS3__.vec.*;
    import com.clubpenguin.tools.localtext.core.*;
    import com.clubpenguin.tools.localtext.core.events.*;
    import flash.display.*;
    import flash.text.*;

    public class LocalTextField extends MovieClip implements ILocalTextField
    {
        private const propertyNames:Vector.<String>;
        private const propertyValues:Array;
        private var _textBounds:TextBounds;
        private var _token:String;
        private var _fontAlias:String;
        private var _groupName:String;
        private var _textField:TextField;
        private var _status:String;
        private var _embedFonts:Boolean = true;
        private var _rendered:Boolean = false;
        private var _textVerticalAlignment:String;
        private var _componentVersion:String;
        private var _replacementMap:CharCodeReplacementMap;
        public static const FONT_NOT_APPLIED:String = "fontNotApplied";
        public static const FONT_APPLIED:String = "fontApplied";
        public static const FONT_NOT_RENDERING:String = "fontNotRendering";
        private static const REPLACEMENT_MAP:CharCodeReplacementMap = new CharCodeReplacementMap();

        public function LocalTextField()
        {
            this.propertyNames = new Vector.<String>;
            this.propertyValues = [];
            this._replacementMap = REPLACEMENT_MAP;
            this._status = FONT_NOT_APPLIED;
            this._textField = this["textField"];
            this._textBounds = new TextBounds(this._textField);
            this._textBounds.visible = false;
            addChild(this._textBounds);
            setChildIndex(this._textBounds, 0);
            mouseChildren = false;
            mouseEnabled = false;
            return;
        }// end function

        public function disableFontEmbedding() : void
        {
            this._embedFonts = false;
            return;
        }// end function

        public function get allowEmbededFonts() : Boolean
        {
            return this._embedFonts;
        }// end function

        public function get fontAlias() : String
        {
            return this._fontAlias;
        }// end function

        public function set fontAlias(param1:String) : void
        {
            this._fontAlias = param1;
            var _loc_2:* = new FontLibraryEvent(FontLibraryEvent.FONT_CHANGED, false, false, this);
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get groupName() : String
        {
            return this._groupName;
        }// end function

        public function set groupName(param1:String) : void
        {
            this._groupName = param1;
            return;
        }// end function

        public function get absoluteGroupName() : String
        {
            if (this.isInGroup)
            {
                return this.loaderInfo.url + "::" + this._groupName;
            }
            return null;
        }// end function

        public function get isInGroup() : Boolean
        {
            return this.groupName != null && this.groupName != "[none]" ? (Boolean(this.groupName.length)) : (false);
        }// end function

        public function get token() : String
        {
            return this._token;
        }// end function

        public function set token(param1:String) : void
        {
            this._token = param1;
            return;
        }// end function

        public function get status() : String
        {
            return this._status;
        }// end function

        public function set status(param1:String) : void
        {
            this._status = param1;
            return;
        }// end function

        public function get text() : String
        {
            return this._textField.text;
        }// end function

        public function set text(param1:String) : void
        {
            this._textField.text = this._replacementMap.replaceCharCodesForSring(param1);
            return;
        }// end function

        public function get textField() : TextField
        {
            return this._textField;
        }// end function

        public function set textField(param1:TextField) : void
        {
            this._textField = param1;
            return;
        }// end function

        public function replaceTextField(param1:TextField) : void
        {
            this.removeChild(this._textField);
            this.addChild(param1);
            this._textField = param1;
            return;
        }// end function

        public function get verticalAlignment() : String
        {
            return this._textVerticalAlignment;
        }// end function

        public function set verticalAlignment(param1:String) : void
        {
            this._textVerticalAlignment = param1;
            return;
        }// end function

        public function get rendered() : Boolean
        {
            return this._rendered;
        }// end function

        public function set rendered(param1:Boolean) : void
        {
            this._rendered = param1;
            return;
        }// end function

        public function get componentVersion() : String
        {
            return this._componentVersion;
        }// end function

        public function set componentVersion(param1:String) : void
        {
            this._componentVersion = param1;
            return;
        }// end function

        override public function get width() : Number
        {
            return this._textBounds.width;
        }// end function

        override public function get height() : Number
        {
            return this._textBounds.height;
        }// end function

        public function get textBounds() : TextBounds
        {
            return this._textBounds;
        }// end function

        public function setProperty(param1:String, param2) : void
        {
            var _loc_3:* = this.propertyNames.indexOf(param1);
            if (_loc_3 == -1)
            {
                this.propertyNames.push(param1);
                this.propertyValues.push(param2);
            }
            else
            {
                this.propertyValues[_loc_3] = param2;
            }
            return;
        }// end function

        public function getProperty(param1:String)
        {
            var _loc_2:* = this.propertyNames.indexOf(param1);
            return _loc_2 == -1 ? (null) : (this.propertyValues[_loc_2]);
        }// end function

    }
}
