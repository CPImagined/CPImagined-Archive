dynamic class com.greensock.plugins.VolumePlugin extends com.greensock.plugins.TweenPlugin
{
    static var API: Number = 1;
    var _sound;
    var addTween;
    var overwriteProps;
    var propName;
    var updateTweens;
    var volume;

    function VolumePlugin()
    {
        super();
        this.propName = "volume";
        this.overwriteProps = ["volume"];
    }

    function onInitTween(target, value, tween)
    {
        if (isNaN(value) || (typeof target != "movieclip" && !(target instanceof Sound))) 
        {
            return false;
        }
        this._sound = typeof target == "movieclip" ? new Sound(target) : Sound(target);
        this.volume = this._sound.getVolume();
        this.addTween(this, "volume", this.volume, value, "volume");
        return true;
    }

    function set changeFactor(n)
    {
        this.updateTweens(n);
        this._sound.setVolume(this.volume);
    }

}
