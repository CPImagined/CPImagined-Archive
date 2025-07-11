﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.dlearning.security.Md5
    {
        function Md5 (_arg_3, _arg_2) {
            if (_arg_3 != undefined) {
                b64pad = _arg_3;
            }
            if (((_arg_2 != undefined) && (_arg_2 == 8)) || (_arg_2 == 16)) {
                chrsz = _arg_2;
            }
        }
        function hash(_arg_2) {
            return(hex_md5(_arg_2));
        }
        function hex_md5(_arg_2) {
            return(binl2hex(core_md5(str2binl(_arg_2), _arg_2.length * chrsz)));
        }
        function b64_md5(_arg_2) {
            return(binl2b64(core_md5(str2binl(_arg_2), _arg_2.length * chrsz)));
        }
        function str_md5(_arg_2) {
            return(binl2str(core_md5(str2binl(_arg_2), _arg_2.length * chrsz)));
        }
        function hex_hmac_md5(_arg_2, _arg_3) {
            return(binl2hex(core_hmac_md5(_arg_2, _arg_3)));
        }
        function b64_hmac_md5(_arg_2, _arg_3) {
            return(binl2b64(core_hmac_md5(_arg_2, _arg_3)));
        }
        function str_hmac_md5(_arg_2, _arg_3) {
            return(binl2str(core_hmac_md5(_arg_2, _arg_3)));
        }
        function md5_cmn(_arg_6, _arg_5, _arg_3, _arg_7, _arg_4, _arg_2) {
            return(safe_add(bit_rol(safe_add(safe_add(_arg_5, _arg_6), safe_add(_arg_7, _arg_2)), _arg_4), _arg_3));
        }
        function md5_ff(_arg_7, _arg_2, _arg_4, _arg_3, _arg_8, _arg_6, _arg_5) {
            return(md5_cmn((_arg_2 & _arg_4) | ((~_arg_2) & _arg_3), _arg_7, _arg_2, _arg_8, _arg_6, _arg_5));
        }
        function md5_gg(_arg_7, _arg_3, _arg_4, _arg_2, _arg_8, _arg_6, _arg_5) {
            return(md5_cmn((_arg_3 & _arg_2) | (_arg_4 & (~_arg_2)), _arg_7, _arg_3, _arg_8, _arg_6, _arg_5));
        }
        function md5_hh(_arg_7, _arg_2, _arg_4, _arg_3, _arg_8, _arg_6, _arg_5) {
            return(md5_cmn((_arg_2 ^ _arg_4) ^ _arg_3, _arg_7, _arg_2, _arg_8, _arg_6, _arg_5));
        }
        function md5_ii(_arg_7, _arg_2, _arg_4, _arg_3, _arg_8, _arg_6, _arg_5) {
            return(md5_cmn(_arg_4 ^ (_arg_2 | (~_arg_3)), _arg_7, _arg_2, _arg_8, _arg_6, _arg_5));
        }
        function core_md5(_arg_7, _arg_12) {
            _arg_7[_arg_12 >> 5] = _arg_7[_arg_12 >> 5] | (128 << (_arg_12 % 32));
            _arg_7[(((_arg_12 + 64) >>> 9) << 4) + 14] = _arg_12;
            var _local_5 = 1732584193 /* 0x67452301 */;
            var _local_4 = -271733879;
            var _local_3 = -1732584194;
            var _local_2 = 271733878 /* 0x10325476 */;
            var _local_6 = 0;
            while (_local_6 < _arg_7.length) {
                var _local_11 = _local_5;
                var _local_10 = _local_4;
                var _local_9 = _local_3;
                var _local_8 = _local_2;
                _local_5 = md5_ff(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 0], 7, -680876936);
                _local_2 = md5_ff(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 1], 12, -389564586);
                _local_3 = md5_ff(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 2], 17, 606105819);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 3], 22, -1044525330);
                _local_5 = md5_ff(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 4], 7, -176418897);
                _local_2 = md5_ff(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 5], 12, 1200080426);
                _local_3 = md5_ff(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 6], 17, -1473231341);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 7], 22, -45705983);
                _local_5 = md5_ff(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 8], 7, 1770035416);
                _local_2 = md5_ff(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 9], 12, -1958414417);
                _local_3 = md5_ff(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 10], 17, -42063);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 11], 22, -1990404162);
                _local_5 = md5_ff(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 12], 7, 1804603682);
                _local_2 = md5_ff(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 13], 12, -40341101);
                _local_3 = md5_ff(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 14], 17, -1502002290);
                _local_4 = md5_ff(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 15], 22, 1236535329);
                _local_5 = md5_gg(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 1], 5, -165796510);
                _local_2 = md5_gg(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 6], 9, -1069501632);
                _local_3 = md5_gg(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 11], 14, 643717713);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 0], 20, -373897302);
                _local_5 = md5_gg(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 5], 5, -701558691);
                _local_2 = md5_gg(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 10], 9, 38016083);
                _local_3 = md5_gg(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 15], 14, -660478335);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 4], 20, -405537848);
                _local_5 = md5_gg(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 9], 5, 568446438);
                _local_2 = md5_gg(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 14], 9, -1019803690);
                _local_3 = md5_gg(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 3], 14, -187363961);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 8], 20, 1163531501);
                _local_5 = md5_gg(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 13], 5, -1444681467);
                _local_2 = md5_gg(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 2], 9, -51403784);
                _local_3 = md5_gg(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 7], 14, 1735328473);
                _local_4 = md5_gg(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 12], 20, -1926607734);
                _local_5 = md5_hh(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 5], 4, -378558);
                _local_2 = md5_hh(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 8], 11, -2022574463);
                _local_3 = md5_hh(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 11], 16, 1839030562);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 14], 23, -35309556);
                _local_5 = md5_hh(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 1], 4, -1530992060);
                _local_2 = md5_hh(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 4], 11, 1272893353);
                _local_3 = md5_hh(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 7], 16, -155497632);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 10], 23, -1094730640);
                _local_5 = md5_hh(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 13], 4, 681279174);
                _local_2 = md5_hh(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 0], 11, -358537222);
                _local_3 = md5_hh(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 3], 16, -722521979);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 6], 23, 76029189);
                _local_5 = md5_hh(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 9], 4, -640364487);
                _local_2 = md5_hh(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 12], 11, -421815835);
                _local_3 = md5_hh(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 15], 16, 530742520);
                _local_4 = md5_hh(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 2], 23, -995338651);
                _local_5 = md5_ii(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 0], 6, -198630844);
                _local_2 = md5_ii(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 7], 10, 1126891415);
                _local_3 = md5_ii(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 14], 15, -1416354905);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 5], 21, -57434055);
                _local_5 = md5_ii(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 12], 6, 1700485571);
                _local_2 = md5_ii(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 3], 10, -1894986606);
                _local_3 = md5_ii(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 10], 15, -1051523);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 1], 21, -2054922799);
                _local_5 = md5_ii(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 8], 6, 1873313359);
                _local_2 = md5_ii(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 15], 10, -30611744);
                _local_3 = md5_ii(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 6], 15, -1560198380);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 13], 21, 1309151649);
                _local_5 = md5_ii(_local_5, _local_4, _local_3, _local_2, _arg_7[_local_6 + 4], 6, -145523070);
                _local_2 = md5_ii(_local_2, _local_5, _local_4, _local_3, _arg_7[_local_6 + 11], 10, -1120210379);
                _local_3 = md5_ii(_local_3, _local_2, _local_5, _local_4, _arg_7[_local_6 + 2], 15, 718787259);
                _local_4 = md5_ii(_local_4, _local_3, _local_2, _local_5, _arg_7[_local_6 + 9], 21, -343485551);
                _local_5 = safe_add(_local_5, _local_11);
                _local_4 = safe_add(_local_4, _local_10);
                _local_3 = safe_add(_local_3, _local_9);
                _local_2 = safe_add(_local_2, _local_8);
                _local_6 = _local_6 + 16;
            }
            var _local_13 = new Array(_local_5, _local_4, _local_3, _local_2);
            return(_local_13);
        }
        function core_hmac_md5(_arg_7, _arg_8) {
            var _local_3 = new Array(str2binl(_arg_7));
            if (_local_3.length > 16) {
                _local_3 = core_md5(_local_3, _arg_7.length * chrsz);
            }
            var _local_4 = new Array(16);
            var _local_5 = new Array(16);
            var _local_2 = 0;
            while (_local_2 < 16) {
                _local_4[_local_2] = _local_3[_local_2] ^ 909522486;
                _local_5[_local_2] = _local_3[_local_2] ^ 1549556828;
                _local_2++;
            }
            var _local_6 = new Array(core_md5(_local_4.concat(str2binl(_arg_8)), 512 + (_arg_8.length * chrsz)));
            return(core_md5(_local_5.concat(_local_6), 640));
        }
        function safe_add(_arg_4, _arg_3) {
            var _local_1 = new Number((_arg_4 & 65535) + (_arg_3 & 65535));
            var _local_2 = new Number(((_arg_4 >> 16) + (_arg_3 >> 16)) + (_local_1 >> 16));
            return((_local_2 << 16) | (_local_1 & 65535));
        }
        function bit_rol(_arg_1, _arg_2) {
            return((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2)));
        }
        function str2binl(_arg_3) {
            var _local_4 = new Array();
            var _local_5 = (1 << chrsz) - 1;
            var _local_2 = 0;
            while (_local_2 < (_arg_3.length * chrsz)) {
                _local_4[_local_2 >> 5] = _local_4[_local_2 >> 5] | ((_arg_3.charCodeAt(_local_2 / chrsz) & _local_5) << (_local_2 % 32));
                _local_2 = _local_2 + chrsz;
            }
            return(_local_4);
        }
        function binl2str(_arg_3) {
            var _local_4 = new String("");
            var _local_5 = (1 << chrsz) - 1;
            var _local_2 = 0;
            while (_local_2 < (_arg_3.length * 32)) {
                _local_4 = _local_4 + String.fromCharCode((_arg_3[_local_2 >> 5] >>> (_local_2 % 32)) & _local_5);
                _local_2 = _local_2 + chrsz;
            }
            return(_local_4);
        }
        function binl2hex(_arg_2) {
            var _local_3 = "0123456789abcdef";
            var _local_4 = new String("");
            var _local_1 = 0;
            while (_local_1 < (_arg_2.length * 4)) {
                _local_4 = _local_4 + (_local_3.charAt((_arg_2[_local_1 >> 2] >> (((_local_1 % 4) * 8) + 4)) & 15) + _local_3.charAt((_arg_2[_local_1 >> 2] >> ((_local_1 % 4) * 8)) & 15));
                _local_1++;
            }
            return(_local_4);
        }
        function binl2b64(_arg_4) {
            var _local_7 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var _local_5 = new String("");
            var _local_3 = 0;
            while (_local_3 < (_arg_4.length * 4)) {
                var _local_6 = ((((_arg_4[_local_3 >> 2] >> (8 * (_local_3 % 4))) & 255) << 16) | (((_arg_4[(_local_3 + 1) >> 2] >> (8 * ((_local_3 + 1) % 4))) & 255) << 8)) | ((_arg_4[(_local_3 + 2) >> 2] >> (8 * ((_local_3 + 2) % 4))) & 255);
                var _local_2 = 0;
                while (_local_2 < 4) {
                    if (((_local_3 * 8) + (_local_2 * 6)) > (_arg_4.length * 32)) {
                        _local_5 = _local_5 + b64pad;
                    } else {
                        _local_5 = _local_5 + _local_7.charAt((_local_6 >> (6 * (3 - _local_2))) & 63);
                    }
                    _local_2++;
                }
                _local_3 = _local_3 + 3;
            }
            return(_local_5);
        }
        var b64pad = new String("");
        var chrsz = new Number(8);
    }
