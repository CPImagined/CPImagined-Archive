dynamic class com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator
{
    static var CLASS_NAME: String = "[RainEffectGenerator] ";
    var _elementArtMc: String = "WeatherFX_01_Water_Sprite";
    var _maxWidth = Stage.width;
    var _maxHeight: Number = 85;
    var _running: Boolean = false;
    var _elementSpeed: Number = 0.5;
    var _elementAmount: Number = 25;
    var _elementShrinkSize: Number = 25;
    var _elementDelayTime: Number = 2;
    var _elementRotation: Number = -26;
    var _elementHolder;
    var _wem;

    function RainEffectGenerator(wem)
    {
        trace(com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator.CLASS_NAME + "Instatiated");
        this._wem = wem;
        this._maxHeight = wem.rainAnimationHeight;
        this._elementSpeed = wem.rainAnimationSpeed;
        this._elementAmount = wem.rainAmount;
        this._elementShrinkSize = wem.rainShrinkSize;
        this._elementDelayTime = wem.rainDelayTime;
        this._elementRotation = wem.rainRotation;
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
        trace(com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator.CLASS_NAME + ": startEffect()");
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
        trace(com.clubpenguin.world.rooms.weathereffects.effect.RainEffectGenerator.CLASS_NAME + ": stopEffect()");
        this._running = false;
    }

    function setupElement(index)
    {
        var __reg2 = this._elementHolder.attachMovie(this._elementArtMc, "r" + index, index + 200);
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
        var __reg4 = effect._elementSpeed;
        var __reg5 = Math.random() * effect._elementDelayTime;
        me._y = 0;
        me._x = int(Math.random() * effect._maxWidth);
        me._rotation = effect._elementRotation;
        me._alpha = 100;
        me._yscale = 100;
        me._xscale = 100;
        var __reg3 = new Array();
        __reg3.push(me);
        __reg3.push(effect);
        com.greensock.TweenMax.to(me, __reg4, {_y: effect._maxHeight, _x: me._x + effect._maxHeight / 2, _yscale: effect._elementShrinkSize, _xscale: effect._elementShrinkSize, delay: __reg5, ease: com.greensock.easing.Linear.easeOut, onComplete: effect.beginEffect, onCompleteParams: __reg3});
    }

}
