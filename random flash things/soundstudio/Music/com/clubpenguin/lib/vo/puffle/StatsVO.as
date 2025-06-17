//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.puffle
{
    import com.clubpenguin.lib.vo.IVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.enums.puffle.CareItemInventoryTypeEnum;

    public class StatsVO implements IVO 
    {

        private static const MIN_STATS_VALUE:int = 0;
        private static const MAX_STATS_VALUE:int = 100;

        public const voUpdated:Signal = new Signal(StatsVO);

        private var _food:int = 100;
        private var _play:int = 100;
        private var _rest:int = 100;
        private var _clean:int = 100;
        private var _invalidated:Boolean = false;
        private var celebrateFullStats:Boolean = false;
        public var puffleID:int;


        public function destroy():void
        {
            this.voUpdated.removeAll();
        }

        public function set food(value:int):void
        {
            if (value != this._food)
            {
                this._food = value;
                this._invalidated = true;
            };
        }

        public function get food():int
        {
            return (this._food);
        }

        public function set play(value:int):void
        {
            if (value != this._play)
            {
                this._play = value;
                this._invalidated = true;
            };
        }

        public function get play():int
        {
            return (this._play);
        }

        public function set rest(value:int):void
        {
            if (value != this._rest)
            {
                this._rest = value;
                this._invalidated = true;
            };
        }

        public function get rest():int
        {
            return (this._rest);
        }

        public function set clean(value:int):void
        {
            if (value != this._clean)
            {
                this._clean = value;
                this._invalidated = true;
            };
        }

        public function get clean():int
        {
            return (this._clean);
        }

        public function update(vo:IVO):void
        {
            var statsVO:StatsVO = (vo as StatsVO);
            this.food = statsVO.food;
            this.play = statsVO.play;
            this.rest = statsVO.rest;
            this.clean = statsVO.clean;
            if (this._invalidated)
            {
                this._invalidated = false;
                this.voUpdated.dispatch(this);
            };
        }

        public function get lowestStat():LowStatVO
        {
            var statsArray:Array;
            var lowestStatVO:LowStatVO = new LowStatVO();
            statsArray = new Array({
                "type":CareItemInventoryTypeEnum.FOOD.type,
                "stat":this._food
            }, {
                "type":CareItemInventoryTypeEnum.PLAY.type,
                "stat":this._play
            }, {
                "type":CareItemInventoryTypeEnum.SLEEP.type,
                "stat":this._rest
            }, {
                "type":CareItemInventoryTypeEnum.CARE.type,
                "stat":this._clean
            });
            lowestStatVO.statNum = statsArray[0].stat;
            lowestStatVO.type = statsArray[0].type;
            var i:Number = 0;
            while (i < statsArray.length)
            {
                if (statsArray[i].stat < lowestStatVO.statNum)
                {
                    lowestStatVO.statNum = statsArray[i].stat;
                    lowestStatVO.type = statsArray[i].type;
                };
                i++;
            };
            return (lowestStatVO);
        }

        public function get id():int
        {
            return (-1);
        }

        public function equals(vo:IVO):Boolean
        {
            return (false);
        }

        public function setCelebrateFullStats(showAnimation:Boolean):void
        {
            this.celebrateFullStats = showAnimation;
        }

        public function getCelebrateFullStats():Boolean
        {
            return (this.celebrateFullStats);
        }

        public function toString():String
        {
            return ((((((("food:" + this._food) + ", play:") + this._play) + ", rest:") + this._rest) + ", clean:") + this._clean);
        }


    }
}//package com.clubpenguin.lib.vo.puffle
