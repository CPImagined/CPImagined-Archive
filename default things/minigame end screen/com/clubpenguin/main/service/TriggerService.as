//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.util.StringUtils;
    import com.clubpenguin.lib.vo.map.MapTriggerVO;

    public class TriggerService extends Actor 
    {

        public var SET_VISITED_CONTENT_FLAGS:String = "vcfs";
        public var GET_VISITED_CONTENT_FLAGS:String = "vcf";
        private var _triggerList:TriggerList;
        private var _socketConnection:IConnection;

        public function TriggerService(connection:IConnection)
        {
            this._socketConnection = connection;
            this._socketConnection.getResponded().add(this.onResponded);
        }

        public function onResponded(messageType:String, responseData:Array):void
        {
            switch (messageType)
            {
                case this.GET_VISITED_CONTENT_FLAGS:
                    if (StringUtils.isValidString(responseData[1]))
                    {
                        this.parseReceivedFlagData(responseData[1]);
                    };
                    break;
            };
        }

        private function parseReceivedFlagData(responseData:String):void
        {
            var categorySegment:Array;
            var triggerIDs:Array;
            var catid:int;
            var tid:int;
            var j:int;
            var categories:Array = responseData.split(":");
            var i:int;
            while (i < categories.length)
            {
                categorySegment = categories[i].split("|");
                catid = int(categorySegment[0]);
                triggerIDs = categorySegment[1].split(",");
                j = 0;
                while (j < triggerIDs.length)
                {
                    tid = triggerIDs[j];
                    this._triggerList.setTriggerId(catid, tid);
                    j++;
                };
                i++;
            };
        }

        public function loadTriggerList():void
        {
            this._triggerList = new TriggerList();
        }

        public function sendTrigger(trigger:MapTriggerVO):void
        {
            if (this.isTriggerSet(trigger))
            {
                return;
            };
            this._triggerList.setTriggerId(trigger.categoryId, trigger.triggerId);
        }

        public function isTriggerSet(trigger:MapTriggerVO):Boolean
        {
            return (this._triggerList.hasTrigger(trigger.categoryId, trigger.triggerId));
        }


    }
}//package com.clubpenguin.main.service

class TriggerList 
{

    /*private*/ var _categories:Array;

    public function TriggerList()
    {
        this._categories = new Array(3);
    }

    public function hasTrigger(catid:int, tid:int):Boolean
    {
        var index:int = (catid - 1);
        var list:Array = this._categories[index];
        if (list == null)
        {
            return (false);
        };
        return (!(list.indexOf(tid) == -1));
    }

    public function setTriggerId(catid:int, tid:int):void
    {
        var index:int = (catid - 1);
        var list:Array = this._categories[index];
        if (list == null)
        {
            list = new Array();
            this._categories[index] = list;
        };
        list.push(tid);
    }

    public function toString():String
    {
        var str:String = "[TriggerList]";
        var i:int;
        while (i < this._categories.length)
        {
            str = (str + ((("\ncatid: " + (i + 1)) + " -> ") + this._categories[i]));
            i++;
        };
        return (str);
    }


}

