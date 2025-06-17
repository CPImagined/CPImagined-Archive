//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model.puffle
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.puffle.MoodVO;
    import flash.utils.Timer;
    import com.clubpenguin.lib.util.collection.Bag;
    import com.clubpenguin.services.socket.puffles.PuffleService;
    import flash.events.TimerEvent;
    import com.clubpenguin.lib.vo.puffle.PuffleVO;
    import com.clubpenguin.lib.vo.IVO;
    import com.clubpenguin.lib.vo.puffle.StatsVO;

    public class PuffleStateManager 
    {

        private static const STATS_TIMER_INTERVAL:uint = 600000;

        public var moodUpdated:Signal = new Signal(MoodVO);
        private var _statsTimer:Timer;
        private var _puffles:Bag;
        private var _puffleService:PuffleService;


        public function init(puffleService:PuffleService, puffles:Bag, isMyPuffles:Boolean):void
        {
            this._puffles = puffles;
            this._puffles.itemAdded.add(this.onPuffleAdded);
            this._puffleService = puffleService;
            this.setupPuffles();
            if (isMyPuffles)
            {
                this.initTimer();
                if (this._puffles.getSize() > 0)
                {
                    this._statsTimer.start();
                };
            };
        }

        public function destroy():void
        {
            if (this._statsTimer)
            {
                this._statsTimer.stop();
                this._statsTimer.removeEventListener(TimerEvent.TIMER, this.timerHandler);
            };
            this.moodUpdated.removeAll();
            this._puffles.destroy(false);
            this._statsTimer = null;
        }

        public function updatePufflesStats():void
        {
            this._puffleService.getMyPufflesStats();
        }

        private function onPuffleAdded(itemVO:IVO):void
        {
            this.setupPuffleState((itemVO as PuffleVO));
            if (((this._statsTimer) && (!(this._statsTimer.running))))
            {
                this._statsTimer.start();
            };
        }

        private function setupPuffleState(puffleVO:PuffleVO):void
        {
            puffleVO.statsVO.voUpdated.add(this.updateMood);
            puffleVO.moodVO.voUpdated.add(this.onMoodUpdated);
            this.updateMood(puffleVO.statsVO);
        }

        private function setupPuffles():void
        {
            var i:uint;
            var puffleList:Array = this._puffles.getAllItems();
            if (((puffleList) && (puffleList.length > 0)))
            {
                i = 0;
                while (i < puffleList.length)
                {
                    this.setupPuffleState((puffleList[i] as PuffleVO));
                    i++;
                };
            };
        }

        private function updateMood(statsVO:StatsVO):void
        {
            var puffleVO:PuffleVO = (this._puffles.getItem(statsVO.puffleID) as PuffleVO);
            if (!puffleVO)
            {
                throw (new Error((("[PuffleStateManager] -> updateMood(): ERROR!!! could not find pufffle with id " + statsVO.puffleID) + " in collection")));
            };
            var average:int = int(Math.ceil((((puffleVO.statsVO.food + puffleVO.statsVO.play) + puffleVO.statsVO.rest) / 3)));
            var moodVO:MoodVO = new MoodVO();
            moodVO.superHappy = (average >= 80);
            moodVO.happy = ((average >= 50) && (average < 80));
            moodVO.sad = ((average >= 10) && (average <= 49));
            moodVO.angry = ((average >= 0) && (average <= 9));
            moodVO.tired = ((puffleVO.statsVO.rest >= 0) && (puffleVO.statsVO.rest <= 20));
            moodVO.hungry = ((puffleVO.statsVO.food >= 0) && (puffleVO.statsVO.food <= 20));
            moodVO.dirty = (puffleVO.statsVO.clean == 0);
            puffleVO.moodVO.update(moodVO);
        }

        private function onMoodUpdated(moodVO:MoodVO):void
        {
            this.moodUpdated.dispatch(moodVO);
        }

        private function timerHandler(event:TimerEvent):void
        {
            this._puffleService.getMyPufflesStats();
        }

        private function initTimer():void
        {
            this._statsTimer = new Timer(STATS_TIMER_INTERVAL);
            this._statsTimer.addEventListener(TimerEvent.TIMER, this.timerHandler);
        }


    }
}//package com.clubpenguin.main.model.puffle
