//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.model.vo
{
    public class SongNameValidationVO 
    {

        private var _songName:String;
        private var _isValid:Boolean;

        public function SongNameValidationVO(songName:String, isValid:Boolean)
        {
            this._songName = songName;
            this._isValid = isValid;
        }

        public function get songName():String
        {
            return (this._songName);
        }

        public function get isValid():Boolean
        {
            return (this._isValid);
        }


    }
}//package com.clubpenguin.music.game.model.vo
