//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.filters.DropShadowFilter;
    import com.greensock.TweenLite;
    import com.greensock.*;

    public class DropShadowFilterPlugin extends FilterPlugin 
    {

        public static const API:Number = 1;
        private static var _propNames:Array = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];

        public function DropShadowFilterPlugin()
        {
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            _target = target;
            _type = DropShadowFilter;
            initFilter(value, new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, ((value.quality) || (2)), value.inner, value.knockout, value.hideObject), _propNames);
            return (true);
        }


    }
}//package com.greensock.plugins
