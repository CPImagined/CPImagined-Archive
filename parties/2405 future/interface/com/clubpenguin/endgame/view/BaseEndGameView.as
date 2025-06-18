//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.view.BaseEndGameView extends MovieClip
    {
        var _x, _y, _mcBlock, block_mc, _endGameClosed, stop, _visible, _shell, _model, _params, onEnterFrame, _currentFrameLabel, gotoAndStop, _closeBtn, close_btn, _howToBtn, how_to_btn, _title, title_mc, _earnedStampsTxt, stamps_mc, _earnedStampsShadowTxt, _totalStampsTxt, _infoTxt, info_txt, _progressGague, progress_gague_mc, _stampViewer, stampList, howto_txt, _descriptionBox, _howToLoc, createEmptyMovieClip, getNextHighestDepth;
        function BaseEndGameView () {
            super();
            _x = END_GAME_POS_X;
            _y = END_GAME_POS_Y;
            _mcBlock = block_mc;
            _mcBlock.useHandCursor = false;
            _mcBlock.tabEnabled = false;
            _mcBlock.onRelease = null;
            _endGameClosed = new org.osflash.signals.Signal();
            this.stop();
            _visible = false;
        }
        function get endGameClosed() {
            return(_endGameClosed);
        }
        function setShell(shell) {
            _shell = shell;
        }
        function setModel(model) {
            _model = model;
        }
        function initialize() {
            _params = _model.endGameParams;
            debugTrace("initialize BaseEndGameView _params = " + _params);
            updateView();
            initReferences();
        }
        function updateView() {
            debugTrace("updateView()");
            if (_params == null) {
                debugTrace("_params == null   abort updateView");
                return(undefined);
            }
            if (_params.numTotalStamps <= 0) {
                gotoNoStamps();
            } else if ((_params.numTotalStamps > 0) && (_params.numCompletedStamps == _params.numTotalStamps)) {
                if (_model.isJustCompleted) {
                    gotoCongrats();
                } else {
                    gotoCompleted();
                }
            } else if (_params.newStamps.length == 0) {
                gotoNoNewStamps();
            } else {
                gotoProgress();
            }
        }
        function delayInitCall(initFunc) {
            onEnterFrame = mx.utils.Delegate.create(this, function () {
                this.onEnterFrame = null;
                this._visible = true;
                initFunc.call(this);
            });
        }
        function gotoNoStamps() {
            _currentFrameLabel = FRAME_NO_STAMPS;
            this.gotoAndStop(_currentFrameLabel);
            delayInitCall(initNoStamps);
        }
        function gotoNoNewStamps() {
            _currentFrameLabel = FRAME_NO_NEW_STAMPS;
            this.gotoAndStop(_currentFrameLabel);
            delayInitCall(initNoNewStamps);
        }
        function gotoHowTo() {
            _currentFrameLabel = FRAME_HOWTO;
            this.gotoAndStop(_currentFrameLabel);
            delayInitCall(initHowTo);
        }
        function gotoCongrats() {
            _currentFrameLabel = FRAME_CONGRATS;
            this.gotoAndStop(_currentFrameLabel);
            delayInitCall(initCongrats);
        }
        function gotoCompleted() {
            _currentFrameLabel = FRAME_COMPLETED;
            this.gotoAndStop(_currentFrameLabel);
            delayInitCall(initCompleted);
        }
        function gotoProgress() {
            _currentFrameLabel = FRAME_PROGRESS;
            this.gotoAndStop(_currentFrameLabel);
            delayInitCall(initProgress);
        }
        function initReferences() {
            debugTrace("initReferences");
            _closeBtn = close_btn;
            _howToBtn = how_to_btn;
            _title = title_mc;
            _earnedStampsTxt = stamps_mc.earned_txt;
            _earnedStampsShadowTxt = stamps_mc.earned_shadow_txt;
            _totalStampsTxt = stamps_mc.total_txt;
            _infoTxt = info_txt;
            _progressGague = progress_gague_mc;
            _stampViewer = stampList;
        }
        function setupComponents() {
            setupDescriptionBox();
            setupStamps();
            setupInfo();
            setupProgressGague();
            setupStampViewer();
            setupTitle();
        }
        function initNoStamps() {
            debugTrace("initNoStamps");
            _isShowingProgressGague = false;
            _isShowingStampViewer = false;
            setupComponents();
            _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
        }
        function initNoNewStamps() {
            debugTrace("initNoNewStamps");
            _isShowingProgressGague = true;
            _isShowingStampViewer = false;
            setupComponents();
            var _local_2 = howto_txt;
            _local_2.text = _shell.getLocalizedString("end_game_howto_btn");
            com.clubpenguin.util.StringUtils.ResizeTextToFit(_local_2);
            _howToBtn.onRelease = mx.utils.Delegate.create(this, gotoHowTo);
            _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
        }
        function initHowTo() {
            debugTrace("initHowTo");
            _isShowingProgressGague = false;
            _isShowingStampViewer = false;
            setupComponents();
            setupHowTo();
            _closeBtn.onRelease = mx.utils.Delegate.create(this, closeHowTo);
        }
        function initCongrats() {
            debugTrace("initCongrats");
            _isShowingProgressGague = false;
            _isShowingStampViewer = true;
            setupComponents();
            _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
        }
        function initCompleted() {
            debugTrace("initCompleted");
            _isShowingProgressGague = false;
            _isShowingStampViewer = false;
            setupComponents();
            _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
        }
        function initProgress() {
            debugTrace("initProgress");
            _isShowingProgressGague = true;
            _isShowingStampViewer = true;
            setupComponents();
            _closeBtn.onRelease = mx.utils.Delegate.create(this, close);
        }
        function setupDescriptionBox() {
            if (_descriptionBox != null) {
                _descriptionBox.removeMovieClip();
            }
            var _local_2 = _stampViewer.paginationHolder.attachMovie(com.clubpenguin.stamps.stampbook.controls.DescriptionBox.LINKAGE_ID, "_descriptionBox", DESCRIPTION_BOX_DEPTH);
            _descriptionBox = com.clubpenguin.stamps.stampbook.controls.DescriptionBox(_local_2);
            _descriptionBox._visible = false;
        }
        function setupTitle() {
            var _local_2 = _model.gameName;
            _title.title_txt.text = _local_2;
            _title.title_shadow_txt.text = _local_2;
            _title.earned_txt.text = _shell.getLocalizedString("end_game_earned");
        }
        function setupStamps() {
            if ((_currentFrameLabel == FRAME_NO_STAMPS) || (_currentFrameLabel == FRAME_HOWTO)) {
                return(undefined);
            }
            var _local_2 = "end_game_stamps_earned";
            _local_2 = _shell.getLocalizedString(_local_2);
            _local_2 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.numCompletedStamps), _local_2);
            _local_2 = com.clubpenguin.util.StringUtils.replaceString("%total%", String(_params.numTotalStamps), _local_2);
            var _local_3 = _shell.getLocalizedString("game_name_stamps");
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%game_name%", String(_model.gameName), _local_3);
            _earnedStampsTxt.text = _local_2;
            _earnedStampsShadowTxt.text = _local_2;
            _totalStampsTxt.text = _local_3;
        }
        function setupInfo() {
            if ((_currentFrameLabel == FRAME_HOWTO) || (_currentFrameLabel == FRAME_NO_STAMPS)) {
                return(undefined);
            }
            var _local_2 = "";
            if (_params.numCompletedStamps == _params.numTotalStamps) {
                _local_2 = createCongratsMessage();
            }
            _infoTxt.text = _local_2;
        }
        function setupProgressGague() {
            if (!_isShowingProgressGague) {
                return(undefined);
            }
            var _local_3 = new com.clubpenguin.endgame.model.StampProgressModel(_shell, _params.numCompletedStamps, _params.numTotalStamps);
            var _local_2 = new com.clubpenguin.endgame.mediator.StampProgressMediator(_progressGague, _local_3);
            _local_2.init();
        }
        function setupStampViewer() {
            if (!_isShowingStampViewer) {
                return(undefined);
            }
            _stampViewer.stampIconRolledOver.add(onStampIconRollOver, this);
            _stampViewer.stampIconRolledOut.add(onStampIconRollOut, this);
            var _local_2 = new com.clubpenguin.endgame.model.StampListModel(_shell, _params.newStamps);
            var _local_3 = new com.clubpenguin.endgame.mediator.StampListMediator(_stampViewer, _local_2);
            _local_3.init();
        }
        function setupCoins() {
        }
        function onStampIconRollOver(target, stamp) {
            _descriptionBox._visible = true;
            _descriptionBox.setModel(stamp);
            _descriptionBox._x = target._x + DESCRIPTION_BOX_OFFSET_X;
            _descriptionBox._y = target._y + DESCRIPTION_BOX_OFFSET_Y;
        }
        function onStampIconRollOut() {
            _descriptionBox._visible = false;
        }
        function setupHowTo() {
            var _local_2 = _shell.getLocalizedString("end_game_howto_title");
            _title.title_txt.text = _local_2;
            _title.title_shadow_txt.text = _local_2;
            if (_howToLoc == undefined) {
                var _local_3 = _shell.getPath("end_game_howto");
                var _local_4 = this.createEmptyMovieClip("howto_loc_mc", getNextHighestDepth());
                _shell.loadSWF(_local_4, _local_3, null, mx.utils.Delegate.create(this, onHowToLocLoaded), null, null);
            } else {
                _howToLoc._visible = true;
            }
        }
        function onHowToLocLoaded(target) {
            _howToLoc = target;
            _howToLoc._x = HOW_TO_LOC_POS_X;
            _howToLoc._y = HOW_TO_LOC_POS_Y;
        }
        function closeHowTo() {
            _howToLoc._visible = false;
            _visible = false;
            gotoNoNewStamps();
            setupCoins();
        }
        function createCongratsMessage() {
            var _local_2 = "";
            _local_2 = (_model.isJustCompleted ? "end_game_first_congrats" : "end_game_congrats");
            _local_2 = _shell.getLocalizedString(_local_2);
            if (_model.isJustCompleted) {
                _local_2 = com.clubpenguin.util.StringUtils.replaceString("%game_name%", String(_model.gameName), _local_2);
            }
            return(_local_2);
        }
        function close() {
            debugTrace("close");
            this.gotoAndStop("hidden");
            _endGameClosed.dispatch();
        }
        function debugTrace(msg) {
        }
        static var LINKAGE_ID = "com.clubpenguin.endgame.view.BaseEndGameView";
        static var FRAME_NO_STAMPS = "noStamps";
        static var FRAME_NO_NEW_STAMPS = "noNewStamps";
        static var FRAME_HOWTO = "howto";
        static var FRAME_CONGRATS = "congrats";
        static var FRAME_COMPLETED = "completed";
        static var FRAME_PROGRESS = "progress";
        static var END_GAME_POS_X = 380;
        static var END_GAME_POS_Y = 240;
        static var HOW_TO_LOC_POS_X = -133;
        static var HOW_TO_LOC_POS_Y = -114;
        static var DESCRIPTION_BOX_DEPTH = 1000;
        static var DESCRIPTION_BOX_OFFSET_X = -82;
        static var DESCRIPTION_BOX_OFFSET_Y = -110;
        var _isShowingProgressGague = false;
        var _isShowingStampViewer = false;
    }
