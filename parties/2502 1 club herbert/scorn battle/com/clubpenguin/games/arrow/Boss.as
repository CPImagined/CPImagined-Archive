package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.BossMC;

    public class Boss extends MovieClip {

        private var game:ArrowEngine;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var dead:Boolean;
        public var knockedOut:Boolean;
        public var defeated:Boolean;
        public var color:Color;
        public var lit:Boolean;
        public var defaultAttackCountDownN:Number;
        public var attackOneCountDownN:Number;
        public var attackTwoCountDownN:Number;
        public var attackOneReady:Boolean;
        public var attackTwoReady:Boolean;
        public var enraged:Boolean;
        public var enrageCountN:Number;
        public var defaultEnrageCountN:Number;
        public var blinking:Boolean;

        public function Boss(_arg_1:ArrowEngine, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new BossMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.movie.x = _arg_2;
            this.movie.y = _arg_3;
            this.mainAction = "hide";
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
            this.knockedOut = false;
            this.defeated = false;
            this.lit = false;
            this.defaultAttackCountDownN = (24 * 10);
            this.attackOneCountDownN = this.defaultAttackCountDownN;
            this.attackTwoCountDownN = this.defaultAttackCountDownN;
            this.attackOneReady = false;
            this.attackTwoReady = false;
            this.enraged = false;
            this.defaultEnrageCountN = 5;
            this.enrageCountN = this.defaultEnrageCountN;
            this.blinking = false;
        }

        public function update():void{
            if (((((((this.mainAction == "hitNormal") || (this.mainAction == "hitStrong")) || (this.mainAction == "ko")) || (this.mainAction == "swipe")) || (this.mainAction == "slam")) || (this.mainAction == "intro"))){
                this.movie.art.art.nextFrame();
            };
            if (this.attackOneReady == false){
                if (this.attackOneCountDownN > 0){
                    this.attackOneCountDownN--;
                } else {
                    this.attackOneCountDownN = this.defaultAttackCountDownN;
                    this.attackOneReady = true;
                };
            };
            if (this.attackTwoReady == false){
                if (this.attackTwoCountDownN > 0){
                    this.attackTwoCountDownN--;
                } else {
                    if (this.enraged){
                        this.attackTwoCountDownN = this.defaultAttackCountDownN;
                        this.attackTwoReady = true;
                        this.enraged = false;
                    };
                };
            };
            if (this.mainAction == "slam"){
                if (this.movie.art.art.currentFrame == 12){
                    this.game.fgObj.slam();
                };
            };
            if (this.mainChanged == false){
                if (this.mainAction == "still"){
                    if (this.attackTwoReady){
                        this.mainAction = "slam";
                        this.mainChanged = true;
                        this.attackTwoReady = false;
                    } else {
                        if (this.attackOneReady){
                            if (this.game.balloonsN > 9){
                                this.mainAction = "swipe";
                                this.mainChanged = true;
                                this.attackOneReady = false;
                            };
                        };
                    };
                };
            };
            if (this.knockedOut){
                if (this.defeated == false){
                    if (this.mainAction == "still"){
                        this.mainAction = "ko";
                        this.mainChanged = true;
                        this.defeated = true;
                    };
                };
            };
            if (this.mainChanged == false){
                if (this.mainAction == "intro"){
                    if (this.movie.art.art.currentFrame == 24){
                        this.game.playSoundEffect("channel2", "dragonIntro");
                    };
                } else {
                    if (this.mainAction == "hitNormal"){
                        if (this.movie.art.art.currentFrame == 2){
                            this.game.playSoundEffect("channel2", "dragonHurt1");
                        };
                    } else {
                        if (this.mainAction == "hitStrong"){
                            if (this.movie.art.art.currentFrame == 2){
                                this.game.playSoundEffect("channel2", "dragonHurt2");
                            };
                        } else {
                            if (this.mainAction == "swipe"){
                                if (this.movie.art.art.currentFrame == 8){
                                    this.game.playSoundEffect("channel2", "dragonFlap");
                                };
                            } else {
                                if (this.mainAction == "ko"){
                                    if (this.movie.art.art.currentFrame == 6){
                                        this.game.playSoundEffect("channel2", "dragonKO");
                                    };
                                };
                            };
                        };
                    };
                };
                if (this.movie.art.art.currentFrame == this.movie.art.art.totalFrames){
                    if (this.mainAction == "intro"){
                        this.mainAction = "still";
                        this.mainChanged = true;
                        this.game.fightStarted = true;
                    } else {
                        if (((this.mainAction == "swipe") || (this.mainAction == "slam"))){
                            this.mainAction = "still";
                            this.mainChanged = true;
                        } else {
                            if ((((this.mainAction == "hitWeak") || (this.mainAction == "hitNormal")) || (this.mainAction == "hitStrong"))){
                                if (this.knockedOut){
                                    this.mainAction = "ko";
                                    this.mainChanged = true;
                                } else {
                                    this.mainAction = "still";
                                    this.mainChanged = true;
                                };
                            } else {
                                if (this.mainAction == "ko"){
                                    this.mainAction = "hide";
                                    this.mainChanged = true;
                                    this.game.bgObj.mainAction = "lvl2";
                                    this.game.bgObj.mainChanged = true;
                                    this.game.fgObj.restore();
                                };
                            };
                        };
                    };
                };
                if (this.mainAction == "still"){
                    if (this.blinking){
                        if (this.movie.art.art.head.eyeL.art.currentFrame == this.movie.art.art.head.eyeL.art.totalFrames){
                            this.blinking = false;
                            this.movie.art.art.head.eyeL.gotoAndStop("still");
                            this.movie.art.art.head.eyeR.gotoAndStop("still");
                        };
                    };
                };
            };
            if (this.mainChanged){
                this.movie.setArtMain(this.mainAction);
                this.blinking = false;
                if (this.mainActionFromStart){
                    this.mainActionFromStart = false;
                    this.movie.setArtMain("hide");
                    this.movie.setArtMain(this.mainAction);
                };
                this.mainChanged = false;
                this.subChanged = true;
            };
            if (this.lit){
                if (this.color.brightness > 0){
                    this.color.brightness = (this.color.brightness - 0.1);
                    this.movie.transform.colorTransform = this.color;
                } else {
                    this.color.brightness = 0;
                    this.movie.transform.colorTransform = this.color;
                    this.lit = false;
                };
            };
            if (this.color.brightness < 0){
                this.color.brightness = (this.color.brightness + 0.1);
                this.movie.transform.colorTransform = this.color;
            };
        }

        public function hit(_arg_1:String):void{
            if (_arg_1 == "normal"){
                if ((((!(this.mainAction == "hitStrong")) && (!(this.mainAction == "swipe"))) && (!(this.mainAction == "slam")))){
                    this.mainAction = "hitNormal";
                };
            } else {
                if (_arg_1 == "strong"){
                    if (((!(this.mainAction == "swipe")) && (!(this.mainAction == "slam")))){
                        this.mainAction = "hitStrong";
                    };
                };
            };
            if ((((!(this.mainAction == "swipe")) && (!(this.mainAction == "slam"))) && (!(this.mainAction == "still")))){
                this.mainChanged = true;
                this.mainActionFromStart = true;
            };
            if (this.mainAction == "hitStrong"){
                this.color.brightness = 0.3;
            } else {
                if (this.mainAction == "hitNormal"){
                    this.color.brightness = 0.3;
                } else {
                    this.color.brightness = 0.6;
                    if (this.mainChanged == false){
                        if (this.mainAction == "still"){
                            if (this.blinking == false){
                                this.blinking = true;
                                this.movie.art.art.head.eyeL.gotoAndStop("still");
                                this.movie.art.art.head.eyeR.gotoAndStop("still");
                                this.movie.art.art.head.eyeL.gotoAndStop("blink");
                                this.movie.art.art.head.eyeR.gotoAndStop("blink");
                            };
                        };
                    };
                };
            };
            this.movie.transform.colorTransform = this.color;
            this.lit = true;
            if (this.mainAction == "hitStrong"){
                this.game.bossHP = (this.game.bossHP - 40);
                this.game.hudObj.hpChanged = true;
                this.enraged = true;
            } else {
                if (this.mainAction == "hitNormal"){
                    this.game.bossHP = (this.game.bossHP - 20);
                    this.game.hudObj.hpChanged = true;
                    if (this.enrageCountN > 0){
                        this.enrageCountN--;
                    } else {
                        this.enrageCountN = this.defaultEnrageCountN;
                        this.enraged = true;
                    };
                } else {
                    this.game.bossHP = (this.game.bossHP - 5);
                    this.game.hudObj.hpChanged = true;
                };
            };
            if (this.game.bossHP < 1){
                this.game.bossHP = 1;
            };
        }

        public function ko():void{
            this.knockedOut = true;
        }

        public function defeat():void{
            this.game.hudObj.type = "gameover";
            this.game.hudObj.mainAction = "gameover";
            this.game.hudObj.mainChanged = true;
            this.game.hudObj.scoreChanged = true;
            this.game.showScoreTally = true;
            this.game.gameOver = true;
        }

        public function tint(_arg_1:Number):void{
            this.color.brightness = _arg_1;
            this.movie.transform.colorTransform = this.color;
        }

        public function destroy():void{
            this.dead = true;
            this.gameplayHolder.removeChild(this.movie);
            delete this[this];
        }


    }
}//package com.clubpenguin.games.arrow
