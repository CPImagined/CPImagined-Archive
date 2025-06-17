//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core.commands
{
    import com.clubpenguin.tools.localtext.core.ILocalTextField;
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.core.LocalTextAlign;

    public class VAlignLTFContentCMD 
    {

        private const TEXT_VISIBILITY_PADDING:Number = 4;

        private var localTextField:ILocalTextField;
        private var maxHeight:Number;

        public function VAlignLTFContentCMD(localTextField:ILocalTextField, maximumHeight:Number=-1)
        {
            this.localTextField = localTextField;
            this.maxHeight = maximumHeight;
        }

        public function execute():void
        {
            var textField:TextField = this.localTextField.textField;
            if (((this.maxHeight > 0) && ((textField.textHeight + this.TEXT_VISIBILITY_PADDING) > this.maxHeight)))
            {
                textField.height = this.maxHeight;
            }
            else
            {
                textField.height = (textField.textHeight + this.TEXT_VISIBILITY_PADDING);
            };
            switch (this.localTextField.verticalAlignment)
            {
                case LocalTextAlign.TOP:
                    textField.y = 0;
                    break;
                case LocalTextAlign.CENTER:
                    textField.y = ((this.localTextField.height - textField.height) / 2);
                    break;
                case LocalTextAlign.BOTTOM:
                    textField.y = (this.localTextField.height - textField.height);
                    break;
            };
            this.localTextField.textBounds.draw();
        }


    }
}//package com.clubpenguin.tools.localtext.core.commands
