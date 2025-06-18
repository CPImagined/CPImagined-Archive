//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.map
{
    public class MapCategoryVO 
    {

        public var categoryId:Number;
        public var name:String;
        public var triggers:Array;


        public function initFromObject(obj:Object):void
        {
            var i:int;
            var trigger:MapTriggerVO;
            this.categoryId = obj.catid;
            this.name = obj.name;
            this.triggers = [];
            if (obj.items)
            {
                i = 0;
                while (i < obj.items.length)
                {
                    trigger = new MapTriggerVO();
                    trigger.initFromObject(obj.items[i]);
                    trigger.categoryId = this.categoryId;
                    this.triggers.push(trigger);
                    i++;
                };
            };
        }

        public function toString():String
        {
            return ((((("[MapCategoryVO] categoryId: " + this.categoryId) + "  name: ") + this.name) + " \ntriggers: ") + this.triggers);
        }


    }
}//package com.clubpenguin.lib.vo.map
