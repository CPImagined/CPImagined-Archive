//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.quest
{
    import com.clubpenguin.lib.enums.Enum;

    public class QuestStateEnum extends Enum 
    {

        public static const NOT_AVAILABLE:QuestStateEnum = new QuestStateEnum("not available", "NOT_AVAILABLE");
        public static const AVAILABLE:QuestStateEnum = new QuestStateEnum("available", "AVAILABLE");
        public static const COMPLETE:QuestStateEnum = new QuestStateEnum("complete", "COMPLETE");
        public static const PRIZE_CLAIMED:QuestStateEnum = new QuestStateEnum("prize claimed", "PRIZE_CLAIMED");
        private static var _enumList:Array = [NOT_AVAILABLE, AVAILABLE, COMPLETE, PRIZE_CLAIMED];

        private var _id:String;
        private var _name:String;

        public function QuestStateEnum(id:String, name:String)
        {
            this._id = id;
            this._name = name;
        }

        public static function getEnumByID(id:String):QuestStateEnum
        {
            var i:int;
            while (i < _enumList.length)
            {
                if (id == _enumList[i].id)
                {
                    return (_enumList[i]);
                };
                i++;
            };
            return (null);
        }


        public function get id():String
        {
            return (this._id);
        }

        public function get nameToken():String
        {
            return (this._name);
        }


    }
}//package com.clubpenguin.lib.vo.quest
