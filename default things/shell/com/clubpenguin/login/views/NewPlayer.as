//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.NewPlayer extends com.clubpenguin.login.views.BaseLoginView
    {
        var _trackerAS2, _usernameInputField, username_input, _penguinNameLabel, peng_name_txt, _passwordInputField, password_input, viewManager, _shell, _passwordLabel, pass_text, _penguinPasswordFieldPrompt, peng_pass_prompt_text, _learnMoreField, learn_more_txt, _learnMoreBtn, learn_more_btn, onLearnMoreBtnReleased, _membershipCodeBtn, membership_code_btn, onMembershipCodeBtnReleased, _clubPenguinRulesField, rules_txt, _rulesBtn, rules_btn, _createAccountBtn, create_account_btn, _backBtn, back_btn, _dontHaveAPenguinField, dont_have_txt, _createFreePenguinField, create_txt, _createFreePenguinShadowField, create_txt_light, _backField, back_txt, redemption_badge_mc, _usernameCheckClip, _passwordCheckClip, _loginBtn, _forgotBtn, _userNameLoggingIn, savePassForRedemption, saveUserForRedemption, sendLoginCommandToServer, bg_mc;
        function NewPlayer () {
            super();
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
        }
        function setup(options) {
            super.setup(options);
        }
        function setupRedemption() {
            super.setupRedemption();
            _usernameInputField = username_input;
            _penguinNameLabel = peng_name_txt;
            _passwordInputField = password_input;
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                _usernameInputField.text = _shell.getLocalizedString("w.redemption.login.prompt.name");
                _usernameInputField.onSetFocus = com.clubpenguin.util.Delegate.create(this, onUsernameFocus);
                _passwordLabel = pass_text;
                _passwordLabel.text = _shell.getLocalizedString("Password:");
                _penguinPasswordFieldPrompt = peng_pass_prompt_text;
                _penguinPasswordFieldPrompt.text = _shell.getLocalizedString("w.redemption.login.prompt.password");
                _passwordInputField.onSetFocus = com.clubpenguin.util.Delegate.create(this, onPasswordFocus);
                _learnMoreField = learn_more_txt;
                _learnMoreBtn = learn_more_btn;
                _learnMoreField.text = _shell.getLocalizedString("w.redemption.login.learnMore");
                _learnMoreBtn.onRelease = com.clubpenguin.util.Delegate.create(this, onLearnMoreBtnReleased);
                _membershipCodeBtn = membership_code_btn;
                _membershipCodeBtn.onRelease = com.clubpenguin.util.Delegate.create(this, onMembershipCodeBtnReleased);
                _membershipCodeBtn.gotoAndStop(_shell.getLanguageAbbriviation());
            } else {
                _clubPenguinRulesField = rules_txt;
                _rulesBtn = rules_btn;
            }
            _createAccountBtn = create_account_btn;
            _backBtn = back_btn;
            _dontHaveAPenguinField = dont_have_txt;
            _createFreePenguinField = create_txt;
            _createFreePenguinShadowField = create_txt_light;
            _backField = back_txt;
        }
        function onUsernameFocus() {
            if (_usernameInputField.text.lastIndexOf(_shell.getLocalizedString("w.redemption.login.prompt.name")) > -1) {
                _usernameInputField.text = "";
            }
        }
        function onPasswordFocus() {
            _penguinPasswordFieldPrompt.text = "";
        }
        function setupLocalization() {
            super.setupLocalization();
            _penguinNameLabel.text = _shell.getLocalizedString("Penguin Name:");
            _dontHaveAPenguinField.text = _shell.getLocalizedString("Don't have a penguin?");
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus()) {
                _createFreePenguinField.text = _shell.getLocalizedString("w.redemption.login.createPenguin");
            } else {
                _createFreePenguinField.text = _shell.getLocalizedString("Create a free account now");
            }
            _createFreePenguinShadowField.text = _createFreePenguinField.text;
            _backField.text = _shell.getLocalizedString("Back");
            _clubPenguinRulesField.text = _shell.getLocalizedString("w.login.prompt.rules");
            redemption_badge_mc.gotoAndStop(_shell.getLanguageAbbriviation());
        }
        function setupTabIndicies() {
            _usernameInputField.tabIndex = 0;
            _passwordInputField.tabIndex = 1;
            _usernameCheckClip.tabIndex = 2;
            _passwordCheckClip.tabIndex = 3;
            _loginBtn.tabIndex = 4;
            _forgotBtn.tabIndex = 5;
            _createAccountBtn.tabIndex = 6;
            _clubPenguinRulesField.tabIndex = 7;
            _backBtn.tabIndex = 8;
            Selection.setFocus(_usernameInputField);
            com.clubpenguin.login.Keyboard.setOnEnterFunction(_loginBtn.onRelease);
        }
        function sendLogin() {
            com.clubpenguin.login.views.BaseLoginView.debugTrace("sendLogin - expecting onLoginResponse ...");
            _trackerAS2.sendToAS3StartAssetLoad("load.selectworld");
            _shell.addListener(_shell.ERROR_PROMPT_CLOSED, enableEnterButton, this);
            _userNameLoggingIn = _usernameInputField.text;
            if (com.clubpenguin.login.views.ViewManager(viewManager).getRedemptionStatus() && (com.clubpenguin.login.LocalData.getSavedPlayerByUsername(_userNameLoggingIn) != undefined)) {
                savePassForRedemption = true;
                saveUserForRedemption = true;
            }
            if ((!com.clubpenguin.login.Tools.isValidUsername(_userNameLoggingIn)) || (!com.clubpenguin.login.Tools.isValidPassword(_passwordInputField.text))) {
                return(undefined);
            }
            if (_shell.getLanguageAbbreviation() == "ru") {
                var _local_2 = ((com.clubpenguin.login.views.BaseLoginView.LOGIN_SCREEN_PREFIX + _shell.toTitleCase(_userNameLoggingIn)) + " ") + _shell.getLocalizedString("Logging in");
                _shell.showLoading(_local_2);
            } else {
                _shell.showLoading(((com.clubpenguin.login.views.BaseLoginView.LOGIN_SCREEN_PREFIX + _shell.getLocalizedString("Logging in")) + " ") + _shell.toTitleCase(_userNameLoggingIn));
            }
            if (!_shell.isLoginFloodControlActive) {
                sendLoginCommandToServer();
            }
            disableEnterButton();
        }
        function disableEnterButton() {
            com.clubpenguin.login.Keyboard.setOnEnterFunction(null);
        }
        function enableEnterButton() {
            _shell.removeListener(_shell.ERROR_PROMPT_CLOSED);
            com.clubpenguin.login.Keyboard.setOnEnterFunction(_loginBtn.onRelease);
        }
        function createPenguinRelease() {
            com.clubpenguin.login.views.ViewManager(viewManager).gotoCreatePenguin();
        }
        function rulesRelease() {
            flash.external.ExternalInterface.call("function callRulesPopUp(lang){showRules(lang)}", _shell.getLanguageAbbriviation());
        }
        function backRelease() {
            flash.external.ExternalInterface.call("function callGoBack(){goBack();}", _shell.getLanguageAbbriviation());
        }
        function setInputHandlingState(enabled) {
            super.setInputHandlingState(enabled);
            if (enabled) {
                _backBtn.onRelease = com.clubpenguin.util.Delegate.create(this, backRelease);
                _createAccountBtn.onRelease = com.clubpenguin.util.Delegate.create(this, createPenguinRelease);
                _rulesBtn.onRelease = com.clubpenguin.util.Delegate.create(this, rulesRelease);
            } else {
                _backBtn.onRelease = null;
                _createAccountBtn.onRelease = null;
                _createAccountBtn.onRelease = com.clubpenguin.util.Delegate.create(this, createPenguinRelease);
            }
        }
        function show() {
            super.show();
            bg_mc.treasureChest.gotoAndStop("start");
        }
        static var LINKAGE_ID = "com.clubpenguin.login.views.NewPlayer";
    }
