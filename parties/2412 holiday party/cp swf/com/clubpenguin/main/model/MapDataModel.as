//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.main.service.TriggerService;
    import com.clubpenguin.lib.vo.map.MapActionVO;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.vo.map.MapCategoryVO;
    import com.clubpenguin.lib.vo.map.MapTriggerVO;

    public class MapDataModel extends Actor 
    {

        private var _categories:Array;
        private var _triggerService:TriggerService;
        public var selectedMapAction:MapActionVO;

        public function MapDataModel(connection:IConnection)
        {
            this._triggerService = new TriggerService(connection);
            this._triggerService.loadTriggerList();
        }

        public function initFromObject(obj:Object):void
        {
            var category:MapCategoryVO;
            this._categories = [];
            var i:int;
            while (i < obj.categories.length)
            {
                category = new MapCategoryVO();
                category.initFromObject(obj.categories[i]);
                this._categories.push(category);
                i++;
            };
        }

        public function getTriggerByMapId(categoryId:Number, mapId:Number):MapTriggerVO
        {
            var category:MapCategoryVO = this.getCategoryById(categoryId);
            if (category == null)
            {
                return (null);
            };
            var i:int;
            while (i < category.triggers.length)
            {
                if (category.triggers[i].mapId == mapId)
                {
                    return (category.triggers[i]);
                };
                i++;
            };
            return (null);
        }

        public function getTriggerByTriggerName(name:String):MapTriggerVO
        {
            var category:MapCategoryVO;
            var trigger:MapTriggerVO;
            for each (category in this._categories)
            {
                for each (trigger in category.triggers)
                {
                    if (trigger.trigger == name)
                    {
                        return (trigger);
                    };
                };
            };
            return (null);
        }

        public function getCategoryById(id:Number):MapCategoryVO
        {
            var i:int;
            while (i < this._categories.length)
            {
                if (this._categories[i].categoryId == id)
                {
                    return (this._categories[i]);
                };
                i++;
            };
            return (null);
        }

        public function getCurrentTriggers():Array
        {
            var trigger:MapTriggerVO;
            var triggers:Array = [];
            var categoryVO:MapCategoryVO = this.getCategoryById(this.selectedMapAction.categoryID);
            var i:int;
            while (i < categoryVO.triggers.length)
            {
                trigger = categoryVO.triggers[i];
                if (trigger.mapId == this.selectedMapAction.mapID)
                {
                    if (!this._triggerService.isTriggerSet(trigger))
                    {
                        triggers.push(trigger);
                    };
                };
                i++;
            };
            return (triggers);
        }

        public function setTriggerVisitedByName(triggerName:String):void
        {
            var trigger:MapTriggerVO = this.getTriggerByTriggerName(triggerName);
            if (trigger)
            {
                this._triggerService.sendTrigger(trigger);
            };
        }


    }
}//package com.clubpenguin.main.model
