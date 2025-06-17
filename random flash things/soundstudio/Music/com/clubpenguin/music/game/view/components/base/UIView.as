//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.base
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;

    public class UIView extends Sprite 
    {

        protected var skin:MovieClip;

        public function UIView(skin:MovieClip)
        {
            Log.debug("");
            this.skin = skin;
            this.createChildComponents();
            this.addListeners();
        }

        public function destroy():void
        {
            this.removeListeners();
        }

        protected function createChildComponents():void
        {
            addChild(this.skin);
        }

        protected function addListeners():void
        {
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        protected function removeListeners():void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        protected function onRemovedFromStage(event:Event):void
        {
            this.removeListeners();
        }


    }
}//package com.clubpenguin.music.game.view.components.base
