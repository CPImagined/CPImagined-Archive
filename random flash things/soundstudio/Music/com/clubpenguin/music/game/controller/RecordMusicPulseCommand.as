//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.model.MusicStudioModel;
    import com.clubpenguin.music.player.IMusicPlayer;
    import com.clubpenguin.lib.util.Log;

    public class RecordMusicPulseCommand extends Command 
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
            var proposedTimestamp:String = this.createTimeStamp(this.model.recordingElapsedTime);
            if (this.isNotDuplicateTimestamp(proposedTimestamp))
            {
                this.model.currentSongDetails.append(proposedTimestamp);
            }
            else
            {
                Log.warn(("Duplicate proposed timestamp.  Increased time by 1 millisecond to append: " + proposedTimestamp));
                proposedTimestamp = this.createTimeStamp((this.model.recordingElapsedTime + 1));
            };
            Log.debug(("model.currentRecording: " + this.model.currentSongDetails));
        }

        private function isNotDuplicateTimestamp(proposedTimestamp:String):Boolean
        {
            var timestamp:String;
            var hex_time:String;
            var proposedHexTime:String = (proposedTimestamp.split("|")[1] as String);
            var stamps:Array = this.model.currentSongDetails.songData.split(",");
            for each (timestamp in stamps)
            {
                if (timestamp.indexOf("|") == -1)
                {
                }
                else
                {
                    hex_time = (timestamp.split("|")[1] as String);
                    if (proposedHexTime == hex_time)
                    {
                        return (false);
                    };
                };
            };
            return (true);
        }

        private function createTimeStamp(timestamp:Number):String
        {
            Log.debug(("model.recordingElapsedTime: " + this.model.recordingElapsedTime));
            var gridLayout:String = (this.event.payload as String);
            var layout_hex:String = parseInt(gridLayout, 2).toString(16);
            Log.debug((timestamp + ""));
            var timestamp_hex:String = timestamp.toString(16);
            return ((layout_hex + "|") + timestamp_hex);
        }


    }
}//package com.clubpenguin.music.game.controller
