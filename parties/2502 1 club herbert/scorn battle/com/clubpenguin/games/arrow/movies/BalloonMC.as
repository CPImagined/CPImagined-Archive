package com.clubpenguin.games.arrow.movies{
    import flash.display.MovieClip;

    public class BalloonMC extends MovieClip {

        public var art:MovieClip;//instance name


        public function setArtMain(_arg_1:String):void{
            this.art.gotoAndStop(_arg_1);
            if (_arg_1 == "pop"){
                this.art.art.gotoAndStop(1);
            };
        }

        public function setArtSub(_arg_1:String):void{
            this.art.art.gotoAndStop(_arg_1);
        }


    }
}//package com.clubpenguin.games.arrow.movies
