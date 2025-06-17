//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    public class Presence 
    {

        private var _id:String;
        private var _status:String;
        private var _location:Location;

        public function Presence(status:String, id:String, location:Location)
        {
            this._status = status;
            this._id = id;
            this._location = location;
        }

        public static function fromRaw(rawPresence:Object):Presence
        {
            var loc:Location;
            if (rawPresence.location)
            {
                loc = Location.fromRaw(rawPresence.location);
            };
            return (new Presence(rawPresence.status, rawPresence.id, loc));
        }


        public function toRaw():Object
        {
            return ({
                "status":this._status,
                "id":this._id,
                "location":((this._location) ? this._location.toRaw() : null)
            });
        }

        public function toString():String
        {
            var locationStr:String = "Location:null";
            if (this._location)
            {
                locationStr = this._location.toString();
            };
            return (((((("Presence{status:" + this._status) + ", ID:") + this._id) + ", location:") + locationStr) + "}");
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get status():String
        {
            return (this._status);
        }

        public function get location():Location
        {
            return (this._location);
        }


    }
}//package com.disney.friends
