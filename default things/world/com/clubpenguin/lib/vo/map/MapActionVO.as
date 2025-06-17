//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.map
{
    public class MapActionVO 
    {

        public var categoryID:int;
        public var mapID:int;
        public var triggerID:int;
        public var makeTriggersVisible:Boolean;

        public function MapActionVO(categoryID:int, mapID:int, triggerID:int, makeTriggersVisible:Boolean)
        {
            this.categoryID = categoryID;
            this.mapID = mapID;
            this.triggerID = triggerID;
            this.makeTriggersVisible = makeTriggersVisible;
        }

        public function toString():String
        {
            return ((((("[MapActionVO] categoryID: " + this.categoryID) + "  mapID: ") + this.mapID) + " triggerID: ") + this.triggerID);
        }

        public function isEmpty():Boolean
        {
            return (((this.categoryID == 0) && (this.mapID == 0)) || (this.triggerID == 0));
        }


    }
}//package com.clubpenguin.lib.vo.map
