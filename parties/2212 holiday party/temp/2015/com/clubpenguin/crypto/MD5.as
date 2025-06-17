class com.clubpenguin.crypto.MD5
{
   static var hexcase = 0;
   static var b64pad = "";
   static var chrsz = 8;
   function MD5()
   {
   }
   static function hash(str)
   {
      return com.clubpenguin.crypto.MD5.hex_md5(str);
   }
   static function utf8Encode(string)
   {
      var _loc6_ = "";
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc8_ = 0;
      _loc5_ = _loc4_ = 0;
      _loc8_ = string.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc8_)
      {
         var _loc1_ = string.charCodeAt(_loc3_);
         var _loc2_ = null;
         if(_loc1_ < 128)
         {
            _loc4_ = _loc4_ + 1;
         }
         else if(_loc1_ > 127 && _loc1_ < 2048)
         {
            _loc2_ = String.fromCharCode(_loc1_ >> 6 | 192) + String.fromCharCode(_loc1_ & 63 | 128);
         }
         else
         {
            _loc2_ = String.fromCharCode(_loc1_ >> 12 | 224) + String.fromCharCode(_loc1_ >> 6 & 63 | 128) + String.fromCharCode(_loc1_ & 63 | 128);
         }
         if(_loc2_ != null)
         {
            if(_loc4_ > _loc5_)
            {
               _loc6_ += string.substring(_loc5_,_loc4_);
            }
            _loc6_ += _loc2_;
            _loc5_ = _loc4_ = _loc3_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      if(_loc4_ > _loc5_)
      {
         _loc6_ += string.substring(_loc5_,string.length);
      }
      return _loc6_;
   }
   static function hex_md5(s)
   {
      s = com.clubpenguin.crypto.MD5.utf8Encode(s);
      return com.clubpenguin.crypto.MD5.binl2hex(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s),s.length * com.clubpenguin.crypto.MD5.chrsz));
   }
   static function b64_md5(s)
   {
      return com.clubpenguin.crypto.MD5.binl2b64(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s),s.length * com.clubpenguin.crypto.MD5.chrsz));
   }
   static function str_md5(s)
   {
      return com.clubpenguin.crypto.MD5.binl2str(com.clubpenguin.crypto.MD5.core_md5(com.clubpenguin.crypto.MD5.str2binl(s),s.length * com.clubpenguin.crypto.MD5.chrsz));
   }
   static function hex_hmac_md5(key, data)
   {
      return com.clubpenguin.crypto.MD5.binl2hex(com.clubpenguin.crypto.MD5.core_hmac_md5(key,data));
   }
   static function b64_hmac_md5(key, data)
   {
      return com.clubpenguin.crypto.MD5.binl2b64(com.clubpenguin.crypto.MD5.core_hmac_md5(key,data));
   }
   static function str_hmac_md5(key, data)
   {
      return com.clubpenguin.crypto.MD5.binl2str(com.clubpenguin.crypto.MD5.core_hmac_md5(key,data));
   }
   static function core_md5(x, len)
   {
      x[len >> 5] |= 128 << len % 32;
      x[(len + 64 >>> 9 << 4) + 14] = len;
      var _loc4_ = 1732584193;
      var _loc3_ = -271733879;
      var _loc2_ = -1732584194;
      var _loc1_ = 271733878;
      var _loc5_ = 0;
      while(_loc5_ < x.length)
      {
         var _loc10_ = _loc4_;
         var _loc9_ = _loc3_;
         var _loc8_ = _loc2_;
         var _loc7_ = _loc1_;
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 0],7,-680876936);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 1],12,-389564586);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 2],17,606105819);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 3],22,-1044525330);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 4],7,-176418897);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 5],12,1200080426);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 6],17,-1473231341);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 7],22,-45705983);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 8],7,1770035416);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 9],12,-1958414417);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 10],17,-42063);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 11],22,-1990404162);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ff(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 12],7,1804603682);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ff(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 13],12,-40341101);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ff(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 14],17,-1502002290);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ff(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 15],22,1236535329);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 1],5,-165796510);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 6],9,-1069501632);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 11],14,643717713);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 0],20,-373897302);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 5],5,-701558691);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 10],9,38016083);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 15],14,-660478335);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 4],20,-405537848);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 9],5,568446438);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 14],9,-1019803690);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 3],14,-187363961);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 8],20,1163531501);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_gg(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 13],5,-1444681467);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_gg(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 2],9,-51403784);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_gg(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 7],14,1735328473);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_gg(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 12],20,-1926607734);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 5],4,-378558);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 8],11,-2022574463);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 11],16,1839030562);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 14],23,-35309556);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 1],4,-1530992060);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 4],11,1272893353);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 7],16,-155497632);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 10],23,-1094730640);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 13],4,681279174);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 0],11,-358537222);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 3],16,-722521979);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 6],23,76029189);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_hh(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 9],4,-640364487);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_hh(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 12],11,-421815835);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_hh(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 15],16,530742520);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_hh(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 2],23,-995338651);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 0],6,-198630844);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 7],10,1126891415);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 14],15,-1416354905);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 5],21,-57434055);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 12],6,1700485571);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 3],10,-1894986606);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 10],15,-1051523);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 1],21,-2054922799);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 8],6,1873313359);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 15],10,-30611744);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 6],15,-1560198380);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 13],21,1309151649);
         _loc4_ = com.clubpenguin.crypto.MD5.md5_ii(_loc4_,_loc3_,_loc2_,_loc1_,x[_loc5_ + 4],6,-145523070);
         _loc1_ = com.clubpenguin.crypto.MD5.md5_ii(_loc1_,_loc4_,_loc3_,_loc2_,x[_loc5_ + 11],10,-1120210379);
         _loc2_ = com.clubpenguin.crypto.MD5.md5_ii(_loc2_,_loc1_,_loc4_,_loc3_,x[_loc5_ + 2],15,718787259);
         _loc3_ = com.clubpenguin.crypto.MD5.md5_ii(_loc3_,_loc2_,_loc1_,_loc4_,x[_loc5_ + 9],21,-343485551);
         _loc4_ = com.clubpenguin.crypto.MD5.safe_add(_loc4_,_loc10_);
         _loc3_ = com.clubpenguin.crypto.MD5.safe_add(_loc3_,_loc9_);
         _loc2_ = com.clubpenguin.crypto.MD5.safe_add(_loc2_,_loc8_);
         _loc1_ = com.clubpenguin.crypto.MD5.safe_add(_loc1_,_loc7_);
         _loc5_ += 16;
      }
      return new Array(_loc4_,_loc3_,_loc2_,_loc1_);
   }
   static function md5_cmn(q, a, b, x, s, t)
   {
      return com.clubpenguin.crypto.MD5.safe_add(com.clubpenguin.crypto.MD5.bit_rol(com.clubpenguin.crypto.MD5.safe_add(com.clubpenguin.crypto.MD5.safe_add(a,q),com.clubpenguin.crypto.MD5.safe_add(x,t)),s),b);
   }
   static function md5_ff(a, b, c, d, x, s, t)
   {
      return com.clubpenguin.crypto.MD5.md5_cmn(b & c | (~b) & d,a,b,x,s,t);
   }
   static function md5_gg(a, b, c, d, x, s, t)
   {
      return com.clubpenguin.crypto.MD5.md5_cmn(b & d | c & (~d),a,b,x,s,t);
   }
   static function md5_hh(a, b, c, d, x, s, t)
   {
      return com.clubpenguin.crypto.MD5.md5_cmn(b ^ c ^ d,a,b,x,s,t);
   }
   static function md5_ii(a, b, c, d, x, s, t)
   {
      return com.clubpenguin.crypto.MD5.md5_cmn(c ^ (b | ~d),a,b,x,s,t);
   }
   static function core_hmac_md5(key, data)
   {
      var _loc2_ = com.clubpenguin.crypto.MD5.str2binl(key);
      if(_loc2_.length > 16)
      {
         _loc2_ = com.clubpenguin.crypto.MD5.core_md5(_loc2_,key.length * com.clubpenguin.crypto.MD5.chrsz);
      }
      var _loc3_ = Array(16);
      var _loc4_ = Array(16);
      var _loc1_ = 0;
      while(_loc1_ < 16)
      {
         _loc3_[_loc1_] = _loc2_[_loc1_] ^ 909522486;
         _loc4_[_loc1_] = _loc2_[_loc1_] ^ 1549556828;
         _loc1_ = _loc1_ + 1;
      }
      var _loc5_ = com.clubpenguin.crypto.MD5.core_md5(_loc3_.concat(com.clubpenguin.crypto.MD5.str2binl(data)),512 + data.length * com.clubpenguin.crypto.MD5.chrsz);
      return com.clubpenguin.crypto.MD5.core_md5(_loc4_.concat(_loc5_),640);
   }
   static function safe_add(x, y)
   {
      var _loc1_ = (x & 65535) + (y & 65535);
      var _loc2_ = (x >> 16) + (y >> 16) + (_loc1_ >> 16);
      return _loc2_ << 16 | _loc1_ & 65535;
   }
   static function bit_rol(num, cnt)
   {
      return num << cnt | num >>> 32 - cnt;
   }
   static function str2binl(str)
   {
      var _loc3_ = new Array();
      var _loc4_ = (1 << com.clubpenguin.crypto.MD5.chrsz) - 1;
      var _loc1_ = 0;
      while(_loc1_ < str.length * com.clubpenguin.crypto.MD5.chrsz)
      {
         _loc3_[_loc1_ >> 5] |= (str.charCodeAt(_loc1_ / com.clubpenguin.crypto.MD5.chrsz) & _loc4_) << _loc1_ % 32;
         _loc1_ += com.clubpenguin.crypto.MD5.chrsz;
      }
      return _loc3_;
   }
   static function binl2str(bin)
   {
      var _loc3_ = "";
      var _loc4_ = (1 << com.clubpenguin.crypto.MD5.chrsz) - 1;
      var _loc1_ = 0;
      while(_loc1_ < bin.length * 32)
      {
         _loc3_ += String.fromCharCode(bin[_loc1_ >> 5] >>> _loc1_ % 32 & _loc4_);
         _loc1_ += com.clubpenguin.crypto.MD5.chrsz;
      }
      return _loc3_;
   }
   static function binl2hex(binarray)
   {
      var _loc3_ = !com.clubpenguin.crypto.MD5.hexcase ? "0123456789abcdef" : "0123456789ABCDEF";
      var _loc4_ = "";
      var _loc1_ = 0;
      while(_loc1_ < binarray.length * 4)
      {
         _loc4_ += _loc3_.charAt(binarray[_loc1_ >> 2] >> _loc1_ % 4 * 8 + 4 & 15) + _loc3_.charAt(binarray[_loc1_ >> 2] >> _loc1_ % 4 * 8 & 15);
         _loc1_ = _loc1_ + 1;
      }
      return _loc4_;
   }
   static function binl2b64(binarray)
   {
      var _loc6_ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
      var _loc4_ = "";
      var _loc2_ = 0;
      while(_loc2_ < binarray.length * 4)
      {
         var _loc5_ = (binarray[_loc2_ >> 2] >> 8 * (_loc2_ % 4) & 255) << 16 | (binarray[_loc2_ + 1 >> 2] >> 8 * ((_loc2_ + 1) % 4) & 255) << 8 | binarray[_loc2_ + 2 >> 2] >> 8 * ((_loc2_ + 2) % 4) & 255;
         var _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(_loc2_ * 8 + _loc1_ * 6 > binarray.length * 32)
            {
               _loc4_ += com.clubpenguin.crypto.MD5.b64pad;
            }
            else
            {
               _loc4_ += _loc6_.charAt(_loc5_ >> 6 * (3 - _loc1_) & 63);
            }
            _loc1_ = _loc1_ + 1;
         }
         _loc2_ += 3;
      }
      return _loc4_;
   }
}
