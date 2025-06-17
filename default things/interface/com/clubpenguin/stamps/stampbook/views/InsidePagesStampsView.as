//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
    {
        var _filePath, _shell, list, content_holder_mc, stampIconLoader, stampIconHolder, _model, title_txt, polaroidsPanel, attachMovie, descriptionBox;
        function InsidePagesStampsView () {
            super();
            _filePath = _shell.getPath("stampbook_categoryHeader");
        }
        function reset() {
            list.reset();
        }
        function cleanUp() {
            content_holder_mc[CONTENT_LIST_CLIP_NAME].removeMovieClip();
            list.removeEventListener("over", onItemRollOver, this);
            list.removeEventListener("out", onItemRollOut, this);
        }
        function configUI() {
            stampIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function populateUI() {
            if (stampIconHolder.load_mc) {
                stampIconHolder.load_mc.removeMovieClip();
            }
            stampIconHolder.createEmptyMovieClip("load_mc", 1);
            stampIconLoader.loadClip((_filePath + _model.getID()) + ".swf", stampIconHolder.load_mc, "InsidePagesStampsView.as populateUI()");
            title_txt.text = _model.getName();
            if (polaroidsPanel) {
                polaroidsPanel.removeMovieClip();
            }
            this.attachMovie("PolaroidsPanel", "polaroidsPanel", descriptionBox.getDepth() - 1, {_x:463, _y:98});
            polaroidsPanel.setModel(_model);
            if (list) {
                list.dataProvider = _model.getItems();
                return(undefined);
            }
            list = com.clubpenguin.stamps.stampbook.controls.List(content_holder_mc.attachMovie("ListBrown", CONTENT_LIST_CLIP_NAME, content_holder_mc.getNextHighestDepth()));
            list.addEventListener("over", onItemRollOver, this);
            list.addEventListener("out", onItemRollOut, this);
            list.init(LIST_WIDTH, LIST_HEIGHT, ITEM_RENDERER, RENDERER_WIDTH, RENDERER_HEIGHT, LIST_PADDING, true);
            list.dataProvider = _model.getItems();
            list.move(0, 0);
        }
        function onItemRollOver(event) {
            descriptionBox._x = event.target._x + DESCRIPTIONBOX_X_OFFSET;
            descriptionBox._y = event.target._y + DESCRIPTIONBOX_Y_OFFSET;
            descriptionBox.setModel(event.data);
        }
        function onItemRollOut(event) {
            descriptionBox._x = -1000;
            descriptionBox._y = -1000;
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView;
        static var LINKAGE_ID = "InsidePagesStampsView";
        static var CONTENT_LIST_CLIP_NAME = "contentList";
        static var ITEM_RENDERER = "StampsRenderer";
        static var RENDERER_WIDTH = 58;
        static var RENDERER_HEIGHT = 54;
        static var LIST_PADDING = 30;
        static var LIST_WIDTH = 365;
        static var LIST_HEIGHT = 360;
        static var DESCRIPTIONBOX_X_OFFSET = 20;
        static var DESCRIPTIONBOX_Y_OFFSET = -5;
    }
