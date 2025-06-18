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
            var i:uint;
            while (i < this.MAP_LENGTH)
            {
                this.replacementMap[i] = -1;
                i++;
            };
            this.replacementMap[160] = 32;
        }

        public function replaceCharCodesForSring(str:String):String
        {
            var replacementCharCode:int;
            var strLen:uint = str.length;
            var charCode:int;
            var replacementChars:Array = [];
            var i:uint;
            while (i < strLen)
            {
                charCode = str.charCodeAt(i);
                replacementCharCode = this.replacementMap[charCode];
                if (replacementCharCode > -1)
                {
                    replacementChars.push(replacementCharCode);
                }
                else
                {
                    replacementChars.push(charCode);
                };
                i++;
            };
            return (String.fromCharCode.apply(null, replacementChars));
        }


    }
}//package com.clubpenguin.tools.localtext.core
