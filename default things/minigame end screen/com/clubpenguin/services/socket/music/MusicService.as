//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.music
{
    import com.clubpenguin.lib.services.socket.IConnection;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.util.Log;
    import org.osflash.signals.ISignal;

    public class MusicService implements IMusicService 
    {

        public static const MUSIC_CATAGORY:String = "musictrack";
        private static const MUSIC_DELETE_TRACK:String = "deletetrack";
        private static const MUSIC_GET_TRACK:String = "loadmusictrack";
        private static const MUSIC_GET_MY_TRACKS:String = "getmymusictracks";
        private static const MUSIC_GET_SHARED_TRACKS:String = "getsharedmusictracks";
        private static const MUSIC_SHARE_TRACK:String = "sharemymusictrack";
        private static const MUSIC_SAVE_TRACK:String = "savemymusictrack";
        private static const MUSIC_BROADCAST_MUSIC_TRACKS:String = "broadcastingmusictracks";
        private static const MUSIC_GET_TRACK_LIKES:String = "getlikecountfortrack";
        private static const MUSIC_GET_LIKES_REFRESH:String = "refreshmytracklikes";

        protected var connection:IConnection;
        private var _retrievedSong:Signal;
        private var _mySongs:Signal;
        private var _saveSong:Signal;
        private var _deleteSong:Signal;
        private var _shareSong:Signal;
        private var _getSharedSongSignal:Signal;
        private var _broadcastMusicTracks:Signal;
        private var _songLikes:Signal;

        public function MusicService()
        {
            Log.info("Created MusicService");
        }

        public function init(connection:IConnection):void
        {
            this.connection = connection;
            this._retrievedSong = new Signal(String);
            this._mySongs = new Signal(String);
            this._saveSong = new Signal(String);
            this._deleteSong = new Signal(String);
            this._shareSong = new Signal(String);
            this._getSharedSongSignal = new Signal(String);
            this._broadcastMusicTracks = new Signal(Array);
            this._songLikes = new Signal(String);
            connection.getResponded().add(this.onResponded);
        }

        public function requestSongByID(playerId:int, songID:int):void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_GET_TRACK, [playerId, songID]);
        }

        public function requestMySongs():void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_GET_MY_TRACKS);
        }

        public function requestSharedSongs():void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_GET_SHARED_TRACKS);
        }

        public function requestMyLikes():void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_GET_LIKES_REFRESH);
        }

        public function requestSongLikes(playerID:int, songID:int):void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_GET_TRACK_LIKES, [playerID, songID]);
        }

        public function saveSong(songData:String):void
        {
            Log.debug("");
            var songParts:Array = songData.split(",");
            var songName:String = (songParts.shift() as String);
            songData = songParts.join(",");
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_SAVE_TRACK, [songName, songData, MusicDataEncoder.encode(songData)]);
        }

        public function deleteSong(songData:String):void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_DELETE_TRACK, [songData]);
        }

        public function shareSong(songData:String, shareFlag:String):void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_SHARE_TRACK, [songData, shareFlag]);
        }

        public function getSongData(songData:String):void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_GET_TRACK, [songData]);
        }

        public function requestBroadcastingMusicTracks():void
        {
            this.connection.sendMessage(MUSIC_CATAGORY, MUSIC_BROADCAST_MUSIC_TRACKS);
        }

        protected function onResponded(messageType:String, responseData:Array):void
        {
            var errorMessage:String = this.validateResponse(messageType, responseData);
            var isValidResponse:* = (errorMessage == "");
            Log.debug(((messageType + " ") + responseData));
            if (!isValidResponse)
            {
                throw (new Error(((("[MusicService] Invalid response from connection for message type '" + messageType) + "'") + errorMessage)));
            };
            switch (messageType)
            {
                case MUSIC_GET_TRACK:
                    this.onSongResponded(String(responseData[4]));
                    break;
                case MUSIC_GET_MY_TRACKS:
                    this.onMySongsResponded(String(responseData[2]));
                    break;
                case MUSIC_GET_SHARED_TRACKS:
                    this.onSharedSongsResponded(String(responseData[2]));
                    break;
                case MUSIC_SAVE_TRACK:
                    this.onSaveSongResponded(String(responseData[1]));
                    break;
                case MUSIC_BROADCAST_MUSIC_TRACKS:
                    responseData.shift();
                    this.onBroadcastMusicTracksReceived(responseData);
                    break;
                case MUSIC_DELETE_TRACK:
                    this.onDeleteSongResponded(String(responseData[1]));
                    break;
                case MUSIC_SHARE_TRACK:
                    this.onShareSongResponded(String(responseData[1]));
                    break;
                case MUSIC_GET_TRACK_LIKES:
                    this.onSongLikesResponded(String(((responseData[2] + "|") + responseData[3])));
                    break;
            };
        }

        private function validateResponse(messageType:String, responseData:Array):String
        {
            var isValid:Boolean;
            var expectedNumTracks:int;
            var tracks:Array;
            var i:int;
            var currentTrack:String;
            switch (messageType)
            {
                case MUSIC_GET_TRACK:
                    isValid = MusicDataEncoder.isValid(responseData[4], responseData[5]);
                    return ((isValid) ? "" : "Message encoding is not what was expected");
                case MUSIC_GET_MY_TRACKS:
                    expectedNumTracks = parseInt((responseData[1] as String));
                    if (expectedNumTracks == 0)
                    {
                        return ("");
                    };
                    tracks = (responseData[2] as String).split(",");
                    if (((responseData[2] == "") || (responseData[2] == null)))
                    {
                        tracks = new Array();
                    };
                    if (expectedNumTracks != tracks.length)
                    {
                        return ((("Unexpected number of tracks: " + expectedNumTracks) + " not ") + tracks.length);
                    };
                    i = 0;
                    while (i < tracks.length)
                    {
                        currentTrack = (tracks[i] as String);
                        if (currentTrack.split("|").length != 4)
                        {
                            return (((("Track details missing expected 4 parts (track[" + i) + "]") + tracks[i]) + ")");
                        };
                        i++;
                    };
                    return ("");
                case MUSIC_SAVE_TRACK:
                    return ("");
                case MUSIC_GET_SHARED_TRACKS:
                    return ("");
            };
            return ("");
        }

        private function onSongResponded(songData:String):void
        {
            this._retrievedSong.dispatch(songData);
        }

        private function onMySongsResponded(songData:String):void
        {
            this._mySongs.dispatch(songData);
        }

        private function onSharedSongsResponded(songsData:String):void
        {
            this._getSharedSongSignal.dispatch(songsData);
        }

        private function onSaveSongResponded(songData:String):void
        {
            this._saveSong.dispatch(songData);
        }

        private function onBroadcastMusicTracksReceived(tracksData:Array):void
        {
            this._broadcastMusicTracks.dispatch(tracksData);
        }

        private function onDeleteSongResponded(songData:String):void
        {
            Log.debug("");
            this._deleteSong.dispatch(songData);
        }

        private function onShareSongResponded(songData:String):void
        {
            Log.debug("");
            this._shareSong.dispatch(songData);
        }

        private function onSongLikesResponded(songData:String):void
        {
            this._songLikes.dispatch(songData);
        }

        public function get songSignal():ISignal
        {
            return (this._retrievedSong);
        }

        public function get mySongsSignal():ISignal
        {
            return (this._mySongs);
        }

        public function get saveSongSignal():ISignal
        {
            return (this._saveSong);
        }

        public function get deleteSongSignal():ISignal
        {
            return (this._deleteSong);
        }

        public function get shareSongSignal():ISignal
        {
            return (this._shareSong);
        }

        public function get songLikesSignal():ISignal
        {
            return (this._songLikes);
        }

        public function get getSharedSongSignal():ISignal
        {
            return (this._getSharedSongSignal);
        }

        public function get broadcastMusicTracksSignal():ISignal
        {
            return (this._broadcastMusicTracks);
        }


    }
}//package com.clubpenguin.services.socket.music
