//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.quest
{
    public class VisitRoomTask extends TaskVO 
    {

        private var _roomID:int;

        public function VisitRoomTask(description:String, roomID:int)
        {
            super(description);
            this._roomID = roomID;
        }

        public function get roomID():int
        {
            return (this._roomID);
        }


    }
}//package com.clubpenguin.lib.vo.quest
