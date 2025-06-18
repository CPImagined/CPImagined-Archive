package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.arrow.movies.FgMC;

    public class Fg extends MovieClip {

        private var game:MovieClip;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var dead:Boolean;
        public var color:Color;

        public function Fg(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.game.objectsN++;
            this.gameplayHolder = this.game.foregroundHolder;
            this.movie = new FgMC();
            this.color = new Color();
            this.gameplayHolder.addChild(this.movie);
            this.movie.x = _arg_2;
            this.movie.y = _arg_3;
            this.mainAction = "lvl1";
            this.mainChanged = true;
            this.subAction = "phase1";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
        }

        public function update():void{
            if (this.mainAction == "lvl1"){
                this.movie.art.art.art.nextFrame();
            };
            if (this.mainChanged){
                this.movie.setArtMain(this.mainAction);
                this.mainChanged = false;
                this.subChanged = true;
            };
            if (this.subChanged){
                if (this.mainAction == "lvl1"){
                    this.movie.setArtSub(this.subAction);
                    this.subChanged = false;
                };
            };
            if (this.mainAction == "lvl1"){
                if (this.movie.art.art.art.currentFrame == this.movie.art.art.art.totalFrames){
                    if (((this.subAction == "phase2") || (this.subAction == "phase3shake"))){
                        this.subAction = "phase3";
                        this.subChanged = true;
                    } else {
                        if (((this.subAction == "phase4") || (this.subAction == "phase5shake"))){
                            this.subAction = "phase5";
                            this.subChanged = true;
                        } else {
                            if (((this.subAction == "phase6") || (this.subAction == "phase7shake"))){
                                this.subAction = "phase7";
                                this.subChanged = true;
                            } else {
                                if (this.subAction == "phase8"){
                                    this.subAction = "phase9";
                                    this.subChanged = true;
                                } else {
                                    if (this.subAction == "phase10"){
                                        this.subAction = "phase9";
                                        this.subChanged = true;
                                    } else {
                                        if (this.subAction == "reverse8"){
                                            this.subAction = "reverse6";
                                            this.subChanged = true;
                                        } else {
                                            if (this.subAction == "reverse6"){
                                                this.subAction = "reverse4";
                                                this.subChanged = true;
                                            } else {
                                                if (this.subAction == "reverse4"){
                                                    this.subAction = "reverse2";
                                                    this.subChanged = true;
                                                } else {
                                                    if (this.subAction == "reverse2"){
                                                        this.subAction = "phase0";
                                                        this.subChanged = true;
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (this.color.brightness < 0){
                this.color.brightness = (this.color.brightness + 0.1);
                this.movie.transform.colorTransform = this.color;
            };
        }

        public function slam():void{
            if (this.subAction == "phase1"){
                this.subAction = "phase2";
                this.subChanged = true;
            } else {
                if (this.subAction == "phase3"){
                    if (Math.floor(this.game.bossHP) < 800){
                        this.subAction = "phase4";
                    } else {
                        this.subAction = "phase3shake";
                    };
                    this.subChanged = true;
                } else {
                    if (this.subAction == "phase5"){
                        if (Math.floor(this.game.bossHP) < 600){
                            this.subAction = "phase6";
                        } else {
                            this.subAction = "phase5shake";
                        };
                        this.subChanged = true;
                    } else {
                        if (this.subAction == "phase7"){
                            if (Math.floor(this.game.bossHP) < 400){
                                this.subAction = "phase8";
                            } else {
                                this.subAction = "phase7shake";
                            };
                            this.subChanged = true;
                        } else {
                            if (this.subAction == "phase9"){
                                this.subAction = "phase10";
                                this.subChanged = true;
                            };
                        };
                    };
                };
            };
        }

        public function restore():void{
            if ((((this.subAction == "phase2") || (this.subAction == "phase3")) || (this.subAction == "phase3shake"))){
                this.subAction = "reverse2";
                this.subChanged = true;
            } else {
                if ((((this.subAction == "phase4") || (this.subAction == "phase5")) || (this.subAction == "phase5shake"))){
                    this.subAction = "reverse4";
                    this.subChanged = true;
                } else {
                    if ((((this.subAction == "phase6") || (this.subAction == "phase7")) || (this.subAction == "phase7shake"))){
                        this.subAction = "reverse6";
                        this.subChanged = true;
                    } else {
                        if ((((this.subAction == "phase8") || (this.subAction == "phase9")) || (this.subAction == "phase10"))){
                            this.subAction = "reverse8";
                            this.subChanged = true;
                        };
                    };
                };
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
