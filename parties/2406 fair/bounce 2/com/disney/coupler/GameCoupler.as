package com.disney.coupler{
    import flash.display.Sprite;

    public class GameCoupler extends Sprite implements ICouplerGame, ICouplerHost {

        private static var $_uid:int = -1;

        protected var __uid:int;
        protected var __game:ICouplerGame;
        protected var __host:ICouplerHost;

        public function GameCoupler(){
            this.__uid = ++$_uid;
        }

        public function setHost(_arg_1:ICouplerHost):void{
            if (_arg_1 != null){
                this.__host = _arg_1;
            } else {
                throw (this.getUniqueName() + " host is not a valid ICouplerHost");
            };
        }

        public function setGame(_arg_1:ICouplerGame):void{
            if (_arg_1 != null){
                this.__game = _arg_1;
            } else {
                throw (this.getUniqueName() + " game is not a valid ICouplerGame");
            };
        }

        public function getUniqueName():String{
            return (("[GameCoupler" + this.__uid) + "]");
        }

        public function destroy():void{
        }

        public function pause(_arg_1:Boolean):void{
        }


    }
}//package com.disney.coupler
