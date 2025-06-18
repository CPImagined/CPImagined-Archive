//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.view.StampListView extends MovieClip
    {
        var stampIconRolledOver, stampIconRolledOut, _shell, _btnPrev, prev_btn, _btnNext, next_btn, _stampViewer, stamp_viewer_mc, _stampPaginationHolder, _stamps, _stampIds, _stampPagination, _numStampIconsLoaded;
        function StampListView () {
            super();
            stampIconRolledOver = new org.osflash.signals.Signal(MovieClip, com.clubpenguin.stamps.IStampBookItem);
            stampIconRolledOut = new org.osflash.signals.Signal();
            initReferences();
        }
        function setShell(shell) {
            _shell = shell;
        }
        function initReferences() {
            _btnPrev = prev_btn;
            _btnNext = next_btn;
            _stampViewer = stamp_viewer_mc;
            _stampPaginationHolder = _stampViewer.pagination_mc;
        }
        function displayStamps(stamps, stampIds) {
            _stamps = stamps;
            _stampIds = stampIds;
            var _local_6 = stamps.length;
            var _local_7 = ((_local_6 <= 2) ? (_local_6) : 3);
            _stampViewer.gotoAndStop(_local_7);
            _btnNext._visible = _local_6 > 3;
            _btnPrev._visible = false;
            if (_stampPagination != null) {
                var _local_4 = _stampPagination.getItems();
                var _local_2 = 0;
                while (_local_2 < _local_4.length) {
                    _local_4[_local_2].removeMovieClip();
                    _local_2++;
                }
            }
            _stampPagination = new com.clubpenguin.ui.components.Pagination(1, _local_7, STAMP_ITEM_WIDTH, STAMP_ITEM_HEIGHT, STAMP_ITEM_PADDING, STAMP_ITEM_PADDING);
            _stampPagination.addEventListener(com.clubpenguin.ui.components.Pagination.CHANGE, onPageChanged, this);
            _numStampIconsLoaded = 0;
            var _local_2 = 0;
            while (_local_2 < stamps.length) {
                var _local_3 = _stampPaginationHolder.createEmptyMovieClip("stampIconPlaceHolder_" + _local_2, _stampPaginationHolder.getNextHighestDepth());
                _shell.loadSWF(_local_3, (_shell.getPath("stampbook_stamps") + _stampIds[_local_2]) + ".swf", mx.utils.Delegate.create(this, onStampIconLoaded), null, mx.utils.Delegate.create(this, onStampIconLoadFailed), null);
                _local_2++;
            }
        }
        function onStampIconLoaded(target) {
            _numStampIconsLoaded++;
            _stampPagination.addItem(target);
            var index = Number(target._name.split("_")[1]);
            target.useHandCursor = false;
            target.hitArea_mc._alpha = 0;
            var _local_2 = function () {
                this.onStampIconRollOver(target, this._stamps[index]);
            };
            target.onRollOver = mx.utils.Delegate.create(this, _local_2);
            target.onDragOver = mx.utils.Delegate.create(this, _local_2);
            target.onRollOut = mx.utils.Delegate.create(this, onStampIconRollOut);
            target.onDragOut = mx.utils.Delegate.create(this, onStampIconRollOut);
            if (_numStampIconsLoaded >= _stamps.length) {
                _stampPagination.positionItems();
                _stampPagination.showPage(1);
                _btnNext.onRelease = mx.utils.Delegate.create(this, onNextStamp);
                _btnPrev.onRelease = mx.utils.Delegate.create(this, onPrevStamp);
            }
        }
        function onStampIconLoadFailed(target) {
            target.removeMovieClip();
        }
        function onStampIconRollOver(target, stamp) {
            stampIconRolledOver.dispatch(target, stamp);
        }
        function onStampIconRollOut() {
            stampIconRolledOut.dispatch();
        }
        function onNextStamp() {
            _stampPagination.showNextPage();
        }
        function onPrevStamp() {
            _stampPagination.showPreviousPage();
        }
        function onPageChanged(arg) {
            _btnNext._visible = arg.currentPage < _stampPagination.numPages;
            _btnPrev._visible = arg.currentPage > 1;
        }
        function get paginationHolder() {
            return(_stampPaginationHolder);
        }
        static var STAMP_ITEM_WIDTH = 70;
        static var STAMP_ITEM_HEIGHT = 65;
        static var STAMP_ITEM_PADDING = 10;
    }
