//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import com.greensock.core.PropTween;

    public class RoundPropsPlugin extends TweenPlugin 
    {

        public static const API:Number = 1;

        protected var _tween:TweenLite;

        public function RoundPropsPlugin()
        {
            this.propName = "roundProps";
            this.overwriteProps = ["roundProps"];
            this.round = true;
            this.priority = -1;
            this.onInitAllProps = _initAllProps;
        }

        public function add(object:Object, propName:String, start:Number, change:Number):void
        {
            addTween(object, propName, start, (start + change), propName);
            this.overwriteProps[this.overwriteProps.length] = propName;
        }

        protected function _removePropTween(propTween:PropTween):void
        {
            if (propTween.nextNode)
            {
                propTween.nextNode.prevNode = propTween.prevNode;
            };
            if (propTween.prevNode)
            {
                propTween.prevNode.nextNode = propTween.nextNode;
            }
            else
            {
                if (_tween.cachedPT1 == propTween)
                {
                    _tween.cachedPT1 = propTween.nextNode;
                };
            };
            if (((propTween.isPlugin) && (propTween.target.onDisable)))
            {
                propTween.target.onDisable();
            };
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            _tween = tween;
            this.overwriteProps = this.overwriteProps.concat((value as Array));
            return (true);
        }

        protected function _initAllProps():void
        {
            var prop:String;
            var multiProps:String;
            var pt:PropTween;
            var rp:Array = _tween.vars.roundProps;
            var i:int = rp.length;
            while (--i > -1)
            {
                prop = rp[i];
                pt = _tween.cachedPT1;
                while (pt)
                {
                    if (pt.name == prop)
                    {
                        if (pt.isPlugin)
                        {
                            pt.target.round = true;
                        }
                        else
                        {
                            add(pt.target, prop, pt.start, pt.change);
                            _removePropTween(pt);
                            _tween.propTweenLookup[prop] = _tween.propTweenLookup.roundProps;
                        };
                    }
                    else
                    {
                        if ((((pt.isPlugin) && (pt.name == "_MULTIPLE_")) && (!(pt.target.round))))
                        {
                            multiProps = ((" " + pt.target.overwriteProps.join(" ")) + " ");
                            if (multiProps.indexOf(((" " + prop) + " ")) != -1)
                            {
                                pt.target.round = true;
                            };
                        };
                    };
                    pt = pt.nextNode;
                };
            };
        }


    }
}//package com.greensock.plugins
