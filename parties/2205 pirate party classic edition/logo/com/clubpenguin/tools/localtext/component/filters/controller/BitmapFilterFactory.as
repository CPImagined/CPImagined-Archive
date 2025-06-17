//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.component.filters.controller
{
    import flash.utils.Dictionary;
    import com.clubpenguin.tools.localtext.component.filters.FilterType;
    import flash.filters.BitmapFilter;
    import com.clubpenguin.tools.localtext.component.filters.FilterDefinition;
    import __AS3__.vec.Vector;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;

    public class BitmapFilterFactory 
    {

        public static const INSTANCE:BitmapFilterFactory = new (BitmapFilterFactory)();

        private const creationFuncsByFiltType:Dictionary = new Dictionary();

        public function BitmapFilterFactory()
        {
            if (INSTANCE)
            {
                throw (new Error("Singleton, use static INSTANCE property instead."));
            };
            this.mapFilterCreationFunctions();
        }

        private function mapFilterCreationFunctions():void
        {
            this.creationFuncsByFiltType[FilterType.DROP_SHADOW] = this.createDropShadowFilter;
        }

        private function getCreationFunctionForType(_arg_1:FilterType):Function
        {
            if (!this.creationFuncsByFiltType[_arg_1])
            {
                throw (new Error((("There is no creation function mapping for FilterType: " + _arg_1.name) + ".  Please create one.")));
            };
            return (this.creationFuncsByFiltType[_arg_1]);
        }

        public function getBitmapFilterFromDefinition(_arg_1:FilterDefinition):BitmapFilter
        {
            var _local_2:Function = this.getCreationFunctionForType(_arg_1.filterType);
            return (_local_2(_arg_1) as BitmapFilter);
        }

        private function createDropShadowFilter(_arg_1:FilterDefinition):BitmapFilter
        {
            var _local_2:Vector.<String> = _arg_1.filterType.parameterNames;
            var _local_3:Array = _arg_1.parameterValues;
            var _local_4:Number = _local_3[_local_2.indexOf("distance")];
            var _local_5:Number = _local_3[_local_2.indexOf("angle")];
            var _local_6:uint = uint(_local_3[_local_2.indexOf("color")]);
            var _local_7:Number = ((_local_6 & 0xFF) / 0xFF);
            _local_6 = (_local_6 >> 8);
            var _local_8:Number = _local_3[_local_2.indexOf("blurX")];
            var _local_9:Number = _local_3[_local_2.indexOf("blurY")];
            var _local_10:Number = _local_3[_local_2.indexOf("strength")];
            var _local_11:int = 1;
            switch (_local_3[_local_2.indexOf("quality")])
            {
                case "low":
                    _local_11 = BitmapFilterQuality.LOW;
                    break;
                case "medium":
                    _local_11 = BitmapFilterQuality.MEDIUM;
                    break;
                case "high":
                    _local_11 = BitmapFilterQuality.HIGH;
                    break;
                default:
                    throw (new Error());
            };
            var _local_12:Boolean = _local_3[_local_2.indexOf("inner")];
            var _local_13:Boolean = _local_3[_local_2.indexOf("knockout")];
            var _local_14:Boolean = _local_3[_local_2.indexOf("hideObject")];
            var _local_15:DropShadowFilter = new DropShadowFilter(_local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_10, _local_11, _local_12, _local_13, _local_14);
            return (_local_15);
        }

        private function createGlowFilter(_arg_1:FilterDefinition):BitmapFilter
        {
            var _local_2:Vector.<String> = _arg_1.filterType.parameterNames;
            var _local_3:Array = _arg_1.parameterValues;
            var _local_4:uint = uint(_local_3[_local_2.indexOf("color")]);
            var _local_5:Number = ((_local_4 & 0xFF) / 0xFF);
            _local_4 = (_local_4 >> 8);
            var _local_6:Number = _local_3[_local_2.indexOf("blurX")];
            var _local_7:Number = _local_3[_local_2.indexOf("blurY")];
            var _local_8:Number = _local_3[_local_2.indexOf("strength")];
            var _local_9:int = 1;
            switch (_local_3[_local_2.indexOf("quality")])
            {
                case "low":
                    _local_9 = BitmapFilterQuality.LOW;
                    break;
                case "medium":
                    _local_9 = BitmapFilterQuality.MEDIUM;
                    break;
                case "high":
                    _local_9 = BitmapFilterQuality.HIGH;
                    break;
                default:
                    throw (new Error());
            };
            var _local_10:Boolean = _local_3[_local_2.indexOf("inner")];
            var _local_11:Boolean = _local_3[_local_2.indexOf("knockout")];
            var _local_12:GlowFilter = new GlowFilter(_local_4, _local_5, _local_6, _local_7, _local_8, _local_9, _local_10, _local_11);
            return (_local_12);
        }


    }
}//package com.clubpenguin.tools.localtext.component.filters.controller
