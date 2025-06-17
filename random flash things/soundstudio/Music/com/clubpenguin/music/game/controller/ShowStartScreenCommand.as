//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;

    public class ShowStartScreenCommand extends Command 
    {

        [Inject]
        public var model:MusicStudioModel;


        override public function execute():void
        {
            dispatch(new MusicStudioViewEvent(MusicStudioViewEvent.SHOW_START_SCREEN_VIEW));
            this.model.stopSong();
            this.model.setRecordingStatus(MusicStudioRecordingStatusEnum.OFF);
            dispatch(new MusicStudioEvent(MusicStudioEvent.STOP_RECORDING_SUCCESS));
            commandMap.execute(StopSongInMusicPlayerCommand, new MusicStudioSongEvent(MusicStudioSongEvent.STOP_SONG));
        }


    }
}//package com.clubpenguin.music.game.controller
