//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import com.clubpenguin.lib.util.Log;

    public class SetSongNameCommand extends Command 
    {

        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var event:MusicStudioSongEvent;


        override public function execute():void
        {
            Log.debug("");
            this.model.currentSongDetails.setSongName(this.event.songDetails[0].songName);
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SONG_NAME_UPDATE_SUCCESS));
        }


    }
}//package com.clubpenguin.music.game.controller
