//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.events
{
    import flash.events.Event;

    public class MusicModuleEvent extends Event 
    {

        public static const STUDIO_ASSETS_LOADED:String = "MusicModuleEvent_STUDIO_ASSETS_LOADED";
        public static const SHOW_STUDIO:String = "MusicModuleEvent_SHOW_STUDIO";
        public static const HIDE_STUDIO:String = "MusicModuleEvent_HIDE_STUDIO";
        public static const INITIALIZE_WIDGET:String = "MusicModuleEvent_INITIALIZE_WIDGET";
        public static const SHOW_WIDGET:String = "MusicModuleEvent_SHOW_WIDGET";
        public static const HIDE_WIDGET:String = "MusicModuleEvent_HIDE_WIDGET";
        public static const SHOW_MYSONGLIST:String = "MusicModuleEvent_SHOW_MYSONGLIST";
        public static const HIDE_MYSONGLIST:String = "MusicModuleEvent_HIDE_MYSONGLIST";

        public var payload:Object;

        public function MusicModuleEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicModuleEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.events
