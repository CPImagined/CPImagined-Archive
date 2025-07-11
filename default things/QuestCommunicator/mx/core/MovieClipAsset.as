﻿//Created by Action Script Viewer - https://www.buraks.com/asv
package mx.core
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class MovieClipAsset extends FlexMovieClip implements IFlexAsset, IFlexDisplayObject, IBorder 
    {

        mx_internal static const VERSION:String = "4.1.0.16076";

        private var _measuredHeight:Number;
        private var _measuredWidth:Number;

        public function MovieClipAsset()
        {
            this._measuredWidth = width;
            this._measuredHeight = height;
        }

        public function get measuredHeight():Number
        {
            return (this._measuredHeight);
        }

        public function get measuredWidth():Number
        {
            return (this._measuredWidth);
        }

        public function get borderMetrics():EdgeMetrics
        {
            if (scale9Grid == null)
            {
                return (EdgeMetrics.EMPTY);
            };
            return (new EdgeMetrics(scale9Grid.left, scale9Grid.top, Math.ceil((this.measuredWidth - scale9Grid.right)), Math.ceil((this.measuredHeight - scale9Grid.bottom))));
        }

        public function move(x:Number, y:Number):void
        {
            this.x = x;
            this.y = y;
        }

        public function setActualSize(newWidth:Number, newHeight:Number):void
        {
            width = newWidth;
            height = newHeight;
        }


    }
}//package mx.core
