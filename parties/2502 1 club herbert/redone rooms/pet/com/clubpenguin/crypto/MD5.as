//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.crypto.MD5
    {
        function MD5 () {
        }
        static function hash(_arg_1) {
            return(hex_md5(_arg_1));
        }
        static function utf8Encode(_arg_7) {
            var _local_6 = "";
            var _local_5;
            var _local_4;
            var _local_8 = 0;
            _local_4 = 0;
            _local_5 = _local_4;
            _local_8 = _arg_7.length;
            var _local_3 = 0;
            while (_local_3 < _local_8) {
                var _local_1 = _arg_7.charCodeAt(_local_3);
                var _local_2 = null;
                if (_local_1 < 128) {
                    _local_4++;
                } else if ((_local_1 > 127) && (_local_1 < 2048)) {
                    _local_2 = String.fromCharCode((_local_1 >> 6) | 192) + String.fromCharCode((_local_1 & 63) | 128);
                } else {
                    _local_2 = (String.fromCharCode((_local_1 >> 12) | 224) + String.fromCharCode(((_local_1 >> 6) & 63) | 128)) + String.fromCharCode((_local_1 & 63) | 128);
                }
                if (_local_2 != null) {
                    if (_local_4 > _local_5) {
                        _local_6 = _local_6 + _arg_7.substring(_local_5, _local_4);
                    }
                    _local_6 = _local_6 + _local_2;
                    _local_4 = _local_3 + 1;
                    _local_5 = _local_4;
                }
                _local_3++;
            }
            if (_local_4 > _local_5) {
                _local_6 = _local_6 + _arg_7.substring(_local_5, _arg_7.length);
            }
            return(_local_6);
        }
        static function hex_md5(_arg_1) {
            _arg_1 = utf8Encode(_arg_1);
            return(binl2hex(core_md5(str2binl(_arg_1), _arg_1.length * chrsz)));
        }
        static function b64_md5(_arg_1) {
            return(binl2b64(core_md5(str2binl(_arg_1), _arg_1.length * chrsz)));
        }
        static function str_md5(_arg_1) {
            return(binl2str(core_md5(str2binl(_arg_1), _arg_1.length * chrsz)));
        }
        static function hex_hmac_md5(_arg_1, _arg_2) {
            return(binl2hex(core_hmac_md5(_arg_1, _arg_2)));
        }
        static function b64_hmac_md5(_arg_1, _arg_2) {
            return(binl2b64(core_hmac_md5(_arg_1, _arg_2)));
        }
        static function str_hmac_md5(_arg_1, _arg_2) {
            return(binl2str(core_hmac_md5(_arg_1, _arg_2)));
        }
        static function core_md5(_arg_6, _arg_11) {
            _arg_6[_arg_11 >> 5] = _arg_6[_arg_11 >> 5] | (128 << (_arg_11 % 32));
            _arg_6[(((_arg_11 + 64) >>> 9) << 4) + 14] = _arg_11;
            var _local_4 = 1732584193 /* 0x67452301 */;
            var _local_3 = -271733879;
            var _local_2 = -1732584194;
            var _local_1 = 271733878 /* 0x10325476 */;
            var _local_5 = 0;
            while (_local_5 < _arg_6.length) {
                var _local_10 = _local_4;
                var _local_9 = _local_3;
                var _local_8 = _local_2;
                var _local_7 = _local_1;
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 0], 7, -680876936);
                _local_1 = md5_ff(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 1], 12, -389564586);
                _local_2 = md5_ff(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 2], 17, 606105819);
                _local_3 = md5_ff(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 3], 22, -1044525330);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 4], 7, -176418897);
                _local_1 = md5_ff(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 5], 12, 1200080426);
                _local_2 = md5_ff(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 6], 17, -1473231341);
                _local_3 = md5_ff(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 7], 22, -45705983);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 8], 7, 1770035416);
                _local_1 = md5_ff(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 9], 12, -1958414417);
                _local_2 = md5_ff(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 10], 17, -42063);
                _local_3 = md5_ff(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 11], 22, -1990404162);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 12], 7, 1804603682);
                _local_1 = md5_ff(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 13], 12, -40341101);
                _local_2 = md5_ff(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 14], 17, -1502002290);
                _local_3 = md5_ff(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 15], 22, 1236535329);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 1], 5, -165796510);
                _local_1 = md5_gg(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 6], 9, -1069501632);
                _local_2 = md5_gg(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 11], 14, 643717713);
                _local_3 = md5_gg(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 0], 20, -373897302);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 5], 5, -701558691);
                _local_1 = md5_gg(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 10], 9, 38016083);
                _local_2 = md5_gg(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 15], 14, -660478335);
                _local_3 = md5_gg(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 4], 20, -405537848);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 9], 5, 568446438);
                _local_1 = md5_gg(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 14], 9, -1019803690);
                _local_2 = md5_gg(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 3], 14, -187363961);
                _local_3 = md5_gg(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 8], 20, 1163531501);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 13], 5, -1444681467);
                _local_1 = md5_gg(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 2], 9, -51403784);
                _local_2 = md5_gg(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 7], 14, 1735328473);
                _local_3 = md5_gg(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 12], 20, -1926607734);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 5], 4, -378558);
                _local_1 = md5_hh(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 8], 11, -2022574463);
                _local_2 = md5_hh(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 11], 16, 1839030562);
                _local_3 = md5_hh(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 14], 23, -35309556);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 1], 4, -1530992060);
                _local_1 = md5_hh(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 4], 11, 1272893353);
                _local_2 = md5_hh(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 7], 16, -155497632);
                _local_3 = md5_hh(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 10], 23, -1094730640);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 13], 4, 681279174);
                _local_1 = md5_hh(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 0], 11, -358537222);
                _local_2 = md5_hh(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 3], 16, -722521979);
                _local_3 = md5_hh(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 6], 23, 76029189);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 9], 4, -640364487);
                _local_1 = md5_hh(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 12], 11, -421815835);
                _local_2 = md5_hh(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 15], 16, 530742520);
                _local_3 = md5_hh(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 2], 23, -995338651);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 0], 6, -198630844);
                _local_1 = md5_ii(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 7], 10, 1126891415);
                _local_2 = md5_ii(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 14], 15, -1416354905);
                _local_3 = md5_ii(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 5], 21, -57434055);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 12], 6, 1700485571);
                _local_1 = md5_ii(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 3], 10, -1894986606);
                _local_2 = md5_ii(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 10], 15, -1051523);
                _local_3 = md5_ii(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 1], 21, -2054922799);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 8], 6, 1873313359);
                _local_1 = md5_ii(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 15], 10, -30611744);
                _local_2 = md5_ii(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 6], 15, -1560198380);
                _local_3 = md5_ii(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 13], 21, 1309151649);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_1, _arg_6[_local_5 + 4], 6, -145523070);
                _local_1 = md5_ii(_local_1, _local_4, _local_3, _local_2, _arg_6[_local_5 + 11], 10, -1120210379);
                _local_2 = md5_ii(_local_2, _local_1, _local_4, _local_3, _arg_6[_local_5 + 2], 15, 718787259);
                _local_3 = md5_ii(_local_3, _local_2, _local_1, _local_4, _arg_6[_local_5 + 9], 21, -343485551);
                _local_4 = safe_add(_local_4, _local_10);
                _local_3 = safe_add(_local_3, _local_9);
                _local_2 = safe_add(_local_2, _local_8);
                _local_1 = safe_add(_local_1, _local_7);
                _local_5 = _local_5 + 16;
            }
            return(new Array(_local_4, _local_3, _local_2, _local_1));
        }
        static function md5_cmn(_arg_5, _arg_4, _arg_2, _arg_6, _arg_3, _arg_1) {
            return(safe_add(bit_rol(safe_add(safe_add(_arg_4, _arg_5), safe_add(_arg_6, _arg_1)), _arg_3), _arg_2));
        }
        static function md5_ff(_arg_6, _arg_1, _arg_3, _arg_2, _arg_7, _arg_5, _arg_4) {
            return(md5_cmn((_arg_1 & _arg_3) | ((~_arg_1) & _arg_2), _arg_6, _arg_1, _arg_7, _arg_5, _arg_4));
        }
        static function md5_gg(_arg_6, _arg_2, _arg_3, _arg_1, _arg_7, _arg_5, _arg_4) {
            return(md5_cmn((_arg_2 & _arg_1) | (_arg_3 & (~_arg_1)), _arg_6, _arg_2, _arg_7, _arg_5, _arg_4));
        }
        static function md5_hh(_arg_6, _arg_1, _arg_3, _arg_2, _arg_7, _arg_5, _arg_4) {
            return(md5_cmn((_arg_1 ^ _arg_3) ^ _arg_2, _arg_6, _arg_1, _arg_7, _arg_5, _arg_4));
        }
        static function md5_ii(_arg_6, _arg_1, _arg_3, _arg_2, _arg_7, _arg_5, _arg_4) {
            return(md5_cmn(_arg_3 ^ (_arg_1 | (~_arg_2)), _arg_6, _arg_1, _arg_7, _arg_5, _arg_4));
        }
        static function core_hmac_md5(_arg_6, _arg_7) {
            var _local_2 = str2binl(_arg_6);
            if (_local_2.length > 16) {
                _local_2 = core_md5(_local_2, _arg_6.length * chrsz);
            }
            var _local_3 = Array(16);
            var _local_4 = Array(16);
            var _local_1 = 0;
            while (_local_1 < 16) {
                _local_3[_local_1] = _local_2[_local_1] ^ 909522486;
                _local_4[_local_1] = _local_2[_local_1] ^ 1549556828;
                _local_1++;
            }
            var _local_5 = core_md5(_local_3.concat(str2binl(_arg_7)), 512 + (_arg_7.length * chrsz));
            return(core_md5(_local_4.concat(_local_5), 640));
        }
        static function safe_add(_arg_4, _arg_3) {
            var _local_1 = (_arg_4 & 65535) + (_arg_3 & 65535);
            var _local_2 = ((_arg_4 >> 16) + (_arg_3 >> 16)) + (_local_1 >> 16);
            return((_local_2 << 16) | (_local_1 & 65535));
        }
        static function bit_rol(_arg_1, _arg_2) {
            return((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2)));
        }
        static function str2binl(_arg_2) {
            var _local_3 = new Array();
            var _local_4 = (1 << chrsz) - 1;
            var _local_1 = 0;
            while (_local_1 < (_arg_2.length * chrsz)) {
                _local_3[_local_1 >> 5] = _local_3[_local_1 >> 5] | ((_arg_2.charCodeAt(_local_1 / chrsz) & _local_4) << (_local_1 % 32));
                _local_1 = _local_1 + chrsz;
            }
            return(_local_3);
        }
        static function binl2str(_arg_2) {
            var _local_3 = "";
            var _local_4 = (1 << chrsz) - 1;
            var _local_1 = 0;
            while (_local_1 < (_arg_2.length * 32)) {
                _local_3 = _local_3 + String.fromCharCode((_arg_2[_local_1 >> 5] >>> (_local_1 % 32)) & _local_4);
                _local_1 = _local_1 + chrsz;
            }
            return(_local_3);
        }
        static function binl2hex(_arg_2) {
            var _local_3 = (hexcase ? "0123456789ABCDEF" : "0123456789abcdef");
            var _local_4 = "";
            var _local_1 = 0;
            while (_local_1 < (_arg_2.length * 4)) {
                _local_4 = _local_4 + (_local_3.charAt((_arg_2[_local_1 >> 2] >> (((_local_1 % 4) * 8) + 4)) & 15) + _local_3.charAt((_arg_2[_local_1 >> 2] >> ((_local_1 % 4) * 8)) & 15));
                _local_1++;
            }
            return(_local_4);
        }
        static function binl2b64(_arg_3) {
            var _local_6 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var _local_4 = "";
            var _local_2 = 0;
            while (_local_2 < (_arg_3.length * 4)) {
                var _local_5 = ((((_arg_3[_local_2 >> 2] >> (8 * (_local_2 % 4))) & 255) << 16) | (((_arg_3[(_local_2 + 1) >> 2] >> (8 * ((_local_2 + 1) % 4))) & 255) << 8)) | ((_arg_3[(_local_2 + 2) >> 2] >> (8 * ((_local_2 + 2) % 4))) & 255);
                var _local_1 = 0;
                while (_local_1 < 4) {
                    if (((_local_2 * 8) + (_local_1 * 6)) > (_arg_3.length * 32)) {
                        _local_4 = _local_4 + b64pad;
                    } else {
                        _local_4 = _local_4 + _local_6.charAt((_local_5 >> (6 * (3 - _local_1))) & 63);
                    }
                    _local_1++;
                }
                _local_2 = _local_2 + 3;
            }
            return(_local_4);
        }
        static var hexcase = 0;
        static var b64pad = "";
        static var chrsz = 8;
    }
