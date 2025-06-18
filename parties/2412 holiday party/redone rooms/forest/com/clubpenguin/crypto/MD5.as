//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.crypto.MD5
    {
        function MD5 () {
        }
        static function hash(str) {
            return(hex_md5(str));
        }
        static function utf8Encode(string) {
            var utftext = "";
            var start;
            var end;
            var stringl = 0;
            start = (end = 0);
            stringl = string.length;
            var n = 0;
            while (n < stringl) {
                var c1 = string.charCodeAt(n);
                var enc = null;
                if (c1 < 128) {
                    end++;
                } else if ((c1 > 127) && (c1 < 2048)) {
                    enc = String.fromCharCode((c1 >> 6) | 192) + String.fromCharCode((c1 & 63) | 128);
                } else {
                    enc = (String.fromCharCode((c1 >> 12) | 224) + String.fromCharCode(((c1 >> 6) & 63) | 128)) + String.fromCharCode((c1 & 63) | 128);
                }
                if (enc != null) {
                    if (end > start) {
                        utftext = utftext + string.substring(start, end);
                    }
                    utftext = utftext + enc;
                    start = (end = n + 1);
                }
                n++;
            }
            if (end > start) {
                utftext = utftext + string.substring(start, string.length);
            }
            return(utftext);
        }
        static function hex_md5(s) {
            s = utf8Encode(s);
            return(binl2hex(core_md5(str2binl(s), s.length * chrsz)));
        }
        static function b64_md5(s) {
            return(binl2b64(core_md5(str2binl(s), s.length * chrsz)));
        }
        static function str_md5(s) {
            return(binl2str(core_md5(str2binl(s), s.length * chrsz)));
        }
        static function hex_hmac_md5(key, data) {
            return(binl2hex(core_hmac_md5(key, data)));
        }
        static function b64_hmac_md5(key, data) {
            return(binl2b64(core_hmac_md5(key, data)));
        }
        static function str_hmac_md5(key, data) {
            return(binl2str(core_hmac_md5(key, data)));
        }
        static function core_md5(x, len) {
            x[len >> 5] = x[len >> 5] | (128 << (len % 32));
            x[(((len + 64) >>> 9) << 4) + 14] = len;
            var a = 1732584193;
            var b = -271733879;
            var c = -1732584194;
            var d = 271733878;
            var i = 0;
            while (i < x.length) {
                var olda = a;
                var oldb = b;
                var oldc = c;
                var oldd = d;
                a = md5_ff(a, b, c, d, x[i + 0], 7, -680876936);
                d = md5_ff(d, a, b, c, x[i + 1], 12, -389564586);
                c = md5_ff(c, d, a, b, x[i + 2], 17, 606105819);
                b = md5_ff(b, c, d, a, x[i + 3], 22, -1044525330);
                a = md5_ff(a, b, c, d, x[i + 4], 7, -176418897);
                d = md5_ff(d, a, b, c, x[i + 5], 12, 1200080426);
                c = md5_ff(c, d, a, b, x[i + 6], 17, -1473231341);
                b = md5_ff(b, c, d, a, x[i + 7], 22, -45705983);
                a = md5_ff(a, b, c, d, x[i + 8], 7, 1770035416);
                d = md5_ff(d, a, b, c, x[i + 9], 12, -1958414417);
                c = md5_ff(c, d, a, b, x[i + 10], 17, -42063);
                b = md5_ff(b, c, d, a, x[i + 11], 22, -1990404162);
                a = md5_ff(a, b, c, d, x[i + 12], 7, 1804603682);
                d = md5_ff(d, a, b, c, x[i + 13], 12, -40341101);
                c = md5_ff(c, d, a, b, x[i + 14], 17, -1502002290);
                b = md5_ff(b, c, d, a, x[i + 15], 22, 1236535329);
                a = md5_gg(a, b, c, d, x[i + 1], 5, -165796510);
                d = md5_gg(d, a, b, c, x[i + 6], 9, -1069501632);
                c = md5_gg(c, d, a, b, x[i + 11], 14, 643717713);
                b = md5_gg(b, c, d, a, x[i + 0], 20, -373897302);
                a = md5_gg(a, b, c, d, x[i + 5], 5, -701558691);
                d = md5_gg(d, a, b, c, x[i + 10], 9, 38016083);
                c = md5_gg(c, d, a, b, x[i + 15], 14, -660478335);
                b = md5_gg(b, c, d, a, x[i + 4], 20, -405537848);
                a = md5_gg(a, b, c, d, x[i + 9], 5, 568446438);
                d = md5_gg(d, a, b, c, x[i + 14], 9, -1019803690);
                c = md5_gg(c, d, a, b, x[i + 3], 14, -187363961);
                b = md5_gg(b, c, d, a, x[i + 8], 20, 1163531501);
                a = md5_gg(a, b, c, d, x[i + 13], 5, -1444681467);
                d = md5_gg(d, a, b, c, x[i + 2], 9, -51403784);
                c = md5_gg(c, d, a, b, x[i + 7], 14, 1735328473);
                b = md5_gg(b, c, d, a, x[i + 12], 20, -1926607734);
                a = md5_hh(a, b, c, d, x[i + 5], 4, -378558);
                d = md5_hh(d, a, b, c, x[i + 8], 11, -2022574463);
                c = md5_hh(c, d, a, b, x[i + 11], 16, 1839030562);
                b = md5_hh(b, c, d, a, x[i + 14], 23, -35309556);
                a = md5_hh(a, b, c, d, x[i + 1], 4, -1530992060);
                d = md5_hh(d, a, b, c, x[i + 4], 11, 1272893353);
                c = md5_hh(c, d, a, b, x[i + 7], 16, -155497632);
                b = md5_hh(b, c, d, a, x[i + 10], 23, -1094730640);
                a = md5_hh(a, b, c, d, x[i + 13], 4, 681279174);
                d = md5_hh(d, a, b, c, x[i + 0], 11, -358537222);
                c = md5_hh(c, d, a, b, x[i + 3], 16, -722521979);
                b = md5_hh(b, c, d, a, x[i + 6], 23, 76029189);
                a = md5_hh(a, b, c, d, x[i + 9], 4, -640364487);
                d = md5_hh(d, a, b, c, x[i + 12], 11, -421815835);
                c = md5_hh(c, d, a, b, x[i + 15], 16, 530742520);
                b = md5_hh(b, c, d, a, x[i + 2], 23, -995338651);
                a = md5_ii(a, b, c, d, x[i + 0], 6, -198630844);
                d = md5_ii(d, a, b, c, x[i + 7], 10, 1126891415);
                c = md5_ii(c, d, a, b, x[i + 14], 15, -1416354905);
                b = md5_ii(b, c, d, a, x[i + 5], 21, -57434055);
                a = md5_ii(a, b, c, d, x[i + 12], 6, 1700485571);
                d = md5_ii(d, a, b, c, x[i + 3], 10, -1894986606);
                c = md5_ii(c, d, a, b, x[i + 10], 15, -1051523);
                b = md5_ii(b, c, d, a, x[i + 1], 21, -2054922799);
                a = md5_ii(a, b, c, d, x[i + 8], 6, 1873313359);
                d = md5_ii(d, a, b, c, x[i + 15], 10, -30611744);
                c = md5_ii(c, d, a, b, x[i + 6], 15, -1560198380);
                b = md5_ii(b, c, d, a, x[i + 13], 21, 1309151649);
                a = md5_ii(a, b, c, d, x[i + 4], 6, -145523070);
                d = md5_ii(d, a, b, c, x[i + 11], 10, -1120210379);
                c = md5_ii(c, d, a, b, x[i + 2], 15, 718787259);
                b = md5_ii(b, c, d, a, x[i + 9], 21, -343485551);
                a = safe_add(a, olda);
                b = safe_add(b, oldb);
                c = safe_add(c, oldc);
                d = safe_add(d, oldd);
                i = i + 16;
            }
            return(new Array(a, b, c, d));
        }
        static function md5_cmn(q, a, b, x, s, t) {
            return(safe_add(bit_rol(safe_add(safe_add(a, q), safe_add(x, t)), s), b));
        }
        static function md5_ff(a, b, c, d, x, s, t) {
            return(md5_cmn((b & c) | ((~b) & d), a, b, x, s, t));
        }
        static function md5_gg(a, b, c, d, x, s, t) {
            return(md5_cmn((b & d) | (c & (~d)), a, b, x, s, t));
        }
        static function md5_hh(a, b, c, d, x, s, t) {
            return(md5_cmn((b ^ c) ^ d, a, b, x, s, t));
        }
        static function md5_ii(a, b, c, d, x, s, t) {
            return(md5_cmn(c ^ (b | (~d)), a, b, x, s, t));
        }
        static function core_hmac_md5(key, data) {
            var bkey = str2binl(key);
            if (bkey.length > 16) {
                bkey = core_md5(bkey, key.length * chrsz);
            }
            var ipad = Array(16);
            var opad = Array(16);
            var i = 0;
            while (i < 16) {
                ipad[i] = bkey[i] ^ 909522486;
                opad[i] = bkey[i] ^ 1549556828;
                i++;
            }
            var hash = core_md5(ipad.concat(str2binl(data)), 512 + (data.length * chrsz));
            return(core_md5(opad.concat(hash), 640));
        }
        static function safe_add(x, y) {
            var lsw = ((x & 65535) + (y & 65535));
            var msw = (((x >> 16) + (y >> 16)) + (lsw >> 16));
            return((msw << 16) | (lsw & 65535));
        }
        static function bit_rol(num, cnt) {
            return((num << cnt) | (num >>> (32 - cnt)));
        }
        static function str2binl(str) {
            var bin = new Array();
            var mask = ((1 << chrsz) - 1);
            var i = 0;
            while (i < (str.length * chrsz)) {
                bin[i >> 5] = bin[i >> 5] | ((str.charCodeAt(i / chrsz) & mask) << (i % 32));
                i = i + chrsz;
            }
            return(bin);
        }
        static function binl2str(bin) {
            var str = "";
            var mask = ((1 << chrsz) - 1);
            var i = 0;
            while (i < (bin.length * 32)) {
                str = str + String.fromCharCode((bin[i >> 5] >>> (i % 32)) & mask);
                i = i + chrsz;
            }
            return(str);
        }
        static function binl2hex(binarray) {
            var hex_tab = (hexcase ? "0123456789ABCDEF" : "0123456789abcdef");
            var str = "";
            var i = 0;
            while (i < (binarray.length * 4)) {
                str = str + (hex_tab.charAt((binarray[i >> 2] >> (((i % 4) * 8) + 4)) & 15) + hex_tab.charAt((binarray[i >> 2] >> ((i % 4) * 8)) & 15));
                i++;
            }
            return(str);
        }
        static function binl2b64(binarray) {
            var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var str = "";
            var i = 0;
            while (i < (binarray.length * 4)) {
                var triplet = (((((binarray[i >> 2] >> (8 * (i % 4))) & 255) << 16) | (((binarray[(i + 1) >> 2] >> (8 * ((i + 1) % 4))) & 255) << 8)) | ((binarray[(i + 2) >> 2] >> (8 * ((i + 2) % 4))) & 255));
                var j = 0;
                while (j < 4) {
                    if (((i * 8) + (j * 6)) > (binarray.length * 32)) {
                        str = str + b64pad;
                    } else {
                        str = str + tab.charAt((triplet >> (6 * (3 - j))) & 63);
                    }
                    j++;
                }
                i = i + 3;
            }
            return(str);
        }
        static var hexcase = 0;
        static var b64pad = "";
        static var chrsz = 8;
    }
