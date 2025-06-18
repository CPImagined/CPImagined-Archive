//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model.vo
{
    public class ElementLevelVO 
    {

        public var type:String;
        public var level:int;
        public var maxLevel:int;
        public var progressPct:Number;
        public var finalChallengeLevel:int;
        public var continuedRewards:Boolean;

        public function ElementLevelVO(_arg_1:String, level:int, totalLevels:int, progressPct:Number, finalChallengeLevel:int, continuedRewards:Boolean)
        {
            this.type = _arg_1;
            totalLevels = ((totalLevels > 0) ? totalLevels : 1);
            this.maxLevel = totalLevels;
            level = ((level >= 0) ? level : 0);
            level = ((level <= totalLevels) ? level : totalLevels);
            this.level = level;
            progressPct = ((progressPct >= 0) ? progressPct : 0);
            progressPct = ((progressPct <= 100) ? progressPct : 100);
            this.progressPct = progressPct;
            this.finalChallengeLevel = finalChallengeLevel;
            this.continuedRewards = continuedRewards;
        }

        public function destroy():void
        {
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model.vo
