﻿//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component
{
    import fl.core.UIComponent;
    import com.clubpenguin.tools.localtext.core.IFontLibraryDependant;
    import flash.text.TextFormat;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import com.clubpenguin.tools.localtext.core.LocalTextField;
    import flash.display.DisplayObject;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import com.clubpenguin.tools.localtext.component.filters.controller.ApplyRawFiltersToTextFieldCMD;
    import com.clubpenguin.tools.localtext.core.commands.VAlignLTFContentCMD;
    import flash.text.Font;
    import __AS3__.vec.Vector;

    public class LocalTextComponent extends UIComponent implements IFontLibraryDependant, ILocalTextComponent 
    {

        private const format:TextFormat = new TextFormat();

        private var _textHorizontalAlignment:String = "left";
        private var _textVerticalAlignment:String = "center";
        private var _debugColor:int = 0xCC00;
        private var _showBounds:Boolean = false;
        private var _textColor:int = 0;
        private var _textSize:Number = 12;
        private var _text:String = "This is a Localized Textfield";
        private var _token:String = "";
        private var _fontName:String = "cpBurbankSmall";
        private var _queuedFontName:String;
        private var _groupName:String = "[none]";
        private var _tf:TextField;
        private var _globalWordWrap:Boolean;
        private var _globalScaling:Boolean;
        private var _globalMinFontSize:Number;
        private var _globalLetterSpacing:Number = 0;
        private var _globalLeading:Number = 0;
        private var _revision:String;
        private var isFontChanged:Boolean;
        private var _ltcFilters:String;
        private var _langControl:Boolean;
        private var _currentLang:String;
        private var _wordWrapData:String;
        private var _scalingData:String;
        private var _minFontSizeData:String;
        private var _letterSpacingData:String;
        private var _leadingData:String;
        private var _localTextField:ILocalTextField;
        private var mismatchedVersionHack:MismatchedVersionsHack;

        public function LocalTextComponent(_arg_1:Number=NaN, _arg_2:Number=NaN)
        {
            mouseEnabled = (mouseChildren = false);
        }

        override protected function configUI():void
        {
            this._localTextField = new LocalTextField();
            this._tf = this._localTextField.textField;
            this.applyLocalTextFieldProps();
            this.mismatchedVersionHack = new MismatchedVersionsHack();
            addChild((this._localTextField as DisplayObject));
            LocalTextProxy.queueLocalTextField(this._localTextField);
            super.configUI();
        }

        private function applyLocalTextFieldProps():void
        {
            this._localTextField.textBounds.color = this._debugColor;
            this._localTextField.groupName = this._groupName;
            this._localTextField.text = this._text;
            this._localTextField.token = this._token;
            this._localTextField.verticalAlignment = this._textVerticalAlignment;
            this._localTextField.componentVersion = this._revision;
            this._localTextField.name = this.name;
            this._localTextField.setProperty("langControl", this._langControl);
            this._localTextField.setProperty("wordWrapData", this._wordWrapData);
            this._localTextField.setProperty("globalScaling", this._globalScaling);
            this._localTextField.setProperty("globalMinFontSize", this._globalMinFontSize);
            this._localTextField.setProperty("globalLetterSpacing", this._globalLetterSpacing);
            this._localTextField.setProperty("globalLeading", this._globalLeading);
            this._localTextField.textBounds.visible = this._showBounds;
            this._localTextField.textBounds.visible = this._showBounds;
            if (this._wordWrapData)
            {
                this._localTextField.setProperty("globalWordWrap", this._globalWordWrap);
            };
            if (this._scalingData)
            {
                this._localTextField.setProperty("scalingData", this._scalingData);
            };
            if (this._minFontSizeData)
            {
                this._localTextField.setProperty("minFontSizeData", this._minFontSizeData);
            };
            if (this._letterSpacingData)
            {
                this._localTextField.setProperty("letterSpacingData", this._letterSpacingData);
            };
            if (this._leadingData)
            {
                this._localTextField.setProperty("leadingData", this._leadingData);
            };
            if (this._ltcFilters)
            {
                new ApplyRawFiltersToTextFieldCMD(this._tf, this._ltcFilters).execute();
            };
        }

        override protected function draw():void
        {
            var _local_1:Array;
            var _local_2:int;
            var _local_3:Array;
            var _local_4:int;
            this.format.font = this._fontName;
            this.format.size = this._textSize;
            this.format.color = this._textColor;
            this.format.align = this._textHorizontalAlignment;
            if (isLivePreview)
            {
                if (((this.langControl) && (this._letterSpacingData)))
                {
                    _local_1 = this._letterSpacingData.split(",");
                    _local_2 = _local_1.indexOf(this._currentLang);
                    if (_local_2 > -1)
                    {
                        this.format.letterSpacing = Number(_local_1[(_local_2 + 1)]);
                    };
                }
                else
                {
                    this.format.letterSpacing = Number(this._globalLetterSpacing);
                };
                if (((this.langControl) && (this._leadingData)))
                {
                    _local_3 = this._leadingData.split(",");
                    _local_4 = _local_3.indexOf(this._currentLang);
                    if (_local_4 > -1)
                    {
                        this.format.leading = Number(_local_3[(_local_4 + 1)]);
                    };
                }
                else
                {
                    this.format.leading = Number(this._globalLeading);
                };
            };
            if (isLivePreview)
            {
                this._tf.wordWrap = ((this._langControl) ? (this._wordWrapData.indexOf(this._currentLang) > -1) : this._globalWordWrap);
            };
            this._tf.setTextFormat(this.format);
            this._tf.defaultTextFormat = this.format;
            this._tf.width = this._localTextField.width;
            this._tf.embedFonts = true;
            this.localTextField.textBounds.width = _width;
            this.localTextField.textBounds.height = _height;
            this.localTextField.textBounds.draw();
            if (isLivePreview)
            {
                new VAlignLTFContentCMD(this._localTextField, _height).execute();
            };
            this._tf.x = 0;
            this._localTextField.fontAlias = this.fontAlias;
            super.draw();
        }

        public function get localTextField():ILocalTextField
        {
            return (this._localTextField);
        }

        override public function set width(_arg_1:Number):void
        {
            super.width = _arg_1;
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        override public function set height(_arg_1:Number):void
        {
            super.height = _arg_1;
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function onFontLibraryLoaded():void
        {
            this.font = this._queuedFontName;
            this._localTextField.fontAlias = this.fontAlias;
        }

        public function set debugColor(_arg_1:int):void
        {
            this._debugColor = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.textBounds.color = _arg_1;
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get debugColor():int
        {
            return (this._debugColor);
        }

        public function set font(_arg_1:String):void
        {
            var _local_5:Font;
            var _local_2:String = this.normalizeFontName(_arg_1);
            if (!LocalTextProxy.initialized)
            {
                this._queuedFontName = _arg_1;
                LocalTextProxy.queueFontLibraryDependant(this);
            }
            else
            {
                this._queuedFontName = null;
            };
            var _local_3:Vector.<Font> = LocalTextProxy.allFonts;
            var _local_4:int;
            while (_local_4 < _local_3.length)
            {
                _local_5 = _local_3[_local_4];
                if (((_local_5.fontName == _local_2) || (_local_5.fontName == _arg_1)))
                {
                    this._fontName = _arg_1;
                    this.isFontChanged = true;
                    if (((isLivePreview) || (this._localTextField)))
                    {
                        if (this.draw != null)
                        {
                            this.draw();
                        };
                    };
                    return;
                };
                _local_4++;
            };
        }

        public function get font():String
        {
            return (this._fontName);
        }

        public function set fontAlias(_arg_1:String):void
        {
            if (_arg_1.indexOf("_") != 0)
            {
                return;
            };
            this._localTextField.fontAlias = _arg_1;
            this.font = _arg_1;
        }

        public function get fontAlias():String
        {
            if (((!(this._localTextField.fontAlias == null)) && (!(this.isFontChanged))))
            {
                return (this._localTextField.fontAlias);
            };
            this.isFontChanged = false;
            return (this.normalizeFontName(this._fontName));
        }

        private function normalizeFontName(_arg_1:String):String
        {
            var _local_2:String = _arg_1.split(" ").join("");
            if (_local_2.indexOf("_") != 0)
            {
                _local_2 = ("_" + _local_2);
            };
            return (_local_2);
        }

        public function set groupName(_arg_1:String):void
        {
            this._groupName = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.groupName = this._groupName;
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get groupName():String
        {
            return (this._groupName);
        }

        public function set textHorizontalAlignment(_arg_1:String):void
        {
            this._textHorizontalAlignment = _arg_1;
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get textHorizontalAlignment():String
        {
            return (this._textHorizontalAlignment);
        }

        public function set textSize(_arg_1:Number):void
        {
            this._textSize = _arg_1;
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get textSize():Number
        {
            return (this._textSize);
        }

        public function set text(_arg_1:String):void
        {
            this._text = unescape(_arg_1);
            if (this._localTextField)
            {
                this._localTextField.text = this._text;
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get text():String
        {
            return (this._text);
        }

        public function set textColor(_arg_1:int):void
        {
            this._textColor = _arg_1;
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get textColor():int
        {
            return (this._textColor);
        }

        public function set token(_arg_1:String):void
        {
            this._token = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.token = this._token;
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get token():String
        {
            return (this._token);
        }

        public function set textVerticalAlignment(_arg_1:String):void
        {
            this._textVerticalAlignment = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.verticalAlignment = this._textVerticalAlignment;
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get textVerticalAlignment():String
        {
            return (this._textVerticalAlignment);
        }

        public function set ltcFilters(_arg_1:String):void
        {
            if (_arg_1 == this._ltcFilters)
            {
                return;
            };
            this._ltcFilters = _arg_1;
            if (this._tf)
            {
                new ApplyRawFiltersToTextFieldCMD(this._tf, this._ltcFilters).execute();
            };
        }

        public function get ltcFilters():String
        {
            return (this._ltcFilters);
        }

        public function set zrevision(_arg_1:String):void
        {
            this._revision = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.componentVersion = this._revision;
            };
        }

        public function get zrevision():String
        {
            return (this._revision);
        }

        override public function set name(_arg_1:String):void
        {
            super.name = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.name = _arg_1;
            };
        }

        public function set langControl(_arg_1:Boolean):void
        {
            this._langControl = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("langControl", _arg_1);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get langControl():Boolean
        {
            return (this._langControl);
        }

        public function set currentLang(_arg_1:String):void
        {
            this._currentLang = _arg_1;
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get currentLang():String
        {
            return (this._currentLang);
        }

        public function set wordWrapData(_arg_1:String):void
        {
            var _local_2:Array = this.mismatchedVersionHack.parseWWPropsToLTC(_arg_1);
            this._wordWrapData = _local_2[MismatchedVersionsHack.WORD_WRAP_INDEX];
            this.letterSpacingData = _local_2[MismatchedVersionsHack.LET_SPACING_DATA_INDEX];
            this.leadingData = _local_2[MismatchedVersionsHack.LEADING_DATA_INDEX];
            this.globalLetterSpacing = _local_2[MismatchedVersionsHack.GLOBAL_LET_SPACING_INDEX];
            this.globalLeading = _local_2[MismatchedVersionsHack.GLOBAL_LEADING_INDEX];
            if (this._localTextField)
            {
                this._localTextField.setProperty("wordWrapData", this._wordWrapData);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get wordWrapData():String
        {
            return (this._wordWrapData);
        }

        public function set globalWordWrap(_arg_1:Boolean):void
        {
            this._globalWordWrap = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalWordWrap", _arg_1);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get globalWordWrap():Boolean
        {
            return (this._globalWordWrap);
        }

        public function set scalingData(_arg_1:String):void
        {
            this._scalingData = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("scalingData", this._scalingData);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get scalingData():String
        {
            return (this._scalingData);
        }

        public function set globalScaling(_arg_1:Boolean):void
        {
            this._globalScaling = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalScaling", _arg_1);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get globalScaling():Boolean
        {
            return (this._globalScaling);
        }

        public function set minFontSizeData(_arg_1:String):void
        {
            this._minFontSizeData = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("minFontSizeData", this._minFontSizeData);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get minFontSizeData():String
        {
            return (this._minFontSizeData);
        }

        public function set globalMinFontSize(_arg_1:Number):void
        {
            this._globalMinFontSize = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalMinFontSize", _arg_1);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get globalMinFontSize():Number
        {
            return (this._globalMinFontSize);
        }

        public function set letterSpacingData(_arg_1:String):void
        {
            this._letterSpacingData = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("letterSpacingData", this._letterSpacingData);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get letterSpacingData():String
        {
            return (this._letterSpacingData);
        }

        public function set globalLetterSpacing(_arg_1:Number):void
        {
            this._globalLetterSpacing = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalLetterSpacing", _arg_1);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get globalLetterSpacing():Number
        {
            return (this._globalLetterSpacing);
        }

        public function set leadingData(_arg_1:String):void
        {
            this._leadingData = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("leadingData", this._leadingData);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get leadingData():String
        {
            return (this._leadingData);
        }

        public function set globalLeading(_arg_1:Number):void
        {
            this._globalLeading = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalLeading", _arg_1);
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get globalLeading():Number
        {
            return (this._globalLeading);
        }

        public function set showBounds(_arg_1:Boolean):void
        {
            this._showBounds = _arg_1;
            if (this._localTextField)
            {
                this._localTextField.textBounds.visible = this._showBounds;
            };
            if (((isLivePreview) || (this._localTextField)))
            {
                if (this.draw != null)
                {
                    this.draw();
                };
            };
        }

        public function get showBounds():Boolean
        {
            return (this._showBounds);
        }

        public function getMetaData():String
        {
            return ("<ltf metadata></ltfmetadata>");
        }

        override public function toString():String
        {
            return (((((((((((((((((((((((((((((("{" + "name: ") + name) + ", ") + "textHorizontalAlignment: ") + this._textHorizontalAlignment) + ", ") + "textVerticalAlignment: ") + this._textVerticalAlignment) + ", ") + "color: ") + this._debugColor) + ", ") + "textSize: ") + this._textSize) + ", ") + "text: ") + this._text) + ", ") + "token: ") + this._token) + ", ") + "fontAlias: ") + this._fontName) + ", ") + "groupID: ") + this._groupName) + ", ") + "_revision: ") + this._revision) + "}");
        }


    }
}//package com.clubpenguin.tools.localtext.component
