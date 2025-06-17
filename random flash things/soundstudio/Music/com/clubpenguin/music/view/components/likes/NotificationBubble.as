//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.view.components.likes
{
    import flash.display.Sprite;
    import flash.utils.Timer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.lib.util.Log;
    import flash.events.Event;
    import com.clubpenguin.music.resources.Utils;
    import flash.events.TimerEvent;

    public class NotificationBubble extends Sprite 
    {

        private const ARROWHEIGHT:Number = 10;

        private var _showing:Boolean;
        private var _bubbleTimer:Timer;
        private var _bubble:MovieClip;
        private var _bubbleText:TextField;
        private var _bubbleFadeY:Number = -20;

        public function NotificationBubble(skin:MovieClip)
        {
            Log.debug("");
            mouseEnabled = false;
            mouseChildren = false;
            this._bubble = skin;
            this._bubbleText = (this._bubble["txt_NoteText"] as TextField);
            this._bubbleTimer = new Timer(1000, 1);
            this.hideBubble(true);
        }

        public function hideBubble(instant:Boolean=false):void
        {
            this._showing = false;
            this._bubble.y = this._bubbleFadeY;
            this._bubble.alpha = 0;
        }

        public function showBubble(message:String):void
        {
            this._bubbleText.text = message;
            if (this._showing)
            {
                this._bubbleTimer.reset();
                this._bubbleTimer.start();
                return;
            };
            this._showing = true;
            addEventListener(Event.ENTER_FRAME, this.doShow);
        }

        private function doShow(e:Event):void
        {
            var newY:Number = Utils.AnimatePropertyToTarget(this._bubble.y, -69, 0.2, 4);
            var newAlpha:Number = Utils.AnimatePropertyToTarget(this._bubble.alpha, 1, 0.1, 4);
            if (((newY == this._bubble.y) && (newAlpha == this._bubble.alpha)))
            {
                removeEventListener(Event.ENTER_FRAME, this.doShow);
                this._bubbleTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.completeShow);
                this._bubbleTimer.reset();
                this._bubbleTimer.start();
            }
            else
            {
                this._bubble.y = newY;
                this._bubble.alpha = newAlpha;
            };
        }

        private function doHide(e:Event):void
        {
            Log.debug(" ");
            var newY:Number = Utils.AnimatePropertyToTarget(this._bubble.y, this._bubbleFadeY, 0.2, 4);
            var newAlpha:Number = Utils.AnimatePropertyToTarget(this._bubble.alpha, 0, 0.1, 4);
            if (((newY == this._bubble.y) && (newAlpha == this._bubble.alpha)))
            {
                removeEventListener(Event.ENTER_FRAME, this.doHide);
                this._showing = false;
                this._bubbleTimer.reset();
            }
            else
            {
                this._bubble.y = newY;
                this._bubble.alpha = newAlpha;
            };
        }

        private function completeShow(e:TimerEvent):void
        {
            addEventListener(Event.ENTER_FRAME, this.doHide);
        }

        override public function set width(newWidth:Number):void
        {
            this._bubble.width = newWidth;
            this._bubbleText.width = this._bubble.width;
        }

        override public function set height(newHeight:Number):void
        {
            this._bubble.height = newHeight;
            this._bubbleText.height = this._bubble.width;
        }


    }
}//package com.clubpenguin.music.view.components.likes
