//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.quest
{
    public class TaskVO 
    {

        private var _isComplete:Boolean = false;
        public var description:String;

        public function TaskVO(description:String)
        {
            this.description = description;
        }

        public function complete():void
        {
            this._isComplete = true;
        }

        public function isComplete():Boolean
        {
            return (this._isComplete);
        }


    }
}//package com.clubpenguin.lib.vo.quest
