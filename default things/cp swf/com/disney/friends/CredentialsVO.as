//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    public class CredentialsVO 
    {

        private var _playerId:String;
        private var _name:String;
        private var _swid:String;
        private var _worldId:int;

        public function CredentialsVO(playerId:String, name:String, swid:String)
        {
            this._playerId = playerId;
            this._name = name;
            this._swid = swid;
        }

        public static function fromRaw(rawCredentials:Object):CredentialsVO
        {
            var playerID:String = "";
            if (rawCredentials.playerId)
            {
                playerID = rawCredentials.playerId;
            };
            return (new CredentialsVO(playerID, rawCredentials.name, rawCredentials.swid));
        }


        public function toRaw():Object
        {
            return ({
                "playerId":this._playerId,
                "name":this._name,
                "swid":this._swid
            });
        }

        public function get playerId():String
        {
            return (this._playerId);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get swid():String
        {
            return (this._swid);
        }

        public function toString():String
        {
            return (((((("CredentialsVO{playerId:" + this._playerId) + ", name:") + this._name) + ", swid:") + this._swid) + "}");
        }


    }
}//package com.disney.friends
