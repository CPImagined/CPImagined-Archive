package com.clubpenguin.tools.localtext.component.filters.controller
{
    import __AS3__.vec.*;
    import com.clubpenguin.tools.localtext.component.filters.*;
    import flash.filters.*;
    import flash.text.*;

    public class ApplyRawFiltersToTextFieldCMD extends Object
    {
        private var textField:TextField;
        private var rawFiltersString:String;

        public function ApplyRawFiltersToTextFieldCMD(param1:TextField, param2:String)
        {
            this.textField = param1;
            this.rawFiltersString = param2;
            return;
        }// end function

        public function execute() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = LTCFilterUtils.getFilterDefsFromRaw(this.rawFiltersString);
            var _loc_2:* = [];
            for each (_loc_3 in _loc_1)
            {
                
                _loc_4 = BitmapFilterFactory.INSTANCE.getBitmapFilterFromDefinition(_loc_3);
                _loc_2.push(_loc_4);
            }
            this.textField.filters = _loc_2;
            return;
        }// end function

    }
}
