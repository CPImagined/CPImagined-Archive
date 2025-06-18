//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.scrollinglist.ScrollingList
    {
        var view, scrollBarMediator, contentOriginY;
        function ScrollingList (view) {
            this.view = view;
            view.content.setMask(view.mask);
            scrollBarMediator = new com.clubpenguin.scrollinglist.ScrollBarMediator(view.scrollBar);
            scrollBarMediator.dragged.add(scrollContent, this);
            contentOriginY = view.mask._y;
        }
        function refresh() {
            view.scrollBar.bar._visible = ((getContentScrollHeight() <= 0) ? false : true);
        }
        function scrollContent(yPositionScale) {
            var _local_2 = getContentScrollHeight();
            if (_local_2 <= 0) {
                return(undefined);
            }
            view.content._y = contentOriginY - (_local_2 * yPositionScale);
        }
        function getContentScrollHeight() {
            return(view.content._height - view.mask._height);
        }
    }
