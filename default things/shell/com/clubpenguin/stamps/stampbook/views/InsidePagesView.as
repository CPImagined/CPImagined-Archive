//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.views.InsidePagesView extends com.clubpenguin.stamps.stampbook.views.BaseView
    {
        var _contentsTitle, _shell, _navigation, contentView, subContentView, stampsView, pinsView, close_btn, start_btn, next_btn, prev_btn, bitmapLines, totalStamps1, totalStamps2, pageNumberOf, book_holder_mc, backgroundLoader, attachMovie, getNextHighestDepth, _currentView, dispatchEvent, _stampLookUp, _pageList, _model, _tabButtonList, tabBtnsHolder, load_mc;
        function InsidePagesView () {
            super();
            _contentsTitle = _shell.getLocalizedString("contents_category_title");
        }
        function cleanUp() {
            _navigation.reset();
            contentView.cleanUp();
            subContentView.cleanUp();
            stampsView.cleanUp();
            pinsView.cleanUp();
            close_btn.removeEventListener("press", onCloseStampBook, this);
            start_btn.removeEventListener("press", onStartInsidePage, this);
            next_btn.removeEventListener("press", onNextInsidePage, this);
            prev_btn.removeEventListener("press", onPreviousInsidePage, this);
            contentView.removeEventListener("itemClick", onContentItemClick, this);
            subContentView.removeEventListener("itemClick", onContentItemClick, this);
        }
        function showUI() {
            bitmapLines._visible = true;
            totalStamps1._visible = true;
            totalStamps2._visible = true;
            pageNumberOf._visible = true;
        }
        function hideUI() {
            bitmapLines._visible = false;
            totalStamps1._visible = false;
            totalStamps2._visible = false;
            pageNumberOf._visible = false;
        }
        function configUI() {
            start_btn = book_holder_mc.book_holder_mc.book_items_mc.book_mc.close_btn;
            backgroundLoader = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            backgroundLoader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            contentView = com.clubpenguin.stamps.stampbook.views.InsidePagesContentView(this.attachMovie("InsidePagesContentView", "insidePagesContentView", getNextHighestDepth()));
            subContentView = com.clubpenguin.stamps.stampbook.views.InsidePagesSubContentView(this.attachMovie("InsidePagesSubContentView", "insidePagesSubContentView", getNextHighestDepth()));
            stampsView = com.clubpenguin.stamps.stampbook.views.InsidePagesStampsView(this.attachMovie("InsidePagesStampsView", "insidePagesStampsView", getNextHighestDepth()));
            pinsView = com.clubpenguin.stamps.stampbook.views.InsidePagesPinsView(this.attachMovie("InsidePagesPinsView", "insidePagesPinsView", getNextHighestDepth()));
            pinsView._visible = (stampsView._visible = (subContentView._visible = (contentView._visible = false)));
            super.configUI();
        }
        function onContentItemClick(event) {
            _navigation.addSection(event.index);
        }
        function onLoadInit(event) {
            var _local_1 = event.target;
            _local_1._alpha = 100;
        }
        function onStartInsidePage(event) {
            if (_navigation.title == _contentsTitle) {
                start_btn.gotoAndStop(1);
                _currentView._visible = false;
                dispatchEvent({type:"close"});
                return(undefined);
            }
            _navigation.reset();
        }
        function onNextInsidePage(event) {
            _navigation.next();
        }
        function onPreviousInsidePage(event) {
            if (_navigation.title == _contentsTitle) {
                prev_btn.gotoAndStop(1);
                _currentView._visible = false;
                dispatchEvent({type:"close"});
                return(undefined);
            }
            _navigation.previous();
        }
        function onCloseStampBook(event) {
            dispatchEvent({type:"closeStampBook"});
        }
        function populateUI() {
            _stampLookUp = com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance();
            _pageList = _stampLookUp.getPageList();
            if (!_navigation) {
                _navigation = new com.clubpenguin.stamps.stampbook.util.Navigation(_model);
                _navigation.addEventListener("change", onNagivationChange, this);
            }
            if (!_tabButtonList) {
                _tabButtonList = [];
                var _local_5 = Array(_navigation.currentSection)[0];
                var _local_6 = _local_5.length;
                var _local_3 = 0;
                while (_local_3 < _local_6) {
                    var _local_4 = _local_5[_local_3];
                    if (_local_4.getID() == com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID) {
                    } else {
                        var _local_2 = com.clubpenguin.stamps.stampbook.controls.IconTabButton(tabBtnsHolder.attachMovie("IconTabButton", "iconTabButton" + _local_3, tabBtnsHolder.getNextHighestDepth()));
                        _local_2.addEventListener("press", onIconTabButtonPressed, this);
                        _local_2._x = 0;
                        _local_2._y = (_local_2._height + TAB_BUTTONS_PADDING) * _local_3;
                        _local_2.data = _local_5[_local_3];
                        _local_2.indexNumber = _local_3;
                        _tabButtonList.push(_local_2);
                    }
                    _local_3++;
                }
            }
            close_btn.addEventListener("press", onCloseStampBook, this);
            start_btn.addEventListener("press", onStartInsidePage, this);
            next_btn.addEventListener("press", onNextInsidePage, this);
            prev_btn.addEventListener("press", onPreviousInsidePage, this);
            contentView.addEventListener("itemClick", onContentItemClick, this);
            subContentView.addEventListener("itemClick", onContentItemClick, this);
            loadContent();
        }
        function onIconTabButtonPressed(event) {
            var _local_2 = com.clubpenguin.stamps.stampbook.controls.IconTabButton(event.target);
            _navigation.goToSection(_local_2.indexNumber);
        }
        function onNagivationChange(event) {
            loadContent();
        }
        function loadContent() {
            var _local_23;
            var _local_12;
            var _local_9;
            var _local_10;
            var _local_11;
            var _local_15;
            var _local_19;
            var _local_17;
            var _local_16;
            var _local_22 = _shell.getPath("stampbook_insidePagesBackground");
            var _local_14;
            _currentView._visible = false;
            _currentView.reset();
            load_mc._alpha = 0;
            var _local_7 = _navigation.currentSection;
            var _local_4 = _local_7.getID();
            var _local_18;
            var _local_8 = _tabButtonList.length;
            var _local_3 = 0;
            while (_local_3 < _local_8) {
                var _local_2 = com.clubpenguin.stamps.stampbook.controls.IconTabButton(_tabButtonList[_local_3]);
                var _local_6 = _local_2.data;
                var _local_5 = _local_6.getID();
                _local_2.selected = (((_local_4 != undefined) && (_local_5 == _local_4)) ? true : false);
                _local_2.enabled = (((_local_4 != undefined) && (_local_5 == _local_4)) ? false : true);
                _local_3++;
            }
            if (_navigation.title == _contentsTitle) {
                showUI();
                start_btn.label = _shell.getLocalizedString("cover");
                _local_9 = _stampLookUp.getNumberOfUserStampsForCategory(_model);
                _local_10 = _stampLookUp.getNumberOfTotalStampsForCategory(_model);
                _local_11 = _shell.getLocalizedString("numerator_over_denominator");
                _local_12 = _shell.replace_m(_local_11, [_local_9, _local_10]);
                totalStamps1.text = _shell.getLocalizedString("total_stamps_label");
                totalStamps2.text = _local_12;
                _local_15 = 1;
                _local_19 = _pageList.length;
                _local_17 = _shell.getLocalizedString("page_number");
                _local_16 = _shell.replace_m(_local_17, [_local_15, _local_19]);
                pageNumberOf.text = _local_16;
                _local_14 = 0;
                _currentView = contentView;
                _currentView.setModel(_model);
                _currentView._visible = true;
            } else if (_navigation.title == com.clubpenguin.stamps.StampManager.MYSTERY_PAGE_TITLE) {
                hideUI();
                start_btn.label = _contentsTitle;
                _local_14 = com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID;
            } else {
                showUI();
                start_btn.label = _contentsTitle;
                var _local_20 = _local_7.getItems();
                var _local_21 = _local_7.getSubCategories();
                if ((_local_21 != undefined) && (_local_21.length > 0)) {
                    _local_9 = _stampLookUp.getNumberOfUserStampsForCategory(_local_7);
                    _local_10 = _stampLookUp.getNumberOfTotalStampsForCategory(_local_7);
                    _local_11 = _shell.getLocalizedString("numerator_over_denominator");
                    _local_18 = _shell.getLocalizedString("category_stamps_label");
                    totalStamps1.text = com.clubpenguin.util.StringUtils.replaceString("%name%", _local_7.getName(), _local_18);
                    _local_12 = _shell.replace_m(_local_11, [_local_9, _local_10]);
                    _currentView = subContentView;
                } else {
                    switch (_local_4) {
                        case com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID : 
                            totalStamps1.text = _shell.getLocalizedString("users_pins_label");
                            _local_12 = String(((_local_20 != undefined) ? (_local_20.length) : 0));
                            _currentView = pinsView;
                            break;
                        default : 
                            _local_9 = _stampLookUp.getNumberOfUserStampsForCategory(_local_7);
                            _local_10 = _stampLookUp.getNumberOfTotalStampsForCategory(_local_7);
                            _local_11 = _shell.replace_m(_shell.getLocalizedString("numerator_over_denominator"), [_local_9, _local_10]);
                            _local_18 = _shell.getLocalizedString("category_label");
                            totalStamps1.text = com.clubpenguin.util.StringUtils.replaceString("%name%", _local_7.getName(), _local_18);
                            _local_12 = _local_11;
                            _currentView = stampsView;
                    }
                }
                _local_14 = ((_local_7.getID() != undefined) ? (_local_7.getID()) : 1);
                _local_15 = getPageIndex(_local_7) + 2;
                _local_19 = _pageList.length;
                _local_17 = _shell.getLocalizedString("page_number");
                _local_16 = _shell.replace_m(_local_17, [_local_15, _local_19]);
                pageNumberOf.text = _local_16;
                totalStamps2.text = _local_12;
                _currentView.setModel(_local_7);
                _currentView._visible = true;
            }
            var _local_13 = book_holder_mc.book_holder_mc.book_items_mc.book_mc.paper_mc.background;
            if (_local_13.load_mc) {
                _local_13.load_mc.removeMovieClip();
            }
            _local_13.createEmptyMovieClip("load_mc", 1);
            backgroundLoader.loadClip((_local_22 + _local_14) + ".swf", _local_13.load_mc, "InsidePagesView.as loadContent()");
        }
        function getPageIndex(page) {
            var _local_3 = _pageList.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_pageList[_local_2] == page) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(-1);
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.views.InsidePagesView;
        static var LINKAGE_ID = "InsidePagesView";
        static var BLANK_CLIP_LINKAGE_ID = "Blank";
        static var TAB_BUTTONS_PADDING = 2;
    }
