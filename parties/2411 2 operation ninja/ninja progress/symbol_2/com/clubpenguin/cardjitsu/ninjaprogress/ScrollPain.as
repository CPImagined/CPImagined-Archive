//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress
{
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.events.Event;

    public class ScrollPain extends MovieClip 
    {

        private var _content:MovieClip;
        private var _scrollbar:ScrollPainBar;
        private var _contentMask:Shape;

        public function ScrollPain()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }

        public function init(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number):void
        {
            this._content = _arg_1;
            this._contentMask = new Shape();
            this._contentMask.graphics.beginFill(0xFFFFFF);
            this._contentMask.graphics.drawRect(0, 0, _arg_2, _arg_3);
            this._contentMask.graphics.endFill();
            addChild(this._contentMask);
            this._contentMask.x = 0;
            this._contentMask.y = 0;
            this._content.mask = this._contentMask;
            this._content.y = 0;
            this._scrollbar = new ScrollPainBar(0, _arg_3);
            this._scrollbar.x = _arg_2;
            this._scrollbar.y = 0;
            addChild(this._scrollbar);
            this._scrollbar.addEventListener(ScrollBarEvent.MOVE_EVENT, this.scrollBar_Move_Handler);
        }

        private function scrollBar_Move_Handler(_arg_1:ScrollBarEvent):void
        {
            var _local_2:Number = ((_arg_1.percentChange * (this._content.height - this._contentMask.height)) * -1);
            this._content.y = Math.min(Math.max((this._content.y + _local_2), (this._contentMask.height - this._content.height)), 0);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress
