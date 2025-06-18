//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core.commands
{
    import com.clubpenguin.tools.localtext.core.LocalTextField;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class FitLTCContentWithinBoundsCMD 
    {

        private const FONT_REDUCTION_STEP:Number = 1;

        private var localTextField:LocalTextField;
        private var minFontSize:Number;
        private var onComplete:Function;

        public function FitLTCContentWithinBoundsCMD(localTextField:LocalTextField, minFontSize:Number, onComplete:Function)
        {
            this.localTextField = localTextField;
            this.minFontSize = minFontSize;
            this.onComplete = onComplete;
        }

        public function execute():void
        {
            var textField:TextField = this.localTextField.textField;
            var textFormat:TextFormat = textField.getTextFormat();
            var originalFontSize:Number = (textFormat.size as Number);
            if (!textField.wordWrap)
            {
                this.reduceFontSizeForWidth(textField, textFormat);
                if (textFormat.size >= this.minFontSize)
                {
                    this.reAlign();
                    return;
                };
            };
            this.reduceFontSizeForHeight(textField, textFormat, originalFontSize);
            this.reAlign();
        }

        private function reduceFontSizeForWidth(textField:TextField, textFormat:TextFormat):void
        {
            var size:Number;
            while (((textField.textWidth > textField.width) && (textFormat.size >= this.minFontSize)))
            {
                size = (textFormat.size as Number);
                size = (size - this.FONT_REDUCTION_STEP);
                textFormat.size = size;
                textField.setTextFormat(textFormat);
            };
        }

        private function reduceFontSizeForHeight(textField:TextField, textFormat:TextFormat, originalFontSize:Number):void
        {
            var size:Number;
            textField.wordWrap = true;
            textFormat.size = originalFontSize;
            textField.autoSize = textFormat.align;
            textField.setTextFormat(textFormat);
            while (((textField.textHeight > this.localTextField.height) && (textFormat.size > this.minFontSize)))
            {
                size = (textFormat.size as Number);
                size = (size - this.FONT_REDUCTION_STEP);
                textFormat.size = size;
                textField.setTextFormat(textFormat);
            };
        }

        private function reAlign():void
        {
            new VAlignLTFContentCMD(this.localTextField).execute();
            this.onComplete();
        }


    }
}//package com.clubpenguin.tools.localtext.core.commands
