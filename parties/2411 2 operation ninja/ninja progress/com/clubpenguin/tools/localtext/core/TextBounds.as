//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import flash.display.Sprite;
    import flash.text.TextField;

    public class TextBounds extends Sprite 
    {

        private static const ERROR_BRIGHT_RED:int = 0xFF3300;
        private static const ERROR_BORDER_THICKNESS:int = 6;
        private static const INVISIBLE_ALPHA:Number = 0.01;
        private static const VISIBLE_ALPHA:Number = 0.4;

        private var _textField:TextField;
        private var _boundsWidth:Number = 0;
        private var _boundsHeight:Number = 0;
        private var _color:uint = 0;
        private var _fillAlpha:Number = 0.01;

        public function TextBounds(textField:TextField)
        {
            this._textField = textField;
            this.draw();
        }

        public function draw():void
        {
            graphics.clear();
            if (((this._textField.textWidth > this.width) || (this._textField.textHeight > this.height)))
            {
                graphics.lineStyle(ERROR_BORDER_THICKNESS, ERROR_BRIGHT_RED);
            };
            graphics.beginFill(this._color, this._fillAlpha);
            graphics.drawRect(0, 0, this._boundsWidth, this._boundsHeight);
            graphics.endFill();
        }

        public function get color():uint
        {
            return (this._color);
        }

        public function set color(boundsColor:uint):void
        {
            this._color = boundsColor;
        }

        override public function get width():Number
        {
            return (this._boundsWidth);
        }

        override public function set width(boundsWidth:Number):void
        {
            this._boundsWidth = boundsWidth;
        }

        override public function get height():Number
        {
            return (this._boundsHeight);
        }

        override public function set height(boundsHeight:Number):void
        {
            this._boundsHeight = boundsHeight;
        }

        public function get fillAlpha():Number
        {
            return (this._fillAlpha);
        }

        public function set fillAlpha(fillAlpha:Number):void
        {
            this._fillAlpha = fillAlpha;
        }

        override public function set visible(value:Boolean):void
        {
            super.visible = value;
            this.fillAlpha = ((value) ? VISIBLE_ALPHA : INVISIBLE_ALPHA);
            this.draw();
        }


    }
}//package com.clubpenguin.tools.localtext.core
