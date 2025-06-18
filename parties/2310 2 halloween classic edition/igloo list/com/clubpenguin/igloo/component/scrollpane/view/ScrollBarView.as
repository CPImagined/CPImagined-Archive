//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.view.ScrollBarView
    {
        var _width, _style, canvasMC, bgMC, scrollHandleMC, rightScrollButtonMC, leftScrollButtonMC, rightScrollButton, leftScrollButton, scrollHandle, _paneWidthInItems;
        function ScrollBarView (mc, width, style) {
            _width = width;
            _style = style;
            canvasMC = mc;
            mc.enabled = false;
            bgMC = mc.createEmptyMovieClip("bgMC", mc.getNextHighestDepth());
            scrollHandleMC = mc.createEmptyMovieClip("scrollHandleMC", mc.getNextHighestDepth());
            rightScrollButtonMC = mc.createEmptyMovieClip("rightScrollButtonMC", mc.getNextHighestDepth());
            leftScrollButtonMC = mc.createEmptyMovieClip("leftScrollButtonMC", mc.getNextHighestDepth());
            rightScrollButton = new com.clubpenguin.igloo.component.scrollpane.view.ScrollBarArrowButton(rightScrollButtonMC, com.clubpenguin.igloo.component.scrollpane.view.ScrollBarArrowButton.LEFT_ARROW, _style);
            rightScrollButtonMC._x = _width - rightScrollButton.getWidth();
            leftScrollButton = new com.clubpenguin.igloo.component.scrollpane.view.ScrollBarArrowButton(leftScrollButtonMC, com.clubpenguin.igloo.component.scrollpane.view.ScrollBarArrowButton.RIGHT_ARROW, _style);
            var _local_3 = (_width - rightScrollButton.getWidth()) - leftScrollButton.getWidth();
            scrollHandle = new com.clubpenguin.igloo.component.scrollpane.view.ScrollBarHandleView(scrollHandleMC, xOffset + leftScrollButton.getWidth(), _local_3, _style.scrollBarSize, _local_3, _style);
            scrollHandleMC._x = xOffset + leftScrollButton.getWidth();
            drawBackground();
            rightScrollButtonMC.onRelease = com.clubpenguin.util.Delegate.create(this, onRightScrollButtonClick);
            leftScrollButtonMC.onRelease = com.clubpenguin.util.Delegate.create(this, onLeftScrollButtonClick);
        }
        function destroy() {
            bgMC.removeMovieClip();
            bgMC = null;
            scrollHandle.destroy();
            scrollHandleMC.removeMovieClip();
            scrollHandleMC = null;
            rightScrollButtonMC.removeMovieClip();
            rightScrollButtonMC = null;
            leftScrollButtonMC.removeMovieClip();
            leftScrollButtonMC = null;
            delete rightScrollButtonMC;
            delete leftScrollButtonMC;
        }
        function getPositionChangedSignal() {
            return(scrollHandle.postionChanged);
        }
        function show() {
            canvasMC._visible = true;
        }
        function hide() {
            canvasMC._visible = false;
        }
        function onLeftScrollButtonClick() {
            scrollHandle.jumpLeft();
        }
        function onRightScrollButtonClick() {
            scrollHandle.jumpRight();
        }
        function getHeight() {
            return(_style.scrollBarSize);
        }
        function drawBackground() {
            var _local_4 = _width - (_style.buttonLineThickness * 2);
            var _local_2 = _style.scrollBarSize - (_style.buttonLineThickness * 2);
            var _local_3 = _style.scrollBarSize / 2;
            var _local_5 = _local_3 - _style.buttonLineThickness;
            com.clubpenguin.util.DrawUtil.drawDonut(bgMC, xOffset, xOffset + ((_width - _local_4) / 2), yOffset, yOffset + ((_style.scrollBarSize - _local_2) / 2), _width, _local_4, _style.scrollBarSize, _local_2, _local_3, _local_5, _style.handleBoundsLineColor, null, null);
        }
        function resize(paneWidthInItems, totalNumberOfItems) {
            trace(this + " ScrollBarView.resize");
            _paneWidthInItems = paneWidthInItems;
            scrollHandle.resize(paneWidthInItems, totalNumberOfItems);
        }
        function getScrollHandle() {
            return(scrollHandle);
        }
        function toString() {
            return("[ScrollBarView]");
        }
        var bgLineThickness = 1;
        var xOffset = 0;
        var yOffset = 0;
    }
