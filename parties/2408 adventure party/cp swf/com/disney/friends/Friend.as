//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    public class Friend 
    {

        private var _swid:String;
        private var _name:String;
        private var _presence:Presence;

        public function Friend(swid:String, name:String, presence:Presence)
        {
            this._swid = swid;
            this._name = name;
            this._presence = presence;
        }

        public static function fromRaw(rawFriend:Object):Friend
        {
            var presence:Presence = Presence.fromRaw(rawFriend.presence);
            var id:String = ((rawFriend.character) ? rawFriend.id : rawFriend.swid);
            return (new Friend(id, rawFriend.name, presence));
        }


        public function toRaw():Object
        {
            return ({
                "swid":this._swid,
                "name":this._name,
                "presence":this._presence.toRaw()
            });
        }

        public function toString():String
        {
            return (((((("Friend{swid:" + this._swid) + ", name:") + this._name) + ", presence:") + this._presence) + "}");
        }

        public function get swid():String
        {
            return (this._swid);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get presence():Presence
        {
            return (this._presence);
        }


    }
}//package com.disney.friends
