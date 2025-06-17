//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import com.clubpenguin.music.game.events.MusicStudioViewEvent;

    public class StopRecordingCommand extends Command 
    {

        [Inject]
        public var event:MusicStudioEvent;
        [Inject]
        public var model:MusicStudioModel;
        [Inject]
        public var musicPlayer:IMusicPlayer;


        override public function execute():void
        {
            Log.debug("");
            var timestamp:Number = (this.event.payload.timestamp as Number);
            timestamp = Math.min(Math.floor((timestamp * 1000)), MusicStudioModel.SONG_MAX_LENGTH);
            Log.debug(("timestamp: " + timestamp));
            Log.debug(("model.recordingElapsedTime: " + this.model.recordingElapsedTime));
            var timestamp_hex:String = timestamp.toString(16);
            this.model.currentSongDetails.endSong(timestamp_hex);
            this.model.setRecordingStatus(MusicStudioRecordingStatusEnum.OFF);
            this.musicPlayer.stop();
            Log.debug(("model.currentRecording: " + this.model.currentSongDetails));
            dispatch(new MusicStudioEvent(MusicStudioEvent.STOP_RECORDING_SUCCESS));
            dispatch(new MusicStudioViewEvent(MusicStudioViewEvent.SHOW_SAVE_PROMPT, this.model.currentSongDetails));
        }


    }
}//package com.clubpenguin.music.game.controller
