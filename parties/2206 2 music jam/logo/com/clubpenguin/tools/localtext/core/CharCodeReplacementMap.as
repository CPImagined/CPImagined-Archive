//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.tools.localtext.core
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class CharCodeReplacementMap 
    {

        private const MAP_LENGTH:uint = 20000;
        private const replacementMap:Vector.<int> = new Vector.<int>(MAP_LENGTH, true);

        public function CharCodeReplacementMap()
        {
            this.setupMap();
        }

        private function setupMap():void
        {
            var _local_1:uint;
            while (_local_1 < this.MAP_LENGTH)
            {
                this.replacementMap[_local_1] = -1;
                _local_1++;
            };
            this.replacementMap[160] = 32;
        }

        public function replaceCharCodesForSring(_arg_1:String):String
        {
            var _local_4:int;
            var _local_2:uint = _arg_1.length;
            var _local_3:int;
            var _local_5:Array = [];
            var _local_6:uint;
            while (_local_6 < _local_2)
            {
                _local_3 = _arg_1.charCodeAt(_local_6);
                _local_4 = this.replacementMap[_local_3];
                if (_local_4 > -1)
                {
                    _local_5.push(_local_4);
                }
                else
                {
                    _local_5.push(_local_3);
                };
                _local_6++;
            };
            return (String.fromCharCode.apply(null, _local_5));
        }


    }
}//package com.clubpenguin.tools.localtext.core
