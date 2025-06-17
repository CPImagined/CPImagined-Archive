//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.core.events.FontLibraryEvent;
    import com.clubpenguin.tools.localtext.component.MismatchedVersionsHack;
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

        public function set fontAlias(value:String):void
        {
            this._fontAlias = value;
            var event:FontLibraryEvent = new FontLibraryEvent(FontLibraryEvent.FONT_CHANGED, false, false, this);
            dispatchEvent(event);
        }

        public function get groupName():String
        {
            return (this._groupName);
        }

        public function set groupName(value:String):void
        {
            this._groupName = value;
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

        public function set token(value:String):void
        {
            this._token = value;
        }

        public function get status():String
        {
            return (this._status);
        }

        public function set status(value:String):void
        {
            this._status = value;
        }

        public function get text():String
        {
            return (this._textField.text);
        }

        public function set text(value:String):void
        {
            if (value != null)
            {
                this._textField.text = this._replacementMap.replaceCharCodesForSring(value);
            };
        }

        public function get textField():TextField
        {
            return (this._textField);
        }

        public function set textField(newTF:TextField):void
        {
            this._textField = newTF;
        }

        public function replaceTextField(replacementTF:TextField):void
        {
            this.removeChild(this._textField);
            this.addChild(replacementTF);
            this._textField = replacementTF;
        }

        public function get verticalAlignment():String
        {
            return (this._textVerticalAlignment);
        }

        public function set verticalAlignment(vAlign:String):void
        {
            this._textVerticalAlignment = vAlign;
        }

        public function get rendered():Boolean
        {
            return (this._rendered);
        }

        public function set rendered(value:Boolean):void
        {
            this._rendered = value;
        }

        public function get componentVersion():String
        {
            return (this._componentVersion);
        }

        public function set componentVersion(value:String):void
        {
            this._componentVersion = value;
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

        public function setProperty(property:String, value:*):void
        {
            if (((value is String) && ((value as String).indexOf("||") > -1)))
            {
                new MismatchedVersionsHack().parseWWPropsToLTF((value as String), this);
                return;
            };
            var propIndex:int = this.propertyNames.indexOf(property);
            if (propIndex == -1)
            {
                this.propertyNames.push(property);
                this.propertyValues.push(value);
            }
            else
            {
                this.propertyValues[propIndex] = value;
            };
        }

        public function getProperty(property:String):*
        {
            var propIndex:int = this.propertyNames.indexOf(property);
            return ((propIndex == -1) ? null : this.propertyValues[propIndex]);
        }


    }
}//package com.clubpenguin.tools.localtext.core
