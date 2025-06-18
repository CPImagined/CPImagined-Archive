package com.clubpenguin.games.arrow.movies{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;

    public class HudMC extends MovieClip {

        public var game:MovieClip;
        public var art:MovieClip;//instance name
        public var closeBtn1:SimpleButton;
        public var closeBtn2:SimpleButton;


        public function setScore(_arg_1:Number):void{
        }

        public function setBossHP(_arg_1:Number):void{
            this.art.art.hp.art.gotoAndStop(_arg_1);
        }

        public function initTally():void{
            this.art.art.tens.gotoAndStop("flick");
            this.art.art.hundreds.gotoAndStop("flick");
            this.art.art.thousands.gotoAndStop("flick");
            this.art.art.tenthousands.gotoAndStop("flick");
            this.art.art.hundredthousands.gotoAndStop("flick");
        }

        public function setOnes(_arg_1:Number):void{
        }

        public function setTens(_arg_1:Number):void{
            this.art.art.tens.gotoAndStop((_arg_1 + 2));
        }

        public function setHundreds(_arg_1:Number):void{
            this.art.art.hundreds.gotoAndStop((_arg_1 + 2));
        }

        public function setThousands(_arg_1:Number):void{
            this.art.art.thousands.gotoAndStop((_arg_1 + 2));
        }

        public function setTenthousands(_arg_1:Number):void{
            this.art.art.tenthousands.gotoAndStop((_arg_1 + 2));
        }

        public function setHundredthousands(_arg_1:Number):void{
            this.art.art.hundredthousands.gotoAndStop((_arg_1 + 2));
        }

        public function endBoss():void{
        }

        public function setArtMain(_arg_1:String):void{
            this.art.gotoAndStop(_arg_1);
            if (_arg_1 == "hint"){
                this.closeBtn1 = this.art.art.close_btn;
                this.closeBtn1.addEventListener(MouseEvent.CLICK, this.onCloseHintClicked);
                this.closeBtn2 = this.art.art.close_btn2;
                this.closeBtn2.addEventListener(MouseEvent.CLICK, this.onCloseHintClicked);
            };
            if (_arg_1 == "gameover"){
                this.closeBtn1 = this.art.art.close_btn;
                this.closeBtn1.addEventListener(MouseEvent.CLICK, this.onCloseClicked);
                this.closeBtn2 = this.art.art.close_btn2;
                this.closeBtn2.addEventListener(MouseEvent.CLICK, this.onCloseClicked2);
            };
        }

        private function onCloseHintClicked(_arg_1:MouseEvent):void{
            this.game.closeHint();
        }

        private function onCloseClicked(_arg_1:MouseEvent):void{
            this.game.closeGame();
        }
		
		private function onCloseClicked2(_arg_1:MouseEvent):void{
            this.game.closeGame();
        }

        public function setArtSub(_arg_1:String):void{
            this.art.art.gotoAndStop(_arg_1);
        }


    }
}//package com.clubpenguin.games.arrow.movies
