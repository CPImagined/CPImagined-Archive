package com.clubpenguin.games.arrow{
    import flash.display.MovieClip;
    import com.clubpenguin.game.ICPGame;
    import flash.media.SoundTransform;
    import flash.media.SoundChannel;
    import com.clubpenguin.game.ICPGameHost;
    import com.disney.coupler.ICouplerHost;
    import com.clubpenguin.game.HostAccess;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.clubpenguin.lib.vo.EndGameVO;

    public class ArrowEngine extends MovieClip implements ICPGame {

        public static const PIN_ITEM_ID:int = 7110;

        public var gameplayHolder:MovieClip;
        public var foregroundHolder:MovieClip;
        public var hudHolder:MovieClip;
        public var playerObj:Player;
        public var bgObj:Bg;
        public var bossObj:Boss;
        public var fgObj:Fg;
        public var hudObj:Hud;
        public var balloonObj:Balloon;
        public var bowObj:Bow;
        public var particleObj:Particle;
        public var popupObj:Popup;
        public var mousePosX:Number;
        public var mousePosY:Number;
        public var mouseMovement:Boolean;
        public var mouseClick:Boolean;
        public var mousePressing:Boolean;
        public var objL:Array;
        public var objectsN:Number;
        public var balloonsN:Number;
        public var particlesN:Number;
        public var n:Number;
        public var countDownN:Number;
        public var countDownDefault:Number;
        public var countDownSpecialN:Number;
        public var countDownSpecialDefault:Number;
        public var particleL:Array;
        public var shotFired:Boolean;
        public var targetsHitN:Number;
        public var targetsHitL:Array;
        public var scoreN:Number;
        public var balloonType:String;
        public var balloonsPoppedN:Number;
        public var gameEnding:Boolean;
        public var showScoreTally:Boolean;
        public var gameOver:Boolean;
        public var balloonSpeed:Number;
        public var tallyDone:Boolean;
        public var bossHP:Number;
        public var fightStarted:Boolean;
        public var penguinColor:Number;
        public var paused:Boolean;
        public var tempPaused:Boolean;
        public var tempCountN:Number;
        public var tempCountDefault:Number;
        public var sfxVolume:SoundTransform;
        public var sndChannelBGMusic:SoundChannel;
        public var sndChannel1:SoundChannel;
        public var sndChannel1Used:Boolean;
        public var sndChannel2:SoundChannel;
        public var sndChannel2Used:Boolean;
        public var sndChannel1LastUsedN:Number;
        public var sndChannel1LastSound:String;
        public var sndChannel2LastUsedN:Number;
        public var sndChannel2LastSound:String;
        public var sndOrbPoof1:SNDorbPoof1;
        public var sndOrbPoof2:SNDorbPoof2;
        public var sndOrbSpeed:SNDorbSpeed;
        public var sndDragonFlap:SNDdragonFlap;
        public var sndDragonHurt1:SNDdragonHurt1;
        public var sndDragonHurt2:SNDdragonHurt2;
        public var sndDragonIntro:SNDdragonIntro;
        public var sndDragonTheme:SNDdragonTheme;
        public var sndDragonKO:SNDdragonKO;
        public var featherHit:Boolean;
        public var hasPin:Boolean;
        public var pauseForced:Boolean;
        public var host:ICPGameHost;

        public function setup(_arg_1:XML=null, _arg_2:Boolean=false):void{
            this.host = HostAccess.getHost();
            this.penguinColor = 16737945;
            this.penguinColor = HostAccess.getHost().getPlayerColor();
            this.mouseMovement = false;
            this.mouseClick = false;
            this.mousePressing = false;
            this.mousePosX = 760;
            this.mousePosY = 480;
            this.objectsN = 0;
            this.balloonsN = 0;
            this.balloonSpeed = 0.06;
            this.countDownDefault = 100;
            this.countDownN = this.countDownDefault;
            this.countDownSpecialDefault = 30;
            this.countDownSpecialN = this.countDownSpecialDefault;
            this.shotFired = false;
            this.scoreN = 0;
            this.targetsHitN = 0;
            this.balloonsPoppedN = 0;
            this.gameEnding = false;
            this.showScoreTally = false;
            this.gameOver = false;
            this.tallyDone = false;
            this.bossHP = 1001;
            this.fightStarted = false;
            this.paused = false;
            this.tempPaused = false;
            this.tempCountDefault = 2;
            this.tempCountN = this.tempCountDefault;
            this.featherHit = false;
            this.pauseForced = false;
            this.sfxVolume = new SoundTransform();
            this.sndChannel1Used = false;
            this.sndChannel1LastSound = "none";
            this.sndChannel1LastUsedN = 0;
            this.sndChannel2Used = false;
            this.sndChannel2LastSound = "none";
            this.sndChannel2LastUsedN = 0;
            this.sndOrbPoof1 = new SNDorbPoof1();
            this.sndOrbPoof2 = new SNDorbPoof2();
            this.sndOrbSpeed = new SNDorbSpeed();
            this.sndDragonFlap = new SNDdragonFlap();
            this.sndDragonHurt1 = new SNDdragonHurt1();
            this.sndDragonHurt2 = new SNDdragonHurt2();
            this.sndDragonIntro = new SNDdragonIntro();
            this.sndDragonKO = new SNDdragonKO();
            this.sndDragonTheme = new SNDdragonTheme();
            this.sndChannelBGMusic = this.sndDragonTheme.play();
            this.sndChannelBGMusic.soundTransform = this.sfxVolume;
            this.addEventListener(MouseEvent.MOUSE_MOVE, this.mousemove);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.mousedown);
            this.addEventListener(MouseEvent.MOUSE_UP, this.mouseup);
            this.gameplayHolder = new MovieClip();
            this.addChild(this.gameplayHolder);
            this.foregroundHolder = new MovieClip();
            this.addChild(this.foregroundHolder);
            this.hudHolder = new MovieClip();
            this.addChild(this.hudHolder);
            this.objL = new Array();
            this.targetsHitL = new Array();
            this.particleL = new Array();
            this.bgObj = new Bg(this, 0, 0);
            this.objL.push(this.bgObj);
            this.bossObj = new Boss(this, 0, 0);
            this.objL.push(this.bossObj);
            this.fgObj = new Fg(this, 0, 0);
            this.objL.push(this.fgObj);
            this.hudObj = new Hud(this, "lvl", 0, 0);
            this.objL.push(this.hudObj);
            this.bowObj = new Bow(this, (380 - 9), (400 - 22));
            this.objL.push(this.bowObj);
            this.playerObj = new Player(this, 380, 400);
            this.objL.push(this.playerObj);
            this.addEventListener(Event.ENTER_FRAME, this.frameEvent);
            this.hasPin = false;
            this.host.getDoesPlayerOwnItem(PIN_ITEM_ID).addOnce(this.onReceivedDoesPlayerOwnItem);
        }

        private function onReceivedDoesPlayerOwnItem(_arg_1:int, _arg_2:Boolean):void{
            if (_arg_1 == PIN_ITEM_ID){
                this.hasPin = _arg_2;
            };
        }

        public function closeGame():void{
            if (this.sndChannelBGMusic){
                this.sndChannelBGMusic.stop();
            };
            if (this.sndChannel1){
                this.sndChannel1.stop();
            };
            if (this.sndChannel2){
                this.sndChannel2.stop();
            };
            this.showGameOver(this.scoreN);
        }

        public function frameEvent(_arg_1:Event):void{
            var _local_2:Array;
            if (this.paused){
                if (this.tempPaused){
                    if (this.tempCountN > 0){
                        this.tempCountN--;
                    } else {
                        this.tempCountN = this.tempCountDefault;
                        this.tempPaused = false;
                        this.paused = false;
                    };
                };
            } else {
                if (this.gameOver == false){
                    if (this.gameEnding == false){
                        if (this.fightStarted){
                            if (this.balloonsN < 4){
                                this.countDownN = 0;
                            };
                            if (this.countDownN > 0){
                                this.countDownN--;
                            } else {
                                this.countDownN = this.countDownDefault;
                                this.placeBalloon(100, 540);
                                this.placeBalloon(200, 540);
                                this.placeBalloon(300, 540);
                                this.placeBalloon(400, 540);
                                this.placeBalloon(500, 540);
                                this.placeBalloon(600, 540);
                            };
                        };
                    };
                } else {
                    if (this.gameOver){
                    };
                };
                if (this.objectsN > 0){
                    this.n = 0;
                    while (this.n < this.objL.length) {
                        this.objL[this.n].update();
                        this.n++;
                    };
                    _local_2 = new Array();
                    this.n = 0;
                    while (this.n < this.objL.length) {
                        if (this.objL[this.n].dead == false){
                            _local_2.push(this.objL[this.n]);
                        } else {
                            this.objectsN--;
                        };
                        this.n++;
                    };
                    this.objL.splice(0);
                    this.objL = this.objL.concat(_local_2);
                };
                if (this.targetsHitN > 0){
                    if (this.targetsHitN == 1){
                        this.n = 0;
                        while (this.n < this.targetsHitL.length) {
                            this.placePopup("points", "one", this.targetsHitL[this.n].movie.x, this.targetsHitL[this.n].movie.y);
                            this.scoreN = (this.scoreN + 10);
                            this.n++;
                        };
                        if (this.featherHit){
                            this.featherHit = false;
                            this.playSoundEffect("channel1", "orbSpeed");
                        } else {
                            this.playSoundEffect("channel1", "orbPoof1");
                        };
                    } else {
                        if (this.targetsHitN == 2){
                            this.n = 0;
                            while (this.n < this.targetsHitL.length) {
                                this.placePopup("points", "two", this.targetsHitL[this.n].movie.x, this.targetsHitL[this.n].movie.y);
                                this.scoreN = (this.scoreN + 20);
                                this.n++;
                            };
                            if (this.featherHit){
                                this.featherHit = false;
                                this.playSoundEffect("channel1", "orbSpeed");
                            } else {
                                this.playSoundEffect("channel1", "orbPoof2");
                            };
                        } else {
                            if (this.targetsHitN == 3){
                                this.n = 0;
                                while (this.n < this.targetsHitL.length) {
                                    this.placePopup("points", "three", this.targetsHitL[this.n].movie.x, this.targetsHitL[this.n].movie.y);
                                    this.scoreN = (this.scoreN + 30);
                                    this.n++;
                                };
                                if (this.featherHit){
                                    this.featherHit = false;
                                    this.playSoundEffect("channel1", "orbSpeed");
                                } else {
                                    this.playSoundEffect("channel1", "orbPoof2");
                                };
                            } else {
                                if (this.targetsHitN == 4){
                                    this.n = 0;
                                    while (this.n < this.targetsHitL.length) {
                                        this.placePopup("points", "four", this.targetsHitL[this.n].movie.x, this.targetsHitL[this.n].movie.y);
                                        this.scoreN = (this.scoreN + 40);
                                        this.n++;
                                    };
                                    if (this.featherHit){
                                        this.featherHit = false;
                                        this.playSoundEffect("channel1", "orbSpeed");
                                    } else {
                                        this.playSoundEffect("channel1", "orbPoof2");
                                    };
                                } else {
                                    if (this.targetsHitN >= 5){
                                        this.n = 0;
                                        while (this.n < this.targetsHitL.length) {
                                            this.placePopup("points", "five", this.targetsHitL[this.n].movie.x, this.targetsHitL[this.n].movie.y);
                                            this.scoreN = (this.scoreN + 50);
                                            this.n++;
                                        };
                                        if (this.featherHit){
                                            this.featherHit = false;
                                            this.playSoundEffect("channel1", "orbSpeed");
                                        } else {
                                            this.playSoundEffect("channel1", "orbPoof2");
                                        };
                                    };
                                };
                            };
                        };
                    };
                    if (this.targetsHitN > 2){
                        this.n = 0;
                        while (this.n < this.objL.length) {
                            this.objL[this.n].tint(-1);
                            this.n++;
                        };
                        this.n = 0;
                        while (this.n < this.targetsHitL.length) {
                            this.targetsHitL[this.n].tint(1);
                            this.n++;
                        };
                        this.hudObj.tint(1);
                        this.paused = true;
                        this.tempPaused = true;
                        this.tempCountN = this.tempCountDefault;
                    } else {
                        if (this.targetsHitN > 1){
                            this.n = 0;
                            while (this.n < this.objL.length) {
                                this.objL[this.n].tint(-1);
                                this.n++;
                            };
                            this.n = 0;
                            while (this.n < this.targetsHitL.length) {
                                this.targetsHitL[this.n].tint(1);
                                this.n++;
                            };
                            this.hudObj.tint(1);
                            this.paused = true;
                            this.tempPaused = true;
                            this.tempCountN = this.tempCountDefault;
                        };
                    };
                    if (this.targetsHitN == 2){
                        this.placePopup("combo", "combo1", 380, 400);
                    } else {
                        if (this.targetsHitN == 3){
                            this.placePopup("combo", "combo2", 380, 400);
                        } else {
                            if (this.targetsHitN == 4){
                                this.placePopup("combo", "combo3", 380, 400);
                            } else {
                                if (this.targetsHitN >= 5){
                                    this.placePopup("combo", "combo4", 380, 400);
                                };
                            };
                        };
                    };
                    if (this.targetsHitN > 2){
                        this.bossObj.hit("strong");
                    } else {
                        if (this.targetsHitN > 1){
                            this.bossObj.hit("normal");
                        } else {
                            this.bossObj.hit("weak");
                        };
                    };
                    this.hudObj.scoreChanged = true;
                    this.targetsHitL.splice(0);
                    this.targetsHitN = 0;
                };
                if (this.gameOver == false){
                    if (this.gameEnding == false){
                        if (this.bossHP <= 1){
                            this.gameEnding = true;
                            this.sndChannelBGMusic.stop();
                            this.host.playMusic(-1);
                        };
                    } else {
                        if (this.gameEnding){
                            if (this.showScoreTally == false){
                                if (this.balloonsN < 1){
                                    this.bossObj.ko();
                                };
                            };
                        };
                    };
                };
                if (this.pauseForced == false){
                    this.paused = true;
                    this.hudObj.mainAction = "hint";
                    this.hudObj.movie.setArtMain(this.hudObj.mainAction);
                };
            };
            if (this.mouseClick){
                if (this.hudObj.mainAction == "lvl"){
                    if (this.mousePosX > 8){
                        if (this.mousePosX < 53){
                            if (this.mousePosY > 11){
                                if (this.mousePosY < 57){
                                    this.paused = true;
                                    this.hudObj.mainAction = "hint";
                                    this.hudObj.movie.setArtMain(this.hudObj.mainAction);
                                };
                            };
                        };
                    };
                };
            };
            this.shotFired = false;
            this.mouseMovement = false;
            this.mouseClick = false;
            this.sndChannel1LastUsedN++;
            this.sndChannel2LastUsedN++;
        }

        public function closeHint():void{
            if (this.pauseForced == false){
                this.pauseForced = true;
                this.bossObj.mainAction = "intro";
                this.bossObj.mainChanged = true;
            };
            this.paused = false;
            this.hudObj.mainAction = "lvl";
            this.hudObj.movie.setArtMain(this.hudObj.mainAction);
            this.hudObj.movie.setBossHP(Math.floor(this.bossHP));
        }

        public function placeBalloon(_arg_1:Number, _arg_2:Number):void{
            this.balloonType = "target";
            if (Math.floor((Math.random() * 4)) == Math.floor((Math.random() * 4))){
                if (this.countDownSpecialN <= 0){
                    this.countDownSpecialDefault = 40;
                    this.countDownSpecialN = this.countDownSpecialDefault;
                    this.balloonType = "feather";
                };
            };
            if (this.balloonType == "target"){
                this.balloonObj = new Balloon(this, this.balloonType, _arg_1, _arg_2, this.balloonSpeed);
            } else {
                this.balloonObj = new Balloon(this, this.balloonType, _arg_1, _arg_2, (this.balloonSpeed * 2));
            };
            this.objL.push(this.balloonObj);
            if (this.balloonsPoppedN > 10){
                this.balloonsPoppedN = (this.balloonsPoppedN - 10);
                this.balloonSpeed = (this.balloonSpeed + 0.03);
                this.countDownDefault = 0;
                this.n = 0;
                while (this.n < 8) {
                    this.n = (this.n + this.balloonSpeed);
                    this.countDownDefault++;
                    this.n = (this.n + 0);
                };
            };
        }

        public function placeParticle(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):void{
            this.particleObj = new Particle(this, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            this.objL.push(this.particleObj);
            if (_arg_1 == "blur"){
                this.particleL.push(this.particleObj);
            };
        }

        public function placePopup(_arg_1:String, _arg_2:String, _arg_3:Number, _arg_4:Number):void{
            this.popupObj = new Popup(this, _arg_1, _arg_2, _arg_3, _arg_4);
            this.objL.push(this.popupObj);
            this.popupObj.update();
        }

        public function playSoundEffect(_arg_1:String, _arg_2:String):void{
            if (_arg_1 == "channel1"){
                if (((!(_arg_2 == this.sndChannel1LastSound)) || (this.sndChannel1LastUsedN > 4))){
                    this.sndChannel1LastSound = _arg_2;
                    this.sndChannel1LastUsedN = 0;
                    if (this.sndChannel1Used){
                        this.sndChannel1.stop();
                    };
                    if (_arg_2 == "orbPoof1"){
                        this.sndChannel1 = this.sndOrbPoof1.play();
                        this.sndChannel1.soundTransform = this.sfxVolume;
                        this.sndChannel1Used = true;
                    } else {
                        if (_arg_2 == "orbPoof2"){
                            this.sndChannel1 = this.sndOrbPoof2.play();
                            this.sndChannel1.soundTransform = this.sfxVolume;
                            this.sndChannel1Used = true;
                        } else {
                            if (_arg_2 == "orbSpeed"){
                                this.sndChannel1 = this.sndOrbSpeed.play();
                                this.sndChannel1.soundTransform = this.sfxVolume;
                                this.sndChannel1Used = true;
                            };
                        };
                    };
                };
            } else {
                if (_arg_1 == "channel2"){
                    if (((!(_arg_2 == this.sndChannel2LastSound)) || (this.sndChannel2LastUsedN > 8))){
                        this.sndChannel2LastSound = _arg_2;
                        this.sndChannel2LastUsedN = 0;
                        if (this.sndChannel2Used){
                            this.sndChannel2.stop();
                        };
                        if (_arg_2 == "dragonIntro"){
                            this.sndChannel2 = this.sndDragonIntro.play();
                            this.sndChannel2.soundTransform = this.sfxVolume;
                            this.sndChannel2Used = true;
                        } else {
                            if (_arg_2 == "dragonFlap"){
                                this.sndChannel2 = this.sndDragonFlap.play();
                                this.sndChannel2.soundTransform = this.sfxVolume;
                                this.sndChannel2Used = true;
                            } else {
                                if (_arg_2 == "dragonHurt1"){
                                    this.sndChannel2 = this.sndDragonHurt1.play();
                                    this.sndChannel2.soundTransform = this.sfxVolume;
                                    this.sndChannel2Used = true;
                                } else {
                                    if (_arg_2 == "dragonHurt2"){
                                        this.sndChannel2 = this.sndDragonHurt2.play();
                                        this.sndChannel2.soundTransform = this.sfxVolume;
                                        this.sndChannel2Used = true;
                                    } else {
                                        if (_arg_2 == "dragonKO"){
                                            this.sndChannel2 = this.sndDragonKO.play();
                                            this.sndChannel2.soundTransform = this.sfxVolume;
                                            this.sndChannel2Used = true;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function toggleSoundEffects(_arg_1:String):void{
            if (_arg_1 == "on"){
                this.sfxVolume.volume = 1;
            } else {
                if (_arg_1 == "off"){
                    this.sfxVolume.volume = 0;
                };
            };
        }

        public function mousemove(_arg_1:MouseEvent):void{
            this.mousePosX = mouseX;
            this.mousePosY = mouseY;
            this.mouseMovement = true;
        }

        public function mousedown(_arg_1:MouseEvent):void{
            this.mouseClick = true;
            this.mousePressing = true;
        }

        public function mouseup(_arg_1:MouseEvent):void{
            this.mousePressing = false;
        }

        public function cleanUp():void{
            this.n = 0;
            while (this.n < this.objL.length) {
                this.objL[this.n].movie.parent.removeChild(this.objL[this.n].movie);
                this.objL[this.n].dead = true;
                delete this.objL[this.n];
                this.n++;
            };
            this.objL.splice(0);
            this.objectsN = 0;
        }

        private function showGameOver(_arg_1:int, _arg_2:int=-1):void{
            this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mousemove);
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.mousedown);
            this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseup);
            this.removeEventListener(Event.ENTER_FRAME, this.frameEvent);
            var _local_3:EndGameVO = new EndGameVO();
            _local_3.setGameCompletedParams({"isScornBattleJustPlayed":true});
            _local_3.setScore(_arg_1);
            if (_arg_2 != -1){
                _local_3.setRoomToJoin(_arg_2);
            };
            this.host.showEndGame(_local_3);
        }


        public function setName(_arg_1:String):void{
        }

        public function startGame():void{
        }

        public function getGameLevel():Number{
            return (0);
        }

        public function getGameScore():Number{
            return (0);
        }

        public function endGame():void{
        }

        public function pauseGame(_arg_1:Boolean):void{
        }

        public function getSaveGame():String{
            return (null);
        }

        public function loadGame(_arg_1:String, _arg_2:String):void{
        }

        public function setHost(_arg_1:ICouplerHost):void{
        }


    }
}//package com.clubpenguin.games.arrow
