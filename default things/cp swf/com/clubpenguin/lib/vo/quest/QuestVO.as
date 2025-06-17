//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.quest
{
    import com.clubpenguin.lib.vo.IVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.PathsVO;

    public class QuestVO implements IVO 
    {

        private var _state:QuestStateEnum = QuestStateEnum.NOT_AVAILABLE;
        private var _id:int;
        private var _strID:String;
        private var _tasks:Array = [];
        private var _rewards:Array = [];
        private var _iconPath:String;
        private var _detailsPath:String;
        public var rewardReady:Signal = new Signal(QuestVO);
        public var updated:Signal = new Signal(QuestVO);

        public function QuestVO(id:int, strID:String)
        {
            this._id = id;
            this._strID = strID;
        }

        public static function fromObject(data:Object):QuestVO
        {
            var rewardVO:QuestRewardVO;
            var taskVO:TaskVO;
            var newQuestVO:QuestVO = new QuestVO(data.id, data.name);
            var j:int;
            while (j < data.awards.length)
            {
                rewardVO = new QuestRewardVO(data.awards[j].id, data.awards[j].type, data.awards[j].n);
                newQuestVO.addReward(rewardVO);
                j++;
            };
            var k:int;
            while (k < data.tasks.length)
            {
                switch (data.tasks[k].type)
                {
                    case "room":
                        taskVO = new VisitRoomTask(data.tasks[k].description, data.tasks[k].data);
                        break;
                    default:
                        taskVO = new TaskVO(data.tasks[k].description);
                };
                newQuestVO.addTask(taskVO);
                k++;
            };
            return (newQuestVO);
        }


        public function get id():int
        {
            return (this._id);
        }

        public function setAssetPaths(pathsVO:PathsVO):void
        {
            this._detailsPath = pathsVO.getGlobalPath("w.questui.skin.details").replace("%quest_name%", this._strID);
            this._iconPath = pathsVO.getLocalPath("w.questui.skin.icon").replace("%quest_name%", this._strID);
        }

        public function get detailsPath():String
        {
            return (this._detailsPath);
        }

        public function get iconPath():String
        {
            return (this._iconPath);
        }

        public function get strID():String
        {
            return (this._strID);
        }

        public function addReward(rewardVO:QuestRewardVO):void
        {
            this._rewards.push(rewardVO);
        }

        public function addTask(taskVO:TaskVO):void
        {
            this._tasks.push(taskVO);
        }

        public function get tasks():Array
        {
            return (this._tasks);
        }

        public function allTasksAreComplete():Boolean
        {
            var allTasksComplete:Boolean = true;
            var i:int;
            while (i < this._tasks.length)
            {
                if (!(this._tasks[i] as TaskVO).isComplete())
                {
                    allTasksComplete = false;
                };
                i++;
            };
            return (allTasksComplete);
        }

        public function prizeClaimed():Boolean
        {
            return (this._state == QuestStateEnum.PRIZE_CLAIMED);
        }

        public function isComplete():Boolean
        {
            return (this._state == QuestStateEnum.COMPLETE);
        }

        public function isRewardUnlocked():Boolean
        {
            return (this._state == QuestStateEnum.COMPLETE);
        }

        public function isAvailable():Boolean
        {
            return (this._state == QuestStateEnum.AVAILABLE);
        }

        public function isNotActivated():Boolean
        {
            return (this._state == QuestStateEnum.NOT_AVAILABLE);
        }

        public function get rewardType():QuestRewardEnum
        {
            if (this._rewards.length >= 1)
            {
                return ((this._rewards[0] as QuestRewardVO).type);
            };
            return (QuestRewardEnum.NONE);
        }

        public function updateQuestProgress(questProgressUpdate:Object):void
        {
            var i:int;
            while (i < this._tasks.length)
            {
                if (questProgressUpdate.tasks[i] == true)
                {
                    (this._tasks[i] as TaskVO).complete();
                };
                i++;
            };
            var oldState:QuestStateEnum = this._state;
            this._state = QuestStateEnum.getEnumByID(questProgressUpdate.status);
            if ((((this.allTasksAreComplete()) && (!(this._state == oldState))) && (this.isComplete())))
            {
                this.rewardReady.dispatch(this);
            };
            this.updated.dispatch(this);
        }

        public function get questState():QuestStateEnum
        {
            return (this._state);
        }

        public function destroy():void
        {
        }

        public function update(vo:IVO):void
        {
        }

        public function equals(vo:IVO):Boolean
        {
            return (vo.id == this._id);
        }

        public function toString():String
        {
            return ("[QuestVO]");
        }


    }
}//package com.clubpenguin.lib.vo.quest
