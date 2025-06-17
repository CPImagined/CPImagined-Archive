//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.model
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.music.game.model.vo.SongDetailsVO;
    import flash.utils.Timer;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.music.game.model.cache.SongNameCache;
    import __AS3__.vec.Vector;
    import flash.events.TimerEvent;
    import com.clubpenguin.music.game.events.MusicStudioSongEvent;
    import flash.utils.getTimer;
    import com.clubpenguin.music.game.events.MusicStudioEvent;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import __AS3__.vec.*;

    public class MusicStudioModel extends Actor 
    {

        public static const SONG_NAME_VALID:int = 1;
        public static const SONG_NAME_INVALID:int = 0;
        public static const SONG_NAME_NOT_VERIFIED:int = -1;
        public static const SONG_MAX_LENGTH:int = 180000;

        private const MAX_NUM_SAVE_SLOTS:uint = 12;

        private var recordingStatus:String = "RECORDING_STATUS_OFF";
        public var currentSongDetails:SongDetailsVO;
        public var pulseTimer:Timer;
        public var environmentData:EnvironmentDataVO;
        private var songNameCache:SongNameCache = new SongNameCache();
        private var _sharedSongs:Vector.<SongDetailsVO>;
        private var _previousRoom:String;
        private var lastPulse:Number;
        private var _recordingElapsedTime:int;

        public function MusicStudioModel()
        {
            this._sharedSongs = new Vector.<SongDetailsVO>();
            this.pulseTimer = new Timer(50);
            this.pulseTimer.addEventListener(TimerEvent.TIMER, this.onPulseTimerEvent);
        }

        public function setSongNameValidation(songName:String, isValid:Boolean):void
        {
            this.songNameCache.cacheTestedName(songName, isValid);
        }

        public function getSongNameValidation(songName:String):int
        {
            if (this.songNameCache.isNameCached(songName))
            {
                return ((this.songNameCache.isNameValid(songName)) ? SONG_NAME_VALID : SONG_NAME_INVALID);
            };
            return (SONG_NAME_NOT_VERIFIED);
        }

        public function setSharedSongs(songs:Vector.<SongDetailsVO>):void
        {
            this._sharedSongs = songs;
            dispatch(new MusicStudioSongEvent(MusicStudioSongEvent.SHARED_SONGS_UPDATED, this.sharedSongs));
        }

        public function get sharedSongs():Vector.<SongDetailsVO>
        {
            return (this._sharedSongs);
        }

        protected function onPulseTimerEvent(e:TimerEvent):void
        {
            var elapsedTime:Number = (getTimer() - this.lastPulse);
            var pulse:MusicStudioEvent = new MusicStudioEvent(MusicStudioEvent.PULSE, {"elapsed":elapsedTime});
            if (this.recordingStatus == MusicStudioRecordingStatusEnum.ON)
            {
                this._recordingElapsedTime = (this._recordingElapsedTime + elapsedTime);
            };
            dispatch(pulse);
            this.lastPulse = getTimer();
        }

        public function get recordingElapsedTime():Number
        {
            return (this._recordingElapsedTime);
        }

        public function startSong(genreId:uint):void
        {
            this.currentSongDetails = new SongDetailsVO(genreId);
            this.lastPulse = getTimer();
            this.pulseTimer.start();
        }

        public function storeSong(str:String):void
        {
            this.currentSongDetails.append(str);
        }

        public function stopSong():void
        {
            this.pulseTimer.stop();
            this.pulseTimer.reset();
            this._recordingElapsedTime = 0;
        }

        public function getRecordingStatus():String
        {
            return (this.recordingStatus);
        }

        public function setRecordingStatus(status:String):void
        {
            this.recordingStatus = status;
            this._recordingElapsedTime = 0;
        }

        public function get previousRoom():String
        {
            return (this._previousRoom);
        }

        public function set previousRoom(value:String):void
        {
            this._previousRoom = value;
        }

        public function getMaxNumberOfSaveSlots():uint
        {
            return (this.MAX_NUM_SAVE_SLOTS);
        }


    }
}//package com.clubpenguin.music.game.model
