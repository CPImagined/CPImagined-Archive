//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.ActiveQuestsModel;

    public class QuestStatusCommand extends SignalCommand 
    {

        [Inject]
        public var questStatusUpdate:Object;
        [Inject]
        public var myActiveQuests:ActiveQuestsModel;


        override public function execute():void
        {
            var i:int;
            while (i < this.questStatusUpdate.quests.length)
            {
                this.myActiveQuests.updateQuestProgress(this.questStatusUpdate.quests[i]);
                i++;
            };
        }


    }
}//package com.clubpenguin.main.command
