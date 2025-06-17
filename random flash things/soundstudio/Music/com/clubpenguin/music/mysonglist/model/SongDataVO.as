//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.model
{
    import com.clubpenguin.lib.util.Log;

    public class SongDataVO 
    {

        private var _name:String;
        private var _id:String;
        private var _shared:Number;
        private var _likeCount:Number;

        public function SongDataVO(name:String, id:String, shared:Number, likeCount:Number)
        {
            Log.debug(("shared: " + shared));
            this._name = name;
            this._id = id;
            this._shared = shared;
            this._likeCount = likeCount;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get shared():Number
        {
            return (this._shared);
        }

        public function set shared(sharedFlag:Number):void
        {
            this._shared = sharedFlag;
        }

        public function set likeCount(value:Number):void
        {
            this._likeCount = value;
        }

        public function get likeCount():Number
        {
            return (this._likeCount);
        }


    }
}//package com.clubpenguin.music.mysonglist.model
