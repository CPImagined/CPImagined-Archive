//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.friends
{
    public class Location 
    {

        private var _land:String;
        private var _room:String;
        private var _world:String;

        public function Location(land:String, room:String, world:String)
        {
            this._land = land;
            this._room = room;
            this._world = world;
        }

        public static function fromRaw(rawLocation:Object):Location
        {
            return (new Location(rawLocation.land, rawLocation.room, rawLocation.world));
        }


        public function toRaw():Object
        {
            return ({
                "land":this._land,
                "room":this._room,
                "world":this._world
            });
        }

        public function toString():String
        {
            return (((((("Location:{land:" + this._land) + ", room:") + this._room) + ", world:") + this._world) + "}");
        }

        public function get land():String
        {
            return (this._land);
        }

        public function get room():String
        {
            return (this._room);
        }

        public function get world():String
        {
            return (this._world);
        }


    }
}//package com.disney.friends
