//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.PlayerLogin extends com.clubpenguin.login.views.BaseLoginView
    {
        var bg_mc, _trackerAS2, _playerPanelClip, item_mc, _paperDollClip, _nicknameField, _removeBtn, remove_btn, _selectedPlayer, _shell, _passwordInputField, _passwordCheckClip, _usernameCheckClip, viewManager, _membershipCodeBtn, membership_code_btn, onMembershipCodeBtnReleased, _diffPenguinBtn, _forgetPenguinField, _loginDifferentField, different_penguin_txt_red, redemption_badge_mc, savePassForRedemption, saveUserForRedemption, _userNameLoggingIn, sendLoginCommandToServer;
        function PlayerLogin () {
            super();
            bg_mc.treasureChest.stop();
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
        }
        function setup(options) {
            super.setup(options);
            _playerPanelClip = item_mc;
            _paperDollClip = _playerPanelClip.paper_mc;
            _nicknameField = _playerPanelClip.nickname1_txt;
            _removeBtn = remove_btn;
            setInputHandlingState(true);
            var _local_7 = options.paperDoll;
            _selectedPlayer = options.playerData;
            var _local_3 = new com.clubpenguin.ui.PaperDoll();
            _local_3.shell = _shell;
            _local_3.paperDollClip = _paperDollClip;
            _local_3.fadeAfterLoad = false;
            _local_3.clear();
            _local_7.duplicate(_local_3);
            if (_selectedPlayer.AvatarAlpha != undefined) {
                _local_3.paperDollClip._alpha = _selectedPlayer.AvatarAlpha;
            }
            if (_selectedPlayer.walkingPuffleId != undefined) {
                var _local_4 = null;
                if (_selectedPlayer.walkingPuffleHatId != undefined) {
                    _local_4 = _shell.getPuffleHatCollection().getPuffleHatVO(_selectedPlayer.walkingPuffleHatId);
                }
                _local_3.loadPuffleItem(_selectedPlayer.walkingPuffleColor, _selectedPlayer.walkingPuffleId, _selectedPlayer.walkingPuffleSubTypeID, _local_4);
            }
            var _local_5 = _selectedPlayer.Username.toUpperCase();
            _nicknameField.text = _local_5;
            if (_originalNicknameYPosition == null) {
                _originalNicknameYPosition = _nicknameField._y;
            } else {
                _nicknameField._y = _originalNicknameYPosition;
            }
            com.clubpenguin.login.Tools.ResizeTextToFit(_nicknameField);
            if (_shell.isValidString(_selectedPlayer.PassCode)) {
                _passwordInputField.text = _shell.meltCode(_selectedPlayer.Username, _selectedPlayer.PassCode);
                _passwordCheckClip.gotoAndStop(2);
                _passwordCheckClip.active = true;
            } else {
                _passwordInputField.text = "";
                _passwordCheckClip.gotoAndStop(1);
                _passwordCheckClip.active = false;
            }
            _usernameCheckClip.gotoAndStop(2);
            _usernameCheckClip.active = true;
        }
        function setupRedemption() {
            super.setupRedemption();
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                _membershipCodeBtn = membership_code_btn;
                _membershipCodeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, onMembershipCodeBtnReleased);
                _membershipCodeBtn.gotoAndStop(_shell.getLanguageAbbriviation());
            }
        }
        function setInputHandlingState(enabled) {
            super.setInputHandlingState(enabled);
            if (enabled) {
                _removeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, removePenguin);
                _playerPanelClip.onRelease = com.clubpenguin.util.Delegate.create(viewManager, com.clubpenguin.login.views.ViewManager(viewManager).gotoPlayerSelection);
                _diffPenguinBtn.onRelease = _playerPanelClip.onRelease;
            } else {
                _removeBtn.onRelease = null;
                _playerPanelClip.onRelease = null;
                _diffPenguinBtn.onRelease = null;
            }
        }
        function setLanguageAbbr(abbr) {
        }
        function setupLocalization() {
            super.setupLocalization();
            _forgetPenguinField.text = _shell.getLocalizedString("Forget my penguin");
            _loginDifferentField.text = _shell.getLocalizedString("Login as a different penguin");
            different_penguin_txt_red.text = _shell.getLocalizedString("Login as a different penguin");
            redemption_badge_mc.gotoAndStop(_shell.getLanguageAbbriviation());
        }
        function setupTabIndicies() {
            _removeBtn.tabIndex = 5;
            _diffPenguinBtn.tabIndex = 6;
            super.setupTabIndicies();
        }
        function sendLogin() {
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                savePassForRedemption = true;
                saveUserForRedemption = true;
            }
            com.clubpenguin.login.views.BaseLoginView.debugTrace("sendLogin - expecting onLoginResponse...");
            _trackerAS2.sendToAS3StartAssetLoad("load.selectworld");
            _userNameLoggingIn = _selectedPlayer.Username;
            if (_shell.getLanguageAbbreviation() == "ru") {
                var _local_2 = ((com.clubpenguin.login.views.BaseLoginView.LOGIN_SCREEN_PREFIX + _shell.toTitleCase(_userNameLoggingIn)) + " ") + _shell.getLocalizedString("Logging in");
                _shell.showLoading(_local_2);
            } else {
                _shell.showLoading(((com.clubpenguin.login.views.BaseLoginView.LOGIN_SCREEN_PREFIX + _shell.getLocalizedString("Logging in")) + " ") + _shell.toTitleCase(_userNameLoggingIn));
            }
            if (!_shell.isLoginFloodControlActive) {
                sendLoginCommandToServer();
            }
        }
        function onLoginResponse(success) {
            if (success) {
                _selectedPlayer = undefined;
            }
            super.onLoginResponse(success);
        }
        function removePenguin() {
            com.clubpenguin.login.LocalData.removeFromSavedPlayersByUsername(_selectedPlayer.Username);
            if (com.clubpenguin.login.LocalData.getSavedPlayers().length > 0) {
                com.clubpenguin.login.views.ViewManager(viewManager).gotoPlayerSelection();
            } else {
                com.clubpenguin.login.views.ViewManager(viewManager).gotoStart();
            }
        }
        function show() {
            super.show();
            bg_mc.treasureChest.gotoAndStop("start");
            _shell.trackEvent("unlock:login_en");
        }
        static var LINKAGE_ID = "com.clubpenguin.login.views.PlayerLogin";
        var _originalNicknameYPosition = null;
    }
