package com.clubpenguin.game{
    public class HostAccess {

        private static var $_gameHost:ICPGameHost;


        public static function setHost(_arg_1:ICPGameHost):void{
            $_gameHost = _arg_1;
        }

        public static function getHost():ICPGameHost{
            return ($_gameHost);
        }


    }
}//package com.clubpenguin.game
