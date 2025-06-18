//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.plugins
{
    import com.greensock.TweenLite;
    import com.greensock.*;

    public class BezierPlugin extends TweenPlugin 
    {

        public static const API:Number = 1;
        protected static const _RAD2DEG:Number = (180 / Math.PI);//57.2957795130823

        protected var _future:Object = {};
        protected var _orient:Boolean;
        protected var _orientData:Array;
        protected var _target:Object;
        protected var _beziers:Object;

        public function BezierPlugin()
        {
            this.propName = "bezier";
            this.overwriteProps = [];
        }

        public static function parseBeziers(props:Object, through:Boolean=false):Object
        {
            var i:int;
            var a:Array;
            var b:Object;
            var p:String;
            var all:Object = {};
            if (through)
            {
                for (p in props)
                {
                    a = props[p];
                    all[p] = (b = []);
                    if (a.length > 2)
                    {
                        b[b.length] = [a[0], (a[1] - ((a[2] - a[0]) / 4)), a[1]];
                        i = 1;
                        while (i < (a.length - 1))
                        {
                            b[b.length] = [a[i], (a[i] + (a[i] - b[(i - 1)][1])), a[(i + 1)]];
                            i = (i + 1);
                        };
                    }
                    else
                    {
                        b[b.length] = [a[0], ((a[0] + a[1]) / 2), a[1]];
                    };
                };
            }
            else
            {
                for (p in props)
                {
                    a = props[p];
                    all[p] = (b = []);
                    if (a.length > 3)
                    {
                        b[b.length] = [a[0], a[1], ((a[1] + a[2]) / 2)];
                        i = 2;
                        while (i < (a.length - 2))
                        {
                            b[b.length] = [b[(i - 2)][2], a[i], ((a[i] + a[(i + 1)]) / 2)];
                            i = (i + 1);
                        };
                        b[b.length] = [b[(b.length - 1)][2], a[(a.length - 2)], a[(a.length - 1)]];
                    }
                    else
                    {
                        if (a.length == 3)
                        {
                            b[b.length] = [a[0], a[1], a[2]];
                        }
                        else
                        {
                            if (a.length == 2)
                            {
                                b[b.length] = [a[0], ((a[0] + a[1]) / 2), a[1]];
                            };
                        };
                    };
                };
            };
            return (all);
        }


        override public function killProps(lookup:Object):void
        {
            var p:String;
            for (p in _beziers)
            {
                if ((p in lookup))
                {
                    delete _beziers[p];
                };
            };
            super.killProps(lookup);
        }

        protected function init(tween:TweenLite, beziers:Array, through:Boolean):void
        {
            var i:int;
            var p:String;
            var killVarsLookup:Object;
            _target = tween.target;
            var enumerables:Object = ((tween.vars.isTV == true) ? tween.vars.exposedVars : tween.vars);
            if (enumerables.orientToBezier == true)
            {
                _orientData = [["x", "y", "rotation", 0, 0.01]];
                _orient = true;
            }
            else
            {
                if ((enumerables.orientToBezier is Array))
                {
                    _orientData = enumerables.orientToBezier;
                    _orient = true;
                };
            };
            var props:Object = {};
            i = 0;
            while (i < beziers.length)
            {
                for (p in beziers[i])
                {
                    if (props[p] == undefined)
                    {
                        props[p] = [tween.target[p]];
                    };
                    if (typeof(beziers[i][p]) == "number")
                    {
                        props[p].push(beziers[i][p]);
                    }
                    else
                    {
                        props[p].push((tween.target[p] + Number(beziers[i][p])));
                    };
                };
                i = (i + 1);
            };
            for (p in props)
            {
                this.overwriteProps[this.overwriteProps.length] = p;
                if (enumerables[p] != undefined)
                {
                    if (typeof(enumerables[p]) == "number")
                    {
                        props[p].push(enumerables[p]);
                    }
                    else
                    {
                        props[p].push((tween.target[p] + Number(enumerables[p])));
                    };
                    killVarsLookup = {};
                    killVarsLookup[p] = true;
                    tween.killVars(killVarsLookup, false);
                    delete enumerables[p];
                };
            };
            _beziers = parseBeziers(props, through);
        }

        override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean
        {
            if (!(value is Array))
            {
                return (false);
            };
            init(tween, (value as Array), false);
            return (true);
        }

        override public function set changeFactor(n:Number):void
        {
            var i:int;
            var p:String;
            var b:Object;
            var t:Number;
            var segments:int;
            var val:Number;
            var curVals:Object;
            var dx:Number;
            var dy:Number;
            var cotb:Array;
            var toAdd:Number;
            var oldTarget:Object;
            var oldRound:Boolean;
            _changeFactor = n;
            if (n == 1)
            {
                for (p in _beziers)
                {
                    i = (_beziers[p].length - 1);
                    _target[p] = _beziers[p][i][2];
                };
            }
            else
            {
                for (p in _beziers)
                {
                    segments = _beziers[p].length;
                    if (n < 0)
                    {
                        i = 0;
                    }
                    else
                    {
                        if (n >= 1)
                        {
                            i = (segments - 1);
                        }
                        else
                        {
                            i = ((segments * n) >> 0);
                        };
                    };
                    t = ((n - (i * (1 / segments))) * segments);
                    b = _beziers[p][i];
                    if (this.round)
                    {
                        val = (b[0] + (t * (((2 * (1 - t)) * (b[1] - b[0])) + (t * (b[2] - b[0])))));
                        if (val > 0)
                        {
                            _target[p] = ((val + 0.5) >> 0);
                        }
                        else
                        {
                            _target[p] = ((val - 0.5) >> 0);
                        };
                    }
                    else
                    {
                        _target[p] = (b[0] + (t * (((2 * (1 - t)) * (b[1] - b[0])) + (t * (b[2] - b[0])))));
                    };
                };
            };
            if (_orient)
            {
                i = _orientData.length;
                curVals = {};
                while (i--)
                {
                    cotb = _orientData[i];
                    curVals[cotb[0]] = _target[cotb[0]];
                    curVals[cotb[1]] = _target[cotb[1]];
                };
                oldTarget = _target;
                oldRound = this.round;
                _target = _future;
                this.round = false;
                _orient = false;
                i = _orientData.length;
                while (i--)
                {
                    cotb = _orientData[i];
                    this.changeFactor = (n + ((cotb[4]) || (0.01)));
                    toAdd = ((cotb[3]) || (0));
                    dx = (_future[cotb[0]] - curVals[cotb[0]]);
                    dy = (_future[cotb[1]] - curVals[cotb[1]]);
                    oldTarget[cotb[2]] = ((Math.atan2(dy, dx) * _RAD2DEG) + toAdd);
                };
                _target = oldTarget;
                this.round = oldRound;
                _orient = true;
            };
        }


    }
}//package com.greensock.plugins
