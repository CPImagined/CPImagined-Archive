package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.bounce.movies.PopupMC;
    import com.clubpenguin.games.bounce.*;

    internal class Popup extends MovieClip {

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
        public var Xmouse:Number;
        public var Ymouse:Number;
        public var pushX:Number;
        public var pushY:Number;
        public var dead:Boolean;
        public var color:Color;
        public var motionX:Number;
        public var motionY:Number;
        public var motionZ:Number;
        public var kind:String;
        public var tempSlice:String;
        public var ones:String;
        public var tens:String;
        public var hundreds:String;
        public var onesN:Number;
        public var tensN:Number;
        public var hundredsN:Number;

        public function Popup(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number, _arg_4:String, _arg_5:String, _arg_6:Number){
            this.game = _arg_1;
            this.kind = "popup";
            this.game.objectsN++;
            this.gameplayHolder = this.game.foregroundHolder;
            this.movie = new PopupMC();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_2;
            this.startY = _arg_3;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.motionX = Math.floor(((Math.random() * 10) - 5));
            this.motionY = (this.game.playerObj.motionY - 40);
            this.motionZ = 0.3;
            this.mainAction = _arg_4;
            this.mainChanged = true;
            this.subAction = _arg_5;
            this.subChanged = true;
            this.mainActionFromStart = false;
            this.dead = false;
            this.color = new Color();
            this.tempSlice = String(_arg_6);
            if (this.tempSlice.length > 2){
                this.hundreds = this.tempSlice.slice(0, 1);
                this.hundredsN = Number(this.hundreds);
                this.hundredsN++;
                this.tens = this.tempSlice.slice(1, 2);
                this.tensN = Number(this.tens);
                this.tensN++;
                this.ones = this.tempSlice.slice(2, 3);
                this.onesN = Number(this.ones);
                this.onesN++;
            } else {
                if (this.tempSlice.length > 1){
                    this.hundreds = "hide";
                    this.hundredsN = 11;
                    this.tens = this.tempSlice.slice(0, 1);
                    this.tensN = Number(this.tens);
                    this.tensN++;
                    this.ones = this.tempSlice.slice(1, 2);
                    this.onesN = Number(this.ones);
                    this.onesN++;
                } else {
                    this.hundreds = "hide";
                    this.hundredsN = 11;
                    this.tens = "hide";
                    this.tensN = 11;
                    this.ones = this.tempSlice.slice(0, 1);
                    this.onesN = Number(this.ones);
                    this.onesN++;
                };
            };
            this.movie.art.art.art.ones.gotoAndStop(this.onesN);
            this.movie.art.art.art.tens.gotoAndStop(this.tensN);
            this.movie.art.art.art.hundreds.gotoAndStop(this.hundredsN);
        }

        public function update():void{
            this.motionY = (this.motionY + 2);
            this.motionZ = (this.motionZ - 0.005);
            this.motionX = (this.motionX * 0.9);
            this.motionY = (this.motionY * 0.9);
            this.motionZ = (this.motionZ * 0.9);
            this.movie.x = (this.movie.x + this.motionX);
            this.movie.y = (this.movie.y + this.motionY);
            this.movie.scaleX = (this.movie.scaleX + this.motionZ);
            this.movie.scaleY = this.movie.scaleX;
            if (this.movie.scaleX < 0.2){
                this.destroy();
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
