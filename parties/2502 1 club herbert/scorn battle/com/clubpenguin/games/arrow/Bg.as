package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.BgMC;

    public class Bg extends MovieClip {

        private var game:ArrowEngine;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var dead:Boolean;
        public var color:Color;

        public function Bg(_arg_1:ArrowEngine, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new BgMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.movie.x = _arg_2;
            this.movie.y = _arg_3;
            this.mainAction = "lvl1";
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
        }

        public function update():void{
            if (this.mainAction == "lvl2"){
                this.movie.art.art.nextFrame();
            };
            if (this.mainChanged == false){
                if (this.movie.art.art.currentFrame == this.movie.art.art.totalFrames){
                    if (this.mainAction == "lvl2"){
                        this.mainAction = "lvl3";
                        this.mainChanged = true;
                        this.game.bossObj.defeat();
                    };
                };
            };
            if (this.mainChanged){
                this.movie.setArtMain(this.mainAction);
                this.mainChanged = false;
                this.subChanged = true;
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
