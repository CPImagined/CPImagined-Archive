//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class ScrollPainBar extends MovieClip 
    {

        private var _minPosition:Number;
        private var _maxPosition:Number;
        private var _currentMouseY:Number;

        public function ScrollPainBar(_arg_1:Number, _arg_2:Number)
        {
            this._minPosition = _arg_1;
            this._maxPosition = _arg_2;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedStage);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }

        private function onMouseDown(_arg_1:Event):void
        {
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUps);
            this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMovement);
            this._currentMouseY = this.stage.mouseY;
        }

        private function onMouseMovement(_arg_1:Event):void
        {
            var _local_2:Number = (this.stage.mouseY - this._currentMouseY);
            var _local_3:Number = (_local_2 / ((this._maxPosition - this.height) - this._minPosition));
            dispatchEvent(new ScrollBarEvent(_local_3));
            this._currentMouseY = this.stage.mouseY;
            this.y = Math.min(Math.max((this.y + _local_2), this._minPosition), (this._maxPosition - this.height));
        }

        private function onMouseUps(_arg_1:Event):void
        {
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUps);
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMovement);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }

        private function onRemovedStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUps);
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMovement);
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress
