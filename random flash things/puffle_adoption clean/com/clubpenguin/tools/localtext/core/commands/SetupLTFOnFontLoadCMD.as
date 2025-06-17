//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core.commands
{
    import com.clubpenguin.tools.localtext.core.LocalTextField;
    import com.clubpenguin.tools.localtext.core.ILocalizedText;
    import com.clubpenguin.tools.localtext.core.LocalTextFieldGroupCollection;
    import com.clubpenguin.tools.localtext.core.FontLibrary;
    import com.clubpenguin.tools.localtext.core.LanguageEnum;
    import flash.text.TextFormat;
    import flash.text.TextField;

    public class SetupLTFOnFontLoadCMD 
    {

        private var localTextField:LocalTextField;
        private var localizedText:ILocalizedText;
        private var localTextFieldGroupCollection:LocalTextFieldGroupCollection;
        private var debugMode:Boolean = false;
        private var fontLibrary:FontLibrary;
        private var langEnum:LanguageEnum;
        private var onCompleteHandler:Function;
        private var translateTokens:Boolean;

        public function SetupLTFOnFontLoadCMD(localTextField:LocalTextField, localizedText:ILocalizedText, debugMode:Boolean, localTextFieldGroupCollection:LocalTextFieldGroupCollection, fontLibrary:FontLibrary, langEnum:LanguageEnum, onCompleteHandler:Function, translateTokens:Boolean=true)
        {
            this.localTextField = localTextField;
            this.localizedText = localizedText;
            this.debugMode = debugMode;
            this.localTextFieldGroupCollection = localTextFieldGroupCollection;
            this.fontLibrary = fontLibrary;
            this.langEnum = langEnum;
            this.onCompleteHandler = onCompleteHandler;
            this.translateTokens = translateTokens;
        }

        public function execute():void
        {
            var translatedText:String;
            if (((this.localTextField.token) && (this.translateTokens)))
            {
                if (!this.localizedText)
                {
                    throw (new Error("ILocalizedText translations have not been specified.  An ILocalizedText instance must exist before processing LocalTextFields"));
                };
                translatedText = this.localizedText.getTextForToken(this.localTextField.token);
                if (((!(translatedText)) || (translatedText == "")))
                {
                    throw (new Error(((("ILocalizedText translation library does not contain a '" + this.langEnum.lang) + "' translation for token: ") + this.localTextField.token)));
                };
                this.localTextField.text = translatedText;
            };
            this.localTextField.textBounds.visible = this.debugMode;
            var fontName:String = this.localTextField.fontAlias;
            if (!this.fontLibrary.isFontRegistered(fontName))
            {
                throw (new Error(((("Font " + fontName) + " is not registered for language ") + this.langEnum.lang)));
            };
            if (!this.fontLibrary.fontHasGlyphs(fontName, this.localTextField.text))
            {
                throw (new Error((((((((("Font " + fontName) + " for language ") + this.langEnum.lang) + " does not support glyphs in string: '") + this.localTextField.text) + "'.\n\nUnsupported glyphs: ") + this.fontLibrary.findUnsupportedGlyphsForFont(fontName, this.localTextField.text)) + "\n\n")));
            };
            this.applyTextFormatForFont(this.localTextField.textField, fontName);
            new UpdateLangSpecificPropsCMD(this.localTextField, this.langEnum, this.onLangSpecificsComplete).execute();
        }

        private function applyTextFormatForFont(textField:TextField, fontName:String):void
        {
            var textFormat:TextFormat = textField.getTextFormat();
            textFormat.font = fontName;
            var replacementTF:TextField = new TextField();
            replacementTF.wordWrap = textField.wordWrap;
            replacementTF.autoSize = textField.autoSize;
            replacementTF.mouseEnabled = textField.mouseEnabled;
            replacementTF.selectable = textField.selectable;
            replacementTF.filters = textField.filters;
            replacementTF.multiline = textField.multiline;
            replacementTF.embedFonts = true;
            replacementTF.defaultTextFormat = textFormat;
            replacementTF.setTextFormat(textFormat);
            replacementTF.text = textField.text;
            replacementTF.x = textField.x;
            replacementTF.y = textField.y;
            replacementTF.width = textField.width;
            replacementTF.height = textField.height;
            this.localTextField.replaceTextField(replacementTF);
        }

        private function onLangSpecificsComplete():void
        {
            this.onCompleteHandler();
        }


    }
}//package com.clubpenguin.tools.localtext.core.commands
