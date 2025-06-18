package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.BowMC;

    public class Bow extends MovieClip {

        private var game:ArrowEngine;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var dead:Boolean;
        public var horiz:Number;
        public var vert:Number;
        public var angle:Number;
        public var pushX:Number;
        public var pushY:Number;
        public var countDownNormal:Number;
        public var countDownFast:Number;
        public var countDownN:Number;
        public var countDownDefault:Number;
        public var countDownResetSpeed:Number;
        public var penguinColor:Color;
        public var color:Color;

        public function Bow(_arg_1:ArrowEngine, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.foregroundHolder;
            this.movie = new BowMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.movie.x = _arg_2;
            this.movie.y = _arg_3;
            this.mainAction = "still";
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
            this.countDownNormal = 12;
            this.countDownFast = 2;
            this.countDownDefault = this.countDownNormal;
            this.countDownN = this.countDownDefault;
            this.countDownResetSpeed = 0;
            this.penguinColor = new Color();
            this.color = new Color();
            this.color.brightness = -0.4;
            this.movie.transform.colorTransform = this.color;
        }

        public function update():void{
            if (this.mainAction == "fire"){
                this.movie.art.art.nextFrame();
            };
            this.findAngle(this.movie.x, this.movie.y, this.game.mousePosX, this.game.mousePosY);
            if (this.game.mousePosX > this.movie.x){
                if (this.angle > 0){
                    this.angle = 0;
                };
            } else {
                if (((this.angle < -180) || (this.angle > 0))){
                    this.angle = -180;
                };
            };
            this.movie.rotation = this.angle;
            if (this.game.mousePosX > this.movie.x){
                this.movie.art.scaleY = -1;
            } else {
                this.movie.art.scaleY = 1;
            };
            if (this.angle >= -46){
                if (this.game.playerObj.subAction != "right"){
                    this.game.playerObj.subAction = "right";
                    this.game.playerObj.subChanged = true;
                };
            } else {
                if (this.angle <= -132){
                    if (this.game.playerObj.subAction != "left"){
                        this.game.playerObj.subAction = "left";
                        this.game.playerObj.subChanged = true;
                    };
                } else {
                    if (this.game.playerObj.subAction != "up"){
                        this.game.playerObj.subAction = "up";
                        this.game.playerObj.subChanged = true;
                    };
                };
            };
            if (this.countDownN > 0){
                this.countDownN--;
            } else {
                if (this.game.fightStarted){
                    if (this.game.balloonsN > 0){
                        if (this.countDownDefault == this.countDownFast){
                            if (this.countDownResetSpeed > 0){
                                this.countDownResetSpeed--;
                            } else {
                                this.countDownDefault = this.countDownNormal;
                            };
                        };
                        this.countDownN = this.countDownDefault;
                        this.game.shotFired = true;
                        this.findMotionFromAngle(this.angle, 30);
                        this.game.particleL.splice(0);
                        this.game.particlesN = 0;
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 2)), (this.movie.y + (this.pushY * 2)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 3)), (this.movie.y + (this.pushY * 3)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 4)), (this.movie.y + (this.pushY * 4)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 5)), (this.movie.y + (this.pushY * 5)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 6)), (this.movie.y + (this.pushY * 6)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 7)), (this.movie.y + (this.pushY * 7)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 8)), (this.movie.y + (this.pushY * 8)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 9)), (this.movie.y + (this.pushY * 9)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 10)), (this.movie.y + (this.pushY * 10)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 11)), (this.movie.y + (this.pushY * 11)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 12)), (this.movie.y + (this.pushY * 12)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 13)), (this.movie.y + (this.pushY * 13)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 14)), (this.movie.y + (this.pushY * 14)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 15)), (this.movie.y + (this.pushY * 15)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 16)), (this.movie.y + (this.pushY * 16)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 17)), (this.movie.y + (this.pushY * 17)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 18)), (this.movie.y + (this.pushY * 18)), this.angle, 0, 0);
                        this.game.placeParticle("blur", (this.movie.x + (this.pushX * 19)), (this.movie.y + (this.pushY * 19)), this.angle, 0, 0);
                        this.game.placeParticle("arrow", this.movie.x, this.movie.y, this.angle, 0, 0);
                        this.mainAction = "fire";
                        this.mainChanged = true;
                        this.mainActionFromStart = true;
                    };
                };
            };
            if (this.mainChanged == false){
                if (this.movie.art.art.currentFrame == this.movie.art.art.totalFrames){
                    if (this.mainAction == "fire"){
                        this.mainAction = "still";
                        this.mainChanged = true;
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
            if (this.mainChanged == false){
                if (this.mainAction == "still"){
                    this.penguinColor.color = this.game.penguinColor;
                    this.movie.art.art.skin.transform.colorTransform = this.penguinColor;
                } else {
                    if (this.mainAction == "fire"){
                        this.penguinColor.color = this.game.penguinColor;
                        this.movie.art.art.skin1.transform.colorTransform = this.penguinColor;
                        this.movie.art.art.skin2.transform.colorTransform = this.penguinColor;
                    };
                };
            };
            if (this.color.brightness < -0.4){
                this.color.brightness = (this.color.brightness + 0.1);
                this.movie.transform.colorTransform = this.color;
            };
            if (this.game.gameOver){
                this.color.brightness = 0;
                this.movie.transform.colorTransform = this.color;
            };
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
            this.color.brightness = (_arg_1 - 0.4);
            this.movie.transform.colorTransform = this.color;
        }

        public function destroy():void{
            this.dead = true;
            this.gameplayHolder.removeChild(this.movie);
            delete this[this];
        }


    }
}//package com.clubpenguin.games.arrow
