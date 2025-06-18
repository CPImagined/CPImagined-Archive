//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
    import __AS3__.vec.*;

    public class LocalTextField extends MovieClip implements ILocalTextField 
    {

        public static const FONT_NOT_APPLIED:String = "fontNotApplied";
        public static const FONT_APPLIED:String = "fontApplied";
        public static const FONT_NOT_RENDERING:String = "fontNotRendering";
        private static const REPLACEMENT_MAP:CharCodeReplacementMap = new CharCodeReplacementMap();

        private const propertyNames:Vector.<String> = new Vector.<String>();
        private const propertyValues:Array = [];

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
        private var _replacementMap:CharCodeReplacementMap = REPLACEMENT_MAP;

        public function LocalTextField()
        {
            this._status = FONT_NOT_APPLIED;
            this._textField = this["textField"];
            this._textBounds = new TextBounds(this._textField);
            this._textBounds.visible = false;
            addChild(this._textBounds);
            setChildIndex(this._textBounds, 0);
            mouseChildren = false;
            mouseEnabled = false;
        }

        public function disableFontEmbedding():void
        {
            this._embedFonts = false;
        }

        public function get allowEmbededFonts():Boolean
        {
            return (this._embedFonts);
        }

        public function get fontAlias():String
        {
            return (this._fontAlias);
        }

        public function set fontAlias(_arg_1:String):void
        {
            this._fontAlias = _arg_1;
            var _local_2:FontLibraryEvent = new FontLibraryEvent(FontLibraryEvent.FONT_CHANGED, false, false, this);
            dispatchEvent(_local_2);
        }

        public function get groupName():String
        {
            return (this._groupName);
        }

        public function set groupName(_arg_1:String):void
        {
            this._groupName = _arg_1;
        }

        public function get absoluteGroupName():String
        {
            if (this.isInGroup)
            {
                return ((this.loaderInfo.url + "::") + this._groupName);
            };
            return (null);
        }

        public function get isInGroup():Boolean
        {
            return (((!(this.groupName == null)) && (!(this.groupName == "[none]"))) ? Boolean(this.groupName.length) : false);
        }

        public function get token():String
        {
            return (this._token);
        }

        public function set token(_arg_1:String):void
        {
            this._token = _arg_1;
        }

        public function get status():String
        {
            return (this._status);
        }

        public function set status(_arg_1:String):void
        {
            this._status = _arg_1;
        }

        public function get text():String
        {
            return (this._textField.text);
        }

        public function set text(_arg_1:String):void
        {
            this._textField.text = this._replacementMap.replaceCharCodesForSring(_arg_1);
        }

        public function get textField():TextField
        {
            return (this._textField);
        }

        public function set textField(_arg_1:TextField):void
        {
            this._textField = _arg_1;
        }

        public function replaceTextField(_arg_1:TextField):void
        {
            this.removeChild(this._textField);
            this.addChild(_arg_1);
            this._textField = _arg_1;
        }

        public function get verticalAlignment():String
        {
            return (this._textVerticalAlignment);
        }

        public function set verticalAlignment(_arg_1:String):void
        {
            this._textVerticalAlignment = _arg_1;
        }

        public function get rendered():Boolean
        {
            return (this._rendered);
        }

        public function set rendered(_arg_1:Boolean):void
        {
            this._rendered = _arg_1;
        }

        public function get componentVersion():String
        {
            return (this._componentVersion);
        }

        public function set componentVersion(_arg_1:String):void
        {
            this._componentVersion = _arg_1;
            if ((((_arg_1) && (!(_arg_1 == ""))) && ((!(_arg_1 == "v2.1.0")) && (!(_arg_1 == "v2.0.9")))))
            {
                trace(("OLD VERSION: " + _arg_1));
            };
        }

        override public function get width():Number
        {
            return (this._textBounds.width);
        }

        override public function get height():Number
        {
            return (this._textBounds.height);
        }

        public function get textBounds():TextBounds
        {
            return (this._textBounds);
        }

        public function setProperty(_arg_1:String, _arg_2:*):void
        {
            if (((_arg_2 is String) && ((_arg_2 as String).indexOf("||") > -1)))
            {
                new MismatchedVersionsHack().parseWWPropsToLTF((_arg_2 as String), this);
                return;
            };
            var _local_3:int = this.propertyNames.indexOf(_arg_1);
            if (_local_3 == -1)
            {
                this.propertyNames.push(_arg_1);
                this.propertyValues.push(_arg_2);
            }
            else
            {
                this.propertyValues[_local_3] = _arg_2;
            };
        }

        public function getProperty(_arg_1:String):*
        {
            var _local_2:int = this.propertyNames.indexOf(_arg_1);
            return ((_local_2 == -1) ? null : this.propertyValues[_local_2]);
        }


    }
}//package com.clubpenguin.tools.localtext.core
