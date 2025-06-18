//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.baseactors
{
    public class BasePlayerStats 
    {

        private static var _instance:BasePlayerStats;

        public var experience:int;
        public var level:uint;

        public function BasePlayerStats(level:uint, experience:int):void
        {
            this.experience = experience;
            this.level = level;
        }

        public static function getInstance(level:uint, experience:int):BasePlayerStats
        {
            if (_instance)
            {
                _instance.level = level;
                _instance.experience = experience;
            }
            else
            {
                _instance = new BasePlayerStats(level, experience);
            };
            return (_instance);
        }


    }
}//package com.playdom.baseactors
