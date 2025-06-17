//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core.commands
{
    import com.clubpenguin.tools.localtext.core.LocalTextField;
    import com.clubpenguin.tools.localtext.core.LanguageEnum;
    import flash.text.TextFormat;

    public class UpdateLangSpecificPropsCMD 
    {

        private var localTextField:LocalTextField;
        private var langEnum:LanguageEnum;
        private var onComplete:Function;

        public function UpdateLangSpecificPropsCMD(localTextField:LocalTextField, langEnum:LanguageEnum, onComplete:Function)
        {
            this.localTextField = localTextField;
            this.langEnum = langEnum;
            this.onComplete = onComplete;
        }

        public function execute():void
        {
            if ((this.localTextField.getProperty("langControl") as Boolean) == true)
            {
                this.updatePropsForLanguage();
            }
            else
            {
                this.updateGlobalProps();
            };
        }

        private function updatePropsForLanguage():void
        {
            var letterSpacings:Array;
            var letterSpacingLangIndex:int;
            var letterSpacingVal:Number;
            var leadings:Array;
            var leadingIndex:int;
            var leadingVal:Number;
            var langMinFontSizeArray:Array;
            var langMinFontSize:Number;
            var langWordWrap:* = ((this.localTextField.getProperty("wordWrapData") as String).indexOf(this.langEnum.lang) > -1);
            this.localTextField.textField.wordWrap = langWordWrap;
            var textFormat:TextFormat = this.localTextField.textField.getTextFormat();
            if ((this.localTextField.getProperty("letterSpacingData") as String) != null)
            {
                letterSpacings = (this.localTextField.getProperty("letterSpacingData") as String).split(",");
                letterSpacingLangIndex = letterSpacings.indexOf(this.langEnum.lang);
                letterSpacingVal = Number(letterSpacings[(letterSpacingLangIndex + 1)]);
                textFormat.letterSpacing = letterSpacingVal;
            };
            if ((this.localTextField.getProperty("leadingData") as String) != null)
            {
                leadings = (this.localTextField.getProperty("leadingData") as String).split(",");
                leadingIndex = leadings.indexOf(this.langEnum.lang);
                leadingVal = leadings[(leadingIndex + 1)];
                textFormat.leading = leadingVal;
            };
            this.localTextField.textField.defaultTextFormat = textFormat;
            this.localTextField.textField.setTextFormat(textFormat);
            var langScaling:* = ((this.localTextField.getProperty("scalingData") as String).indexOf(this.langEnum.lang) > -1);
            if (langScaling)
            {
                langMinFontSizeArray = (this.localTextField.getProperty("minFontSizeData") as String).split(",");
                langMinFontSize = Number((langMinFontSizeArray[(langMinFontSizeArray.indexOf(this.langEnum.lang) + 1)] as String));
                new FitLTCContentWithinBoundsCMD(this.localTextField, langMinFontSize, this.onPropertiesUpdated).execute();
            }
            else
            {
                this.localTextField.textField.autoSize = this.localTextField.textField.getTextFormat().align;
                new VAlignLTFContentCMD(this.localTextField).execute();
            };
        }

        private function updateGlobalProps():void
        {
            var globalMinFontSize:Number;
            var globalWordWrap:Boolean = (this.localTextField.getProperty("globalWordWrap") as Boolean);
            this.localTextField.textField.wordWrap = globalWordWrap;
            var globalLetterSpacing:Number = (this.localTextField.getProperty("globalLetterSpacing") as Number);
            var globalLeading:Number = (this.localTextField.getProperty("globalLeading") as Number);
            var textFormat:TextFormat = this.localTextField.textField.getTextFormat();
            textFormat.letterSpacing = globalLetterSpacing;
            textFormat.leading = globalLeading;
            this.localTextField.textField.defaultTextFormat = textFormat;
            this.localTextField.textField.setTextFormat(textFormat);
            var globalScaling:Boolean = (this.localTextField.getProperty("globalScaling") as Boolean);
            if (globalScaling)
            {
                globalMinFontSize = (this.localTextField.getProperty("globalMinFontSize") as Number);
                new FitLTCContentWithinBoundsCMD(this.localTextField, globalMinFontSize, this.onPropertiesUpdated).execute();
            }
            else
            {
                this.localTextField.textField.autoSize = this.localTextField.textField.getTextFormat().align;
                new VAlignLTFContentCMD(this.localTextField).execute();
            };
        }

        private function onPropertiesUpdated():void
        {
            this.onComplete();
        }


    }
}//package com.clubpenguin.tools.localtext.core.commands
