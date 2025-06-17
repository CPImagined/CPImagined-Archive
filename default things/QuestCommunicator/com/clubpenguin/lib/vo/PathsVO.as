//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo
{
    public class PathsVO 
    {

        private var _environmentDataVO:EnvironmentDataVO;
        public var data:Object;


        public function init(environmentDataVO:EnvironmentDataVO):void
        {
            this._environmentDataVO = environmentDataVO;
        }

        public function getLocalPath(key:String):String
        {
            var path:String = (("[" + key) + "]");
            if (this.data["local"][key])
            {
                path = (this._environmentDataVO.localContentPath + this.data["local"][key]);
            };
            return (path);
        }

        public function getGlobalPath(key:String):String
        {
            var path:String = (("[" + key) + "]");
            if (this.data["global"][key])
            {
                path = (this._environmentDataVO.globalContentPath + this.data["global"][key]);
            };
            return (path);
        }

        public function getLinkPath(key:String):String
        {
            var path:String = (("[" + key) + "]");
            if (this.data["link"][key])
            {
                path = this.data["link"][key];
            };
            return (path);
        }


    }
}//package com.clubpenguin.lib.vo
