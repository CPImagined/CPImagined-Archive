//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.StampBook extends MovieClip
    {
        static var SHELL, __get__shell, STAMP_MANAGER, __get__stampManager, ACTIVE_PLAYER, __get__activePlayer;
        var _trackerAS2, _visible, _recentlyEarnedList, _isMyStampBook, _insidePagesViewClip, attachMovie, getNextHighestDepth, _categoryList, _coverStamps, _userStampsList, _stampBookCoverViewClip, stampbookCoverView, recentlyEarnedView, insidePagesView, _storagePromptHolder, createEmptyMovieClip, _parent;
        function StampBook () {
            super();
            com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell = SHELL;
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            _visible = false;
            configUI();
        }
        static function set shell(clip) {
            SHELL = clip;
            //return(__get__shell());
        }
        static function set stampManager(manager) {
            STAMP_MANAGER = manager;
            //return(__get__stampManager());
        }
        static function set activePlayer(activePlayerObj) {
            ACTIVE_PLAYER = activePlayerObj;
            //return(__get__activePlayer());
        }
        function configUI() {
            if ((((SHELL == undefined) || (STAMP_MANAGER == undefined)) || (ACTIVE_PLAYER == undefined)) || (ACTIVE_PLAYER.player_id == undefined)) {
                return(undefined);
            }
            _recentlyEarnedList = [];
            _isMyStampBook = SHELL.isMyPlayer(ACTIVE_PLAYER.player_id);
            _insidePagesViewClip = this.attachMovie("InsidePagesView", INSIDE_PAGES_VIEW_CLIP_NAME, getNextHighestDepth());
            SHELL.addListener(SHELL.PLAYERS_STAMP_BOOK_CATEGORIES, handleGetPlayersStampBookCategories, this);
            SHELL.addListener(SHELL.STAMP_BOOK_COVER_DETAILS, handleGetStampBookCoverDetails, this);
            SHELL.addListener(SHELL.PLAYERS_STAMPS, handleGetPlayersStamps, this);
            SHELL.showLoading();
            STAMP_MANAGER.getPlayersStampBookCategories(ACTIVE_PLAYER.player_id);
        }
        function handleGetPlayersStampBookCategories(stampCategories) {
            SHELL.removeListener(SHELL.PLAYERS_STAMP_BOOK_CATEGORIES, handleGetPlayersStampBookCategories, this);
            _categoryList = stampCategories;
            STAMP_MANAGER.getStampBookCoverDetails(ACTIVE_PLAYER.player_id);
        }
        function handleGetStampBookCoverDetails(stampBookCover) {
            SHELL.removeListener(SHELL.STAMP_BOOK_COVER_DETAILS, handleGetStampBookCoverDetails, this);
            _coverStamps = stampBookCover;
            STAMP_MANAGER.getPlayersStamps(ACTIVE_PLAYER.player_id);
        }
        function handleGetPlayersStamps(stampsList) {
            SHELL.removeListener(SHELL.PLAYERS_STAMPS, handleGetPlayersStamps, this);
            _userStampsList = stampsList;
            com.clubpenguin.stamps.stampbook.util.StampLookUp.getInstance().initialize(ACTIVE_PLAYER, _categoryList, _userStampsList, _coverStamps, STAMP_MANAGER);
            _stampBookCoverViewClip = this.attachMovie("StampbookCoverView", STAMPBOOK_COVER_VIEW_CLIP_NAME, getNextHighestDepth());
            if (_isMyStampBook) {
                SHELL.addListener(SHELL.MY_RECENTLY_EARNED_STAMPS, handleGetMyRecentlyEarnedStamps, this);
                STAMP_MANAGER.getMyRecentlyEarnedStamps();
            } else {
                drawUI();
            }
        }
        function handleGetMyRecentlyEarnedStamps(stampsList) {
            SHELL.removeListener(SHELL.MY_RECENTLY_EARNED_STAMPS, handleGetMyRecentlyEarnedStamps, this);
            _recentlyEarnedList = stampsList;
            drawUI();
        }
        function drawUI() {
            stampbookCoverView._visible = true;
            stampbookCoverView = com.clubpenguin.stamps.stampbook.views.StampbookCoverView(_stampBookCoverViewClip);
            stampbookCoverView.addEventListener("claspClicked", onContinueToInsidePages, this);
            stampbookCoverView.addEventListener("stampbookCoverViewDoneLoading", onStampbookCoverViewDoneLoading, this);
            stampbookCoverView.setModel(_coverStamps);
            stampbookCoverView.closeStampBookFunction = mx.utils.Delegate.create(this, handleCloseStampBook);
            stampbookCoverView.toggleEditControls = ((_isMyStampBook && (SHELL.isPlayerMemberById(ACTIVE_PLAYER.player_id))) ? true : false);
            var _local_2 = 0;
            while (_local_2 < SHELL.ROSTER.buddies.length) {
                var _local_3 = SHELL.ROSTER.buddies[_local_2];
                if (Number(_local_3.player_id) == ACTIVE_PLAYER.player_id) {
                    SHELL.sendInteraction(_local_3.swid, SHELL.STAMPS_INTERACTION);
                }
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < SHELL.ROSTER.buddies.length) {
                var _local_3 = SHELL.ROSTER.buddies[_local_2];
                if (Number(_local_3.player_id) == ACTIVE_PLAYER.player_id) {
                    SHELL.sendInteraction(_local_3.swid, SHELL.STAMPS_INTERACTION);
                }
                _local_2++;
            }
            if (_recentlyEarnedList.length > 0) {
                recentlyEarnedView = com.clubpenguin.stamps.stampbook.views.RecentlyEarnedStampsView(this.attachMovie("RecentlyEarnedStampsView", RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME, getNextHighestDepth()));
                recentlyEarnedView.setModel(_recentlyEarnedList);
                recentlyEarnedView.addEventListener("close", onCloseRecentlyEarnedView, this);
                recentlyEarnedView._x = (Stage.width - recentlyEarnedView.getWidth()) >> 1;
                recentlyEarnedView._y = (Stage.height - recentlyEarnedView.getHeight()) >> 1;
            }
            insidePagesView = com.clubpenguin.stamps.stampbook.views.InsidePagesView(_insidePagesViewClip);
            insidePagesView.addEventListener("close", onGoBackToCover, this);
            insidePagesView.addEventListener("closeStampBook", handleCloseStampBook, this);
            insidePagesView._visible = false;
            if ((((ACTIVE_PLAYER.player_id == SHELL.getMyPlayerId()) && (_isFirstView)) && (!SHELL.isPlayerMemberById(ACTIVE_PLAYER.player_id))) && (STAMP_MANAGER.getHasModifiedStampCover())) {
                _isFirstView = false;
                var _local_5 = SHELL.getPath("stampbook_cover_storage");
                _storagePromptHolder = this.createEmptyMovieClip("_storagePromptHolder", getNextHighestDepth());
                var _local_4 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
                _local_4.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, mx.utils.Delegate.create(this, onStoragePromptLoaded));
                _local_4.loadClip(_local_5, _storagePromptHolder, "StampBook.as drawUI()");
            }
        }
        function onStoragePromptLoaded(event) {
            var _local_2 = event.target;
            _local_2.blocker_mc.tabEnabled = false;
            _local_2.blocker_mc.onPress = null;
            _local_2.blocker_mc.useHandCursor = false;
            _local_2.screen_mc.close_btn.onRelease = mx.utils.Delegate.create(this, onStoragePromptClose);
            _local_2.screen_mc.buy_btn.onRelease = mx.utils.Delegate.create(this, onStoragePromptBuy);
        }
        function onStoragePromptClose() {
            _storagePromptHolder.removeMovieClip();
        }
        function onStoragePromptBuy() {
            _storagePromptHolder.removeMovieClip();
            SHELL.sendNavigateToBuyMembership(OOPS_MESSAGE_TRACKING);
        }
        function onContinueToInsidePages(event) {
            stampbookCoverView._visible = false;
            insidePagesView.setModel(_categoryList);
            insidePagesView._visible = true;
        }
        function onStampbookCoverViewDoneLoading(event) {
            SHELL.hideLoading();
            _visible = true;
        }
        function onGoBackToCover(event) {
            insidePagesView._visible = false;
            stampbookCoverView._visible = true;
        }
        function onCloseRecentlyEarnedView(event) {
            recentlyEarnedView._visible = false;
        }
        function handleCloseStampBook() {
            _parent._root.close();
        }
        function cleanUp() {
            insidePagesView.removeEventListener("close", onGoBackToCover, this);
            insidePagesView.removeEventListener("closeStampBook", handleCloseStampBook, this);
            stampbookCoverView.removeEventListener("claspClicked", onContinueToInsidePages, this);
            stampbookCoverView.removeEventListener("stampbookCoverViewDoneLoading", onStampbookCoverViewDoneLoading, this);
            if (_recentlyEarnedList.length > 0) {
                this[RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME].removeMovieClip();
                recentlyEarnedView.removeEventListener("close", onCloseRecentlyEarnedView, this);
            }
            recentlyEarnedView.cleanUp();
            stampbookCoverView.cleanUp();
            insidePagesView.cleanUp();
            _stampBookCoverViewClip.removeMovieClip();
            _insidePagesViewClip.removeMovieClip();
        }
        static var STAMPBOOK_COVER_VIEW_CLIP_NAME = "stampBookCoverView";
        static var RECENTLY_EARNED_STAMPS_VIEW_CLIP_NAME = "recentlyEarnedStampsView";
        static var INSIDE_PAGES_VIEW_CLIP_NAME = "insidePagesView";
        static var OOPS_MESSAGE_TRACKING = "oops_stampbook";
        static var _isFirstView = true;
    }
