class com.disney.dlearning.security.Md5
{
   var b64pad = new String("");
   var chrsz = new Number(8);
   function Md5(b64pad, chrsz)
   {
      if(b64pad != undefined)
      {
         this.b64pad = b64pad;
      }
      if(chrsz != undefined && chrsz == 8 || chrsz == 16)
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
      return this.binl2hex(this.core_md5(this.str2binl(s),s.length * this.chrsz));
   }
   function b64_md5(s)
   {
      return this.binl2b64(this.core_md5(this.str2binl(s),s.length * this.chrsz));
   }
   function str_md5(s)
   {
      return this.binl2str(this.core_md5(this.str2binl(s),s.length * this.chrsz));
   }
   function hex_hmac_md5(key, data)
   {
      return this.binl2hex(this.core_hmac_md5(key,data));
   }
   function b64_hmac_md5(key, data)
   {
      return this.binl2b64(this.core_hmac_md5(key,data));
   }
   function str_hmac_md5(key, data)
   {
      return this.binl2str(this.core_hmac_md5(key,data));
   }
   function md5_cmn(q, a, b, x, s, t)
   {
      return this.safe_add(this.bit_rol(this.safe_add(this.safe_add(a,q),this.safe_add(x,t)),s),b);
   }
   function md5_ff(a, b, c, d, x, s, t)
   {
      return this.md5_cmn(b & c | (~b) & d,a,b,x,s,t);
   }
   function md5_gg(a, b, c, d, x, s, t)
   {
      return this.md5_cmn(b & d | c & (~d),a,b,x,s,t);
   }
   function md5_hh(a, b, c, d, x, s, t)
   {
      return this.md5_cmn(b ^ c ^ d,a,b,x,s,t);
   }
   function md5_ii(a, b, c, d, x, s, t)
   {
      return this.md5_cmn(c ^ (b | ~d),a,b,x,s,t);
   }
   function core_md5(x, len)
   {
      x[len >> 5] |= 128 << len % 32;
      x[(len + 64 >>> 9 << 4) + 14] = len;
      var _loc5_ = 1732584193;
      var _loc4_ = -271733879;
      var _loc3_ = -1732584194;
      var _loc2_ = 271733878;
      var _loc6_ = 0;
      while(_loc6_ < x.length)
      {
         var _loc10_ = _loc5_;
         var _loc9_ = _loc4_;
         var _loc8_ = _loc3_;
         var _loc11_ = _loc2_;
         _loc5_ = this.md5_ff(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 0],7,-680876936);
         _loc2_ = this.md5_ff(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 1],12,-389564586);
         _loc3_ = this.md5_ff(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 2],17,606105819);
         _loc4_ = this.md5_ff(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 3],22,-1044525330);
         _loc5_ = this.md5_ff(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 4],7,-176418897);
         _loc2_ = this.md5_ff(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 5],12,1200080426);
         _loc3_ = this.md5_ff(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 6],17,-1473231341);
         _loc4_ = this.md5_ff(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 7],22,-45705983);
         _loc5_ = this.md5_ff(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 8],7,1770035416);
         _loc2_ = this.md5_ff(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 9],12,-1958414417);
         _loc3_ = this.md5_ff(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 10],17,-42063);
         _loc4_ = this.md5_ff(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 11],22,-1990404162);
         _loc5_ = this.md5_ff(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 12],7,1804603682);
         _loc2_ = this.md5_ff(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 13],12,-40341101);
         _loc3_ = this.md5_ff(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 14],17,-1502002290);
         _loc4_ = this.md5_ff(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 15],22,1236535329);
         _loc5_ = this.md5_gg(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 1],5,-165796510);
         _loc2_ = this.md5_gg(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 6],9,-1069501632);
         _loc3_ = this.md5_gg(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 11],14,643717713);
         _loc4_ = this.md5_gg(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 0],20,-373897302);
         _loc5_ = this.md5_gg(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 5],5,-701558691);
         _loc2_ = this.md5_gg(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 10],9,38016083);
         _loc3_ = this.md5_gg(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 15],14,-660478335);
         _loc4_ = this.md5_gg(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 4],20,-405537848);
         _loc5_ = this.md5_gg(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 9],5,568446438);
         _loc2_ = this.md5_gg(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 14],9,-1019803690);
         _loc3_ = this.md5_gg(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 3],14,-187363961);
         _loc4_ = this.md5_gg(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 8],20,1163531501);
         _loc5_ = this.md5_gg(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 13],5,-1444681467);
         _loc2_ = this.md5_gg(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 2],9,-51403784);
         _loc3_ = this.md5_gg(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 7],14,1735328473);
         _loc4_ = this.md5_gg(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 12],20,-1926607734);
         _loc5_ = this.md5_hh(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 5],4,-378558);
         _loc2_ = this.md5_hh(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 8],11,-2022574463);
         _loc3_ = this.md5_hh(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 11],16,1839030562);
         _loc4_ = this.md5_hh(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 14],23,-35309556);
         _loc5_ = this.md5_hh(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 1],4,-1530992060);
         _loc2_ = this.md5_hh(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 4],11,1272893353);
         _loc3_ = this.md5_hh(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 7],16,-155497632);
         _loc4_ = this.md5_hh(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 10],23,-1094730640);
         _loc5_ = this.md5_hh(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 13],4,681279174);
         _loc2_ = this.md5_hh(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 0],11,-358537222);
         _loc3_ = this.md5_hh(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 3],16,-722521979);
         _loc4_ = this.md5_hh(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 6],23,76029189);
         _loc5_ = this.md5_hh(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 9],4,-640364487);
         _loc2_ = this.md5_hh(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 12],11,-421815835);
         _loc3_ = this.md5_hh(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 15],16,530742520);
         _loc4_ = this.md5_hh(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 2],23,-995338651);
         _loc5_ = this.md5_ii(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 0],6,-198630844);
         _loc2_ = this.md5_ii(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 7],10,1126891415);
         _loc3_ = this.md5_ii(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 14],15,-1416354905);
         _loc4_ = this.md5_ii(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 5],21,-57434055);
         _loc5_ = this.md5_ii(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 12],6,1700485571);
         _loc2_ = this.md5_ii(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 3],10,-1894986606);
         _loc3_ = this.md5_ii(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 10],15,-1051523);
         _loc4_ = this.md5_ii(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 1],21,-2054922799);
         _loc5_ = this.md5_ii(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 8],6,1873313359);
         _loc2_ = this.md5_ii(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 15],10,-30611744);
         _loc3_ = this.md5_ii(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 6],15,-1560198380);
         _loc4_ = this.md5_ii(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 13],21,1309151649);
         _loc5_ = this.md5_ii(_loc5_,_loc4_,_loc3_,_loc2_,x[_loc6_ + 4],6,-145523070);
         _loc2_ = this.md5_ii(_loc2_,_loc5_,_loc4_,_loc3_,x[_loc6_ + 11],10,-1120210379);
         _loc3_ = this.md5_ii(_loc3_,_loc2_,_loc5_,_loc4_,x[_loc6_ + 2],15,718787259);
         _loc4_ = this.md5_ii(_loc4_,_loc3_,_loc2_,_loc5_,x[_loc6_ + 9],21,-343485551);
         _loc5_ = this.safe_add(_loc5_,_loc10_);
         _loc4_ = this.safe_add(_loc4_,_loc9_);
         _loc3_ = this.safe_add(_loc3_,_loc8_);
         _loc2_ = this.safe_add(_loc2_,_loc11_);
         _loc6_ += 16;
      }
      var _loc13_ = new Array(_loc5_,_loc4_,_loc3_,_loc2_);
      return _loc13_;
   }
   function core_hmac_md5(key, data)
   {
      var _loc3_ = new Array(this.str2binl(key));
      if(_loc3_.length > 16)
      {
         _loc3_ = this.core_md5(_loc3_,key.length * this.chrsz);
      }
      var _loc4_ = new Array(16);
      var _loc5_ = new Array(16);
      var _loc2_ = 0;
      while(_loc2_ < 16)
      {
         _loc4_[_loc2_] = _loc3_[_loc2_] ^ 0x36363636;
         _loc5_[_loc2_] = _loc3_[_loc2_] ^ 0x5C5C5C5C;
         _loc2_ = _loc2_ + 1;
      }
      var _loc6_ = new Array(this.core_md5(_loc4_.concat(this.str2binl(data)),512 + data.length * this.chrsz));
      return this.core_md5(_loc5_.concat(_loc6_),640);
   }
   function safe_add(x, y)
   {
      var _loc1_ = new Number((x & 0xFFFF) + (y & 0xFFFF));
      var _loc2_ = new Number((x >> 16) + (y >> 16) + (_loc1_ >> 16));
      return _loc2_ << 16 | _loc1_ & 0xFFFF;
   }
   function bit_rol(num, cnt)
   {
      return num << cnt | num >>> 32 - cnt;
   }
   function str2binl(str)
   {
      var _loc3_ = new Array();
      var _loc5_ = (1 << this.chrsz) - 1;
      var _loc2_ = 0;
      while(_loc2_ < str.length * this.chrsz)
      {
         _loc3_[_loc2_ >> 5] |= (str.charCodeAt(_loc2_ / this.chrsz) & _loc5_) << _loc2_ % 32;
         _loc2_ += this.chrsz;
      }
      return _loc3_;
   }
   function binl2str(bin)
   {
      var _loc3_ = new String("");
      var _loc5_ = (1 << this.chrsz) - 1;
      var _loc2_ = 0;
      while(_loc2_ < bin.length * 32)
      {
         _loc3_ += String.fromCharCode(bin[_loc2_ >> 5] >>> _loc2_ % 32 & _loc5_);
         _loc2_ += this.chrsz;
      }
      return _loc3_;
   }
   function binl2hex(binarray)
   {
      var _loc4_ = "0123456789abcdef";
      var _loc3_ = new String("");
      var _loc1_ = 0;
      while(_loc1_ < binarray.length * 4)
      {
         _loc3_ += _loc4_.charAt(binarray[_loc1_ >> 2] >> _loc1_ % 4 * 8 + 4 & 0x0F) + _loc4_.charAt(binarray[_loc1_ >> 2] >> _loc1_ % 4 * 8 & 0x0F);
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   function binl2b64(binarray)
   {
      var _loc7_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      var _loc4_ = new String("");
      var _loc2_ = 0;
      while(_loc2_ < binarray.length * 4)
      {
         var _loc6_ = (binarray[_loc2_ >> 2] >> 8 * (_loc2_ % 4) & 0xFF) << 16 | (binarray[_loc2_ + 1 >> 2] >> 8 * ((_loc2_ + 1) % 4) & 0xFF) << 8 | binarray[_loc2_ + 2 >> 2] >> 8 * ((_loc2_ + 2) % 4) & 0xFF;
         var _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(_loc2_ * 8 + _loc3_ * 6 > binarray.length * 32)
            {
               _loc4_ += this.b64pad;
            }
            else
            {
               _loc4_ += _loc7_.charAt(_loc6_ >> 6 * (3 - _loc3_) & 0x3F);
            }
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ += 3;
      }
      return _loc4_;
   }
}
