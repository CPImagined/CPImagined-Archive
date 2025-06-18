dynamic class com.clubpenguin.crypto.MD5
{
    static var hexcase: Number = 0;
    static var b64pad: String = "";
    static var chrsz: Number = 8;

    function MD5()
    {
    }

    static function hash(str)
    {
        return com.clubpenguin.crypto.MD5.hex_md5(str);
    }

    static function utf8Encode(string)
    {
        var __reg3 = "";
        var __reg6 = undefined;
        var __reg4 = undefined;
        var __reg8 = 0;
        __reg6 = __reg4 = 0;
        __reg8 = string.length;
        var __reg5 = 0;
        while (__reg5 < __reg8) 
        {
            var __reg1 = string.charCodeAt(__reg5);
            var __reg2 = null;
            if (__reg1 < 128) 
            {
                ++__reg4;
            }
            else if (__reg1 > 127 && __reg1 < 2048) 
            {
                __reg2 = String.fromCharCode(__reg1 >> 6 | 192) + String.fromCharCode(__reg1 & 63 | 128);
            }
            else 
            {
                __reg2 = String.fromCharCode(__reg1 >> 12 | 224) + String.fromCharCode(__reg1 >> 6 & 63 | 128) + String.fromCharCode(__reg1 & 63 | 128);
            }
            if (__reg2 != null) 
            {
                if (__reg4 > __reg6) 
                {
                    __reg3 = __reg3 + string.substring(__reg6, __reg4);
                }
                __reg3 = __reg3 + __reg2;
                __reg6 = __reg4 = __reg5 + 1;
            }
            ++__reg5;
        }
        if (__reg4 > __reg6) 
        {
            __reg3 = __reg3 + string.substring(__reg6, string.length);
        }
        return __reg3;
    }

    static function hex_md5(s)
    {
        s = com.clubpenguin.crypto.MD5.utf8Encode(s);
        return com.clubpenguin.crypto.MD5.binl2hex(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s), s.length * com.clubpenguin.crypto.MD5.chrsz));
    }

    static function b64_md5(s)
    {
        return com.clubpenguin.crypto.MD5.binl2b64(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s), s.length * com.clubpenguin.crypto.MD5.chrsz));
    }

    static function str_md5(s)
    {
        return com.clubpenguin.crypto.MD5.binl2str(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s), s.length * com.clubpenguin.crypto.MD5.chrsz));
    }

    static function hex_hmac_md5(key, data)
    {
        return com.clubpenguin.crypto.MD5.binl2hex(com.clubpenguin.crypto.MD5.core_hmac_md5(key, data));
    }

    static function b64_hmac_md5(key, data)
    {
        return com.clubpenguin.crypto.MD5.binl2b64(com.clubpenguin.crypto.MD5.core_hmac_md5(key, data));
    }

    static function str_hmac_md5(key, data)
    {
        return com.clubpenguin.crypto.MD5.binl2str(com.clubpenguin.crypto.MD5.core_hmac_md5(key, data));
    }

    static function core_md5(x, len)
    {
        x[len >> 5] = x[len >> 5] | 128 << len % 32;
        x[(len + 64 >>> 9 << 4) + 14] = len;
        var __reg2 = 1732584193;
        var __reg3 = -271733879;
        var __reg4 = -1732584194;
        var __reg1 = 271733878;
        var __reg5 = 0;
        while (__reg5 < x.length) 
        {
            var __reg10 = __reg2;
            var __reg7 = __reg3;
            var __reg8 = __reg4;
            var __reg9 = __reg1;
            __reg2 = com.clubpenguin.crypto.MD5.md5_ff(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 0], 7, -680876936);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ff(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 1], 12, -389564586);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ff(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 2], 17, 606105819);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ff(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 3], 22, -1044525330);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ff(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 4], 7, -176418897);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ff(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 5], 12, 1200080426);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ff(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 6], 17, -1473231341);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ff(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 7], 22, -45705983);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ff(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 8], 7, 1770035416);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ff(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 9], 12, -1958414417);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ff(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 10], 17, -42063);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ff(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 11], 22, -1990404162);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ff(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 12], 7, 1804603682);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ff(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 13], 12, -40341101);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ff(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 14], 17, -1502002290);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ff(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 15], 22, 1236535329);
            __reg2 = com.clubpenguin.crypto.MD5.md5_gg(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 1], 5, -165796510);
            __reg1 = com.clubpenguin.crypto.MD5.md5_gg(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 6], 9, -1069501632);
            __reg4 = com.clubpenguin.crypto.MD5.md5_gg(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 11], 14, 643717713);
            __reg3 = com.clubpenguin.crypto.MD5.md5_gg(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 0], 20, -373897302);
            __reg2 = com.clubpenguin.crypto.MD5.md5_gg(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 5], 5, -701558691);
            __reg1 = com.clubpenguin.crypto.MD5.md5_gg(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 10], 9, 38016083);
            __reg4 = com.clubpenguin.crypto.MD5.md5_gg(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 15], 14, -660478335);
            __reg3 = com.clubpenguin.crypto.MD5.md5_gg(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 4], 20, -405537848);
            __reg2 = com.clubpenguin.crypto.MD5.md5_gg(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 9], 5, 568446438);
            __reg1 = com.clubpenguin.crypto.MD5.md5_gg(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 14], 9, -1019803690);
            __reg4 = com.clubpenguin.crypto.MD5.md5_gg(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 3], 14, -187363961);
            __reg3 = com.clubpenguin.crypto.MD5.md5_gg(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 8], 20, 1163531501);
            __reg2 = com.clubpenguin.crypto.MD5.md5_gg(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 13], 5, -1444681467);
            __reg1 = com.clubpenguin.crypto.MD5.md5_gg(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 2], 9, -51403784);
            __reg4 = com.clubpenguin.crypto.MD5.md5_gg(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 7], 14, 1735328473);
            __reg3 = com.clubpenguin.crypto.MD5.md5_gg(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 12], 20, -1926607734);
            __reg2 = com.clubpenguin.crypto.MD5.md5_hh(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 5], 4, -378558);
            __reg1 = com.clubpenguin.crypto.MD5.md5_hh(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 8], 11, -2022574463);
            __reg4 = com.clubpenguin.crypto.MD5.md5_hh(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 11], 16, 1839030562);
            __reg3 = com.clubpenguin.crypto.MD5.md5_hh(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 14], 23, -35309556);
            __reg2 = com.clubpenguin.crypto.MD5.md5_hh(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 1], 4, -1530992060);
            __reg1 = com.clubpenguin.crypto.MD5.md5_hh(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 4], 11, 1272893353);
            __reg4 = com.clubpenguin.crypto.MD5.md5_hh(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 7], 16, -155497632);
            __reg3 = com.clubpenguin.crypto.MD5.md5_hh(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 10], 23, -1094730640);
            __reg2 = com.clubpenguin.crypto.MD5.md5_hh(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 13], 4, 681279174);
            __reg1 = com.clubpenguin.crypto.MD5.md5_hh(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 0], 11, -358537222);
            __reg4 = com.clubpenguin.crypto.MD5.md5_hh(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 3], 16, -722521979);
            __reg3 = com.clubpenguin.crypto.MD5.md5_hh(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 6], 23, 76029189);
            __reg2 = com.clubpenguin.crypto.MD5.md5_hh(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 9], 4, -640364487);
            __reg1 = com.clubpenguin.crypto.MD5.md5_hh(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 12], 11, -421815835);
            __reg4 = com.clubpenguin.crypto.MD5.md5_hh(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 15], 16, 530742520);
            __reg3 = com.clubpenguin.crypto.MD5.md5_hh(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 2], 23, -995338651);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ii(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 0], 6, -198630844);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ii(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 7], 10, 1126891415);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ii(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 14], 15, -1416354905);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ii(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 5], 21, -57434055);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ii(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 12], 6, 1700485571);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ii(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 3], 10, -1894986606);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ii(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 10], 15, -1051523);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ii(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 1], 21, -2054922799);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ii(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 8], 6, 1873313359);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ii(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 15], 10, -30611744);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ii(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 6], 15, -1560198380);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ii(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 13], 21, 1309151649);
            __reg2 = com.clubpenguin.crypto.MD5.md5_ii(__reg2, __reg3, __reg4, __reg1, x[__reg5 + 4], 6, -145523070);
            __reg1 = com.clubpenguin.crypto.MD5.md5_ii(__reg1, __reg2, __reg3, __reg4, x[__reg5 + 11], 10, -1120210379);
            __reg4 = com.clubpenguin.crypto.MD5.md5_ii(__reg4, __reg1, __reg2, __reg3, x[__reg5 + 2], 15, 718787259);
            __reg3 = com.clubpenguin.crypto.MD5.md5_ii(__reg3, __reg4, __reg1, __reg2, x[__reg5 + 9], 21, -343485551);
            __reg2 = com.clubpenguin.crypto.MD5.safe_add(__reg2, __reg10);
            __reg3 = com.clubpenguin.crypto.MD5.safe_add(__reg3, __reg7);
            __reg4 = com.clubpenguin.crypto.MD5.safe_add(__reg4, __reg8);
            __reg1 = com.clubpenguin.crypto.MD5.safe_add(__reg1, __reg9);
            __reg5 = __reg5 + 16;
        }
        return new Array(__reg2, __reg3, __reg4, __reg1);
    }

    static function md5_cmn(q, a, b, x, s, t)
    {
        return com.clubpenguin.crypto.MD5.safe_add(com.clubpenguin.crypto.MD5.bit_rol(com.clubpenguin.crypto.MD5.safe_add(com.clubpenguin.crypto.MD5.safe_add(a, q), com.clubpenguin.crypto.MD5.safe_add(x, t)), s), b);
    }

    static function md5_ff(a, b, c, d, x, s, t)
    {
        return com.clubpenguin.crypto.MD5.md5_cmn(b & c | b ^ (4294967295 & d), a, b, x, s, t);
    }

    static function md5_gg(a, b, c, d, x, s, t)
    {
        return com.clubpenguin.crypto.MD5.md5_cmn(b & d | (c & d) ^ 4294967295, a, b, x, s, t);
    }

    static function md5_hh(a, b, c, d, x, s, t)
    {
        return com.clubpenguin.crypto.MD5.md5_cmn(b ^ c ^ d, a, b, x, s, t);
    }

    static function md5_ii(a, b, c, d, x, s, t)
    {
        return com.clubpenguin.crypto.MD5.md5_cmn(c ^ (b | d ^ 4294967295), a, b, x, s, t);
    }

    static function core_hmac_md5(key, data)
    {
        var __reg2 = com.clubpenguin.crypto.MD5.str2binl(key);
        if (__reg2.length > 16) 
        {
            __reg2 = com.clubpenguin.crypto.MD5.core_md5(__reg2, key.length * com.clubpenguin.crypto.MD5.chrsz);
        }
        var __reg4 = Array(16);
        var __reg3 = Array(16);
        var __reg1 = 0;
        while (__reg1 < 16) 
        {
            __reg4[__reg1] = __reg2[__reg1] ^ 909522486;
            __reg3[__reg1] = __reg2[__reg1] ^ 1549556828;
            ++__reg1;
        }
        var __reg5 = com.clubpenguin.crypto.MD5.core_md5(__reg4.concat(com.clubpenguin.crypto.MD5.str2binl(data)), 512 + data.length * com.clubpenguin.crypto.MD5.chrsz);
        return com.clubpenguin.crypto.MD5.core_md5(__reg3.concat(__reg5), 640);
    }

    static function safe_add(x, y)
    {
        var __reg1 = (x & 65535) + (y & 65535);
        var __reg2 = (x >> 16) + (y >> 16) + (__reg1 >> 16);
        return __reg2 << 16 | __reg1 & 65535;
    }

    static function bit_rol(num, cnt)
    {
        return num << cnt | num >>> 32 - cnt;
    }

    static function str2binl(str)
    {
        var __reg2 = new Array();
        var __reg4 = (1 << com.clubpenguin.crypto.MD5.chrsz) - 1;
        var __reg1 = 0;
        while (__reg1 < str.length * com.clubpenguin.crypto.MD5.chrsz) 
        {
            __reg2[__reg1 >> 5] = __reg2[__reg1 >> 5] | (str.charCodeAt(__reg1 / com.clubpenguin.crypto.MD5.chrsz) & __reg4) << __reg1 % 32;
            __reg1 = __reg1 + com.clubpenguin.crypto.MD5.chrsz;
        }
        return __reg2;
    }

    static function binl2str(bin)
    {
        var __reg2 = "";
        var __reg4 = (1 << com.clubpenguin.crypto.MD5.chrsz) - 1;
        var __reg1 = 0;
        while (__reg1 < bin.length * 32) 
        {
            __reg2 = __reg2 + String.fromCharCode(bin[__reg1 >> 5] >>> __reg1 % 32 & __reg4);
            __reg1 = __reg1 + com.clubpenguin.crypto.MD5.chrsz;
        }
        return __reg2;
    }

    static function binl2hex(binarray)
    {
        var __reg4 = com.clubpenguin.crypto.MD5.hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
        var __reg3 = "";
        var __reg1 = 0;
        while (__reg1 < binarray.length * 4) 
        {
            __reg3 = __reg3 + (__reg4.charAt(binarray[__reg1 >> 2] >> __reg1 % 4 * 8 + 4 & 15) + __reg4.charAt(binarray[__reg1 >> 2] >> __reg1 % 4 * 8 & 15));
            ++__reg1;
        }
        return __reg3;
    }

    static function binl2b64(binarray)
    {
        var __reg6 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var __reg3 = "";
        var __reg1 = 0;
        while (__reg1 < binarray.length * 4) 
        {
            var __reg5 = (binarray[__reg1 >> 2] >> 8 * (__reg1 % 4) & 255) << 16 | (binarray[__reg1 + 1 >> 2] >> 8 * ((__reg1 + 1) % 4) & 255) << 8 | binarray[__reg1 + 2 >> 2] >> 8 * ((__reg1 + 2) % 4) & 255;
            var __reg2 = 0;
            while (__reg2 < 4) 
            {
                if (__reg1 * 8 + __reg2 * 6 > binarray.length * 32) 
                {
                    __reg3 = __reg3 + com.clubpenguin.crypto.MD5.b64pad;
                }
                else 
                {
                    __reg3 = __reg3 + __reg6.charAt(__reg5 >> 6 * (3 - __reg2) & 63);
                }
                ++__reg2;
            }
            __reg1 = __reg1 + 3;
        }
        return __reg3;
    }

}
