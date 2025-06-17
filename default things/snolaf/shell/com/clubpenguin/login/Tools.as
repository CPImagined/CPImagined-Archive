//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.Tools
    {
        function Tools () {
        }
        static function isValidPassword(pass) {
            var _local_2 = _global.getCurrentShell();
            pass = String(pass);
            var _local_3 = pass.length;
            if (!_local_2.isValidString(pass)) {
                if (_local_2.redemptionActive) {
                    _local_2.$e("[login] isValidPassword() -> No password passed to login", {error_code:_local_2.PASSWORD_REQUIRED_REDEMPTION});
                } else {
                    _local_2.$e("[login] isValidPassword() -> No password passed to login", {error_code:_local_2.PASSWORD_REQUIRED});
                }
                return(false);
            }
            if (_local_3 < MIN_PASS_LENGTH) {
                if (_local_2.redemptionActive) {
                    _local_2.$e("[login] isValidPassword() -> Password too short", {error_code:_local_2.PASSWORD_SHORT_REDEMPTION});
                } else {
                    _local_2.$e("[login] isValidPassword() -> Password too short", {error_code:_local_2.PASSWORD_SHORT});
                }
                return(false);
            }
            if (_local_3 > MAX_PASS_LENGTH) {
                _local_2.$e("[login] isValidPassword() -> Password too long", {error_code:_local_2.PASSWORD_LONG});
                return(false);
            }
            return(true);
        }
        static function isValidUsername(username) {
            var _local_2 = _global.getCurrentShell();
            username = String(username);
            var _local_4 = username.length;
            if ((!_local_2.isValidString(username)) || (username == _local_2.getLocalizedString("w.redemption.login.prompt.name"))) {
                if (_local_2.redemptionActive) {
                    _local_2.$e("[login] isValidUsername() -> No username passed to login to redemption", {error_code:_local_2.NAME_REQUIRED_REDEMPTION});
                } else {
                    _local_2.$e("[login] isValidUsername() -> No username passed to login", {error_code:_local_2.NAME_REQUIRED});
                }
                return(false);
            }
            if (_local_4 < MIN_USERNAME_LENGTH) {
                if (_local_2.redemptionActive) {
                    _local_2.$e("[login] isValidUsername() -> Username too short for redemption", {error_code:_local_2.NAME_SHORT_REDEMPTION});
                } else {
                    _local_2.$e("[login] isValidUsername() -> Username too short", {error_code:_local_2.NAME_SHORT});
                }
                return(false);
            }
            if (_local_4 > MAX_USERNAME_LENGTH) {
                _local_2.$e("[login] isValidUsername() -> Username too long", {error_code:_local_2.NAME_LONG});
                return(false);
            }
            return(true);
        }
        static function getTrackingAppend() {
            var _local_3 = _global.getCurrentShell();
            var _local_4 = _local_3.getLanguageAbbriviation();
            var _local_2 = "";
            if (_local_3.getAffilateId() != 1) {
                _local_2 = "?playhome_" + _local_4;
            }
            return(_local_2);
        }
        static function makeCheckboxToggle(mc) {
            if (mc._currentframe == mc._totalframes) {
                mc.gotoAndStop(1);
                return(false);
            }
            mc.gotoAndStop(mc._totalframes);
            return(true);
        }
        static function ResizeTextToFit(txt, adjustFromOrigin) {
            if (txt.maxscroll > 1) {
                var _local_4 = txt.text;
                txt.text = "A";
                var _local_3 = txt.textHeight;
                txt.text = _local_4;
                while (txt.maxscroll > 1) {
                    var _local_2 = txt.getTextFormat();
                    _local_2.size--;
                    txt.setTextFormat(_local_2);
                }
                if (adjustFromOrigin == true) {
                    txt._y = _local_3 - txt.textHeight;
                } else {
                    txt._y = txt._y + (_local_3 - txt.textHeight);
                }
            }
        }
        static var MIN_PASS_LENGTH = 4;
        static var MAX_PASS_LENGTH = 32;
        static var MIN_USERNAME_LENGTH = 4;
        static var MAX_USERNAME_LENGTH = 12;
    }
