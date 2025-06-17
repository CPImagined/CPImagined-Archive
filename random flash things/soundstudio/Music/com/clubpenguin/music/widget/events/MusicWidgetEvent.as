//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.events
{
    import flash.events.Event;
    import com.clubpenguin.lib.util.Log;

    public class MusicWidgetEvent extends Event 
    {

        public static const SHOW:String = "MusicWidgetEvent_SHOW";
        public static const HIDE:String = "MusicWidgetEvent_HIDE";
        public static const EXPAND:String = "MusicWidgetEvent_EXPAND";
        public static const COLLAPSE:String = "MusicWidgetEvent_COLLAPSE";
        public static const PLAY:String = "MusicWidgetEvent_PLAY";
        public static const STOP:String = "MusicWidgetEvent_STOP";
        public static const WIDGET_ASSETS_LOADED:String = "MusicWidgetEvent_LOAD";
        public static const CHECK_CAN_LIKE_SONG:String = "MusicWidgetEvent_CHECK_CAN_LIKE_SONG";
        public static const LIKE_SONG:String = "MusicWidgetEvent_LIKE_SONG";
        public static const LIKES_UPDATED:String = "MusicWidgetEvent_LIKES_UPDATED";
        public static const UPDATE:String = "MusicWidgetEvent_UPDATE";
        public static const SHOW_MYSONGLIST:String = "MusicWidgetEvent_SONGLIST";
        public static const SHUTDOWN:String = "MusicWidgetEvent_SHUTDOWN";
        public static const GET_BROADCASTS:String = "MusicWidgetEvent_GET_BROADCASTS";

        public var payload:Object;

        public function MusicWidgetEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            Log.debug(("type " + _arg_1));
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicWidgetEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.widget.events
