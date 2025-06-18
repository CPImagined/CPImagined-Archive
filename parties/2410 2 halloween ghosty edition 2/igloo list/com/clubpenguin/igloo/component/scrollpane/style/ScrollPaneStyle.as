//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle
    {
        var scrollType, bufferMode, buttonLineColorDefault, buttonFillColorDefault, buttonLineColorDown, buttonFillColorDown, buttonLineColorOver, buttonFillColorOver, buttonLineThickness, handleCornerRadius, scrollBarSize, handleBoundsLineColor, itemRendererXOffset, itemRendererYOffset;
        function ScrollPaneStyle () {
            scrollType = VERTICAL;
            bufferMode = UNBUFFERED;
            buttonLineColorDefault = 9145227 /* 0x8B8B8B */;
            buttonFillColorDefault = 15658734 /* 0xEEEEEE */;
            buttonLineColorDown = 9145227 /* 0x8B8B8B */;
            buttonFillColorDown = 13421772 /* 0xCCCCCC */;
            buttonLineColorOver = 9145227 /* 0x8B8B8B */;
            buttonFillColorOver = 13421772 /* 0xCCCCCC */;
            buttonLineThickness = 2;
            handleCornerRadius = 8;
            scrollBarSize = 16;
            handleBoundsLineColor = 13421772 /* 0xCCCCCC */;
            itemRendererXOffset = 0;
            itemRendererYOffset = 0;
        }
        function get isVertical() {
            return(scrollType == VERTICAL);
        }
        function get isHorizontal() {
            return(scrollType == HORIZONTAL);
        }
        function get isBuffered() {
            return(bufferMode == BUFFERED);
        }
        function get isUnBuffered() {
            return(bufferMode == UNBUFFERED);
        }
        static var HORIZONTAL = "horizontal";
        static var VERTICAL = "vertical";
        static var BUFFERED = "buffered";
        static var UNBUFFERED = "unbuffered";
    }
