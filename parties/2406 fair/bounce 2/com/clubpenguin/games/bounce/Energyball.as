package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import com.clubpenguin.games.bounce.movies.EnergyballMC;
    import com.clubpenguin.games.bounce.*;

    internal class Energyball extends MovieClip {

        private var game:MovieClip;
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
        public var pushX:Number;
        public var pushY:Number;
        public var dead:Boolean;
        public var motionX:Number;
        public var motionY:Number;
        public var motionR:Number;
        public var kind:String;

        public function Energyball(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number, _arg_4:String){
            this.game = _arg_1;
            this.kind = "energyBall";
            this.game.objectsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new EnergyballMC();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_2;
            this.startY = _arg_3;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.motionX = 0;
            this.motionY = 0;
            this.mainAction = _arg_4;
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
            this.angle = Math.floor((Math.random() * 360));
            this.findMotionFromAngle(this.angle, 20);
            this.motionX = this.pushX;
            this.motionY = this.pushY;
            this.movie.x = (this.movie.x + this.motionX);
            this.movie.y = (this.movie.y + this.motionY);
            this.movie.rotation = Math.floor((Math.random() * 360));
            this.motionR = Math.floor(((Math.random() * 50) + 20));
            if (Math.floor((Math.random() * 2)) == 0){
                this.motionR = (this.motionR * -1);
            };
            this.movie.setArtMain(this.mainAction);
            this.movie.setArtSub(this.subAction);
            this.movie.art.art.art.gotoAndStop((Math.floor((Math.random() * 8)) + 1));
            this.movie.rotation = (this.movie.rotation + Math.floor((Math.random() * 360)));
        }

        public function update():void{
            this.findDistance(this.movie.x, this.movie.y, this.game.playerObj.movie.x, this.game.playerObj.movie.y);
            if (this.Distance > 60){
                this.findAngle(this.movie.x, this.movie.y, this.game.playerObj.movie.x, this.game.playerObj.movie.y);
                this.findMotionFromAngle(this.angle, (this.Distance / 10));
                this.motionX = (this.motionX + this.pushX);
                this.motionY = (this.motionY + this.pushY);
            } else {
                this.game.playerObj.energyEffect = true;
                this.game.playerObj.setColorEffect(2);
                this.destroy();
            };
            this.motionX = (this.motionX * 0.9);
            this.motionY = (this.motionY * 0.9);
            this.motionR = (this.motionR * 0.9);
            this.movie.x = (this.movie.x + this.motionX);
            this.movie.y = (this.movie.y + this.motionY);
            this.movie.rotation = (this.movie.rotation + this.motionR);
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
            if (this.mainAction == "normal"){
                if (this.subChanged == false){
                    if (this.movie.art.art.art.currentFrame == this.movie.art.art.art.totalFrames){
                        if (this.subAction == "pop"){
                            this.destroy();
                        };
                    };
                };
            };
            if (this.subChanged){
                this.movie.setArtSub(this.subAction);
                this.subChanged = false;
            };
        }

        public function findDistance(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void{
            this.distX = Math.round((_arg_3 - _arg_1));
            this.distY = Math.round((_arg_4 - _arg_2));
            this.Distance = Math.round(Math.sqrt(((this.distX * this.distX) + (this.distY * this.distY))));
        }

        public function findAngle(_arg_1:*, _arg_2:*, _arg_3:*, _arg_4:*):*{
            this.horiz = (_arg_3 - _arg_1);
            this.vert = (_arg_4 - _arg_2);
            this.angle = Math.atan2(this.vert, this.horiz);
            this.angle = Math.round(((this.angle / Math.PI) * 180));
        }

        public function findMotionFromAngle(_arg_1:*, _arg_2:*):*{
            this.pushX = (Math.cos((_arg_1 * (Math.PI / 180))) * _arg_2);
            this.pushY = (Math.sin((_arg_1 * (Math.PI / 180))) * _arg_2);
        }

        public function destroy():void{
            if (this.dead == false){
                this.dead = true;
                this.gameplayHolder.removeChild(this.movie);
                delete this[this];
            };
        }


    }
}//package com.clubpenguin.games.bounce
