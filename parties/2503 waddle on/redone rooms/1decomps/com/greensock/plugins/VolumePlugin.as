    class com.greensock.plugins.VolumePlugin extends com.greensock.plugins.TweenPlugin
    {
        var propName, overwriteProps, _sound, volume, addTween, updateTweens, __get__changeFactor;
        function VolumePlugin () {
            super();
            propName = "volume";
            overwriteProps = ["volume"];
        }
        function onInitTween(target, value, tween) {
            if (isNaN(value) || ((typeof(target) != "movieclip") && (!(target instanceof Sound)))) {
                return(false);
            }
            _sound = ((typeof(target) == "movieclip") ? (new Sound(target)) : (Sound(target)));
            volume = _sound.getVolume();
            addTween(this, "volume", volume, value, "volume");
            return(true);
        }
        function set changeFactor(n) {
            updateTweens(n);
            _sound.setVolume(volume);
            //return(__get__changeFactor());
        }
        static var API = 1;
    }
