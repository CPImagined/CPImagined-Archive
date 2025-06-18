//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.geom.ColorTransform;
    import flash.geom.Transform;
    import flash.display.DisplayObject;
    import com.greensock.TweenLite;
    import com.greensock.core.PropTween;
    import flash.display.*;
    import com.greensock.*;
    import com.greensock.core.*;

    public class TintPlugin extends TweenPlugin 
    {

        public static const API:Number = 1;
        protected static var _props:Array = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];

        protected var _ct:ColorTransform;
        protected var _transform:Transform;
        protected var _ignoreAlpha:Boolean;

        public function TintPlugin()
        {
            this.propName = "tint";
            this.overwriteProps = ["tint"];
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            if (!(target is DisplayObject))
            {
                return (false);
            };
            var end:ColorTransform = new ColorTransform();
            if (((!(value == null)) && (!(tween.vars.removeTint == true))))
            {
                end.color = uint(value);
            };
            _ignoreAlpha = true;
            init((target as DisplayObject), end);
            return (true);
        }

        override public function set changeFactor(n:Number):void
        {
            var ct:ColorTransform;
            updateTweens(n);
            if (_ignoreAlpha)
            {
                ct = _transform.colorTransform;
                _ct.alphaMultiplier = ct.alphaMultiplier;
                _ct.alphaOffset = ct.alphaOffset;
            };
            _transform.colorTransform = _ct;
        }

        public function init(target:DisplayObject, end:ColorTransform):void
        {
            var p:String;
            _transform = target.transform;
            _ct = _transform.colorTransform;
            var i:int = _props.length;
            while (i--)
            {
                p = _props[i];
                if (_ct[p] != end[p])
                {
                    _tweens[_tweens.length] = new PropTween(_ct, p, _ct[p], (end[p] - _ct[p]), "tint", false);
                };
            };
        }


    }
}//package com.greensock.plugins
