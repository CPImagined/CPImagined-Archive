package com.clubpenguin.tools.localtext.core.commands
{
    import com.clubpenguin.tools.localtext.core.*;
    import flash.text.*;

    public class VAlignLTFContentCMD extends Object
    {
        private const TEXT_VISIBILITY_PADDING:Number = 4;
        private var localTextField:ILocalTextField;
        private var maxHeight:Number;

        public function VAlignLTFContentCMD(param1:ILocalTextField, param2:Number = -1)
        {
            this.localTextField = param1;
            this.maxHeight = param2;
            return;
        }// end function

        public function execute() : void
        {
            var _loc_1:* = this.localTextField.textField;
            if (this.maxHeight > 0 && _loc_1.textHeight + this.TEXT_VISIBILITY_PADDING > this.maxHeight)
            {
                _loc_1.height = this.maxHeight;
            }
            else
            {
                _loc_1.height = _loc_1.textHeight + this.TEXT_VISIBILITY_PADDING;
            }
            switch(this.localTextField.verticalAlignment)
            {
                case LocalTextAlign.TOP:
                {
                    _loc_1.y = 0;
                    break;
                }
                case LocalTextAlign.CENTER:
                {
                    _loc_1.y = (this.localTextField.height - _loc_1.height) / 2;
                    break;
                }
                case LocalTextAlign.BOTTOM:
                {
                    _loc_1.y = this.localTextField.height - _loc_1.height;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.localTextField.textBounds.draw();
            return;
        }// end function

    }
}
