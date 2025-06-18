//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.filters.GlowFilter;
    import com.greensock.TweenLite;
    import com.greensock.*;

    public class GlowFilterPlugin extends FilterPlugin 
    {

        public static const API:Number = 1;
        private static var _propNames:Array = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];

        public function GlowFilterPlugin()
        {
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            _target = target;
            _type = GlowFilter;
            initFilter(value, new GlowFilter(0xFFFFFF, 0, 0, 0, ((value.strength) || (1)), ((value.quality) || (2)), value.inner, value.knockout), _propNames);
            return (true);
        }


    }
}//package com.greensock.plugins
