package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import flash.display.SimpleButton;
    import com.clubpenguin.games.arrow.movies.HudMC;
    import flash.events.MouseEvent;
    import com.clubpenguin.game.HostAccess;

    public class Hud extends MovieClip {

        private var game:ArrowEngine;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var dead:Boolean;
        public var scoreChanged:Boolean;
        public var hpChanged:Boolean;
        public var type:String;
        public var tallyInitilized:Boolean;
        public var tallyComplete:Boolean;
        public var ones:String;
        public var tens:String;
        public var hundreds:String;
        public var thousands:String;
        public var tenthousands:String;
        public var hundredthousands:String;
        public var onesN:Number;
        public var tensN:Number;
        public var hundredsN:Number;
        public var thousandsN:Number;
        public var tenthousandsN:Number;
        public var hundredthousandsN:Number;
        public var onesSet:Boolean;
        public var tensSet:Boolean;
        public var hundredsSet:Boolean;
        public var thousandsSet:Boolean;
        public var tenthousandsSet:Boolean;
        public var hundredthousandsSet:Boolean;
        public var tallyCountDownN:Number;
        public var tallyCountDownNDefault:Number;
        public var color:Color;
        public var closeBtn:SimpleButton;

        public function Hud(_arg_1:ArrowEngine, _arg_2:String, _arg_3:Number, _arg_4:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.hudHolder;
            this.movie = new HudMC();
            this.movie.game = this.game;
            this.gameplayHolder.addChild(this.movie);
            this.movie.x = _arg_3;
            this.movie.y = _arg_4;
            this.type = _arg_2;
            this.mainAction = this.type;
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
            this.scoreChanged = true;
            this.hpChanged = true;
            this.tallyInitilized = false;
            this.tallyComplete = false;
            this.ones = "0";
            this.tens = "0";
            this.hundreds = "0";
            this.thousands = "0";
            this.tenthousands = "0";
            this.hundredthousands = "0";
            this.onesN = 0;
            this.tensN = 0;
            this.hundredsN = 0;
            this.thousandsN = 0;
            this.tenthousandsN = 0;
            this.hundredthousandsN = 0;
            this.onesSet = false;
            this.tensSet = false;
            this.hundredsSet = false;
            this.thousandsSet = false;
            this.tenthousandsSet = false;
            this.hundredthousandsSet = false;
            this.tallyCountDownN = 20;
            this.tallyCountDownNDefault = 20;
            this.color = new Color();
            this.closeBtn = this.movie.art.close_btn;
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.onCloseClicked);
        }

        private function onCloseClicked(_arg_1:MouseEvent):void{
            this.game.closeGame();
        }

        public function update():void{
            if (this.mainChanged){
                this.movie.setArtMain(this.mainAction);
                this.mainChanged = false;
                this.subChanged = true;
            };
            if (this.game.gameEnding){
                if (this.game.showScoreTally == false){
                    this.movie.endBoss();
                };
            };
            if (this.hpChanged){
                this.movie.setBossHP(Math.floor(this.game.bossHP));
                this.hpChanged = false;
            };
            if (this.scoreChanged){
                if (this.game.gameEnding == false){
                    this.movie.setScore(this.game.scoreN);
                };
                this.scoreChanged = false;
            };
            if (this.game.showScoreTally){
                if (this.tallyInitilized == false){
                    if (this.movie.art.art.currentFrame >= 73){
                        this.ones = String(this.game.scoreN);
                        this.tens = String(this.game.scoreN);
                        this.hundreds = String(this.game.scoreN);
                        this.thousands = String(this.game.scoreN);
                        this.tenthousands = String(this.game.scoreN);
                        this.hundredthousands = String(this.game.scoreN);
                        this.onesN = Number(this.ones.slice(-1));
                        this.tensN = Number(this.tens.slice(-2));
                        this.hundredsN = Number(this.hundreds.slice(-3));
                        this.thousandsN = Number(this.thousands.slice(-4));
                        this.tenthousandsN = Number(this.tenthousands.slice(-5));
                        this.hundredthousandsN = Number(this.hundredthousands.slice(-6));
                        this.onesN = Math.floor(this.onesN);
                        this.tensN = Math.floor((this.tensN * 0.1));
                        this.hundredsN = Math.floor((this.hundredsN * 0.01));
                        this.thousandsN = Math.floor((this.thousandsN * 0.001));
                        this.tenthousandsN = Math.floor((this.tenthousandsN * 0.0001));
                        this.hundredthousandsN = Math.floor((this.hundredthousandsN * 1E-5));
                        this.movie.initTally();
                        this.tallyInitilized = true;
                        if (this.game.hasPin){
                            this.movie.art.art.reward.gotoAndStop("coins");
                        } else {
                            this.movie.art.art.reward.gotoAndStop("pin");
                            HostAccess.getHost().purchaseItem(ArrowEngine.PIN_ITEM_ID);
                        };
                    };
                };
            };
            if (this.tallyInitilized){
                if (this.tallyComplete == false){
                    if (this.tallyCountDownN > 0){
                        this.tallyCountDownN--;
                    } else {
                        this.tallyCountDownN = this.tallyCountDownNDefault;
                        this.tallyCountDownNDefault = Math.floor((this.tallyCountDownNDefault * 0.7));
                        if (this.onesSet == false){
                            this.movie.setOnes(this.onesN);
                            this.onesSet = true;
                        } else {
                            if (this.tensSet == false){
                                this.movie.setTens(this.tensN);
                                this.tensSet = true;
                            } else {
                                if (this.hundredsSet == false){
                                    this.movie.setHundreds(this.hundredsN);
                                    this.hundredsSet = true;
                                } else {
                                    if (this.thousandsSet == false){
                                        this.movie.setThousands(this.thousandsN);
                                        this.thousandsSet = true;
                                    } else {
                                        if (this.tenthousandsSet == false){
                                            this.movie.setTenthousands(this.tenthousandsN);
                                            this.tenthousandsSet = true;
                                        } else {
                                            if (this.hundredthousandsSet == false){
                                                this.movie.setHundredthousands(this.hundredthousandsN);
                                                this.hundredthousandsSet = true;
                                            } else {
                                                this.tallyComplete = true;
                                                this.game.tallyDone = true;
                                                this.game.countDownN = (24 * 5);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (this.color.brightness > 0){
                this.color.brightness = (this.color.brightness - 0.1);
                if (this.color.brightness < 0){
                    this.color.brightness = 0;
                };
                this.movie.art.art.hp.transform.colorTransform = this.color;
            };
        }

        public function tint(_arg_1:Number):void{
            if (this.mainAction == "lvl"){
                this.color.brightness = _arg_1;
                this.movie.art.art.hp.transform.colorTransform = this.color;
            };
        }

        public function destroy():void{
            this.dead = true;
            this.gameplayHolder.removeChild(this.movie);
            delete this[this];
        }


    }
}//package com.clubpenguin.games.arrow
