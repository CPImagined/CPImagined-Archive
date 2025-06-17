package com.clubpenguin.tools.localtext.core
{
    import flash.display.*;
    import flash.text.*;

    public class TextBounds extends Sprite
    {
        private var _textField:TextField;
        private var _boundsWidth:Number = 0;
        private var _boundsHeight:Number = 0;
        private var _color:uint = 0;
        private var _fillAlpha:Number = 0.01;
        private static const ERROR_BRIGHT_RED:int = 16724736;
        private static const ERROR_BORDER_THICKNESS:int = 6;
        private static const INVISIBLE_ALPHA:Number = 0.01;
        private static const VISIBLE_ALPHA:Number = 0.4;

        public function TextBounds(param1:TextField)
        {
            this._textField = param1;
            this.draw();
            return;
        }// end function

        public function draw() : void
        {
            graphics.clear();
            if (this._textField.textWidth > this.width || this._textField.textHeight > this.height)
            {
                graphics.lineStyle(ERROR_BORDER_THICKNESS, ERROR_BRIGHT_RED);
            }
            graphics.beginFill(this._color, this._fillAlpha);
            graphics.drawRect(0, 0, this._boundsWidth, this._boundsHeight);
            graphics.endFill();
            return;
        }// end function

        public function get color() : uint
        {
            return this._color;
        }// end function

        public function set color(param1:uint) : void
        {
            this._color = param1;
            return;
        }// end function

        override public function get width() : Number
        {
            return this._boundsWidth;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._boundsWidth = param1;
            return;
        }// end function

        override public function get height() : Number
        {
            return this._boundsHeight;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._boundsHeight = param1;
            return;
        }// end function

        public function get fillAlpha() : Number
        {
            return this._fillAlpha;
        }// end function

        public function set fillAlpha(param1:Number) : void
        {
            this._fillAlpha = param1;
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            this.fillAlpha = param1 ? (VISIBLE_ALPHA) : (INVISIBLE_ALPHA);
            this.draw();
            return;
        }// end function

    }
}
