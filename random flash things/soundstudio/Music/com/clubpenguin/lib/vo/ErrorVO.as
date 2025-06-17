//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo
{
    public class ErrorVO 
    {

        private var _errorMessage:String;
        private var _errorCode:uint;
        private var _buttonURL:String;
        private var _buttonText:String;
        private var _buttonTarget:String;

        public function ErrorVO(errorMessage:String, errorCode:uint=0, buttonURL:String="", buttonText:String="", buttonTarget:String="_self")
        {
            this._errorMessage = errorMessage;
            this._errorCode = errorCode;
            this._buttonURL = buttonURL;
            this._buttonText = buttonText;
            this._buttonTarget = buttonTarget;
        }

        public function get errorMessage():String
        {
            return (this._errorMessage);
        }

        public function get errorCode():uint
        {
            return (this._errorCode);
        }

        public function get buttonURL():String
        {
            return (this._buttonURL);
        }

        public function get buttonText():String
        {
            return (this._buttonText);
        }

        public function get buttonTarget():String
        {
            return (this._buttonTarget);
        }


    }
}//package com.clubpenguin.lib.vo
