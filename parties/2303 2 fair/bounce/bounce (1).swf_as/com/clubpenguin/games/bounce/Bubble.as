package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.bounce.movies.BubbleMC;
    import com.clubpenguin.games.bounce.*;

    internal class Bubble extends MovieClip {

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
        public var radiusN:Number;
        public var defaultMotionX:Number;
        public var kind:String;
        public var collision:Boolean;
        public var targetX:Number;
        public var targetY:Number;

        public function Bubble(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number, _arg_4:String){
            this.game = _arg_1;
            this.kind = "bubble";
            this.game.objectsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new BubbleMC();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_2;
            this.startY = _arg_3;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.defaultMotionX = 10;
            this.motionX = this.defaultMotionX;
            this.motionY = -20;
            this.mainAction = _arg_4;
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
            this.color = new Color();
            this.collision = false;
            this.movie.setArtMain(this.mainAction);
            this.movie.setArtSub(this.subAction);
            this.movie.art.art.art.gotoAndStop((Math.floor((Math.random() * 3)) + 1));
        }

        public function update():void{
            if (this.subAction == "still"){
                this.collision = false;
                this.targetX = this.game.playerObj.movie.x;
                this.targetY = this.game.playerObj.movie.y;
                this.findDistance(this.movie.x, this.movie.y, this.targetX, this.targetY);
                if (this.Distance < 70){
                    this.collision = true;
                } else {
                    this.targetX = this.game.playerObj.colX;
                    this.targetY = this.game.playerObj.colY;
                    this.findDistance(this.movie.x, this.movie.y, this.targetX, this.targetY);
                    if (this.Distance < 70){
                        this.collision = true;
                    };
                };
                if (this.collision == true){
                    if (((this.game.playerObj.motionY > 0) && (this.game.playerObj.movie.y < this.movie.y))){
                        this.game.playerObj.motionY = (-30 * this.game.speedMultiplier);
                        this.game.playerObj.subAction = "bounce";
                        this.game.playerObj.subChanged = true;
                        this.game.playerObj.subActionFromStart = true;
                        this.game.playerObj.behaviour = "jump";
                        this.pop();
                        this.game.scoreMultiplier = 1;
                        this.n = 0;
                        while (this.n < 10) {
                            this.game.placeEnergyball(((this.movie.x + (Math.random() * 50)) - 25), ((this.movie.y + (Math.random() * 50)) - 25), "normal");
                            this.n++;
                        };
                        this.game.scoreN = (this.game.scoreN + 10);
                        this.game.hudObj.updateScore();
                        this.game.placePopup(this.movie.x, this.movie.y, "pts", "still", 10);
                        this.game.scoreMultiplier++;
                        this.game.playSoundEffect("bounce");
                    } else {
                        if (this.game.playerObj.motionY < 0){
                            this.game.playerObj.motionY = (this.game.playerObj.motionY - (10 * this.game.speedMultiplier));
                            this.game.playerObj.subAction = "boost";
                            this.game.playerObj.subChanged = true;
                            this.game.playerObj.subActionFromStart = true;
                            this.game.playerObj.behaviour = "jump";
                            this.pop();
                            this.n = 0;
                            while (this.n < 10) {
                                this.game.placeEnergyball(((this.movie.x + (Math.random() * 50)) - 25), ((this.movie.y + (Math.random() * 50)) - 25), "normal");
                                this.n++;
                            };
                            this.game.scoreN = (this.game.scoreN + (10 * this.game.scoreMultiplier));
                            this.game.hudObj.updateScore();
                            this.game.placePopup(this.movie.x, this.movie.y, "pts", "still", (10 * this.game.scoreMultiplier));
                            this.game.scoreMultiplier++;
                            if (this.game.scoreMultiplier > 10){
                                this.game.scoreMultiplier = 10;
                            };
                            this.game.playSoundEffect("airpoint");
                        };
                    };
                };
                if (this.movie.y > (this.game.playerObj.movie.y + (700 * this.game.speedMultiplier))){
                    this.game.placeNextBubble();
                    this.destroy();
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

        public function pop():*{
            this.subAction = "pop";
            this.subChanged = true;
            this.game.placeNextBubble();
            this.game.speedMultiplier = (this.game.speedMultiplier + 0.01);
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
