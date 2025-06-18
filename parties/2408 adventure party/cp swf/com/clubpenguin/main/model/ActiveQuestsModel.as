//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import com.clubpenguin.lib.util.collection.Collection;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.quest.QuestVO;
    import com.clubpenguin.lib.vo.IVO;
    import com.clubpenguin.lib.util.Log;

    public class ActiveQuestsModel extends Collection 
    {

        public static var rewardsReadyChanged:Signal = new Signal();
        public static var questUpdate:Signal = new Signal();

        public var version:Number = 0;
        public var spawnRoomID:int = 100;
        private var _recentlyCompletedQuests:Array = [];

        public function ActiveQuestsModel(clazz:Class)
        {
            super(clazz);
        }

        override public function add(questVO:IVO):Boolean
        {
            (questVO as QuestVO).updated.add(this.onQuestUpdated);
            questUpdate.dispatch();
            return (super.add(questVO));
        }

        private function onQuestUpdated(questVO:QuestVO):void
        {
            Log.debug((("\tActiveQuestsModel.onQuestUpdated(" + questVO.strID) + ")"));
            questUpdate.dispatch();
            this.resetCompletedQuests();
            if (questVO.prizeClaimed())
            {
                rewardsReadyChanged.dispatch();
            };
        }

        public function get recentlyCompletedQuests():Array
        {
            Log.debug("\tActiveQuestsModel.recentlyCompletedQuests()");
            return (this._recentlyCompletedQuests);
        }

        public function resetCompletedQuests():void
        {
            var quest:QuestVO;
            Log.debug("\tActiveQuestsModel.resetCompletedQuests()");
            this._recentlyCompletedQuests = [];
            var temp_questList:Array = getAllItems();
            for each (quest in temp_questList)
            {
                if (quest.isComplete())
                {
                    this._recentlyCompletedQuests.push(quest);
                };
            };
        }

        public function updateQuestProgress(updateData:Object):void
        {
            var key:String;
            var questToUpdate:QuestVO;
            for (key in updateData)
            {
                Log.debug(((("[ActiveQuestsModel] updateQuestProgress bjs:: updateData[" + key) + "] = ") + updateData[key]));
            };
            questToUpdate = (getItem(updateData.id) as QuestVO);
            questToUpdate.updateQuestProgress(updateData);
        }

        public function get rewardsReadyAmount():uint
        {
            Log.debug("\tActiveQuestsModel.rewardsReadyAmount()");
            Log.debug(("\t\t_recentlyCompletedQuests: " + this._recentlyCompletedQuests));
            return (this._recentlyCompletedQuests.length);
        }


    }
}//package com.clubpenguin.main.model
