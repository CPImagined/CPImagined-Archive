//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
    {
        var _filePath, _shell, list, content_holder_mc, stampIconLoader, load_mc, stampIconHolder, _model, title_txt, dispatchEvent;
        function InsidePagesSubContentView () {
            super();
            _filePath = _shell.getPath("stampbook_categoryHeader");
        }
        function reset() {
            list.reset();
        }
        function cleanUp() {
            content_holder_mc[CONTENT_LIST_CLIP_NAME].removeMovieClip();
            list.removeEventListener("itemClick", onListItemClick, this);
        }
        function configUI() {
            stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function populateUI() {
            if (load_mc) {
                load_mc.removeMovieClip();
            }
            load_mc = stampIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            stampIconLoader.loadClip((_filePath + _model.getID()) + ".swf", load_mc, "InsidePagesSubContentView.as populateUI()");
            title_txt.text = _model.getName();
            if (list) {
                list.dataProvider = _model.getSubCategories();
                return(undefined);
            }
            list = com.clubpenguin.stamps.stampbook.controls.ContentList(content_holder_mc.attachMovie("ContentList", CONTENT_LIST_CLIP_NAME, content_holder_mc.getNextHighestDepth()));
            list.init(LIST_WIDTH, LIST_HEIGHT, ITEM_RENDERER, RENDERER_WIDTH, RENDERER_HEIGHT, LIST_PADDING);
            list.addEventListener("itemClick", onListItemClick, this);
            list.dataProvider = _model.getSubCategories();
            list.move(0, 0);
        }
        function onListItemClick(event) {
            dispatchEvent(event);
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView;
        static var LINKAGE_ID = "InsidePagesSubContentView";
        static var CONTENT_LIST_CLIP_NAME = "contentList";
        static var ITEM_RENDERER = "ListButton";
        static var RENDERER_WIDTH = 164;
        static var RENDERER_HEIGHT = 30;
        static var LIST_PADDING = 15;
        static var LIST_WIDTH = 545;
        static var LIST_HEIGHT = 225;
    }
