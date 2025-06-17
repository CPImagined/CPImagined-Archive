//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    public class WebLoggerContext extends AnalyticsContext 
    {

        private var _categoryMap:Object;
        private var _categoryIndexMap:Object;

        public function WebLoggerContext()
        {
            this._categoryMap = {};
            this._categoryIndexMap = {};
        }

        override public function initFromConfig(config:Object):void
        {
            super.initFromConfig(config);
            this._categoryMap = config.categoryMap;
            this._categoryIndexMap = config.CATEGORY_INDEX_MAP;
        }

        public function get categoryMap():Object
        {
            return (this._categoryMap);
        }

        public function set categoryMap(map:Object):void
        {
            this._categoryMap = map;
        }

        public function get categoryIndexMap():Object
        {
            return (this._categoryIndexMap);
        }

        public function set categoryIndexMap(map:Object):void
        {
            this._categoryIndexMap = map;
        }

        override public function toString():String
        {
            var str:String = super.toString();
            str = (str + ("\n   _categoryMap=" + this._categoryMap));
            str = (str + ("\n   _categoryIndexMap=" + this._categoryIndexMap));
            return (str);
        }


    }
}//package com.clubpenguin.main.analytics
