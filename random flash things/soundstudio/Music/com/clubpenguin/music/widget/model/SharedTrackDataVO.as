//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.model
{
    public class SharedTrackDataVO 
    {

        private var _playerID:int;
        private var _playerSwid:String;
        private var _playerNickname:String;
        private var _songID:int;
        private var _likeCount:int;
        private var _canLikeSong:Boolean = false;

        public function SharedTrackDataVO(playerID:Number, nickname:String, swid:String, songID:Number, likeCount:Number)
        {
            this._playerID = playerID;
            this._playerNickname = nickname;
            this._playerSwid = swid;
            this._songID = songID;
            this._likeCount = likeCount;
        }

        public function get playerID():int
        {
            return (this._playerID);
        }

        public function get playerSwid():String
        {
            return (this._playerSwid);
        }

        public function get playerNickname():String
        {
            return (this._playerNickname);
        }

        public function get songID():int
        {
            return (this._songID);
        }

        public function get likeCount():int
        {
            return (this._likeCount);
        }

        public function setLikesCount(numLikes:int):void
        {
            this._likeCount = numLikes;
        }

        public function get canLikeSong():Boolean
        {
            return (this._canLikeSong);
        }

        public function set canLikeSong(canLike:Boolean):void
        {
            this._canLikeSong = canLike;
        }


    }
}//package com.clubpenguin.music.widget.model
