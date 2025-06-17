//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component.filters.controller
{
    import flash.text.TextField;
    import com.clubpenguin.tools.localtext.component.filters.FilterDefinition;
    import flash.filters.BitmapFilter;
    import com.clubpenguin.tools.localtext.component.filters.LTCFilterUtils;
    import __AS3__.vec.Vector;

    public class ApplyRawFiltersToTextFieldCMD 
    {

        private var textField:TextField;
        private var rawFiltersString:String;

        public function ApplyRawFiltersToTextFieldCMD(_arg_1:TextField, _arg_2:String)
        {
            this.textField = _arg_1;
            this.rawFiltersString = _arg_2;
        }

        public function execute():void
        {
            var _local_3:FilterDefinition;
            var _local_4:BitmapFilter;
            var _local_1:Vector.<FilterDefinition> = LTCFilterUtils.getFilterDefsFromRaw(this.rawFiltersString);
            var _local_2:Array = [];
            for each (_local_3 in _local_1)
            {
                _local_4 = BitmapFilterFactory.INSTANCE.getBitmapFilterFromDefinition(_local_3);
                _local_2.push(_local_4);
            };
            this.textField.filters = _local_2;
        }


    }
}//package com.clubpenguin.tools.localtext.component.filters.controller
