//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.InsidePagesContentView extends com.clubpenguin.stamps.stampbook.views.InsidePagesBaseView
    {
        var _buttonsList, content_holder_mc, _shell, title_txt, legend, _model, dispatchEvent;
        function InsidePagesContentView () {
            super();
        }
        function cleanUp() {
            var _local_4 = _buttonsList.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                _buttonsList[_local_2].removeEventListener("press", onContentBtnPressed, this);
                _local_2++;
            }
            _local_4 = NUM_COLUMNS * NUM_ROWS;
            _local_2 = 0;
            while (_local_2 < _local_4) {
                var _local_3 = content_holder_mc["listButton" + _local_2];
                if (_local_3) {
                    _local_3.removeMovieClip();
                }
                _local_2++;
            }
        }
        function configUI() {
            _buttonsList = [];
            title_txt.text = _shell.getLocalizedString("contents_category_title");
            legend.titleText.text = _shell.getLocalizedString("toc_legend_title");
            legend.easyText.text = _shell.getLocalizedString("toc_legend_easy");
            legend.mediumText.text = _shell.getLocalizedString("toc_legend_medium");
            legend.hardText.text = _shell.getLocalizedString("toc_legend_hard");
            legend.extremeText.text = _shell.getLocalizedString("toc_legend_extreme");
            legend.memberText.text = _shell.getLocalizedString("toc_legend_member");
            legend.newText.text = _shell.getLocalizedString("toc_legend_new");
            legend.editText.text = _shell.getLocalizedString("toc_legend_edit");
            legend.saveText.text = _shell.getLocalizedString("toc_legend_save");
            legend.newClip.gotoAndStop(_shell.getLocalizedFrame());
            super.configUI();
        }
        function populateUI() {
            var _local_5 = _buttonsList.length;
            if (_local_5 > 0) {
                var _local_3 = 0;
                while (_local_3 < _local_5) {
                    var _local_4 = _model[_local_3];
                    if ((_local_4.getID() == undefined) || (_local_4.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)) {
                    } else {
                        var _local_2 = com.clubpenguin.stamps.stampbook.controls.ListButton(_buttonsList[_local_3]);
                        _local_2.setModel(_local_4);
                        _local_2.indexNumber = _local_3;
                    }
                    _local_3++;
                }
                return(undefined);
            }
            _local_5 = NUM_COLUMNS * NUM_ROWS;
            var _local_3 = 0;
            while (_local_3 < _local_5) {
                var _local_4 = _model[_local_3];
                if ((_local_4.getID() == undefined) || (_local_4.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID)) {
                } else {
                    var _local_2 = com.clubpenguin.stamps.stampbook.controls.ListButton(content_holder_mc.attachMovie(BUTTON_RENDERER, "listButton" + _local_3, content_holder_mc.getNextHighestDepth()));
                    _local_2.addEventListener("press", onContentBtnPressed, this);
                    _local_2._x = (_local_3 % NUM_COLUMNS) * (_local_2._width + HORIZONTAL_PADDING);
                    _local_2._y = Math.floor(_local_3 / NUM_COLUMNS) * (_local_2._height + VERTICAL_PADDING);
                    _local_2.setModel(_local_4);
                    _local_2.indexNumber = _local_3;
                    _buttonsList.push(_local_2);
                }
                _local_3++;
            }
        }
        function onContentBtnPressed(event) {
            var _local_2 = com.clubpenguin.stamps.stampbook.controls.ListButton(event.target);
            var _local_3 = event.data;
            dispatchEvent({type:"itemClick", category:_local_3.getName(), index:_local_2.indexNumber});
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView;
        static var LINKAGE_ID = "InsidePagesContentView";
        static var NUM_COLUMNS = 2;
        static var NUM_ROWS = 5;
        static var VERTICAL_PADDING = 10;
        static var HORIZONTAL_PADDING = 38;
        static var BUTTON_RENDERER = "ListButton";
    }
