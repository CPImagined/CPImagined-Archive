//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.events
{
    import flash.events.Event;

    public class MusicStudioStartScreenEvent extends Event 
    {

        public static const PLAY_GAME_REQUEST:String = "MusicStudioStartScreenEvent_PLAY_GAME_REQUEST";
        public static const SHOW_INSTRUCTIONS_REQUEST:String = "MusicStudioStartScreenEvent_SHOW_INSTRUCTIONS_REQUEST";
        public static const SHOW_SONGLIST_REQUEST:String = "MusicStudioStartScreenEvent_SHOW_SONGLIST_REQUEST";

        public var payload:Object;

        public function MusicStudioStartScreenEvent(_arg_1:String, payload:Object=null)
        {
            super(_arg_1, true, true);
            this.payload = payload;
        }

        override public function clone():Event
        {
            return (new MusicStudioStartScreenEvent(type, this.payload));
        }


    }
}//package com.clubpenguin.music.game.view.events
