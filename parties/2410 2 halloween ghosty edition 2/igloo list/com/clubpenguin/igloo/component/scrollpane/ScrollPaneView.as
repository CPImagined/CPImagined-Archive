//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.component.scrollpane.ScrollPaneView
    {
        var _style, scrollBarMC, scrollBar, _yOffset, paneMC, pane, _height;
        function ScrollPaneView (mc, x, y, width, height, itemRenderer, style) {
            _style = style;
            if (_style.scrollType == com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle.HORIZONTAL) {
                createHorizontallyScrollingPane(mc, x, y, width, height, itemRenderer);
            } else if (_style.scrollType == com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle.VERTICAL) {
                createVerticallyScrollingPane(mc, x, y, width, height, itemRenderer);
            } else {
                createVerticallyScrollingPane(mc, x, y, width, height, itemRenderer);
            }
        }
        function createHorizontallyScrollingPane(mc, x, y, width, height, itemRenderer) {
            scrollBarMC = mc.createEmptyMovieClip("scrollBarMC", mc.getNextHighestDepth());
            scrollBar = new com.clubpenguin.igloo.component.scrollpane.view.ScrollBarView(scrollBarMC, width, _style);
            _yOffset = y;
            paneMC = mc.createEmptyMovieClip("paneMC", mc.getNextHighestDepth());
            if (_style.isBuffered) {
                pane = new com.clubpenguin.igloo.component.scrollpane.view.BufferedPaneView(paneMC, width, height - scrollBar.getHeight(), itemRenderer, _style);
            } else {
                pane = new com.clubpenguin.igloo.component.scrollpane.view.PaneView(paneMC, width, height - scrollBar.getHeight(), itemRenderer, _style);
            }
            paneMC._x = x;
            paneMC._y = y;
            _height = height;
            scrollBarMC._x = x;
            scrollBarMC._y = paneMC._y + pane.getHeight();
        }
        function createVerticallyScrollingPane(mc, x, y, width, height, itemRenderer) {
            trace("ScrollPaneView.createVerticallyScrollingPane");
            scrollBarMC = mc.createEmptyMovieClip("scrollBarMC", mc.getNextHighestDepth());
            scrollBar = new com.clubpenguin.igloo.component.scrollpane.view.ScrollBarView(scrollBarMC, height, _style);
            _yOffset = y;
            paneMC = mc.createEmptyMovieClip("paneMC", mc.getNextHighestDepth());
            pane = new com.clubpenguin.igloo.component.scrollpane.view.PaneView(paneMC, width - scrollBar.getHeight(), height, itemRenderer, _style);
            paneMC._x = x;
            paneMC._y = y;
            _height = height;
            scrollBarMC._x = (x + pane.getWidth()) + scrollBar.getHeight();
            scrollBarMC._y = paneMC._y;
            scrollBarMC._rotation = 90;
        }
        function destroy() {
            scrollBarMC.removeMovieClip();
            scrollBar.destroy();
            paneMC.removeMovieClip();
            pane.destroy();
        }
        function hideScrollbar() {
            trace("ScrollPaneView.hideScrollbar before paneMC._y: " + paneMC._y);
            scrollBar.hide();
            paneMC._y = _yOffset + ((_height - pane.getHeight()) / 2);
            trace("ScrollPaneView.hideScrollbar after paneMC._y: " + paneMC._y);
        }
        function showScrollbar() {
            scrollBar.show();
            paneMC._y = _yOffset;
        }
        function getItemsPerRow() {
            return(((_style.scrollType == com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle.HORIZONTAL) ? (pane.getItemsPerRow()) : 1));
        }
        function getItemsPerColumn() {
            return(((_style.scrollType == com.clubpenguin.igloo.component.scrollpane.style.ScrollPaneStyle.VERTICAL) ? (pane.getItemsPerColumn()) : 1));
        }
    }
