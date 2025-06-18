//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.map
{
    public class TriggerArrowVO 
    {

        public var x:Number;
        public var y:Number;
        public var rotation:Number;
        public var isFlipped:Boolean;


        public function initFromObject(obj:Object):void
        {
            this.x = obj.x;
            this.y = obj.y;
            this.rotation = obj.rotation;
            this.isFlipped = obj.isFlipped;
        }


    }
}//package com.clubpenguin.lib.vo.map
