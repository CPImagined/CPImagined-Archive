package com.clubpenguin.games.arrow.movies{
    import flash.display.MovieClip;

    public class BossMC extends MovieClip {

        public var art:MovieClip;//instance name


        public function setArtMain(_arg_1:String):void{
            this.art.gotoAndStop(_arg_1);
            if (((((((_arg_1 == "hitNormal") || (_arg_1 == "hitStrong")) || (_arg_1 == "ko")) || (_arg_1 == "swipe")) || (_arg_1 == "slam")) || (_arg_1 == "intro"))){
                this.art.art.gotoAndStop(1);
            };
            if (_arg_1 == "still"){
                this.art.art.head.eyeL.gotoAndStop("still");
                this.art.art.head.eyeR.gotoAndStop("still");
            };
        }

        public function setArtSub(_arg_1:String):void{
            this.art.art.gotoAndStop(_arg_1);
        }


    }
}//package com.clubpenguin.games.arrow.movies
