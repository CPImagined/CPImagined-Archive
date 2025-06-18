//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.controller
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.cardjitsu.ninjaprogress.view.OverlayView;
    import flash.display.MovieClip;
    import com.clubpenguin.cardjitsu.ninjaprogress.controller.localization.ILocaleTextReplacer;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.OverlayEvent;
    import com.clubpenguin.cardjitsu.ninjaprogress.events.NinjaModuleEvent;

    public class OverlayController extends EventDispatcher 
    {

        private var _overlay:OverlayView;

        public function OverlayController(skin:MovieClip, localeTextReplacer:ILocaleTextReplacer)
        {
            this._overlay = new OverlayView(skin, localeTextReplacer);
        }

        public function localize():void
        {
            this._overlay.localize();
        }

        public function showOverlay():void
        {
            this._overlay.addEventListener(OverlayEvent.CLOSE, this.hideOverlay);
            this._overlay.addEventListener(OverlayEvent.LOGOUT, this.onLogout);
            this._overlay.show();
        }

        public function hideOverlay(event:OverlayEvent):void
        {
            this._overlay.removeEventListener(OverlayEvent.CLOSE, this.hideOverlay);
            this._overlay.removeEventListener(OverlayEvent.LOGOUT, this.onLogout);
            this._overlay.hide();
        }

        private function onLogout(event:OverlayEvent):void
        {
            this.hideOverlay(event);
            dispatchEvent(new NinjaModuleEvent(NinjaModuleEvent.GOTO_REDEMPTION, null));
        }

        public function destroy():void
        {
            this._overlay.destroy();
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.controller
