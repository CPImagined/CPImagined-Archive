dynamic class com.disney.dlearning.security.Md5
{
    var b64pad = new String("");
    var chrsz = new Number(8);

    function Md5(b64pad, chrsz)
    {
        if (b64pad != undefined) 
        {
            this.b64pad = b64pad;
        }
        if ((chrsz != undefined && chrsz == 8) || chrsz == 16) 
        {
            this.chrsz = chrsz;
        }
    }

    function hash(s)
    {
        return this.hex_md5(s);
    }

    function hex_md5(s)
    {
        return this.binl2hex(this.core_md5(this.str2binl(s), s.length * this.chrsz));
    }

    function b64_md5(s)
    {
        return this.binl2b64(this.core_md5(this.str2binl(s), s.length * this.chrsz));
    }

    function str_md5(s)
    {
        return this.binl2str(this.core_md5(this.str2binl(s), s.length * this.chrsz));
    }

    function hex_hmac_md5(key, data)
    {
        return this.binl2hex(this.core_hmac_md5(key, data));
    }

    function b64_hmac_md5(key, data)
    {
        return this.binl2b64(this.core_hmac_md5(key, data));
    }

    function str_hmac_md5(key, data)
    {
        return this.binl2str(this.core_hmac_md5(key, data));
    }

    function md5_cmn(q, a, b, x, s, t)
    {
        return this.safe_add(this.bit_rol(this.safe_add(this.safe_add(a, q), this.safe_add(x, t)), s), b);
    }

    function md5_ff(a, b, c, d, x, s, t)
    {
        return this.md5_cmn(b & c | b ^ 4294967295 & d, a, b, x, s, t);
    }

    function md5_gg(a, b, c, d, x, s, t)
    {
        return this.md5_cmn(b & d | c & d ^ 4294967295, a, b, x, s, t);
    }

    function md5_hh(a, b, c, d, x, s, t)
    {
        return this.md5_cmn(b ^ c ^ d, a, b, x, s, t);
    }

    function md5_ii(a, b, c, d, x, s, t)
    {
        return this.md5_cmn(c ^ (b | d ^ 4294967295), a, b, x, s, t);
    }

    function core_md5(x, len)
    {
        x[len >> 5] = x[len >> 5] | 128 << len % 32;
        x[(len + 64 >>> 9 << 4) + 14] = len;
        var __reg5 = 1732584193;
        var __reg4 = -271733879;
        var __reg3 = -1732584194;
        var __reg2 = 271733878;
        var __reg6 = 0;
        while (__reg6 < x.length) 
        {
            var __reg11 = __reg5;
            var __reg10 = __reg4;
            var __reg9 = __reg3;
            var __reg8 = __reg2;
            __reg5 = this.md5_ff(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 0], 7, -680876936);
            __reg2 = this.md5_ff(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 1], 12, -389564586);
            __reg3 = this.md5_ff(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 2], 17, 606105819);
            __reg4 = this.md5_ff(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 3], 22, -1044525330);
            __reg5 = this.md5_ff(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 4], 7, -176418897);
            __reg2 = this.md5_ff(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 5], 12, 1200080426);
            __reg3 = this.md5_ff(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 6], 17, -1473231341);
            __reg4 = this.md5_ff(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 7], 22, -45705983);
            __reg5 = this.md5_ff(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 8], 7, 1770035416);
            __reg2 = this.md5_ff(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 9], 12, -1958414417);
            __reg3 = this.md5_ff(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 10], 17, -42063);
            __reg4 = this.md5_ff(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 11], 22, -1990404162);
            __reg5 = this.md5_ff(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 12], 7, 1804603682);
            __reg2 = this.md5_ff(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 13], 12, -40341101);
            __reg3 = this.md5_ff(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 14], 17, -1502002290);
            __reg4 = this.md5_ff(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 15], 22, 1236535329);
            __reg5 = this.md5_gg(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 1], 5, -165796510);
            __reg2 = this.md5_gg(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 6], 9, -1069501632);
            __reg3 = this.md5_gg(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 11], 14, 643717713);
            __reg4 = this.md5_gg(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 0], 20, -373897302);
            __reg5 = this.md5_gg(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 5], 5, -701558691);
            __reg2 = this.md5_gg(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 10], 9, 38016083);
            __reg3 = this.md5_gg(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 15], 14, -660478335);
            __reg4 = this.md5_gg(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 4], 20, -405537848);
            __reg5 = this.md5_gg(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 9], 5, 568446438);
            __reg2 = this.md5_gg(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 14], 9, -1019803690);
            __reg3 = this.md5_gg(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 3], 14, -187363961);
            __reg4 = this.md5_gg(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 8], 20, 1163531501);
            __reg5 = this.md5_gg(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 13], 5, -1444681467);
            __reg2 = this.md5_gg(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 2], 9, -51403784);
            __reg3 = this.md5_gg(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 7], 14, 1735328473);
            __reg4 = this.md5_gg(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 12], 20, -1926607734);
            __reg5 = this.md5_hh(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 5], 4, -378558);
            __reg2 = this.md5_hh(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 8], 11, -2022574463);
            __reg3 = this.md5_hh(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 11], 16, 1839030562);
            __reg4 = this.md5_hh(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 14], 23, -35309556);
            __reg5 = this.md5_hh(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 1], 4, -1530992060);
            __reg2 = this.md5_hh(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 4], 11, 1272893353);
            __reg3 = this.md5_hh(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 7], 16, -155497632);
            __reg4 = this.md5_hh(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 10], 23, -1094730640);
            __reg5 = this.md5_hh(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 13], 4, 681279174);
            __reg2 = this.md5_hh(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 0], 11, -358537222);
            __reg3 = this.md5_hh(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 3], 16, -722521979);
            __reg4 = this.md5_hh(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 6], 23, 76029189);
            __reg5 = this.md5_hh(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 9], 4, -640364487);
            __reg2 = this.md5_hh(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 12], 11, -421815835);
            __reg3 = this.md5_hh(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 15], 16, 530742520);
            __reg4 = this.md5_hh(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 2], 23, -995338651);
            __reg5 = this.md5_ii(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 0], 6, -198630844);
            __reg2 = this.md5_ii(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 7], 10, 1126891415);
            __reg3 = this.md5_ii(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 14], 15, -1416354905);
            __reg4 = this.md5_ii(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 5], 21, -57434055);
            __reg5 = this.md5_ii(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 12], 6, 1700485571);
            __reg2 = this.md5_ii(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 3], 10, -1894986606);
            __reg3 = this.md5_ii(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 10], 15, -1051523);
            __reg4 = this.md5_ii(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 1], 21, -2054922799);
            __reg5 = this.md5_ii(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 8], 6, 1873313359);
            __reg2 = this.md5_ii(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 15], 10, -30611744);
            __reg3 = this.md5_ii(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 6], 15, -1560198380);
            __reg4 = this.md5_ii(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 13], 21, 1309151649);
            __reg5 = this.md5_ii(__reg5, __reg4, __reg3, __reg2, x[__reg6 + 4], 6, -145523070);
            __reg2 = this.md5_ii(__reg2, __reg5, __reg4, __reg3, x[__reg6 + 11], 10, -1120210379);
            __reg3 = this.md5_ii(__reg3, __reg2, __reg5, __reg4, x[__reg6 + 2], 15, 718787259);
            __reg4 = this.md5_ii(__reg4, __reg3, __reg2, __reg5, x[__reg6 + 9], 21, -343485551);
            __reg5 = this.safe_add(__reg5, __reg11);
            __reg4 = this.safe_add(__reg4, __reg10);
            __reg3 = this.safe_add(__reg3, __reg9);
            __reg2 = this.safe_add(__reg2, __reg8);
            __reg6 = __reg6 + 16;
        }
        var __reg13 = new Array(__reg5, __reg4, __reg3, __reg2);
        return __reg13;
    }

    function core_hmac_md5(key, data)
    {
        var __reg3 = new Array(this.str2binl(key));
        if (__reg3.length > 16) 
        {
            __reg3 = this.core_md5(__reg3, key.length * this.chrsz);
        }
        var __reg4 = new Array(16);
        var __reg5 = new Array(16);
        var __reg2 = 0;
        while (__reg2 < 16) 
        {
            __reg4[__reg2] = __reg3[__reg2] ^ 909522486;
            __reg5[__reg2] = __reg3[__reg2] ^ 1549556828;
            ++__reg2;
        }
        var __reg6 = new Array(this.core_md5(__reg4.concat(this.str2binl(data)), 512 + data.length * this.chrsz));
        return this.core_md5(__reg5.concat(__reg6), 640);
    }

    function safe_add(x, y)
    {
        var __reg1 = new Number((x & 65535) + (y & 65535));
        var __reg2 = new Number((x >> 16) + (y >> 16) + (__reg1 >> 16));
        return __reg2 << 16 | __reg1 & 65535;
    }

    function bit_rol(num, cnt)
    {
        return num << cnt | num >>> 32 - cnt;
    }

    function str2binl(str)
    {
        var __reg4 = new Array();
        var __reg5 = (1 << this.chrsz) - 1;
        var __reg2 = 0;
        while (__reg2 < str.length * this.chrsz) 
        {
            __reg4[__reg2 >> 5] = __reg4[__reg2 >> 5] | (str.charCodeAt(__reg2 / this.chrsz) & __reg5) << __reg2 % 32;
            __reg2 = __reg2 + this.chrsz;
        }
        return __reg4;
    }

    function binl2str(bin)
    {
        var __reg4 = new String("");
        var __reg5 = (1 << this.chrsz) - 1;
        var __reg2 = 0;
        while (__reg2 < bin.length * 32) 
        {
            __reg4 = __reg4 + String.fromCharCode(bin[__reg2 >> 5] >>> __reg2 % 32 & __reg5);
            __reg2 = __reg2 + this.chrsz;
        }
        return __reg4;
    }

    function binl2hex(binarray)
    {
        var __reg3 = "0123456789abcdef";
        var __reg4 = new String("");
        var __reg1 = 0;
        while (__reg1 < binarray.length * 4) 
        {
            __reg4 = __reg4 + (__reg3.charAt(binarray[__reg1 >> 2] >> __reg1 % 4 * 8 + 4 & 15) + __reg3.charAt(binarray[__reg1 >> 2] >> __reg1 % 4 * 8 & 15));
            ++__reg1;
        }
        return __reg4;
    }

    function binl2b64(binarray)
    {
        var __reg7 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        var __reg5 = new String("");
        var __reg3 = 0;
        while (__reg3 < binarray.length * 4) 
        {
            var __reg6 = (binarray[__reg3 >> 2] >> 8 * (__reg3 % 4) & 255) << 16 | (binarray[__reg3 + 1 >> 2] >> 8 * ((__reg3 + 1) % 4) & 255) << 8 | binarray[__reg3 + 2 >> 2] >> 8 * ((__reg3 + 2) % 4) & 255;
            var __reg2 = 0;
            while (__reg2 < 4) 
            {
                if (__reg3 * 8 + __reg2 * 6 > binarray.length * 32) 
                {
                    __reg5 = __reg5 + this.b64pad;
                }
                else 
                {
                    __reg5 = __reg5 + __reg7.charAt(__reg6 >> 6 * (3 - __reg2) & 63);
                }
                ++__reg2;
            }
            __reg3 = __reg3 + 3;
        }
        return __reg5;
    }

}
