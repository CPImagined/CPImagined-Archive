//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.superhero.TrailingSnowball extends MovieClip
    {
        var gotoAndStop, art, removeMovieClip;
        function TrailingSnowball () {
            super();
            this.gotoAndStop(1);
            art.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackFrames);
        }
        function trackFrames() {
            if (art._currentFrame == art._totalFrames) {
                trace("Sonic Wave Duplicate - I'M KILLING MYSELF");
                delete art.onEnterFrame;
                this.removeMovieClip();
            }
        }
    }
