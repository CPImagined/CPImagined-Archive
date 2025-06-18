//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.map
{
    public class MapTriggerVO 
    {

        public var categoryId:int;
        public var triggerId:int;
        public var mapId:int;
        public var roomId:int;
        public var label:String;
        public var trigger:String;
        public var arrowVO:TriggerArrowVO;


        public function initFromObject(obj:Object):void
        {
            this.triggerId = obj.tid;
            this.mapId = obj.mapid;
            this.roomId = obj.roomid;
            this.label = obj.label;
            this.trigger = obj.trigger;
            if (obj.arrow)
            {
                this.arrowVO = new TriggerArrowVO();
                this.arrowVO.initFromObject(obj.arrow);
            };
        }

        public function toString():String
        {
            return ((((((("[MapTriggerVO] triggerId: " + this.triggerId) + " mapId: ") + this.mapId) + " label: ") + this.label) + " trigger: ") + this.trigger);
        }


    }
}//package com.clubpenguin.lib.vo.map
