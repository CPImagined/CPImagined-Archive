//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import flash.media.SoundTransform;
    import com.greensock.TweenLite;
    import com.greensock.*;

    public class VolumePlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _st:SoundTransform;

        public function VolumePlugin()
        {
            this.propName = "volume";
            this.overwriteProps = ["volume"];
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            if ((((isNaN(value)) || (target.hasOwnProperty("volume"))) || (!(target.hasOwnProperty("soundTransform")))))
            {
                return (false);
            };
            _target = target;
            _st = _target.soundTransform;
            addTween(_st, "volume", _st.volume, value, "volume");
            return (true);
        }

        override public function set changeFactor(n:Number):void
        {
            updateTweens(n);
            _target.soundTransform = _st;
        }


    }
}//package com.greensock.plugins
