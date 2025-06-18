package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import fl.motion.Color;
    import flash.display.SimpleButton;
    import com.clubpenguin.games.bounce.movies.HudMC;
    import flash.events.MouseEvent;
    import com.clubpenguin.games.bounce.*;

    internal class Hud extends MovieClip {

        private var game:MovieClip;
        public var gameplayHolder:Object;
        public var movie:MovieClip;
        public var startX:Number;
        public var startY:Number;
        public var mainAction:String;
        public var mainChanged:Boolean;
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
        public var color:Color;
        public var kind:String;
        public var tempSlice:String;
        public var ones:String;
        public var tens:String;
        public var hundreds:String;
        public var thousands:String;
        public var tenthousands:String;
        public var hundredthousands:String;
        public var onesN:Number;
        public var tensN:Number;
        public var hundredsN:Number;
        public var thousandsN:Number;
        public var tenthousandsN:Number;
        public var hundredthousandsN:Number;
        public var closeBtn:SimpleButton;

        public function Hud(_arg_1:MovieClip, _arg_2:String, _arg_3:Number, _arg_4:Number){
            this.game = _arg_1;
            this.kind = "hud";
            this.game.objectsN++;
            this.gameplayHolder = this.game.hudHolder;
            this.movie = new HudMC();
            this.gameplayHolder.addChild(this.movie);
            this.startX = _arg_3;
            this.startY = _arg_4;
            this.movie.x = this.startX;
            this.movie.y = this.startY;
            this.Xmouse = this.startX;
            this.Ymouse = this.startY;
            this.mainAction = _arg_2;
            this.mainChanged = true;
            this.mainActionFromStart = false;
            this.motionX = 0;
            this.motionY = 0;
            this.dead = false;
            this.color = new Color();
            this.movie.setArtMain(this.mainAction);
            this.closeBtn = this.movie.art.close_btn;
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.onCloseClicked, false, 0, true);
        }

        private function onCloseClicked(_arg_1:MouseEvent):void{
            this.game.closeGame();
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
            };
        }

        public function updateScore():*{
            if (this.game.scoreN > this.game.bestScoreN){
                this.game.bestScoreN = this.game.scoreN;
            };
            if (this.mainAction == "lvl"){
                this.tempSlice = String(this.game.scoreN);
                if (this.tempSlice.length > 5){
                    this.hundredthousands = this.tempSlice.slice(0, 1);
                    this.hundredthousandsN = Number(this.hundredthousands);
                    this.hundredthousandsN++;
                    this.tenthousands = this.tempSlice.slice(1, 2);
                    this.tenthousandsN = Number(this.tenthousands);
                    this.tenthousandsN++;
                    this.thousands = this.tempSlice.slice(2, 3);
                    this.thousandsN = Number(this.thousands);
                    this.thousandsN++;
                    this.hundreds = this.tempSlice.slice(3, 4);
                    this.hundredsN = Number(this.hundreds);
                    this.hundredsN++;
                    this.tens = this.tempSlice.slice(4, 5);
                    this.tensN = Number(this.tens);
                    this.tensN++;
                    this.ones = this.tempSlice.slice(5, 6);
                    this.onesN = Number(this.ones);
                    this.onesN++;
                } else {
                    if (this.tempSlice.length > 4){
                        this.hundredthousandsN = 1;
                        this.tenthousands = this.tempSlice.slice(0, 1);
                        this.tenthousandsN = Number(this.tenthousands);
                        this.tenthousandsN++;
                        this.thousands = this.tempSlice.slice(1, 2);
                        this.thousandsN = Number(this.thousands);
                        this.thousandsN++;
                        this.hundreds = this.tempSlice.slice(2, 3);
                        this.hundredsN = Number(this.hundreds);
                        this.hundredsN++;
                        this.tens = this.tempSlice.slice(3, 4);
                        this.tensN = Number(this.tens);
                        this.tensN++;
                        this.ones = this.tempSlice.slice(4, 5);
                        this.onesN = Number(this.ones);
                        this.onesN++;
                    } else {
                        if (this.tempSlice.length > 3){
                            this.hundredthousandsN = 1;
                            this.tenthousandsN = 1;
                            this.thousands = this.tempSlice.slice(0, 1);
                            this.thousandsN = Number(this.thousands);
                            this.thousandsN++;
                            this.hundreds = this.tempSlice.slice(1, 2);
                            this.hundredsN = Number(this.hundreds);
                            this.hundredsN++;
                            this.tens = this.tempSlice.slice(2, 3);
                            this.tensN = Number(this.tens);
                            this.tensN++;
                            this.ones = this.tempSlice.slice(3, 4);
                            this.onesN = Number(this.ones);
                            this.onesN++;
                        } else {
                            if (this.tempSlice.length > 2){
                                this.hundredthousandsN = 1;
                                this.tenthousandsN = 1;
                                this.thousandsN = 1;
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
                                    this.hundredthousandsN = 1;
                                    this.tenthousandsN = 1;
                                    this.thousandsN = 1;
                                    this.hundredsN = 1;
                                    this.tens = this.tempSlice.slice(0, 1);
                                    this.tensN = Number(this.tens);
                                    this.tensN++;
                                    this.ones = this.tempSlice.slice(1, 2);
                                    this.onesN = Number(this.ones);
                                    this.onesN++;
                                } else {
                                    this.hundredthousandsN = 1;
                                    this.tenthousandsN = 1;
                                    this.thousandsN = 1;
                                    this.hundredsN = 1;
                                    this.tensN = 1;
                                    this.ones = this.tempSlice.slice(0, 1);
                                    this.onesN = Number(this.ones);
                                    this.onesN++;
                                };
                            };
                        };
                    };
                };
                this.movie.art.art.ones.gotoAndStop(this.onesN);
                this.movie.art.art.tens.gotoAndStop(this.tensN);
                this.movie.art.art.hundreds.gotoAndStop(this.hundredsN);
                this.movie.art.art.thousands.gotoAndStop(this.thousandsN);
                this.movie.art.art.tenthousands.gotoAndStop(this.tenthousandsN);
                this.movie.art.art.hundredthousands.gotoAndStop(this.hundredthousandsN);
            } else {
                if (((this.mainAction == "endwin") || (this.mainAction == "endlose"))){
                };
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
            this.dead = true;
            this.gameplayHolder.removeChild(this.movie);
            delete this[this];
        }


    }
}//package com.clubpenguin.games.bounce
