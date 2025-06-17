//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core.commands
{
    import com.clubpenguin.tools.localtext.core.LocalTextFieldGroupCollection;
    import com.clubpenguin.tools.localtext.core.LocalTextField;
    import __AS3__.vec.Vector;
    import flash.text.TextFormat;

    public class SetLTFGroupFontSizeCMD 
    {

        private var localTextFieldGroupCollection:LocalTextFieldGroupCollection;
        private var localTextField:LocalTextField;

        public function SetLTFGroupFontSizeCMD(localTextFieldGroupCollection:LocalTextFieldGroupCollection, localTextField:LocalTextField)
        {
            this.localTextFieldGroupCollection = localTextFieldGroupCollection;
            this.localTextField = localTextField;
        }

        public function execute():void
        {
            var groupLTFs:Vector.<LocalTextField>;
            var ltf:LocalTextField;
            var curLTFTextFormat:TextFormat;
            var ltfAbsGroupName:String = this.localTextField.absoluteGroupName;
            var currentGroupFontSize:Number = this.localTextFieldGroupCollection.getGroupFontSize(ltfAbsGroupName);
            var textFormat:TextFormat = this.localTextField.textField.getTextFormat();
            if ((textFormat.size as Number) > currentGroupFontSize)
            {
                textFormat.size = currentGroupFontSize;
                this.localTextField.textField.setTextFormat(textFormat);
                this.localTextField.textField.autoSize = this.localTextField.textField.getTextFormat().align;
                new VAlignLTFContentCMD(this.localTextField).execute();
                return;
            };
            if ((textFormat.size as Number) < currentGroupFontSize)
            {
                this.localTextFieldGroupCollection.setGroupFontSize(this.localTextField.absoluteGroupName, (textFormat.size as Number));
                groupLTFs = this.localTextFieldGroupCollection.getLocalTextFieldsInGroup(this.localTextField.absoluteGroupName);
                for each (ltf in groupLTFs)
                {
                    curLTFTextFormat = ltf.textField.getTextFormat();
                    curLTFTextFormat.size = textFormat.size;
                    ltf.textField.setTextFormat(curLTFTextFormat);
                    ltf.textField.autoSize = curLTFTextFormat.align;
                    new VAlignLTFContentCMD(ltf).execute();
                };
            };
        }


    }
}//package com.clubpenguin.tools.localtext.core.commands
