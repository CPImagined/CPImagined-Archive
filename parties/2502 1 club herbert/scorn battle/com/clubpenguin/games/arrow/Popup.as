package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.PopupMC;

    public class Popup extends MovieClip {

        private var game:ArrowEngine;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var n:Number;
        public var dead:Boolean;
        public var maxScaleX:Number;
        public var color:Color;
        public var startY:Number;

        public function Popup(_arg_1:ArrowEngine, _arg_2:String, _arg_3:String, _arg_4:Number, _arg_5:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.foregroundHolder;
            this.movie = new PopupMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.startY = _arg_5;
            this.movie.x = _arg_4;
            this.movie.y = _arg_5;
            this.mainAction = _arg_2;
            this.mainChanged = true;
            this.subAction = _arg_3;
            this.subChanged = true;
            this.mainActionFromStart = false;
            this.dead = false;
            this.maxScaleX = 2;
        }

        public function update():void{
            if (((this.mainAction == "points") || (this.mainAction == "combo"))){
                this.movie.art.art.nextFrame();
            };
            if (this.mainAction == "points"){
                if (this.movie.scaleX >= 2){
                    this.subAction = "pop";
                    this.subChanged = true;
                } else {
                    this.movie.scaleX = (this.movie.scaleX + 0.1);
                    this.movie.scaleY = this.movie.scaleX;
                    this.movie.y--;
                };
            } else {
                if (this.mainAction == "combo"){
                    if (this.movie.y < (this.startY - 30)){
                        this.subAction = "pop";
                        this.subChanged = true;
                    } else {
                        this.movie.y = (this.movie.y - 1.2);
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
            if (this.subChanged){
                this.movie.setArtSub(this.subAction);
                this.subChanged = false;
            };
            if (((this.mainAction == "points") || (this.mainAction == "combo"))){
                if (this.subAction == "pop"){
                    if (this.movie.art.art.currentFrame == this.movie.art.art.totalFrames){
                        this.destroy();
                    };
                };
            };
            if (this.color.brightness < 0){
                this.color.brightness = (this.color.brightness + 0.1);
                this.movie.transform.colorTransform = this.color;
            };
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
