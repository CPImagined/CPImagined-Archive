//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.resources.song
{
    public class RecordData 
    {

        private var _recordGridStatus:String;
        private var _recordTimeStamp:Number;

        public function RecordData(recordGridStatus:String, recordTimeStamp:Number, numBits:uint=40)
        {
            recordGridStatus = (this.zeros(numBits) + recordGridStatus).substr(-(numBits));
            this._recordTimeStamp = recordTimeStamp;
            this._recordGridStatus = recordGridStatus;
        }

        private function zeros(numZeros:int):String
        {
            var str:String = "";
            var i:int;
            while (i < numZeros)
            {
                str = (str + "0");
                i++;
            };
            return (str);
        }

        public function get recordTimeStamp():Number
        {
            return (this._recordTimeStamp);
        }

        public function get recordGridStatus():String
        {
            return (this._recordGridStatus);
        }


    }
}//package com.clubpenguin.music.resources.song
