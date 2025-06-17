//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.analytics
{
    import flash.net.SharedObject;

    public class PersistentABTestData 
    {

        public static const LOAD_WEB_SERVICE:String = "loadWebService";
        private static var PERSISTENT_DATA_LOCATION:String = "/";
        private static var PERSISTENT_DATA_NAME:String = "ABPersistentData";

        private var _persistentData:SharedObject;
        private var _isLsoAvailable:Boolean = true;


        public function init():void
        {
            try
            {
                this._persistentData = SharedObject.getLocal(PERSISTENT_DATA_NAME, PERSISTENT_DATA_LOCATION);
            }
            catch(error:Error)
            {
                _isLsoAvailable = false;
            };
        }

        public function getData(_arg_1:String):Object
        {
            var dataObj:Object = {};
            if (this._isLsoAvailable)
            {
                switch (_arg_1)
                {
                    case LOAD_WEB_SERVICE:
                        dataObj = this.getLoadWebServiceData();
                        break;
                };
            };
            return (dataObj);
        }

        public function saveData():void
        {
            if (this._isLsoAvailable)
            {
                this._persistentData.flush();
            };
        }

        private function getLoadWebServiceData():Object
        {
            if (this._persistentData.data.loadWebservices == undefined)
            {
                this._persistentData.data["loadWebservices"] = {};
            };
            return (this._persistentData.data.loadWebservices);
        }


    }
}//package com.clubpenguin.main.analytics
