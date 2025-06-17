//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.mysonglist.events
{
    import flash.events.Event;

    public class MySongListEvent extends Event 
    {

        public static var ASSETS_LOADED:String = "mysonglist_assets_loaded";
        public static var SONGDATA_LOADED:String = "songdata_loaded";
        public static var SONG_PLAY:String = "song_play";
        public static var SONG_DELETE:String = "song_delete";
        public static var SONG_SHARE:String = "song_share";
        public static var MODULE_CLOSE:String = "module_close";
        public static var SONG_LIKES:String = "song_likes";
        public static var SONG_STOP:String = "song_stop";
        public static var OPEN_STUDIO:String = "open_studio";
        public static var CREATE_TRACK:String = "create_track";

        public var payload:Object;

        public function MySongListEvent(_arg_1:String, payload:Object=null, bubbles:Boolean=true)
        {
            super(_arg_1, bubbles, true);
            this.payload = payload;
        }

    }
}//package com.clubpenguin.music.mysonglist.events
