package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import com.clubpenguin.games.bounce.movies.GoalMC;
    import com.clubpenguin.games.bounce.*;

    internal class Goal extends MovieClip {

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
        public var behaviour:String;
        public var kind:String;
        public var penguinColor:Color;

        public function Goal(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number){
            this.game = _arg_1;
            this.kind = "goal";
            this.game.objectsN++;
            this.gameplayHolder = this.game.gameplayHolder;
            this.movie = new GoalMC();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_2;
            this.startY = _arg_3;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.mainAction = "normal";
            this.mainChanged = true;
            this.subAction = "still";
            this.subChanged = false;
            this.mainActionFromStart = false;
            this.dead = false;
            this.color = new Color();
            this.behaviour = "idle";
            this.penguinColor = new Color();
        }

        public function update():void{
            if (this.behaviour == "idle"){
                this.findDistance(this.movie.x, this.movie.y, this.game.playerObj.movie.x, this.game.playerObj.movie.y);
                if (this.Distance < 100){
                    this.game.playerObj.reachGoal();
                    this.game.scoreN = (this.game.scoreN + 1000);
                    this.game.hudObj.updateScore();
                    this.subAction = "pop";
                    this.movie.setArtSub(this.subAction);
                    this.penguinColor.color = this.game.penguinColor;
                    trace(("HSF Goal.as 85 penguinColor = " + this.penguinColor));
                    trace(("HSF Goal.as 85 penguinColor.color = " + this.penguinColor.color));
                    this.movie.art.art.art.skin.transform.colorTransform = this.penguinColor;
                    this.game.playSoundEffect("gamewin");
                    this.behaviour = "done";
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
                            this.game.endWin();
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
