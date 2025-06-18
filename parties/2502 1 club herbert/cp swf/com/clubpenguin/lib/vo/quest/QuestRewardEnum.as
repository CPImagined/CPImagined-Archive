//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.quest
{
    import com.clubpenguin.lib.enums.Enum;

    public class QuestRewardEnum extends Enum 
    {

        public static const PUFFLE_HAT:QuestRewardEnum = new QuestRewardEnum("puffleItem", "PUFFLE_HAT");
        public static const CLOTHING:QuestRewardEnum = new QuestRewardEnum("penguinItem", "CLOTHING");
        public static const FURNITURE:QuestRewardEnum = new QuestRewardEnum("furnitureItem", "FURNITURE");
        public static const NONE:QuestRewardEnum = new QuestRewardEnum("", "NONE");
        private static var _enumList:Array = [PUFFLE_HAT, CLOTHING, FURNITURE, NONE];

        private var _id:String;
        private var _name:String;

        public function QuestRewardEnum(id:String, name:String)
        {
            this._id = id;
            this._name = name;
        }

        public static function getEnumByID(id:String):QuestRewardEnum
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

        public function get name():String
        {
            return (this._name);
        }


    }
}//package com.clubpenguin.lib.vo.quest
