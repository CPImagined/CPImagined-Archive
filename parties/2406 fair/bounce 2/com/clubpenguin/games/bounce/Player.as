package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.bounce.movies.PlayerMC;
    import com.clubpenguin.games.bounce.*;

    internal class Player extends MovieClip {

        private var game:MovieClip;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var startX:Number;
        public var startY:Number;
        public var flipPosX:Number;
        public var mainAction:String;
        public var subAction:String;
        public var mainChanged:Boolean;
        public var subChanged:Boolean;
        public var mainActionFromStart:Boolean;
        public var subActionFromStart:Boolean;
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
        public var behaviour:String;
        public var myColorTransform:Color;
        public var penguinColor:Color;
        public var redOffset:Number;
        public var greenOffset:Number;
        public var blueOffset:Number;
        public var brightnessOffset:Number;
        public var energyEffect:Boolean;
        public var kind:String;
        public var prevX:Number;
        public var prevY:Number;
        public var colX:Number;
        public var colY:Number;
        private var _isFireFallingSoundPlaying:Boolean = false;

        public function Player(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.kind = "player";
            this.game.objectsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new PlayerMC();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_2;
            this.startY = _arg_3;
            this.flipPosX = this.startX;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.prevX = this.startX;
            this.prevY = this.startY;
            this.colX = this.startX;
            this.colY = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.mainAction = "normal";
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.subActionFromStart = false;
            this.motionX = 0;
            this.motionY = -60;
            this.dead = false;
            this.behaviour = "idle";
            this.energyEffect = false;
            this.myColorTransform = new Color();
            this.redOffset = 0;
            this.greenOffset = 0;
            this.blueOffset = 0;
            this.brightnessOffset = 0;
            this.penguinColor = new Color();
        }

        public function update():void{
            if (((this.behaviour == "idle") || (this.behaviour == "jump"))){
                this.movie.x = ((this.movie.x + this.game.mousePosX) / 2);
                if (this.movie.x > (this.flipPosX + 10)){
                    this.movie.art.scaleX = 1;
                    this.flipPosX = this.movie.x;
                } else {
                    if (this.movie.x < (this.flipPosX - 10)){
                        this.movie.art.scaleX = -1;
                        this.flipPosX = this.movie.x;
                    };
                };
                this.motionY = (this.motionY + (1 * this.game.speedMultiplier));
                this.motionX = (this.motionX * 0.98);
                if (this.subAction != "movedown4"){
                    this.motionY = (this.motionY * 0.98);
                };
                this.prevX = this.movie.x;
                this.prevY = this.movie.y;
                this.movie.x = (this.movie.x + this.motionX);
                this.movie.y = (this.movie.y + this.motionY);
                this.colX = ((this.prevX + this.movie.x) / 2);
                this.colY = ((this.prevY + this.movie.y) / 2);
                if (this.movie.y > 240){
                    this.behaviour = "fallen";
                    this.movie.y = 240;
                    this.motionX = 0;
                    this.motionY = 0;
                    this.subAction = "splat";
                    this.subChanged = true;
                    this.game.playSoundEffect("playerland");
                };
            };
            if (this.behaviour == "idle"){
                if (this.mainAction == "normal"){
                    this.setFromMotion();
                };
            };
            if (this.energyEffect){
                this.brightnessOffset = (this.brightnessOffset * 0.1);
                if (this.brightnessOffset < 0.1){
                    this.brightnessOffset = 0;
                };
                this.setColorEffect(this.brightnessOffset);
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
                        if (this.subAction == "bounce"){
                            this.subAction = "still";
                            this.subChanged = true;
                            this.behaviour = "idle";
                            this.setFromMotion();
                        } else {
                            if (this.subAction == "boost"){
                                this.subAction = "still";
                                this.subChanged = true;
                                this.behaviour = "idle";
                                this.setFromMotion();
                            } else {
                                if (this.subAction == "splat"){
                                    this.game.playSoundEffect("gamefail");
                                    this.game.endLose();
                                    this.subAction = "stuck";
                                    this.subChanged = true;
                                };
                            };
                        };
                    };
                };
            };
            if (this.subChanged){
                this.movie.setArtSub(this.subAction);
                if (this.subActionFromStart){
                    this.subActionFromStart = false;
                    this.movie.setArtSub("hide");
                    this.movie.setArtSub(this.subAction);
                };
                this.subChanged = false;
                if (this.mainAction == "normal"){
                    if (this.subAction != "hide"){
                        this.penguinColor.color = this.game.penguinColor;
                        trace(("HSF Game.as 300 game = " + this.game));
                        trace(("HSF Game.as 300 game.penguinColor = " + this.game.penguinColor));
                        trace(("HSF Game.as 300 penguinColor = " + this.penguinColor));
                        trace(("HSF Game.as 300 penguinColor.color = " + this.penguinColor.color));
                        this.movie.art.art.art.skin.transform.colorTransform = this.penguinColor;
                    };
                };
            };
        }

        public function reachGoal():*{
            this.destroy();
        }

        public function setFromMotion():*{
            if (this.motionY < 0){
                this.subAction = "moveup";
                this.subChanged = true;
            } else {
                if (this.motionY > (30 * this.game.speedMultiplier)){
                    this.subAction = "movedown4";
                    this.subChanged = true;
                    if (!this._isFireFallingSoundPlaying){
                        this._isFireFallingSoundPlaying = true;
                        this.game.playSoundEffect("fallloop");
                    };
                } else {
                    if (this.motionY > (28 * this.game.speedMultiplier)){
                        this.subAction = "movedown3";
                        this.subChanged = true;
                    } else {
                        if (this.motionY > (25 * this.game.speedMultiplier)){
                            if (this.subAction != "movedown2"){
                                this.game.playSoundEffect("playerfallstart");
                            };
                            this.subAction = "movedown2";
                            this.subChanged = true;
                        } else {
                            if (this.motionY > (20 * this.game.speedMultiplier)){
                                this.subAction = "movedown1";
                                this.subChanged = true;
                            } else {
                                this.subAction = "still";
                                this.subChanged = true;
                            };
                        };
                    };
                };
            };
        }

        public function setColorEffect(_arg_1:*):*{
            this.brightnessOffset = _arg_1;
            this.myColorTransform.brightness = this.brightnessOffset;
            this.movie.transform.colorTransform = this.myColorTransform;
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
