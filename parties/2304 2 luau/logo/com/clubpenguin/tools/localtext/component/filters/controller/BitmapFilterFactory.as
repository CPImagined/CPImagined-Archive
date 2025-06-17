package com.clubpenguin.tools.localtext.component.filters.controller
{
    import __AS3__.vec.*;
    import com.clubpenguin.tools.localtext.component.filters.*;
    import flash.filters.*;
    import flash.utils.*;

    public class BitmapFilterFactory extends Object
    {
        private const creationFuncsByFiltType:Dictionary;
        public static const INSTANCE:BitmapFilterFactory = new BitmapFilterFactory;

        public function BitmapFilterFactory()
        {
            this.creationFuncsByFiltType = new Dictionary();
            if (INSTANCE)
            {
                throw new Error("Singleton, use static INSTANCE property instead.");
            }
            this.mapFilterCreationFunctions();
            return;
        }// end function

        private function mapFilterCreationFunctions() : void
        {
            this.creationFuncsByFiltType[FilterType.DROP_SHADOW] = this.createDropShadowFilter;
            return;
        }// end function

        private function getCreationFunctionForType(param1:FilterType) : Function
        {
            if (!this.creationFuncsByFiltType[param1])
            {
                throw new Error("There is no creation function mapping for FilterType: " + param1.name + ".  Please create one.");
            }
            return this.creationFuncsByFiltType[param1];
        }// end function

        public function getBitmapFilterFromDefinition(param1:FilterDefinition) : BitmapFilter
        {
            var _loc_2:* = this.getCreationFunctionForType(param1.filterType);
            return this._loc_2(param1) as BitmapFilter;
        }// end function

        private function createDropShadowFilter(param1:FilterDefinition) : BitmapFilter
        {
            var _loc_2:* = param1.filterType.parameterNames;
            var _loc_3:* = param1.parameterValues;
            var _loc_4:* = _loc_3[_loc_2.indexOf("distance")];
            var _loc_5:* = _loc_3[_loc_2.indexOf("angle")];
            var _loc_6:* = uint(_loc_3[_loc_2.indexOf("color")]);
            var _loc_7:* = (uint(_loc_3[_loc_2.indexOf("color")]) & 255) / 255;
            _loc_6 = _loc_6 >> 8;
            var _loc_8:* = _loc_3[_loc_2.indexOf("blurX")];
            var _loc_9:* = _loc_3[_loc_2.indexOf("blurY")];
            var _loc_10:* = _loc_3[_loc_2.indexOf("strength")];
            var _loc_11:* = 1;
            switch(_loc_3[_loc_2.indexOf("quality")])
            {
                case "low":
                {
                    _loc_11 = BitmapFilterQuality.LOW;
                    break;
                }
                case "medium":
                {
                    _loc_11 = BitmapFilterQuality.MEDIUM;
                    break;
                }
                case "high":
                {
                    _loc_11 = BitmapFilterQuality.HIGH;
                    break;
                }
                default:
                {
                    throw new Error();
                    break;
                }
            }
            var _loc_12:* = _loc_3[_loc_2.indexOf("inner")];
            var _loc_13:* = _loc_3[_loc_2.indexOf("knockout")];
            var _loc_14:* = _loc_3[_loc_2.indexOf("hideObject")];
            var _loc_15:* = new DropShadowFilter(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12, _loc_13, _loc_14);
            return new DropShadowFilter(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12, _loc_13, _loc_14);
        }// end function

        private function createGlowFilter(param1:FilterDefinition) : BitmapFilter
        {
            var _loc_2:* = param1.filterType.parameterNames;
            var _loc_3:* = param1.parameterValues;
            var _loc_4:* = uint(_loc_3[_loc_2.indexOf("color")]);
            var _loc_5:* = (uint(_loc_3[_loc_2.indexOf("color")]) & 255) / 255;
            _loc_4 = _loc_4 >> 8;
            var _loc_6:* = _loc_3[_loc_2.indexOf("blurX")];
            var _loc_7:* = _loc_3[_loc_2.indexOf("blurY")];
            var _loc_8:* = _loc_3[_loc_2.indexOf("strength")];
            var _loc_9:* = 1;
            switch(_loc_3[_loc_2.indexOf("quality")])
            {
                case "low":
                {
                    _loc_9 = BitmapFilterQuality.LOW;
                    break;
                }
                case "medium":
                {
                    _loc_9 = BitmapFilterQuality.MEDIUM;
                    break;
                }
                case "high":
                {
                    _loc_9 = BitmapFilterQuality.HIGH;
                    break;
                }
                default:
                {
                    throw new Error();
                    break;
                }
            }
            var _loc_10:* = _loc_3[_loc_2.indexOf("inner")];
            var _loc_11:* = _loc_3[_loc_2.indexOf("knockout")];
            var _loc_12:* = new GlowFilter(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11);
            return new GlowFilter(_loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11);
        }// end function

    }
}
