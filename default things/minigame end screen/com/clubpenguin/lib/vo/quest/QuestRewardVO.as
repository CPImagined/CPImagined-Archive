//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.quest
{
    public class QuestRewardVO 
    {

        private var _itemID:int;
        private var _type:QuestRewardEnum;
        private var _quantity:int;

        public function QuestRewardVO(itemID:int, _arg_2:String, quantity:int=1)
        {
            this._itemID = itemID;
            this._type = QuestRewardEnum.getEnumByID(_arg_2);
            this._quantity = quantity;
        }

        public function get type():QuestRewardEnum
        {
            return (this._type);
        }


    }
}//package com.clubpenguin.lib.vo.quest
