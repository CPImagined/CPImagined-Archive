//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.view
{
    import flash.display.MovieClip;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;

    public class LogoView extends MovieClip 
    {

        public static var ANIMATION_COMPLETE:String = "anim_complete";

        private var _view:MovieClip;
        private var _globalLogo:MovieClip;
        private var _localLogo:MovieClip;

        public function LogoView(viewClip:MovieClip, lang:String)
        {
            Log.debug((((("LogoView(viewClip: " + viewClip) + ", lang: ") + lang) + ")"));
            this._view = viewClip;
            this._globalLogo = this._view.globalLogo;
            this._globalLogo.gotoAndStop(lang);
            this._globalLogo.localLogo.stop();
            this._localLogo = this._globalLogo.localLogo;
            addChild(this._view);
        }

        override public function play():void
        {
            Log.debug("\tLogoView.play()");
            this._localLogo.play();
            this._localLogo.addEventListener(Event.ENTER_FRAME, this.onAnimationProgress);
        }

        private function onAnimationProgress(event:Event):void
        {
            if (this._localLogo.currentFrame == this._localLogo.totalFrames)
            {
                Log.debug("\t\t-Logo Animation Complete");
                this._localLogo.stop();
                dispatchEvent(new Event(ANIMATION_COMPLETE));
                this.destroy();
            };
        }

        public function destroy():void
        {
            Log.debug("\tLogoView.destroy()");
            this._localLogo.removeEventListener(Event.ENTER_FRAME, this.onAnimationProgress);
            if (this._view.stage)
            {
                removeChild(this._view);
            };
        }


    }
}//package com.clubpenguin.main.view
