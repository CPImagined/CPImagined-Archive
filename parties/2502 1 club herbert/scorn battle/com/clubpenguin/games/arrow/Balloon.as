package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.BalloonMC;

    public class Balloon extends MovieClip {

        private var game:ArrowEngine;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var startX:Number;
        public var startY:Number;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var n:Number;
        public var distX:Number;
        public var distY:Number;
        public var Distance:Number;
        public var horiz:Number;
        public var vert:Number;
        public var angle:Number;
        public var angle2:Number;
        public var Xmouse:Number;
        public var Ymouse:Number;
        public var pushX:Number;
        public var pushY:Number;
        public var motionX:Number;
        public var motionY:Number;
        public var dead:Boolean;
        public var type:String;
        public var popped:Boolean;
        public var speed:Number;
        public var friction:Number;
        public var color:Color;

        public function Balloon(_arg_1:ArrowEngine, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.game.balloonsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new BalloonMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.type = _arg_2;
            this.movie.gotoAndStop(this.type);
            this.startX = _arg_3;
            this.startY = _arg_4;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.mainAction = "still";
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.motionX = 0;
            this.motionY = (Math.floor((Math.random() * 5)) * -1);
            this.dead = false;
            this.popped = false;
            this.speed = _arg_5;
            this.friction = (0.99 - (Math.floor((Math.random() * 10)) / 1000));
        }

        public function update():void{
            if (this.mainAction == "pop"){
                this.movie.art.art.nextFrame();
            };
            if (this.mainAction == "still"){
                this.motionY = (this.motionY - this.speed);
            };
            this.motionX = (this.motionX * this.friction);
            this.motionY = (this.motionY * this.friction);
            this.movie.x = (this.movie.x + this.motionX);
            this.movie.y = (this.movie.y + this.motionY);
            if (this.movie.y < -100){
                this.destroy();
            };
            if (this.type == "timebonus"){
                if (this.game.gameEnding){
                    this.type = "feather";
                    this.movie.gotoAndStop(this.type);
                    this.mainChanged = true;
                };
            };
            if (this.game.bossObj.mainAction == "swipe"){
                this.motionX = (this.motionX - 1);
            };
            if (this.game.shotFired){
                if (this.movie.x > -40){
                    if (this.game.particlesN > 0){
                        this.n = 0;
                        while (this.n < this.game.particleL.length) {
                            if (this.popped == false){
                                this.findDistance(this.game.particleL[this.n].movie.x, this.game.particleL[this.n].movie.y, this.movie.x, this.movie.y);
                                if (this.Distance < 40){
                                    this.game.targetsHitN++;
                                    this.game.targetsHitL.push(this);
                                    this.mainAction = "pop";
                                    this.mainChanged = true;
                                    this.motionX = 0;
                                    this.motionY = 0;
                                    this.popped = true;
                                    this.game.balloonsPoppedN = (this.game.balloonsPoppedN + this.game.targetsHitN);
                                    if (this.type == "feather"){
                                        this.game.bowObj.countDownDefault = this.game.bowObj.countDownFast;
                                        this.game.bowObj.countDownResetSpeed = 40;
                                        this.game.bowObj.countDownN = 0;
                                        this.game.featherHit = true;
                                    };
                                    this.game.countDownSpecialN = (this.game.countDownSpecialN - this.game.targetsHitN);
                                    this.findMotionFromAngle(this.game.particleL[this.n].movie.rotation, 8);
                                    this.n = 0;
                                    while (this.n < this.game.targetsHitN) {
                                        this.game.placeParticle("coin", this.movie.x, this.movie.y, 0, (this.pushX * (Math.floor((Math.random() * 10)) + 1)), ((this.pushY * (Math.floor((Math.random() * 10)) + 1)) - 5));
                                        this.n++;
                                    };
                                    this.n = this.game.particleL.length;
                                };
                            };
                            this.n++;
                        };
                    };
                };
            };
            if (this.mainChanged == false){
                if (this.movie.art.art.currentFrame == this.movie.art.art.totalFrames){
                    if (this.mainAction == "pop"){
                        this.destroy();
                    };
                };
            };
            if (this.mainChanged){
                this.movie.setArtMain(this.mainAction);
                if (this.mainActionFromStart){
                    this.mainActionFromStart = false;
                    this.movie.setArtMain("hide");
                    this.movie.setArtMain(this.mainAction);
                };
                this.mainChanged = false;
                this.subChanged = true;
            };
            if (this.color.brightness < 0){
                this.color.brightness = (this.color.brightness + 0.1);
                this.movie.transform.colorTransform = this.color;
            };
        }

        public function findDistance(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void{
            this.distX = Math.round((_arg_3 - _arg_1));
            this.distY = Math.round((_arg_4 - _arg_2));
            this.Distance = Math.round(Math.sqrt(((this.distX * this.distX) + (this.distY * this.distY))));
        }

        public function findAngle(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void{
            this.horiz = (_arg_3 - _arg_1);
            this.vert = (_arg_4 - _arg_2);
            this.angle = Math.atan2(this.vert, this.horiz);
            this.angle = Math.round(((this.angle / Math.PI) * 180));
        }

        public function findMotionFromAngle(_arg_1:Number, _arg_2:Number):void{
            this.pushX = (Math.cos((_arg_1 * (Math.PI / 180))) * _arg_2);
            this.pushY = (Math.sin((_arg_1 * (Math.PI / 180))) * _arg_2);
        }

        public function tint(_arg_1:Number):void{
            this.color.brightness = _arg_1;
            this.movie.transform.colorTransform = this.color;
        }

        public function destroy():void{
            this.dead = true;
            this.game.balloonsN--;
            this.gameplayHolder.removeChild(this.movie);
            delete this[this];
        }


    }
}//package com.clubpenguin.games.arrow
