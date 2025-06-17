//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.view.components.likes
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.events.MouseEvent;
    import com.clubpenguin.lib.util.Log;

    public class LikesButton extends Sprite 
    {

        public static const IDLE:String = "Idle";
        public static const OVER:String = "Over";
        public static const LIKE:String = "Like";
        public static const DOWN:String = "Down";
        public static const ACTIVE:String = "Active";
        public static const ERROR:String = "Error";
        public static const ERROR_MESSAGE_TOKEN:String = "w.app.music.likes.error";
        public static const ALREADY_LIKED_MESSAGE_TOKEN:String = "w.app.music.likes.alreadyliked";

        protected var skin:MovieClip;
        protected var notificationBubble:NotificationBubble;
        private var _localizationManager:ILocalizationManager;
        private var _likesCount:int = -1;
        private var _enabled:Boolean;

        public function LikesButton(skin:MovieClip)
        {
            this.skin = skin;
            this.init();
            this.updateListeners();
            this.updateSkin();
        }

        public function get likesCount():int
        {
            return (this._likesCount);
        }

        public function set likesCount(count:int):void
        {
            this._likesCount = count;
            this.updateLikesLabel();
        }

        public function get enabled():Boolean
        {
            return (this._enabled);
        }

        public function set enabled(bool:Boolean):void
        {
            this._enabled = bool;
            this.updateListeners();
            this.updateButtonSkin();
        }

        public function localize(localizationManager:ILocalizationManager):void
        {
            this._localizationManager = localizationManager;
        }

        private function updateListeners():void
        {
            if (this.enabled)
            {
                this.addListeners();
            }
            else
            {
                this.removeListeners();
            };
        }

        private function init():void
        {
            this.skin.button.stop();
            this.skin.label.mouseEnabled = false;
            this.skin.label.mouseEnabled = false;
            this.skin.label.stop();
            this.skin.count.mouseEnabled = false;
            if (!this.notificationBubble)
            {
                this.notificationBubble = new NotificationBubble(this.skin["notificationBubble"]);
            };
        }

        private function addListeners():void
        {
            if (!this.skin.button.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                this.skin.button.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
                this.skin.button.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
                this.skin.button.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
                this.skin.button.addEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
            };
        }

        private function removeListeners():void
        {
            if (this.skin.button.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                this.skin.button.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
                this.skin.button.removeEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
                this.skin.button.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDown);
                this.skin.button.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
            };
            this.removeStageListener();
        }

        protected function mouseClick(event:MouseEvent):void
        {
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }

        protected function mouseOver(event:MouseEvent):void
        {
            this.skin.label.gotoAndStop(OVER);
            this.skin.button.gotoAndStop(OVER);
        }

        protected function mouseOut(event:MouseEvent):void
        {
            this.updateButtonSkin();
        }

        protected function mouseDown(event:MouseEvent):void
        {
            this.skin.label.gotoAndStop(DOWN);
            this.skin.button.gotoAndStop(DOWN);
            this.skin.stage.addEventListener(MouseEvent.MOUSE_UP, this.onAppMouseUp);
        }

        private function onAppMouseUp(event:MouseEvent):void
        {
            if (((this.skin.stage) && (this.skin.stage.hasEventListener(MouseEvent.MOUSE_UP))))
            {
                this.skin.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onAppMouseUp);
            };
            this.updateButtonSkin();
        }

        private function mouseUp(event:MouseEvent):void
        {
            this.removeStageListener();
            this.skin.button.gotoAndStop(((this.enabled) ? ACTIVE : IDLE));
            this.skin.label.gotoAndStop(((this.enabled) ? LIKE : IDLE));
            this.mouseClick(event);
        }

        private function removeStageListener():void
        {
            if (((this.skin.stage) && (this.skin.stage.hasEventListener(MouseEvent.MOUSE_UP))))
            {
                this.skin.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onAppMouseUp);
            };
        }

        private function updateSkin():void
        {
            this.updateButtonSkin();
            this.updateLikesLabel();
        }

        private function updateButtonSkin():void
        {
            this.skin.label.gotoAndStop(((this.enabled) ? ACTIVE : IDLE));
            this.skin.button.gotoAndStop(((this.enabled) ? ACTIVE : IDLE));
            this.skin.button.buttonMode = this.enabled;
        }

        private function updateLikesLabel():void
        {
            var MAX_LABEL_VALUE:int;
            var countText:String;
            if (((isNaN(this.likesCount)) || (this.likesCount == -1)))
            {
                this.skin.count.text = "";
                this.skin.label.gotoAndStop(ERROR);
                this.skin.button.gotoAndStop(ERROR);
            }
            else
            {
                MAX_LABEL_VALUE = 99999;
                countText = Math.min(MAX_LABEL_VALUE, this._likesCount).toString();
                this.skin.count.text = (countText + ((this.likesCount > MAX_LABEL_VALUE) ? "+" : ""));
            };
        }

        public function showNotificationBubble():void
        {
            var localizedString:String;
            if (this.skin.button.currentFrameLabel == ERROR)
            {
                localizedString = this._localizationManager.getLocalizedString(ERROR_MESSAGE_TOKEN);
            }
            else
            {
                if (!this.enabled)
                {
                    localizedString = this._localizationManager.getLocalizedString(ALREADY_LIKED_MESSAGE_TOKEN);
                };
            };
            Log.debug(("localizedString " + localizedString));
            if ((((localizedString) && (!(localizedString == ""))) && (!(localizedString == null))))
            {
                this.notificationBubble.showBubble(localizedString);
            };
        }


    }
}//package com.clubpenguin.music.view.components.likes
