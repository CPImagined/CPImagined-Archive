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

        public function VAlignLTFContentCMD(_arg_1:ILocalTextField, _arg_2:Number=-1)
        {
            this.localTextField = _arg_1;
            this.maxHeight = _arg_2;
        }

        public function execute():void
        {
            var _local_1:TextField = this.localTextField.textField;
            if (((this.maxHeight > 0) && ((_local_1.textHeight + this.TEXT_VISIBILITY_PADDING) > this.maxHeight)))
            {
                _local_1.height = this.maxHeight;
            }
            else
            {
                _local_1.height = (_local_1.textHeight + this.TEXT_VISIBILITY_PADDING);
            };
            switch (this.localTextField.verticalAlignment)
            {
                case LocalTextAlign.TOP:
                    _local_1.y = 0;
                    break;
                case LocalTextAlign.CENTER:
                    _local_1.y = ((this.localTextField.height - _local_1.height) / 2);
                    break;
                case LocalTextAlign.BOTTOM:
                    _local_1.y = (this.localTextField.height - _local_1.height);
                    break;
            };
            this.localTextField.textBounds.draw();
        }


    }
}//package com.clubpenguin.tools.localtext.core.commands
