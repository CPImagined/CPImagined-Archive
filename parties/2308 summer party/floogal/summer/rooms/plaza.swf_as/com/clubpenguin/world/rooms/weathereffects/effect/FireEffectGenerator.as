dynamic class com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator
{
    static var CLASS_NAME: String = "[FireEffectGenerator] ";
    var _elementArtMc: String = "WeatherFX_03_Fire_Sprite";
    var _maxWidth = Stage.width;
    static var _maxHeight: Number = 55;
    var _running: Boolean = false;
    var _elementAmount: Number = 3;
    static var _delayTime: Number = 2;
    var _elementHolder;
    var _wem;

    function FireEffectGenerator(wem)
    {
        trace(com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + "Instatiated");
        this._wem = wem;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._maxHeight = this._wem.fireAnimationHeight;
        this._elementAmount = this._wem.fireAmount;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._delayTime = this._wem.fireDelayTime;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects = [];
        this.setMovieClips();
    }

    function setMovieClips()
    {
        this._elementHolder = this._wem.getBackogrundMC().weatherEffects_mc.fireEffect;
    }

    function startEffect()
    {
        if (this._running) 
        {
            return undefined;
        }
        trace(com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + ": startEffect()");
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
        trace(com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + ": stopEffect()");
        this._running = false;
        var __reg2 = 0;
        for (;;) 
        {
            if (__reg2 >= this._elementAmount) 
            {
                return;
            }
            com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[__reg2].repeat = 0;
            ++__reg2;
        }
    }

    function setupElement(index)
    {
        trace(com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator.CLASS_NAME + ": setupElement()");
        var __reg2 = this._elementHolder.attachMovie(this._elementArtMc, "f" + index, index + 100);
        __reg2.gotoAndStop(1);
        __reg2.index = index;
        var __reg6 = Math.random() * com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._delayTime;
        var __reg4 = new Array();
        __reg4.push(__reg2);
        __reg4.push(this);
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[index] = new com.greensock.TweenMax(__reg2, 0, {delay: __reg6, onComplete: this.beginEffect, onCompleteParams: __reg4});
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[index].play();
    }

    function beginEffect(me, effect)
    {
        if (!effect._running) 
        {
            me.removeMovieClip();
            return undefined;
        }
        me.play();
    }

    static function onAnimDone(mc)
    {
        mc.gotoAndStop(1);
        var __reg2 = Math.random() * com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._delayTime;
        mc._y = int(Math.random() * com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._maxHeight);
        mc._x = 0;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[mc.index].delay = __reg2;
        com.clubpenguin.world.rooms.weathereffects.effect.FireEffectGenerator._tweenObjects[mc.index].restart(true, false);
    }

}
