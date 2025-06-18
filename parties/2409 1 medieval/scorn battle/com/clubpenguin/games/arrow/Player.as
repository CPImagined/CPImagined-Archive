package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.PlayerMC;

    public class Player extends MovieClip {

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
        public var Xmouse:Number;
        public var Ymouse:Number;
        public var pushX:Number;
        public var pushY:Number;
        public var motionX:Number;
        public var motionY:Number;
        public var dead:Boolean;
        public var penguinColor:Color;
        public var color:Color;

        public function Player(_arg_1:ArrowEngine, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.foregroundHolder;
            this.movie = new PlayerMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_2;
            this.startY = _arg_3;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.mainAction = "still";
            this.mainChanged = true;
            this.subAction = "right";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.motionX = 0;
            this.motionY = 0;
            this.dead = false;
            this.penguinColor = new Color();
            this.color = new Color();
            this.color.brightness = -0.4;
            this.movie.transform.colorTransform = this.color;
        }

        public function update():void{
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
            if (this.subChanged){
                this.movie.setArtSub(this.subAction);
                this.subChanged = false;
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
