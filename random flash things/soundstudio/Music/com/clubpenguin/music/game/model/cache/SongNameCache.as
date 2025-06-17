//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.model.cache
{
    import flash.utils.Dictionary;

    public class SongNameCache 
    {

        private var _nameCache:Dictionary;

        public function SongNameCache()
        {
            this._nameCache = new Dictionary();
        }

        public function cacheTestedName(name:String, isValid:Boolean):void
        {
            this._nameCache[name] = isValid;
        }

        public function isNameCached(name:String):Boolean
        {
            return (!(this._nameCache[name] == undefined));
        }

        public function isNameValid(name:String):Boolean
        {
            return (this._nameCache[name]);
        }


    }
}//package com.clubpenguin.music.game.model.cache
