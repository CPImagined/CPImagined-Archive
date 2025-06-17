//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.player
{
    import flash.events.EventDispatcher;
    import com.clubpenguin.music.resources.song.SongRecorded;
    import flash.display.Loader;
    import __AS3__.vec.Vector;
    import flash.system.ApplicationDomain;
    import flash.utils.Timer;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import flash.events.TimerEvent;
    import com.clubpenguin.lib.util.Log;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.system.LoaderContext;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import __AS3__.vec.*;

    public class MusicPlayer extends EventDispatcher implements IMusicPlayer 
    {

        public static const EVENT_LOAD_COMPLETE:String = "event_load_complete";
        public static const EVENT_LOAD_FAIL:String = "event_load_fail";
        public static const EVENT_SONG_COMPLETE:String = "event_song_complete";
        public static const EVENT_SONG_STOP:String = "event_song_stop";

        private const PATH_ALBUM_POP:String = "/music/albums/album_pop.swf";
        private const PATH_ALBUM_DUBSTEP:String = "/music/albums/album_dubstep.swf";
        private const PATH_ALBUM_DANCE:String = "/music/albums/album_dance.swf";
        private const PATH_ALBUM_ROCK:String = "/music/albums/album_rock.swf";
        private const PATH_ALBUM_SPOOKY:String = "/music/albums/album_spooky.swf";
        private const FADE_INTERVAL_TIME:Number = 100;
        private const FADE_INTERVAL_DELTA:Number = 0.05;
        private const NUM_GENRES:Number = 4;

        private var _currentSong:SongRecorded;
        private var _queuedSong:SongRecorded;
        private var _assetLoader:Loader;
        private var _loadedGenres:Vector.<ApplicationDomain>;
        private var _loadedSongs:Array;
        private var _fadeTimer:Timer;
        private var _currentFadeDelta:Number;
        private var _isMute:Boolean = false;
        [Inject]
        public var environmentData:EnvironmentDataVO;
        [Inject]
        public var musicService:IMusicService;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var mainModel:MainModel;


        public function init():void
        {
            this._loadedGenres = new Vector.<ApplicationDomain>(this.NUM_GENRES);
            this._loadedGenres.push(null);
            this._loadedSongs = new Array();
            this._fadeTimer = new Timer(this.FADE_INTERVAL_TIME);
            this._fadeTimer.addEventListener(TimerEvent.TIMER, this._fadeTimer_Tick_Handler);
            Log.debug(("bridge : " + this.bridge));
            this.bridge.getStartIglooMusicSignal().add(this.bridge_PlaySong_Handler);
            this.bridge.getStopIglooMusicSignal().add(this.bridge_StopSong_Hanler);
        }

        public function loadSong(songRecorded:SongRecorded):void
        {
            Log.debug("");
            if (this._currentSong != null)
            {
                this.stop();
                this.loadNextSong(songRecorded);
            }
            else
            {
                if (this._currentSong == null)
                {
                    this.loadNextSong(songRecorded);
                };
            };
        }

        private function loadNextSong(songRecorded:SongRecorded):void
        {
            this._currentSong = songRecorded;
            if (((!(this._loadedSongs[this._currentSong.songID] == null)) && (!(songRecorded.songID == 0))))
            {
                this.musicService_LoadSong_Handler(this._loadedSongs[this._currentSong.songID]);
            }
            else
            {
                if (this._currentSong.rawData != null)
                {
                    this.musicService_LoadSong_Handler(this._currentSong.rawData);
                }
                else
                {
                    this.musicService.songSignal.addOnce(this.musicService_LoadSong_Handler);
                    this.musicService.requestSongByID(songRecorded.playerID, songRecorded.songID);
                };
            };
        }

        private function musicService_LoadSong_Handler(data:String):void
        {
            this._loadedSongs[this._currentSong.songID] = data;
            this._currentSong.convertRawData(data);
            this.loadGenre(this._currentSong.genreID);
        }

        public function loadEmptySong(genreID:int):void
        {
            if (this._currentSong == null)
            {
                this._currentSong = new SongRecorded(-1, -1);
                this._currentSong.convertRawData(genreID.toString());
                this.loadGenre(genreID);
            };
        }

        private function loadGenre(genreID:int):void
        {
            var url:URLRequest;
            var _assetLoader_Fail_Handler:Function;
            _assetLoader_Fail_Handler = function (e:Event):void
            {
                Log.debug(("_assetLoader_Fail_Handler: " + url));
                _loadedGenres[genreID] = null;
                dispatchEvent(new Event(MusicPlayer.EVENT_LOAD_FAIL, false, true));
            };
            if (((this._loadedGenres.length > genreID) && (!(this._loadedGenres[genreID] == null))))
            {
                Log.debug("Loading cached genre.");
                this._assetLoader_Complete_Handler(null);
                return;
            };
            var genrePath:String = this.albumPathFromID(genreID);
            var assetPath:String = (this.environmentData.globalContentPath + genrePath);
            url = new URLRequest(assetPath);
            this._assetLoader = new Loader();
            this._assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this._assetLoader_Complete_Handler);
            this._assetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _assetLoader_Fail_Handler);
            var appDomain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
            this._loadedGenres[genreID] = appDomain;
            var loaderContext:LoaderContext = new LoaderContext(false, appDomain, null);
            this._assetLoader.load(url, loaderContext);
        }

        private function _assetLoader_Complete_Handler(e:Event):void
        {
            Log.debug("");
            dispatchEvent(new Event(MusicPlayer.EVENT_LOAD_COMPLETE, false, true));
            if (this._currentSong.autoPlay)
            {
                this.play();
            };
        }

        private function fadeOut():void
        {
            this._currentFadeDelta = (this.FADE_INTERVAL_DELTA * -1);
            this._fadeTimer.reset();
            this._fadeTimer.start();
        }

        private function fadeIn():void
        {
            this._currentSong.volume = 0;
            this._currentFadeDelta = this.FADE_INTERVAL_DELTA;
            this._fadeTimer.reset();
            this._fadeTimer.start();
        }

        private function _fadeTimer_Tick_Handler(e:TimerEvent):void
        {
            var currentVolume:Number;
            if (this._currentSong == null)
            {
                this._fadeTimer.reset();
                return;
            };
            currentVolume = this._currentSong.volume;
            currentVolume = Math.min(Math.max((this._currentFadeDelta + currentVolume), 0), 1);
            this._currentSong.volume = currentVolume;
            if (((this._currentFadeDelta < 0) && (currentVolume == 0)))
            {
                this._fadeTimer.reset();
                this.song_Complete_Handler(null);
            }
            else
            {
                if (((this._currentFadeDelta > 0) && (currentVolume == 1)))
                {
                    this._fadeTimer.reset();
                };
            };
        }

        public function play():void
        {
            if (this._currentSong != null)
            {
                if (this._currentSong.fade)
                {
                };
                if (this._isMute)
                {
                    this._currentSong.mute();
                };
                this._currentSong.play(this._loadedGenres[this._currentSong.genreID]);
                this._currentSong.addEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.song_Complete_Handler);
                Log.debug((" send request to mute room music" + this.bridge));
                this.bridge.send(new AVMBridgeMessage(AVMBridgeMessage.MSG_MUTE_ROOM_MUSIC));
            };
        }

        public function stop(fade:Boolean=false):void
        {
            if (this._currentSong != null)
            {
                this._currentSong.loop = false;
                this._currentSong.stop();
                this._currentSong.removeEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.song_Complete_Handler);
                this._currentSong = null;
                dispatchEvent(new Event(MusicPlayer.EVENT_SONG_STOP, false, true));
            };
        }

        public function appendStatus(status:String):void
        {
            if (this._currentSong != null)
            {
                this._currentSong.appendStatus(status);
            };
        }

        public function song_Complete_Handler(e:Event):void
        {
            Log.debug("");
            this._currentSong.removeEventListener(MusicPlayer.EVENT_SONG_COMPLETE, this.song_Complete_Handler);
            this._currentSong.stop();
            this._currentSong = null;
            if (this._queuedSong != null)
            {
                this.loadSong(this._queuedSong);
            }
            else
            {
                dispatchEvent(new Event(EVENT_SONG_COMPLETE, false, true));
            };
        }

        public function mute():void
        {
            Log.debug("");
            this._isMute = true;
            if (this._currentSong != null)
            {
                this._currentSong.mute();
            };
        }

        public function unmute():void
        {
            Log.debug("");
            this._isMute = false;
            if (this._currentSong != null)
            {
                this._currentSong.unmute();
            };
        }

        public function resetLoops():void
        {
            if (this._currentSong != null)
            {
                this._currentSong.resetLoops();
            };
        }

        private function bridge_PlaySong_Handler(payload:Object):void
        {
            var playerID:int = parseInt(String(payload.iglooPlayerID));
            var songID:int = parseInt(String(payload.songID));
            Log.debug(((playerID + " ") + songID));
            this.loadSong(new SongRecorded(songID, playerID, true, false, true));
        }

        private function bridge_StopSong_Hanler():void
        {
            Log.debug("");
            this.stop(false);
        }

        private function albumPathFromID(albumID:Number):String
        {
            var albumPath:String;
            switch (albumID)
            {
                case 0:
                    albumPath = this.PATH_ALBUM_POP;
                    break;
                case 1:
                    albumPath = this.PATH_ALBUM_ROCK;
                    break;
                case 2:
                    albumPath = this.PATH_ALBUM_DANCE;
                    break;
                case 3:
                    albumPath = this.PATH_ALBUM_DUBSTEP;
                    break;
                case 4:
                    albumPath = this.PATH_ALBUM_SPOOKY;
                    break;
                default:
                    albumPath = this.PATH_ALBUM_POP;
            };
            return (albumPath);
        }


    }
}//package com.clubpenguin.music.player
