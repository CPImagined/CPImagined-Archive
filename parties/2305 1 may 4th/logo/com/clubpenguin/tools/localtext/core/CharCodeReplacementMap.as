package com.clubpenguin.tools.localtext.core
{
    import __AS3__.vec.*;

    public class CharCodeReplacementMap extends Object
    {
        private const MAP_LENGTH:uint = 20000;
        private const replacementMap:Vector.<int>;

        public function CharCodeReplacementMap()
        {
            this.replacementMap = new Vector.<int>(this.MAP_LENGTH, true);
            this.setupMap();
            return;
        }// end function

        private function setupMap() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this.MAP_LENGTH)
            {
                
                this.replacementMap[_loc_1] = -1;
                _loc_1 = _loc_1 + 1;
            }
            this.replacementMap[160] = 32;
            return;
        }// end function

        public function replaceCharCodesForSring(param1:String) : String
        {
            var _loc_4:* = 0;
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_2)
            {
                
                _loc_3 = param1.charCodeAt(_loc_6);
                _loc_4 = this.replacementMap[_loc_3];
                if (_loc_4 > -1)
                {
                    _loc_5.push(_loc_4);
                }
                else
                {
                    _loc_5.push(_loc_3);
                }
                _loc_6 = _loc_6 + 1;
            }
            return String.fromCharCode.apply(null, _loc_5);
        }// end function

    }
}
