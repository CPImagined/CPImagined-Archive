//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.BaseLoginView extends com.clubpenguin.ui.views.AbstractView
    {
        var _trackerAS2, _continueLoginDelegate, _backgroundClip, bg_mc, _passwordInputField, password_input, _passwordCheckClip, password_check, _usernameCheckClip, username_check, _loginBtn, login_btn, _forgotBtn, forgot_btn, _closeButton, close_btn, _passwordField, pass_txt, _rememberPenguinField, remember_peng_txt, _rememberPasswordField, remember_pass_txt, _signInField, sign_in_txt, _signInFieldShadow, sign_in_txt_light, _forgotPasswordField, forgot_pass_txt, _passwordNoteClip, note_mc, _contentTracked, _opcodeJournal, _shell, viewManager, getURL, gotoAndStop, _prompt, _parent, _userNameLoggingIn, rosterTimeoutID;
        function BaseLoginView () {
            super();
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            _continueLoginDelegate = com.clubpenguin.util.Delegate.create(this, sendLoginCommandToServer);
        }
        function setup(options) {
            debugTrace("setup");
            setupRedemption();
            _backgroundClip = bg_mc;
            _passwordInputField = password_input;
            _passwordCheckClip = password_check;
            _usernameCheckClip = username_check;
            _loginBtn = login_btn;
            _forgotBtn = forgot_btn;
            _closeButton = close_btn;
            _closeButton.onRelease = com.clubpenguin.util.Delegate.create(this, handleCloseButtonRelease);
            _passwordField = pass_txt;
            _rememberPenguinField = remember_peng_txt;
            _rememberPasswordField = remember_pass_txt;
            _signInField = sign_in_txt;
            _signInFieldShadow = sign_in_txt_light;
            _forgotPasswordField = forgot_pass_txt;
            _passwordNoteClip = note_mc;
            setInputHandlingState(true);
            _contentTracked = false;
            _opcodeJournal = new com.clubpenguin.login.OpcodeJournal();
            setupLocalization();
            setupTabIndicies();
            _shell.AIRTOWER.addListener(_shell.AIRTOWER.MOBILE_ACCOUNT_ACTIVATION_REQUIRED, com.clubpenguin.util.Delegate.create(this, handleMobileAccountActivation));
            _shell.addListener(_shell.CONTINUE_LOGIN, _continueLoginDelegate);
        }
        function show() {
            super.show();
            if (!_contentTracked) {
                _contentTracked = true;
                if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                    _shell.trackEvent("unlock:login");
                } else {
                    _shell.trackEvent("login_page_reached");
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
        function onLearnMoreBtnReleased() {
            this.getURL(_shell.getPath("member_web"), "_self");
        }
        function handleCloseButtonRelease() {
            com.clubpenguin.login.views.ViewManager(viewManager).setRedemptionStatus(false);
            com.clubpenguin.login.views.ViewManager(viewManager).gotoLogin();
        }
        function playerRememberUsername() {
            var _local_2 = com.clubpenguin.login.Tools.makeCheckboxToggle(_usernameCheckClip);
            _usernameCheckClip.active = _local_2;
            if (!_usernameCheckClip.active) {
                if (_passwordCheckClip.active) {
                    _passwordCheckClip.gotoAndStop(1);
                    _passwordCheckClip.active = false;
                }
            }
        }
        function setRedemptionForPlayerSelection() {
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                this.gotoAndStop("redemption");
            } else {
                this.gotoAndStop("regular");
            }
        }
        function setInputHandlingState(enabled) {
            if (enabled) {
                _loginBtn.onRelease = com.clubpenguin.util.Delegate.create(this, sendLogin);
                _passwordCheckClip.onRelease = com.clubpenguin.util.Delegate.create(this, playerRememberPassword);
                _usernameCheckClip.onRelease = com.clubpenguin.util.Delegate.create(this, playerRememberUsername);
                _forgotBtn.onRelease = com.clubpenguin.util.Delegate.create(this, forgotPassword);
            } else {
                _loginBtn.onRelease = null;
                _passwordCheckClip.onRelease = null;
                _usernameCheckClip.onRelease = null;
                _forgotBtn.onRelease = null;
            }
        }
        function playerRememberPassword() {
            if (!_passwordCheckClip.active) {
                _shell.trackEvent("login_save_password_selected");
                _prompt = _parent.attachMovie("PublicComputerPrompt", "prompt", _parent.getNextHighestDepth());
                _prompt.yes_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onIsPublicComputer);
                _prompt.no_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onIsPrivateComputer);
                _prompt.txMessage.text = _shell.getLocalizedString("public_computer_prompt_msg");
                _prompt.yes_txt.text = _shell.getLocalizedString("Yes");
                _prompt.no_txt.text = _shell.getLocalizedString("No");
                _prompt.blocker_mc.tabEnabled = false;
                _prompt.blocker_mc.onPress = null;
                _prompt.blocker_mc.useHandCursor = false;
            } else {
                _passwordCheckClip.active = com.clubpenguin.login.Tools.makeCheckboxToggle(_passwordCheckClip);
            }
        }
        function onIsPublicComputer() {
            _prompt.removeMovieClip();
            showSavePasswordPrompt();
        }
        function onIsPrivateComputer() {
            _prompt.removeMovieClip();
            showSavePasswordPrompt();
        }
        function showSavePasswordPrompt() {
            _prompt = _parent.attachMovie("SavePasswordPrompt", "prompt", _parent.getNextHighestDepth());
            _prompt.save_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onAcceptSavePassword);
            _prompt.nosave_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onDeclineSavePassword);
            _prompt.close_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onDeclineSavePassword);
            _prompt.learnmore_btn.onRelease = com.clubpenguin.util.Delegate.create(this, onSavePasswordLearnMore);
            _prompt.save_txt.text = "measure";
            var _local_2 = _prompt.save_txt.textHeight;
            _prompt.save_txt.text = _shell.getLocalizedString("save_password");
            if (_prompt.save_txt.textHeight > (_local_2 + (MULTI_LINE_SPACING / 2))) {
                _prompt.save_txt._y = _prompt.save_txt._y - MULTI_LINE_SPACING;
            }
            _prompt.nosave_txt.text = _shell.getLocalizedString("dont_save_password");
            if (_prompt.nosave_txt.textHeight > (_local_2 + (MULTI_LINE_SPACING / 2))) {
                _prompt.nosave_txt._y = _prompt.nosave_txt._y - MULTI_LINE_SPACING;
            }
            _prompt.learnmore_txt.text = _shell.getLocalizedString("learn_more");
            _prompt.message_txt.text = _shell.getLocalizedString("save_password_warning_msg");
            _prompt.messageShadow_txt.text = _prompt.message_txt.text;
            _prompt.msg1_txt.text = _shell.getLocalizedString("player_safety_lose_coins");
            _prompt.msg2_txt.text = _shell.getLocalizedString("player_safety_changed_igloo");
            _prompt.msg3_txt.text = _shell.getLocalizedString("player_safety_banned");
            _prompt.blocker_mc.tabEnabled = false;
            _prompt.blocker_mc.onPress = null;
            _prompt.blocker_mc.useHandCursor = false;
        }
        function onSavePasswordLearnMore() {
            _shell.trackEvent("login_save_password_more_info_selected");
            this.getURL(_shell.getPath("player_safety"));
        }
        function onAcceptSavePassword() {
            _shell.trackEvent("login_save_password_prompt_accepted");
            var _local_2 = com.clubpenguin.login.Tools.makeCheckboxToggle(_passwordCheckClip);
            _passwordCheckClip.active = _local_2;
            if (!_usernameCheckClip.active) {
                _usernameCheckClip.onRelease();
            }
            _prompt.removeMovieClip();
        }
        function onDeclineSavePassword() {
            _shell.trackEvent("login_save_password_prompt_declined");
            _prompt.removeMovieClip();
        }
        function setupRedemption() {
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                this.gotoAndStop("redemption");
            }
        }
        function setLanguageAbbr(abbr) {
            super.setLanguageAbbr(abbr);
        }
        function setupLocalization() {
            _passwordField.text = _shell.getLocalizedString("Password:");
            _rememberPenguinField.text = _shell.getLocalizedString("Remember me on this computer");
            _rememberPasswordField.text = _shell.getLocalizedString("Remember my password");
            _signInField.text = _shell.getLocalizedString("Login");
            _signInFieldShadow.text = _shell.getLocalizedString("Login");
            _forgotPasswordField.text = _shell.getLocalizedString("Forgot your password?");
            var _local_2 = _shell.getLocalizedFrame();
            _passwordNoteClip.gotoAndStop(_local_2);
        }
        function setupTabIndicies() {
            _passwordInputField.tabIndex = 0;
            _usernameCheckClip.tabIndex = 1;
            _passwordCheckClip.tabIndex = 2;
            _loginBtn.tabIndex = 3;
            _forgotBtn.tabIndex = 4;
            if (!_shell.isValidString(_passwordInputField.text)) {
                Selection.setFocus(_passwordInputField);
            }
            com.clubpenguin.login.Keyboard.setOnEnterFunction(_loginBtn.onRelease);
        }
        function sendLogin() {
        }
        function sendLoginCommandToServer() {
            _shell.sendLogin(_userNameLoggingIn, _passwordInputField.text, com.clubpenguin.util.Delegate.create(this, onLoginResponse));
        }
        function onLoginResponse(success) {
            debugTrace("onLoginResponse - " + success);
            if (success) {
                rosterTimeoutID = setTimeout(_shell.hideLoading, FRIENDS_ROSTER_FETCH_DELAY);
                var _local_2 = {};
                _local_2.Username = _userNameLoggingIn.toLowerCase();
                _local_2.Password = _passwordInputField.text;
                _local_2.isRememberUsername = savePassForRedemption || (_usernameCheckClip.active);
                _local_2.isRememberPassword = saveUserForRedemption || (_passwordCheckClip.active);
                com.clubpenguin.login.LocalData.setLoginPlayerObjectToSave(_local_2);
                com.clubpenguin.login.LocalData.saveNicknameToCookie(_local_2.Username);
                if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                    com.clubpenguin.login.Keyboard.clearOnEnterFunction();
                    _shell.gotoState(_shell.MERCH_STATE);
                }
                var _local_3 = _shell.getMyPlayerId();
                if (_local_3 == undefined) {
                    _local_3 = -1;
                }
                _shell.connectToFriends(_shell.getMyPlayerObject(), _shell.isPlayerMascotById(_local_3));
                com.clubpenguin.login.views.ViewManager(viewManager).gotoWorldSelection();
                _shell.sendMyPlayerData(_shell.getMyPlayerObject());
                _opcodeJournal.init(_local_3);
                _opcodeJournal.sendEventAction();
                _trackerAS2.startTracker();
            } else {
                var _local_4 = String(flash.external.ExternalInterface.call("window.navigator.userAgent.toString"));
                if ((_local_4.indexOf("Chrome") != -1) && (_local_4.indexOf("Macintosh") != -1)) {
                    _shell.$e("onLoginResponse() -> Login Failed", {error_code:_shell.CHROME_MAC_LOGIN_ERROR});
                } else {
                    _shell.$e("onLoginResponse() -> Login Failed", {error_code:_shell.NO_SOCKET_CONNECTION});
                }
            }
        }
        function forgotPassword() {
            this.getURL(_shell.getPath("forgot_password_web") + com.clubpenguin.login.Tools.getTrackingAppend());
        }
        static function debugTrace(msg) {
            if (debugTracesActive) {
            }
        }
        function handleMobileAccountActivation(serverResponse) {
            var _local_5 = serverResponse[0];
            var _local_3 = serverResponse[1];
            var _local_2 = new Object();
            _local_2.emailAddress = _local_3;
            _local_2.userName = _userNameLoggingIn;
            _local_2.password = _passwordInputField.text;
            com.clubpenguin.login.Keyboard.setOnEnterFunction(null);
            _shell.hideLoading();
            _shell.sendOpenAS3Module("mobile_account_activation", _local_2);
        }
        function setShell(target) {
            super.setShell(target);
            _shell.ROSTER.updated.add(onRosterUpdated, this);
        }
        function onRosterUpdated(numBuddies) {
            if (numBuddies > 0) {
                clearTimeout(rosterTimeoutID);
                _shell.hideLoading();
                _shell.ROSTER.updated.remove(onRosterUpdated, this);
            }
        }
        static var FRIENDS_ROSTER_FETCH_DELAY = 0;
        static var LOGIN_SCREEN_PREFIX = "loginScreenPrefix#";
        static var LINKAGE_ID = "";
        static var MULTI_LINE_SPACING = 6;
        static var debugTracesActive = true;
        var savePassForRedemption = false;
        var saveUserForRedemption = false;
    }
