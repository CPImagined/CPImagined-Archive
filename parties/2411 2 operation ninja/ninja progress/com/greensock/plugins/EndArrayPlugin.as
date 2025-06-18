//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import com.greensock.*;

    public class EndArrayPlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _a:Array;
        protected var _info:Array = [];

        public function EndArrayPlugin()
        {
            this.propName = "endArray";
            this.overwriteProps = ["endArray"];
        }

        public function init(start:Array, end:Array):void
        {
            _a = start;
            var i:int = end.length;
            while (i--)
            {
                if (((!(start[i] == end[i])) && (!(start[i] == null))))
                {
                    _info[_info.length] = new ArrayTweenInfo(i, _a[i], (end[i] - _a[i]));
                };
            };
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            if (((!(target is Array)) || (!(value is Array))))
            {
                return (false);
            };
            init((target as Array), value);
            return (true);
        }

        override public function set changeFactor(n:Number):void
        {
            var ti:ArrayTweenInfo;
            var val:Number;
            var i:int = _info.length;
            if (this.round)
            {
                while (i--)
                {
                    ti = _info[i];
                    val = (ti.start + (ti.change * n));
                    if (val > 0)
                    {
                        _a[ti.index] = ((val + 0.5) >> 0);
                    }
                    else
                    {
                        _a[ti.index] = ((val - 0.5) >> 0);
                    };
                };
            }
            else
            {
                while (i--)
                {
                    ti = _info[i];
                    _a[ti.index] = (ti.start + (ti.change * n));
                };
            };
        }


    }
}//package com.greensock.plugins

class ArrayTweenInfo 
{

    public var change:Number;
    public var start:Number;
    public var index:uint;

    public function ArrayTweenInfo(index:uint, start:Number, change:Number)
    {
        this.index = index;
        this.start = start;
        this.change = change;
    }

}

