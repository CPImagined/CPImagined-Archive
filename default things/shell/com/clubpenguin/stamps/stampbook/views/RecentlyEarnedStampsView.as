//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView extends com.clubpenguin.stamps.stampbook.views.BaseView
    {
        var _stampManager, _shell, background, mouseBlocker, closeBtn, _model, title, description, congratulationsMessage, _selectedCoordinates, stampsHolder, descriptionBox, stampsList, dispatchEvent;
        function RecentlyEarnedStampsView () {
            super();
            _stampManager = _shell.getStampManager();
        }
        function getWidth() {
            return(background._width);
        }
        function getHeight() {
            return(background._height);
        }
        function cleanUp() {
        }
        function configUI() {
            super.configUI();
            mouseBlocker.useHandCursor = false;
            closeBtn.addEventListener("release", onCloseButtonPressed, this);
        }
        function populateUI() {
            var _local_2 = _model.length;
            switch (_local_2) {
                case 1 : 
                case 2 : 
                case 3 : 
                case 4 : 
                case 5 : 
                case 6 : 
                    drawGrid();
                    break;
                default : 
                    drawList();
                    break;
            }
            title.text = _shell.getLocalizedString("recently_earned_title");
            description.text = _shell.getLocalizedString("recently_earned_description");
            var _local_3 = ((_local_2 > 1) ? (_shell.getLocalizedString("recently_earned_congrats_multiple_stamp")) : (_shell.getLocalizedString("recently_earned_congrats_single_stamp")));
            congratulationsMessage.text = _shell.replace_m(_local_3, [_local_2]);
        }
        function drawGrid() {
            var _local_5 = _model.length;
            var _local_6 = _local_5 - 1;
            _selectedCoordinates = _coordinate[_local_6];
            var _local_7 = stampsHolder.attachMovie("ListBackground", "listBackground", stampsHolder.getNextHighestDepth());
            _local_7._width = _dimensions[_local_6].width;
            _local_7._height = _dimensions[_local_6].height;
            var _local_4 = stampsHolder.createEmptyMovieClip("gridHolder", stampsHolder.getNextHighestDepth());
            var _local_3 = 0;
            while (_local_3 < _local_5) {
                var _local_2 = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedRenderer(_local_4.attachMovie(ITEM_RENDERER, "itemRenderer" + _local_3, _local_4.getNextHighestDepth()));
                _local_2.useHandCursor = false;
                _local_2.addEventListener("over", onStampItemRollOver, this);
                _local_2.addEventListener("out", onStampItemRollOut, this);
                _local_2.setScale(STAMP_BOOK_ITEM_ART_SCALE, STAMP_BOOK_ITEM_ART_SCALE);
                _local_2.move(_selectedCoordinates[_local_3].x, _selectedCoordinates[_local_3].y);
                _local_2.setModel(_model[_local_3]);
                _local_3++;
            }
            _local_4._x = PADDING;
            _local_4._y = PADDING;
            stampsHolder._x = (background._width - stampsHolder._width) >> 1;
            congratulationsMessage._y = (stampsHolder._y + stampsHolder._height) + PADDING;
            background._height = ((background._y + congratulationsMessage._y) + congratulationsMessage._height) + PADDING;
        }
        function onStampItemRollOver(event) {
            var _local_2 = MovieClip(event.target);
            descriptionBox._x = ((stampsHolder._x + _local_2._x) - _local_2._width) + DESCRIPTIONBOX_X_OFFSET;
            descriptionBox._y = (((stampsHolder._y + _local_2._y) - (_local_2._height / 2)) - descriptionBox._height) + DESCRIPTIONBOX_Y_OFFSET;
            descriptionBox.setModel(event.data);
        }
        function onStampItemRollOut(event) {
            onStampListRollOut(event);
        }
        function drawList() {
            var _local_2 = 5;
            var _local_3 = _dimensions[_local_2].width;
            var _local_4 = _dimensions[_local_2].height;
            stampsList = com.clubpenguin.stamps.stampbook.controls.RecentlyEarnedList(stampsHolder.attachMovie(LIST_LINKAGE_ID, "stamps_list", stampsHolder.getNextHighestDepth()));
            stampsList.addEventListener("loadInit", onStampsListInit, this);
            stampsList.addEventListener("over", onStampsListRollOver, this);
            stampsList.addEventListener("out", onStampListRollOut, this);
            stampsList.init(_local_3, _local_4, ITEM_RENDERER, com.clubpenguin.stamps.StampManager.STAMP_ICON_BOX_WIDTH, com.clubpenguin.stamps.StampManager.STAMP_ICON_BOX_HEIGHT, PADDING);
            stampsList.dataProvider = Array(_model)[0];
            stampsList.move(0, 0);
        }
        function onStampsListInit(event) {
            stampsHolder._x = (background._width - stampsHolder._width) >> 1;
            stampsHolder._y = (description._y + description._height) + PADDING;
            congratulationsMessage._y = (stampsHolder._y + stampsHolder._height) + PADDING;
            background._height = ((background._y + congratulationsMessage._y) + congratulationsMessage._height) + PADDING;
        }
        function onCloseButtonPressed() {
            dispatchEvent({type:"close"});
        }
        function onStampsListRollOver(event) {
            var _local_2 = MovieClip(event.target);
            descriptionBox._x = (stampsHolder._x + _local_2._x) + DESCRIPTIONBOX_X_OFFSET;
            descriptionBox._y = ((stampsHolder._y + _local_2._y) - descriptionBox._height) + DESCRIPTIONBOX_Y_OFFSET;
            descriptionBox.setModel(event.data);
        }
        function onStampListRollOut(event) {
            descriptionBox._x = -1000;
            descriptionBox._y = -1000;
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView;
        static var LINKAGE_ID = "RecentlyEarnedStampsView";
        static var LIST_LINKAGE_ID = "RecentlyEarnedList";
        static var ITEM_RENDERER = "RecentlyEarnedRenderer";
        static var STAMP_BOOK_ITEM_ART_SCALE = 100;
        static var PADDING = 10;
        static var DESCRIPTIONBOX_X_OFFSET = 5;
        static var DESCRIPTIONBOX_Y_OFFSET = 15;
        var _coordinate = [[{x:35, y:32.75}], [{x:35, y:32.75}, {x:115, y:32.75}], [{x:35, y:32.75}, {x:115, y:32.75}, {x:195, y:32.75}], [{x:35, y:32.75}, {x:115, y:32.75}, {x:35, y:108.25}, {x:115, y:108.25}], [{x:35, y:32.75}, {x:115, y:32.75}, {x:195, y:32.75}, {x:80, y:108.25}, {x:160, y:108.25}], [{x:35, y:32.75}, {x:115, y:32.75}, {x:195, y:32.75}, {x:35, y:108.25}, {x:115, y:108.25}, {x:195, y:108.25}]];
        var _dimensions = [{width:90, height:85.5}, {width:170, height:85.5}, {width:250, height:85.5}, {width:170, height:161}, {width:250, height:161}, {width:250, height:161}];
    }
