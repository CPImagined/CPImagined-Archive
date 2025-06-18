//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
    {
        var _filePath, _shell, list, content_holder_mc, pinIconLoader, descriptionBox, pinLoadMc, pinIconHolder, _model, title_txt;
        function InsidePagesPinsView () {
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
            pinIconLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            super.configUI();
        }
        function populateUI() {
            descriptionBox.singleLine = true;
            if (pinLoadMc) {
                pinLoadMc.removeMovieClip();
            }
            pinLoadMc = pinIconHolder.attachMovie(com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView.BLANK_CLIP_LINKAGE_ID, "clip", 1, {_x:0, _y:0});
            pinIconLoader.loadClip((_filePath + _model.getID()) + ".swf", pinLoadMc, "InsidePagesPins.as populateUI()");
            title_txt.text = _model.getName();
            if (list) {
                list.dataProvider = _model.getItems();
                return(undefined);
            }
            list = com.clubpenguin.stamps.stampbook.controls.List(content_holder_mc.attachMovie("ListBrown", CONTENT_LIST_CLIP_NAME, content_holder_mc.getNextHighestDepth()));
            list.addEventListener("over", onItemRollOver, this);
            list.addEventListener("out", onItemRollOut, this);
            list.init(LIST_WIDTH, LIST_HEIGHT, ITEM_RENDERER, RENDERER_WIDTH, RENDERER_HEIGHT, LIST_PADDING, false);
            list.dataProvider = _model.getItems();
            list.move(0, 0);
            list.scrollBar._visible = list.dataProvider.length > 0;
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
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView;
        static var LINKAGE_ID = "InsidePagesPinsView";
        static var CONTENT_LIST_CLIP_NAME = "contentList";
        static var ITEM_RENDERER = "BaseItemRenderer";
        static var RENDERER_WIDTH = 55.85;
        static var RENDERER_HEIGHT = 51.9;
        static var LIST_PADDING = 20;
        static var LIST_WIDTH = 560;
        static var LIST_HEIGHT = 340;
        static var DESCRIPTIONBOX_X_OFFSET = 25;
        static var DESCRIPTIONBOX_Y_OFFSET = 7;
    }
