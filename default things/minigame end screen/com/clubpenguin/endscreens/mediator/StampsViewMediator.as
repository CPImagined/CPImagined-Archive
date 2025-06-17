//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.endscreens.view.ScrollingStampsView;
    import com.clubpenguin.endscreens.model.MiniGameEndScreensModel;
    import com.clubpenguin.main.MainContext;
    import flash.utils.Timer;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.TimerEvent;

    public class StampsViewMediator extends Mediator 
    {

        [Inject]
        public var view:ScrollingStampsView;
        [Inject]
        public var model:MiniGameEndScreensModel;
        [Inject]
        public var context:MainContext;
        private var _scrollTimer:Timer = new Timer(MiniGameEndScreensConstants.STAMP_SCROLLPANE_TIMER_DELAY);


        override public function onRegister():void
        {
            this.view.initView(this);
            this.view.onCompleted.addOnce(this.onViewComplete);
        }

        override public function onRemove():void
        {
            this.view.clearListeners();
            this._scrollTimer.stop();
            this._scrollTimer = null;
        }

        private function onViewComplete():void
        {
        }

        public function stampRatio():String
        {
            var ratio:String = ((this.model.numberOfStampsEarnedForGame + "/") + this.model.numberOfGameStamps);
            return (ratio);
        }

        public function mouseScrollWheel(event:MouseEvent):void
        {
            if (event.delta > 0)
            {
                this.view.scrollRight();
            }
            else
            {
                this.view.scrollLeft();
            };
        }

        public function mouseClickScrollButtonLeft(event:Event):void
        {
            this.view.scrollLeft();
        }

        public function mouseDownScrollButtonLeft(event:Event):void
        {
            this._scrollTimer.addEventListener(TimerEvent.TIMER, this.view.scrollLeft);
            this._scrollTimer.start();
        }

        public function mouseUpScrollButtonLeft(event:Event):void
        {
            this._scrollTimer.removeEventListener(TimerEvent.TIMER, this.view.scrollLeft);
            this._scrollTimer.stop();
        }

        public function mouseClickScrollButtonRight(event:Event):void
        {
            this.view.scrollRight();
        }

        public function mouseDownScrollButtonRight(event:Event):void
        {
            this._scrollTimer.addEventListener(TimerEvent.TIMER, this.view.scrollRight);
            this._scrollTimer.start();
        }

        public function mouseUpScrollButtonRight(event:Event):void
        {
            this._scrollTimer.removeEventListener(TimerEvent.TIMER, this.view.scrollRight);
            this._scrollTimer.stop();
        }


    }
}//package com.clubpenguin.endscreens.mediator
