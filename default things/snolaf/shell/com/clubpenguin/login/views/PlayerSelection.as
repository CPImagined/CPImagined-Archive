//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.PlayerSelection extends com.clubpenguin.ui.views.AbstractView
    {
        var _storedPlayerClips, _backgroundClip, bg_mc, _loginAsDiffBtn, login_as_diff_btn, viewManager, _closeButton, close_btn, _differentPenguinField, different_penguin_txt, _paperDolls, _contentTracked, _savedPlayers, _numSavedPlayers, _currentPlayerScreen, gotoAndStop, _membershipCodeBtn, membership_code_btn, _shell, redemption_badge_mc, getURL;
        function PlayerSelection () {
            super();
            debugTrace("instantiated..");
        }
        function setupView() {
            _storedPlayerClips = new Array();
            var _local_2 = 0;
            while (_local_2 < MAX_STORED_PLAYERS) {
                _storedPlayerClips[_local_2] = this["playerClip" + (_local_2 + 1)];
                _local_2++;
            }
            _backgroundClip = bg_mc;
            _loginAsDiffBtn = login_as_diff_btn;
            _loginAsDiffBtn.onRelease = com.clubpenguin.util.Delegate.create(viewManager, com.clubpenguin.login.views.ViewManager(viewManager).gotoNewPlayer);
            _closeButton = close_btn;
            _closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, handleCloseButtonRelease);
            _differentPenguinField = different_penguin_txt;
            _backgroundClip.onRelease = undefined;
            _backgroundClip.useHandCursor = false;
            _backgroundClip.tabEnabled = false;
            _paperDolls = new Array();
            _contentTracked = false;
        }
        function handleCloseButtonRelease() {
            com.clubpenguin.login.views.ViewManager(viewManager).setRedemptionStatus(false);
            com.clubpenguin.login.views.ViewManager(viewManager).gotoLogin();
        }
        function setupPlayerSelection() {
            debugTrace("setupPlayerSelection");
            setRedemptionForPlayerSelection();
            setupView();
            translatePlayerSelection();
            _savedPlayers = com.clubpenguin.login.LocalData.getSavedPlayers();
            _numSavedPlayers = _savedPlayers.length;
            if (_numSavedPlayers < 1) {
                com.clubpenguin.login.views.ViewManager(viewManager).gotoStart();
                return(undefined);
            }
            _currentPlayerScreen = getPlayerScreen();
            setupPlayerCards();
            this.show();
        }
        function setRedemptionForPlayerSelection() {
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                this.gotoAndStop("redemption");
                _membershipCodeBtn = membership_code_btn;
                _membershipCodeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, onMembershipCodeBtnReleased);
                _membershipCodeBtn.gotoAndStop(_shell.getLanguageAbbriviation());
            }
        }
        function setLanguageAbbr(abbr) {
            super.setLanguageAbbr(abbr);
            redemption_badge_mc.gotoAndStop(abbr);
        }
        function show() {
            super.show();
            bg_mc.treasureChest.gotoAndStop("start");
            if (!_contentTracked) {
                _contentTracked = true;
                if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                    _shell.trackContent(REDEMPTION_TRACKING_NAME);
                } else {
                    _shell.trackContent(TRACKING_NAME);
                }
            }
        }
        function onMembershipCodeBtnReleased() {
            var _local_3 = _shell.getLanguageAbbriviation();
            var _local_2 = "activate_card.php";
            if (_local_3 != "en") {
            }
            this.getURL(_shell.getPath("member_web") + _local_2);
        }
        function translatePlayerSelection() {
            _differentPenguinField.text = _shell.getLocalizedString("Login as a different penguin");
        }
        function getPlayerScreen() {
            hideAllPlayers();
            if ((_numSavedPlayers > 0) && (_numSavedPlayers <= MAX_STORED_PLAYERS)) {
                return(_storedPlayerClips[_numSavedPlayers - 1]);
            } else {
                _shell.$e("[login] getPlayerScreen() -> no players saved");
                return(_storedPlayerClips[0]);
            }
        }
        function setupPlayerCards() {
            var _local_10 = _numSavedPlayers;
            var _local_5 = 0;
            while (_local_5 < _local_10) {
                var _local_3 = _savedPlayers[_local_5];
                var _local_8 = _local_3.Username.toUpperCase();
                var _local_2 = _currentPlayerScreen[("item" + _local_5) + "_mc"];
                _local_2.nickname1_txt.text = _local_8;
                if (_local_2.originalNicknameYPosition == null) {
                    _local_2.originalNicknameYPosition = _local_2.nickname1_txt._y;
                } else {
                    _local_2.nickname1_txt._y = _local_2.originalNicknameYPosition;
                }
                com.clubpenguin.login.Tools.ResizeTextToFit(_local_2.nickname1_txt);
                var _local_4 = new com.clubpenguin.ui.PaperDoll();
                _local_4.shell = _shell;
                _local_4.paperDollClip = _local_2.paper_mc;
                _local_4.fadeAfterLoad = true;
                _local_4.colourID = _local_3.Colour;
                for (var _local_9 in _shell.PAPERDOLL_DEFAULT_LAYER_DEPTHS) {
                    var _local_6 = _local_9.substr(0, 1).toUpperCase() + _local_9.substr(1);
                    _local_4.addItem(_local_9, _local_3[_local_6] || 0);
                }
                if (_local_3.AvatarAlpha != undefined) {
                    _local_4.paperDollClip._alpha = _local_3.AvatarAlpha;
                }
                if (_local_3.walkingPuffleId != undefined) {
                    var _local_7 = null;
                    if (_local_3.walkingPuffleHatId != undefined) {
                        _local_7 = _shell.getPuffleHatCollection().getPuffleHatVO(_local_3.walkingPuffleHatId);
                    }
                    _local_4.loadPuffleItem(_local_3.walkingPuffleColor, _local_3.walkingPuffleId, _local_3.walkingPuffleSubTypeID, _local_7);
                }
                _local_2.playerData = _local_3;
                _local_2.paperDoll = _local_4;
                _local_2.onRelease = com.clubpenguin.util.Delegate.create(this, selectPlayer, _local_5);
                _local_2.onRollOver = com.clubpenguin.util.Delegate.create(this, highlightPlayer, _local_5);
                _local_2.onRollOut = com.clubpenguin.util.Delegate.create(this, dullPlayer, _local_5);
                _local_2.onDragOut = com.clubpenguin.util.Delegate.create(this, dullPlayer, _local_5);
                _local_2.tabIndex = _currentTabIndex++;
                _paperDolls[_local_5] = _local_2;
                _local_5++;
            }
            _currentPlayerScreen._visible = true;
            _loginAsDiffBtn.tabIndex = _currentTabIndex;
        }
        function selectPlayer(playerIdx) {
            var _local_2 = new Object();
            _local_2.playerData = _paperDolls[playerIdx].playerData;
            _local_2.paperDoll = _paperDolls[playerIdx].paperDoll;
            com.clubpenguin.login.views.ViewManager(viewManager).gotoPlayerLogin(_local_2);
        }
        function highlightPlayer(playerIdx) {
            _paperDolls[playerIdx].background_mc.gotoAndStop("_over");
        }
        function dullPlayer(playerIdx) {
            _paperDolls[playerIdx].background_mc.gotoAndStop("_up");
        }
        function hideAllPlayers() {
            var _local_2 = 0;
            while (_local_2 < MAX_STORED_PLAYERS) {
                _storedPlayerClips[_local_2]._visible = false;
                _local_2++;
            }
        }
        function debugTrace(msg) {
            if (_debugTracesActive) {
            }
        }
        static var LINKAGE_ID = "com.clubpenguin.login.views.PlayerSelection";
        static var _debugTracesActive = true;
        static var MAX_STORED_PLAYERS = 6;
        static var TRACKING_NAME = "select_penguin";
        static var REDEMPTION_TRACKING_NAME = "unlock:saved_login";
        var _currentTabIndex = 0;
    }
