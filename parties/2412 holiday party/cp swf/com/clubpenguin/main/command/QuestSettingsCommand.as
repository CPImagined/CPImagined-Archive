//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.ActiveQuestsModel;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.vo.quest.QuestVO;
    import com.clubpenguin.lib.util.Log;

    public class QuestSettingsCommand extends SignalCommand 
    {

        [Inject]
        public var myActiveQuests:ActiveQuestsModel;
        [Inject]
        public var questSettingData:Object;
        [Inject]
        public var pathsVO:PathsVO;


        override public function execute():void
        {
            var questVO:QuestVO;
            Log.debug("QuestSettingsCommand.execute()");
            this.myActiveQuests.clear();
            this.myActiveQuests.version = this.questSettingData.ver;
            this.myActiveQuests.spawnRoomID = this.questSettingData.spawnRoomId;
            var i:int;
            while (i < this.questSettingData.quests.length)
            {
                Log.debug(((("\t-questSettingData.quests[" + i) + "]: ") + this.questSettingData.quests[i]));
                questVO = QuestVO.fromObject(this.questSettingData.quests[i]);
                questVO.setAssetPaths(this.pathsVO);
                this.myActiveQuests.add(questVO);
                i++;
            };
        }


    }
}//package com.clubpenguin.main.command
