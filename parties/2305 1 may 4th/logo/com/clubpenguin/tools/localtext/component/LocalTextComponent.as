package com.clubpenguin.tools.localtext.component
{
    import __AS3__.vec.*;
    import com.clubpenguin.tools.localtext.component.*;
    import com.clubpenguin.tools.localtext.component.filters.controller.*;
    import com.clubpenguin.tools.localtext.core.*;
    import com.clubpenguin.tools.localtext.core.commands.*;
    import fl.core.*;
    import flash.display.*;
    import flash.text.*;

    public class LocalTextComponent extends UIComponent implements IFontLibraryDependant, ILocalTextComponent
    {
        private const format:TextFormat;
        private var _textHorizontalAlignment:String = "left";
        private var _textVerticalAlignment:String = "center";
        private var _debugColor:int = 52224;
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
        private var _revision:String;
        private var isFontChanged:Boolean;
        private var _ltcFilters:String;
        private var _langControl:Boolean;
        private var _currentLang:String;
        private var _wordWrapData:String;
        private var _scalingData:String;
        private var _minFontSizeData:String;
        private var _localTextField:ILocalTextField;

        public function LocalTextComponent(param1:Number = NaN, param2:Number = NaN)
        {
            this.format = new TextFormat();
            var _loc_3:* = false;
            mouseChildren = false;
            mouseEnabled = _loc_3;
            return;
        }// end function

        override protected function configUI() : void
        {
            this._localTextField = new LocalTextField();
            this._tf = this._localTextField.textField;
            this.applyLocalTextFieldProps();
            addChild(this._localTextField as DisplayObject);
            LocalTextProxy.queueLocalTextField(this._localTextField);
            super.configUI();
            return;
        }// end function

        private function applyLocalTextFieldProps() : void
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
            this._localTextField.textBounds.visible = this._showBounds;
            this._localTextField.textBounds.visible = this._showBounds;
            if (this._wordWrapData)
            {
                this._localTextField.setProperty("globalWordWrap", this._globalWordWrap);
            }
            if (this._scalingData)
            {
                this._localTextField.setProperty("scalingData", this._scalingData);
            }
            if (this._minFontSizeData)
            {
                this._localTextField.setProperty("minFontSizeData", this._minFontSizeData);
            }
            if (this._ltcFilters)
            {
                new ApplyRawFiltersToTextFieldCMD(this._tf, this._ltcFilters).execute();
            }
            return;
        }// end function

        override protected function draw() : void
        {
            this.format.font = this._fontName;
            this.format.size = this._textSize;
            this.format.color = this._textColor;
            this.format.align = this._textHorizontalAlignment;
            this._tf.setTextFormat(this.format);
            this._tf.defaultTextFormat = this.format;
            this._tf.width = this._localTextField.width;
            if (isLivePreview)
            {
                this._tf.wordWrap = this._langControl ? (this._wordWrapData.indexOf(this._currentLang) > -1) : (this._globalWordWrap);
            }
            this._tf.embedFonts = true;
            this.localTextField.textBounds.width = _width;
            this.localTextField.textBounds.height = _height;
            this.localTextField.textBounds.draw();
            if (isLivePreview)
            {
                new VAlignLTFContentCMD(this._localTextField, _height).execute();
            }
            this._tf.x = 0;
            this._localTextField.fontAlias = this.fontAlias;
            super.draw();
            return;
        }// end function

        public function get localTextField() : ILocalTextField
        {
            return this._localTextField;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function set debugColor(param1:int) : void
        {
            this._debugColor = param1;
            if (this._localTextField)
            {
                this._localTextField.textBounds.color = param1;
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get debugColor() : int
        {
            return this._debugColor;
        }// end function

        public function set font(param1:String) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = this.normalizeFontName(param1);
            if (!LocalTextProxy.initialized)
            {
                this._queuedFontName = param1;
                LocalTextProxy.queueFontLibraryDependant(this);
            }
            else
            {
                this._queuedFontName = null;
            }
            var _loc_3:* = LocalTextProxy.allFonts;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                if (_loc_5.fontName == _loc_2 || _loc_5.fontName == param1)
                {
                    this._fontName = param1;
                    this.isFontChanged = true;
                    if (isLivePreview || this._localTextField)
                    {
                        this.draw();
                    }
                    return;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function onFontLibraryLoaded() : void
        {
            this.font = this._queuedFontName;
            this._localTextField.fontAlias = this.fontAlias;
            return;
        }// end function

        public function get font() : String
        {
            return this._fontName;
        }// end function

        public function set fontAlias(param1:String) : void
        {
            if (param1.indexOf("_") != 0)
            {
                return;
            }
            this._localTextField.fontAlias = param1;
            this.font = param1;
            return;
        }// end function

        public function get fontAlias() : String
        {
            if (this._localTextField.fontAlias != null && !this.isFontChanged)
            {
                return this._localTextField.fontAlias;
            }
            this.isFontChanged = false;
            return this.normalizeFontName(this._fontName);
        }// end function

        private function normalizeFontName(param1:String) : String
        {
            var _loc_2:* = param1.split(" ").join("");
            if (_loc_2.indexOf("_") != 0)
            {
                _loc_2 = "_" + _loc_2;
            }
            return _loc_2;
        }// end function

        public function set groupName(param1:String) : void
        {
            this._groupName = param1;
            if (this._localTextField)
            {
                this._localTextField.groupName = this._groupName;
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get groupName() : String
        {
            return this._groupName;
        }// end function

        public function set textHorizontalAlignment(param1:String) : void
        {
            this._textHorizontalAlignment = param1;
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get textHorizontalAlignment() : String
        {
            return this._textHorizontalAlignment;
        }// end function

        public function set textSize(param1:Number) : void
        {
            this._textSize = param1;
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get textSize() : Number
        {
            return this._textSize;
        }// end function

        public function set text(param1:String) : void
        {
            this._text = unescape(param1);
            if (this._localTextField)
            {
                this._localTextField.text = this._text;
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

        public function set textColor(param1:int) : void
        {
            this._textColor = param1;
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get textColor() : int
        {
            return this._textColor;
        }// end function

        public function set token(param1:String) : void
        {
            this._token = param1;
            if (this._localTextField)
            {
                this._localTextField.token = this._token;
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get token() : String
        {
            return this._token;
        }// end function

        public function set textVerticalAlignment(param1:String) : void
        {
            this._textVerticalAlignment = param1;
            if (this._localTextField)
            {
                this._localTextField.verticalAlignment = this._textVerticalAlignment;
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get textVerticalAlignment() : String
        {
            return this._textVerticalAlignment;
        }// end function

        public function set ltcFilters(param1:String) : void
        {
            if (param1 == this._ltcFilters)
            {
                return;
            }
            this._ltcFilters = param1;
            if (this._tf)
            {
                new ApplyRawFiltersToTextFieldCMD(this._tf, this._ltcFilters).execute();
            }
            return;
        }// end function

        public function get ltcFilters() : String
        {
            return this._ltcFilters;
        }// end function

        public function set zrevision(param1:String) : void
        {
            this._revision = param1;
            if (this._localTextField)
            {
                this._localTextField.componentVersion = this._revision;
            }
            return;
        }// end function

        public function get zrevision() : String
        {
            return this._revision;
        }// end function

        override public function set name(param1:String) : void
        {
            super.name = param1;
            if (this._localTextField)
            {
                this._localTextField.name = param1;
            }
            return;
        }// end function

        public function set langControl(param1:Boolean) : void
        {
            this._langControl = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("langControl", param1);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get langControl() : Boolean
        {
            return this._langControl;
        }// end function

        public function set currentLang(param1:String) : void
        {
            this._currentLang = param1;
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get currentLang() : String
        {
            return this._currentLang;
        }// end function

        public function set wordWrapData(param1:String) : void
        {
            this._wordWrapData = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("wordWrapData", this._wordWrapData);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get wordWrapData() : String
        {
            return this._wordWrapData;
        }// end function

        public function set globalWordWrap(param1:Boolean) : void
        {
            this._globalWordWrap = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalWordWrap", param1);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get globalWordWrap() : Boolean
        {
            return this._globalWordWrap;
        }// end function

        public function set scalingData(param1:String) : void
        {
            this._scalingData = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("scalingData", this._scalingData);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get scalingData() : String
        {
            return this._scalingData;
        }// end function

        public function set globalScaling(param1:Boolean) : void
        {
            this._globalScaling = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalScaling", param1);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get globalScaling() : Boolean
        {
            return this._globalScaling;
        }// end function

        public function set minFontSizeData(param1:String) : void
        {
            this._minFontSizeData = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("minFontSizeData", this._minFontSizeData);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get minFontSizeData() : String
        {
            return this._minFontSizeData;
        }// end function

        public function set globalMinFontSize(param1:Number) : void
        {
            this._globalMinFontSize = param1;
            if (this._localTextField)
            {
                this._localTextField.setProperty("globalMinFontSize", param1);
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get globalMinFontSize() : Number
        {
            return this._globalMinFontSize;
        }// end function

        public function set showBounds(param1:Boolean) : void
        {
            this._showBounds = param1;
            if (this._localTextField)
            {
                this._localTextField.textBounds.visible = this._showBounds;
            }
            if (isLivePreview || this._localTextField)
            {
                this.draw();
            }
            return;
        }// end function

        public function get showBounds() : Boolean
        {
            return this._showBounds;
        }// end function

        public function getMetaData() : String
        {
            return "<ltf metadata></ltfmetadata>";
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = "{" + "name: " + name + ", " + "textHorizontalAlignment: " + this._textHorizontalAlignment + ", " + "textVerticalAlignment: " + this._textVerticalAlignment + ", " + "color: " + this._debugColor + ", " + "textSize: " + this._textSize + ", " + "text: " + this._text + ", " + "token: " + this._token + ", " + "fontAlias: " + this._fontName + ", " + "groupID: " + this._groupName + ", " + "_revision: " + this._revision + "}";
            return _loc_1;
        }// end function

    }
}
