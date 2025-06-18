dynamic class com.clubpenguin.world.rooms.weathereffects.effect.SnowEffectGenerator
{
    static var CLASS_NAME: String = "[SnowEffectGenerator] ";
    var _elementArtMc: String = "WeatherFX_02_Snow_Sprite";
    var _maxWidth = Stage.width;
    var _maxHeight: Number = 85;
    var _running: Boolean = false;
    var _elementSpeed: Number = 1;
    var _elementAmount: Number = 25;
    var _elementShrinkSize: Number = 50;
    var _delayTime: Number = 2;
    var _elementHolder;
    var _wem;

    function SnowEffectGenerator(wem)
    {
        this._wem = wem;
        this._maxHeight = wem.snowAnimationHeight;
        this._elementSpeed = wem.snowAnimationSpeed;
        this._elementAmount = wem.snowAmount;
        this._elementShrinkSize = wem.snowShrinkSize;
        this._delayTime = wem.snowDelayTime;
        this.setMovieClips();
    }

    function setMovieClips()
    {
        this._elementHolder = this._wem.getBackogrundMC().weatherEffects_mc.waterEffect;
    }

    function startEffect()
    {
        if (this._running) 
        {
            return undefined;
        }
        this._running = true;
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= this._elementAmount) 
            {
                return;
            }
            this.setupElement(__reg2);
            ++__reg2;
        }
    }

    function stopEffect()
    {
        this._running = false;
    }

    function setupElement(index)
    {
        var __reg2 = this._elementHolder.attachMovie(this._elementArtMc, "s" + index, index + 300);
        __reg2.index = index;
        this.beginEffect(__reg2, this);
    }

    function beginEffect(me, effect)
    {
        if (!effect._running) 
        {
            me.removeMovieClip();
            return undefined;
        }
        effect._running = true;
        var __reg5 = effect._elementSpeed;
        var __reg4 = Math.random() * effect._delayTime;
        me._y = -5;
        me._x = int(Math.random() * effect._maxWidth);
        me._alpha = 100;
        me._yscale = 100;
        me._xscale = 100;
        var __reg3 = new Array();
        __reg3.push(me);
        __reg3.push(effect);
        com.greensock.TweenMax.to(me, __reg5, {_y: effect._maxHeight, _x: me._x + effect._maxHeight / 2, _yscale: effect._elementShrinkSize, _xscale: effect._elementShrinkSize, delay: __reg4, ease: com.greensock.easing.Linear.easeOut, onComplete: effect.beginEffect, onCompleteParams: __reg3});
    }

}
