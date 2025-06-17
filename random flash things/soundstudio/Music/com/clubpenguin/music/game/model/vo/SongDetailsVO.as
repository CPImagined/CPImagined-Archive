//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.model.vo
{
    public class SongDetailsVO 
    {

        private static const EOF:String = "FFFF";

        public var canLikeSong:Boolean = false;
        public var playing:Boolean = false;
        private var _songId:int;
        private var _songName:String;
        private var _genreId:uint;
        private var _songData:String;
        private var _playerId:int;
        private var _playerName:String;
        private var _likesCount:int;

        public function SongDetailsVO(genreId:uint)
        {
            this._songData = "";
            this._genreId = genreId;
        }

        public function get songId():int
        {
            return (this._songId);
        }

        public function get songName():String
        {
            return (this._songName);
        }

        public function get genreId():uint
        {
            return (this._genreId);
        }

        public function get songData():String
        {
            return (this._songData);
        }

        public function get playerId():int
        {
            return (this._playerId);
        }

        public function get playerName():String
        {
            return (this._playerName);
        }

        public function get likesCount():int
        {
            return (this._likesCount);
        }

        public function setLikesCount(numLikes:int):void
        {
            this._likesCount = numLikes;
        }

        public function setPlayerId(playerId:int):void
        {
            this._playerId = playerId;
        }

        public function setPlayerName(playerName:String):void
        {
            this._playerName = playerName;
        }

        public function setSongName(songName:String):void
        {
            this._songName = songName;
        }

        public function setSongId(songId:int):void
        {
            this._songId = songId;
        }

        public function append(value:String):void
        {
            this._songData = (this._songData + ("," + value));
        }

        public function endSong(timestamp_hex:String):void
        {
            this._songData = (this._songData + ((("," + EOF) + "|") + timestamp_hex));
        }

        public function toString():String
        {
            return (((this.songName + ",") + this.genreId) + this.songData);
        }

        public function get songLength():Number
        {
            var songDataSplit:Array = this._songData.split(",");
            var endData:String = songDataSplit[(songDataSplit.length - 1)];
            if (endData.split("|")[0] == EOF)
            {
                return (parseInt(endData.split("|")[1], 16));
            };
            return (-1);
        }


    }
}//package com.clubpenguin.music.game.model.vo
