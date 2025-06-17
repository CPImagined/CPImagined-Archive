//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.resources.scrollbar
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import com.clubpenguin.lib.util.Log;
    import flash.events.MouseEvent;

    public class ScrollControl_Studio extends MovieClip 
    {

        private const CLICK_SCROLL_PERCENT:Number = 0.1;
        private const SCROLL_AREA_HEIGHT:Number = 383.1;

        private var _scrollArea:MovieClip;
        private var _scrollButtonUp:SimpleButton;
        private var _scrollButtonDown:SimpleButton;
        private var _scrollButtonDrag:SimpleButton;
        private var _scrollBarMin:Number = -69.65;
        private var _scrollBarMax:Number = 234.1;
        private var _contentMax:Number = 0;
        private var _contentMin:Number = -615.6;
        private var _currentMouseY:Number;
        private var _skin:MovieClip;

        public function ScrollControl_Studio(skin:MovieClip)
        {
            this._skin = skin;
            this._scrollArea = this._skin["scrollArea"]["scrollArea_content"];
            this._scrollButtonUp = this._skin["scrollBar"]["button_up"];
            this._scrollButtonDown = this._skin["scrollBar"]["button_down"];
            this._scrollButtonDrag = this._skin["scrollBar"]["button_drag"];
        }

        public function init():void
        {
            Log.debug((this._scrollArea.height + ""));
            this._contentMin = (this.SCROLL_AREA_HEIGHT - this._scrollArea.height);
            Log.debug((this._contentMin + ""));
            this.addEventListeners();
        }

        private function addEventListeners():void
        {
            this._scrollButtonUp.addEventListener(MouseEvent.CLICK, this.buttonUp_Click_Handler);
            this._scrollButtonDown.addEventListener(MouseEvent.CLICK, this.buttonDown_Click_Handler);
            this._scrollButtonDrag.addEventListener(MouseEvent.MOUSE_DOWN, this.buttonDrag_Down_Handler);
        }

        private function buttonUp_Click_Handler(e:MouseEvent):void
        {
            this.moveAllByPercent(this.CLICK_SCROLL_PERCENT);
        }

        private function buttonDown_Click_Handler(e:MouseEvent):void
        {
            this.moveAllByPercent((this.CLICK_SCROLL_PERCENT * -1));
        }

        private function buttonDrag_Down_Handler(e:MouseEvent):void
        {
            this._scrollButtonDrag.removeEventListener(MouseEvent.MOUSE_DOWN, this.buttonDrag_Down_Handler);
            this._skin.stage.addEventListener(MouseEvent.MOUSE_UP, this.buttonDrag_Up_Handler);
            this._skin.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.buttonDrag_Move_Handler);
            this._currentMouseY = this._skin.stage.mouseY;
        }

        private function buttonDrag_Up_Handler(e:MouseEvent):void
        {
            this._scrollButtonDrag.addEventListener(MouseEvent.MOUSE_DOWN, this.buttonDrag_Down_Handler);
            this._skin.stage.removeEventListener(MouseEvent.MOUSE_UP, this.buttonDrag_Up_Handler);
            this._skin.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.buttonDrag_Move_Handler);
        }

        private function buttonDrag_Move_Handler(e:MouseEvent):void
        {
            var mouseYDelta:Number = (this._skin.stage.mouseY - this._currentMouseY);
            var percentChange:Number = (mouseYDelta / (this._scrollBarMax - this._scrollBarMin));
            this.moveContentByPercent((percentChange * -1));
            this._currentMouseY = this._skin.stage.mouseY;
            this._scrollButtonDrag.y = Math.min(Math.max((this._scrollButtonDrag.y + mouseYDelta), this._scrollBarMin), this._scrollBarMax);
        }

        private function moveBarByPercent(percentMoved:Number):void
        {
            percentMoved = (percentMoved * -1);
            var barYDelta:Number = (percentMoved * (this._scrollBarMax - this._scrollBarMin));
            this._scrollButtonDrag.y = Math.min(Math.max((this._scrollButtonDrag.y + barYDelta), this._scrollBarMin), this._scrollBarMax);
        }

        private function moveContentByPercent(percentMoved:Number):void
        {
            var contentYDelta:Number = (percentMoved * (this._contentMax - this._contentMin));
            this._scrollArea.y = Math.min(Math.max((this._scrollArea.y + contentYDelta), this._contentMin), this._contentMax);
        }

        private function moveAllByPercent(percentMoved:Number):void
        {
            this.moveContentByPercent(percentMoved);
            this.moveBarByPercent(percentMoved);
        }


    }
}//package com.clubpenguin.music.resources.scrollbar
