//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.game.service.INameValidationService;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.events.MusicModuleEvent;

    public class SaveSongCommand extends Command 
    {

        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var service:INameValidationService;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var tracker:Tracker;


        override public function execute():void
        {
            Log.debug("");
            var songName:String = this.model.currentSongDetails.songName;
            var nameValid:int = this.model.getSongNameValidation(songName);
            if (nameValid == MusicStudioModel.SONG_NAME_VALID)
            {
                this.saveSong();
            }
            else
            {
                this.saveFail();
            };
            var songLengthSeconds:Number = Math.round((this.model.currentSongDetails.songLength / 1000));
            Log.debug(("song length: " + songLengthSeconds));
            this.tracker.trackGameAction("soundstudio", "song_created", false, null, false, {"message":("length=" + songLengthSeconds.toString())});
            this.tracker.trackGameAction("soundstudio", "game_save", false, null, false, null);
        }

        private function saveSong():void
        {
            var songData:String = this.model.currentSongDetails.toString();
            Log.debug(("" + songData));
            this.musicService.saveSongSignal.addOnce(this.onSaveResponse);
            this.musicService.saveSong(songData);
        }

        public function onSaveResponse(response:String):void
        {
            Log.debug(response);
            this.saveSuccess();
        }

        private function saveSuccess():void
        {
            Log.debug("");
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SAVE_SONG_SUCCESS));
            (contextView as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicModuleEvent(MusicModuleEvent.SHOW_MYSONGLIST));
        }

        private function saveFail():void
        {
            Log.debug("");
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SAVE_SONG_FAIL));
        }


    }
}//package com.clubpenguin.music.game.controller
