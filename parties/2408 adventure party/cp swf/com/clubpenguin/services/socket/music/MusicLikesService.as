//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.music
{
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.services.socket.IConnection;
    import org.osflash.signals.ISignal;

    public class MusicLikesService extends MusicService implements IMusicLikesService 
    {

        private static const MUSIC_LIKES_CAN_LIKE_TRACK:String = "canliketrack";
        private static const MUSIC_LIKES_SEND_LIKE:String = "liketrack";
        private static const MUSIC_LIKES_ON_LIKE_COUNT:String = "getlikecountfortrack";

        private var _likesCount:Signal;
        private var _checkCanLikeTrack:Signal;
        private var _cannotLikeTrack:Signal;
        private var _storedSongForLikeRequest:Object;

        public function MusicLikesService()
        {
            Log.info("Creating MusicLikesService");
        }

        override public function init(connection:IConnection):void
        {
            super.init(connection);
            this._likesCount = new Signal(int);
            this._cannotLikeTrack = new Signal();
            this._checkCanLikeTrack = new Signal(Boolean);
        }

        override protected function onResponded(messageType:String, responseData:Array):void
        {
            super.onResponded(messageType, responseData);
            switch (messageType)
            {
                case MUSIC_LIKES_ON_LIKE_COUNT:
                    this.onLikeCountRequest(int(responseData[2]));
                    break;
                case MUSIC_LIKES_CAN_LIKE_TRACK:
                    this.onCanILikeTrackResponse(int(responseData[2]));
                    break;
                case MUSIC_LIKES_SEND_LIKE:
                    this.onLikeTrackResponse(int(responseData[3]));
                    break;
            };
        }

        private function onLikeCountRequest(likeCount:int):void
        {
            this._likesCount.dispatch(likeCount);
        }

        private function onLikeTrackResponse(likeCount:int):void
        {
            this._likesCount.dispatch(likeCount);
        }

        private function onCannotLikeTrackResponse():void
        {
            this._cannotLikeTrack.dispatch();
        }

        private function onCanILikeTrackResponse(response:int):void
        {
            switch (response)
            {
                case 0:
                    this.onCannotLikeTrackResponse();
                    this._checkCanLikeTrack.dispatch(false);
                    break;
                case 1:
                    if (this._storedSongForLikeRequest.likeSong)
                    {
                        this.sendLike();
                    }
                    else
                    {
                        this._checkCanLikeTrack.dispatch(true);
                    };
                    break;
                case -1:
                    Log.error("Likes service is reporting down.");
                    break;
                default:
                    Log.error("Unknown ");
            };
        }

        public function requestSendLike(playerID:int, songID:int):void
        {
            this._storedSongForLikeRequest = {
                "playerID":playerID,
                "songID":songID,
                "likeSong":true
            };
            connection.sendMessage(MUSIC_CATAGORY, MUSIC_LIKES_CAN_LIKE_TRACK, [playerID, songID]);
        }

        public function requestCanLikeSong(playerID:int, songID:int):void
        {
            this._storedSongForLikeRequest = {
                "playerID":playerID,
                "songID":songID,
                "likeSong":false
            };
            connection.sendMessage(MUSIC_CATAGORY, MUSIC_LIKES_CAN_LIKE_TRACK, [playerID, songID]);
        }

        private function sendLike():void
        {
            connection.sendMessage(MUSIC_CATAGORY, MUSIC_LIKES_SEND_LIKE, [this._storedSongForLikeRequest.playerID, this._storedSongForLikeRequest.songID]);
        }

        public function requestLikeCountBySongID(playerID:int, songID:int):void
        {
            connection.sendMessage(MUSIC_CATAGORY, MUSIC_LIKES_ON_LIKE_COUNT, [playerID, songID]);
        }

        public function get likesCount():ISignal
        {
            return (this._likesCount);
        }

        public function get cannotLikeTrack():ISignal
        {
            return (this._cannotLikeTrack);
        }

        public function get checkCanLikeTrack():ISignal
        {
            return (this._checkCanLikeTrack);
        }


    }
}//package com.clubpenguin.services.socket.music
