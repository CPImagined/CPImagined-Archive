//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import flash.events.IEventDispatcher;
    import com.clubpenguin.music.player.MusicPlayer;
    import flash.events.Event;

    public class LoadGenreCommand extends Command 
    {

        private const albumIDToName:Array = ["pop", "rock", "dance", "dubstep", "spooky"];

        [Inject]
        public var event:MusicStudioEvent;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var appModel:IAppModel;
        [Inject]
        public var musicPlayer:IMusicPlayer;
        [Inject]
        public var tracker:Tracker;


        override public function execute():void
        {
            Log.debug("");
            if (this.model.getRecordingStatus() != MusicStudioRecordingStatusEnum.OFF)
            {
                return;
            };
            (this.musicPlayer as IEventDispatcher).addEventListener(MusicPlayer.EVENT_LOAD_COMPLETE, this.onGenreLoaded);
            this.musicPlayer.stop();
            this.musicPlayer.loadEmptySong((this.event.payload as int));
        }

        private function onGenreLoaded(e:Event):void
        {
            Log.debug(("Album: " + this.albumIDToName[(this.event.payload as int)]));
            (this.musicPlayer as IEventDispatcher).removeEventListener(MusicPlayer.EVENT_LOAD_COMPLETE, this.onGenreLoaded);
            this.tracker.trackGameAction("soundstudio", "genre_chosen", false, null, false, {"message":("genre=" + this.albumIDToName[(this.event.payload as int)])});
            this.model.startSong((this.event.payload as int));
            dispatch(new MusicStudioEvent(MusicStudioEvent.GENRE_LOADED, this.event.payload));
        }


    }
}//package com.clubpenguin.music.game.controller
