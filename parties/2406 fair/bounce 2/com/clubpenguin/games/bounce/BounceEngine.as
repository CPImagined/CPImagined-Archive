package com.clubpenguin.games.bounce{
    import flash.display.MovieClip;
    import com.clubpenguin.game.ICPGame;
    import flash.media.SoundTransform;
    import flash.media.SoundChannel;
    import com.clubpenguin.games.bounce.audio.SNDbounce;
    import com.clubpenguin.games.bounce.audio.SNDairpoint;
    import com.clubpenguin.games.bounce.audio.SNDgamestart;
    import com.clubpenguin.games.bounce.audio.SNDgamewin;
    import com.clubpenguin.games.bounce.audio.SNDgamefail;
    import com.clubpenguin.games.bounce.audio.SNDfallloop;
    import com.clubpenguin.games.bounce.audio.SNDplayerfallstart;
    import com.clubpenguin.games.bounce.audio.SNDplayerland;
    import com.clubpenguin.game.ICPGameHost;
    import com.clubpenguin.lib.vo.EndGameVO;
    import com.disney.coupler.ICouplerHost;
    import com.clubpenguin.game.HostAccess;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.clubpenguin.games.bounce.audio.*;

    public class BounceEngine extends MovieClip implements ICPGame {

        private static const NUM_BUBBLES_TO_WIN:int = 500;
        public static const END_GAME_SCREEN_PATH:String = "oops_game_system_defender";

        public var gameplayHolder:MovieClip;
        public var foregroundHolder:MovieClip;
        public var hudHolder:MovieClip;
        public var playerObj:Player;
        public var bubbleObj:Bubble;
        public var energyballObj:Energyball;
        public var popupObj:Popup;
        public var goalObj:Goal;
        public var bgObj:Bg;
        public var parallaxObj:Parallax;
        public var ground:Object;
        public var cloudNear:Object;
        public var cloudMid:Object;
        public var cloudFar:Object;
        public var hudObj:Hud;
        public var mousePosX:Number;
        public var mousePosY:Number;
        public var mouseMovement:Boolean;
        public var mouseClick:Boolean;
        public var mousePressing:Boolean;
        public var objL:Array;
        public var objectsN:Number;
        public var particlesN:Number;
        public var n:Number;
        public var distX:Number;
        public var distY:Number;
        public var Distance:Number;
        public var particleL:Array;
        public var scoreN:Number;
        public var bestScoreN:Number;
        public var scoreMultiplier:Number;
        public var penguinColor:Number;
        public var paused:Boolean;
        public var sfxVolume:SoundTransform;
        public var sndChannel1:SoundChannel;
        public var sndChannel1Used:Boolean;
        public var sndChannel2:SoundChannel;
        public var sndChannel2Used:Boolean;
        public var sndChannel1LastUsedN:Number;
        public var sndChannel2LastUsedN:Number;
        public var sndChannel1LastSound:String;
        public var sndChannel2LastSound:String;
        public var countEasy:Number;
        public var countMedium:Number;
        public var countHard:Number;
        public var countDefaultN:Number;
        public var countN:Number;
        public var sndBounce:SNDbounce;
        public var sndAirpoint:SNDairpoint;
        public var sndGamestart:SNDgamestart;
        public var sndGamewin:SNDgamewin;
        public var sndGameFail:SNDgamefail;
        public var sndFallloop:SNDfallloop;
        public var sndPlayerfallstart:SNDplayerfallstart;
        public var sndPlayerland:SNDplayerland;
        public var placeBubbleY:Number;
        public var speedMultiplier:Number;
        public var bubbleSupplyN:Number;
        public var placementStyle:String;
        public var groupingX:Number;
        public var placementSupply:*;
        public var pauseWaitN:Number;
        public var pauseDefaultWaitN:Number;
        public var host:ICPGameHost;
        private var endGameVO:EndGameVO;

        public function BounceEngine(){
            this.bestScoreN = 0;
        }

        public function setHost(_arg_1:ICouplerHost):void{
        }

        public function setup(_arg_1:XML=null, _arg_2:Boolean=false):void{
            this.host = HostAccess.getHost();
            this.penguinColor = this.host.getPlayerColor();
            this.mouseMovement = false;
            this.mouseClick = false;
            this.mousePressing = false;
            this.pauseDefaultWaitN = 6;
            this.pauseWaitN = this.pauseDefaultWaitN;
            this.mousePosX = 380;
            this.mousePosY = 480;
            this.objectsN = 0;
            this.scoreN = 0;
            this.scoreMultiplier = 1;
            this.paused = true;
            this.countDefaultN = this.countEasy;
            this.countN = this.countDefaultN;
            this.placeBubbleY = -400;
            this.speedMultiplier = 1;
            this.bubbleSupplyN = NUM_BUBBLES_TO_WIN;
            this.placementStyle = "random";
            this.groupingX = ((380 + Math.floor((Math.random() * 100))) - 50);
            this.placementSupply = 20;
            this.sfxVolume = new SoundTransform();
            this.sndChannel1Used = false;
            this.sndChannel2Used = false;
            this.sndChannel1LastUsedN = 0;
            this.sndChannel2LastUsedN = 0;
            this.sndChannel1LastSound = "none";
            this.sndChannel2LastSound = "none";
            this.sndBounce = new SNDbounce();
            this.sndAirpoint = new SNDairpoint();
            this.sndGamestart = new SNDgamestart();
            this.sndGamewin = new SNDgamewin();
            this.sndGameFail = new SNDgamefail();
            this.sndFallloop = new SNDfallloop();
            this.sndPlayerfallstart = new SNDplayerfallstart();
            this.sndPlayerland = new SNDplayerland();
            this.addEventListener(Event.ENTER_FRAME, this.frameEvent);
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
            this.particleL = new Array();
            this.bgObj = new Bg(this, 0, 0);
            this.objL.push(this.bgObj);
            this.parallaxObj = new Parallax(this, 0, 0, "far", "cloud");
            this.objL.push(this.parallaxObj);
            this.cloudFar = this.parallaxObj;
            this.parallaxObj = new Parallax(this, 0, 0, "mid", "cloud");
            this.objL.push(this.parallaxObj);
            this.cloudMid = this.parallaxObj;
            this.parallaxObj = new Parallax(this, 0, 0, "near", "cloud");
            this.objL.push(this.parallaxObj);
            this.cloudNear = this.parallaxObj;
            this.parallaxObj = new Parallax(this, 0, 0, "near", "ground");
            this.objL.push(this.parallaxObj);
            this.ground = this.parallaxObj;
            this.hudObj = new Hud(this, "title", 0, 0);
            this.objL.push(this.hudObj);
        }

        public function closeGame():void{
            this.showGameOver(this.scoreN);
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

        public function setupGameplay():*{
            this.playerObj = new Player(this, this.mousePosX, 200);
            this.objL.push(this.playerObj);
            this.playSoundEffect("gamestart");
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.placeNextBubble();
            this.hudObj.updateScore();
        }

        public function resetGameplay():*{
            this.showGameOver(0, 230);
        }

        public function endWin():*{
            this.n = 0;
            while (this.n < this.objL.length) {
                if (this.objL[this.n].kind == "popup"){
                    this.objL[this.n].destroy();
                };
                this.n++;
            };
            this.paused = true;
            this.showGameOver(this.scoreN, -1, true);
        }

        public function endLose():*{
            this.n = 0;
            while (this.n < this.objL.length) {
                if (this.objL[this.n].kind == "popup"){
                    this.objL[this.n].destroy();
                };
                this.n++;
            };
            this.paused = true;
            this.showGameOver(this.scoreN);
        }

        public function frameEvent(_arg_1:Event):void{
            var _local_2:*;
            if (!this.paused){
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
                this.gameplayHolder.y = ((this.playerObj.movie.y * -1) + 200);
                this.bgObj.movie.y = (0 - this.gameplayHolder.y);
                this.foregroundHolder.y = this.gameplayHolder.y;
                this.cloudNear.movie.y = ((this.gameplayHolder.y / 16) - this.gameplayHolder.y);
                this.cloudMid.movie.y = ((this.gameplayHolder.y / 32) - this.gameplayHolder.y);
                this.cloudFar.movie.y = ((this.gameplayHolder.y / 64) - this.gameplayHolder.y);
            };
            if (this.mouseClick){
                if (this.hudObj.mainAction == "title"){
                    this.findDistance(380, 240, this.mousePosX, this.mousePosY);
                    if (this.Distance < 89){
                        this.paused = false;
                        this.hudObj.mainAction = "lvl";
                        this.hudObj.movie.setArtMain(this.hudObj.mainAction);
                        this.setupGameplay();
                    };
                } else {
                    if (((this.hudObj.mainAction == "endlose") || (this.hudObj.mainAction == "endwin"))){
                        this.findDistance(380, 240, this.mousePosX, this.mousePosY);
                        if (this.Distance < 89){
                            this.resetGameplay();
                        };
                    };
                };
            };
            this.mouseMovement = false;
            this.mouseClick = false;
            this.sndChannel1LastUsedN++;
            this.sndChannel2LastUsedN++;
        }

        public function placeNextBubble():*{
            if (this.bubbleSupplyN > 0){
                this.bubbleSupplyN--;
                if (this.placementStyle == "random"){
                    this.placeBubble(Math.floor((Math.random() * 760)), this.placeBubbleY, "normal");
                    this.placeBubbleY = (this.placeBubbleY - (200 * (this.speedMultiplier * 0.5)));
                    if (this.placementSupply > 0){
                        this.placementSupply--;
                    } else {
                        this.placementStyle = "grouping";
                        this.groupingX = ((380 + Math.floor((Math.random() * 100))) - 50);
                        this.placementSupply = (Math.floor((Math.random() * 6)) + 2);
                    };
                } else {
                    if (this.placementStyle == "grouping"){
                        this.placeBubble(((this.groupingX + Math.floor((Math.random() * 200))) - 100), this.placeBubbleY, "normal");
                        this.placeBubbleY = (this.placeBubbleY - (200 * (this.speedMultiplier * 0.5)));
                        if (this.placementSupply > 0){
                            this.placementSupply--;
                        } else {
                            this.placementStyle = "random";
                            this.placementSupply = (Math.floor((Math.random() * 20)) + 10);
                        };
                    };
                };
            } else {
                if (this.bubbleSupplyN == 0){
                    this.bubbleSupplyN--;
                    this.placeGoal(380, this.placeBubbleY);
                };
            };
        }

        public function placeBubble(_arg_1:*, _arg_2:*, _arg_3:*):*{
            this.bubbleObj = new Bubble(this, _arg_1, _arg_2, _arg_3);
            this.bubbleObj.movie.cacheAsBitmap = true;
            this.objL.push(this.bubbleObj);
        }

        public function placeEnergyball(_arg_1:*, _arg_2:*, _arg_3:*):*{
            this.energyballObj = new Energyball(this, _arg_1, _arg_2, _arg_3);
            this.objL.push(this.energyballObj);
        }

        public function placePopup(_arg_1:*, _arg_2:*, _arg_3:*, _arg_4:*, _arg_5:*):*{
            this.popupObj = new Popup(this, _arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            this.objL.push(this.popupObj);
        }

        public function placeGoal(_arg_1:*, _arg_2:*):*{
            this.goalObj = new Goal(this, _arg_1, _arg_2);
            this.goalObj.movie.cacheAsBitmap = true;
            this.objL.push(this.goalObj);
        }

        final public function playFireFallingLoop():void{
        }

        public function playSoundEffect(_arg_1:*):void{
            if (this.sndChannel1LastUsedN > this.sndChannel2LastUsedN){
                if (((!(_arg_1 == this.sndChannel1LastSound)) || (this.sndChannel1LastUsedN > 4))){
                    this.sndChannel1LastSound = _arg_1;
                    this.sndChannel1LastUsedN = 0;
                    if (this.sndChannel1Used){
                        this.sndChannel1.stop();
                    };
                    if (_arg_1 == "bounce"){
                        this.sndChannel1 = this.sndBounce.play();
                        this.sndChannel1.soundTransform = this.sfxVolume;
                        this.sndChannel1Used = true;
                    } else {
                        if (_arg_1 == "airpoint"){
                            this.sndChannel1 = this.sndAirpoint.play();
                            this.sndChannel1.soundTransform = this.sfxVolume;
                            this.sndChannel1Used = true;
                        } else {
                            if (_arg_1 == "gamestart"){
                                this.sndChannel1 = this.sndGamestart.play();
                                this.sndChannel1.soundTransform = this.sfxVolume;
                                this.sndChannel1Used = true;
                            } else {
                                if (_arg_1 == "gamewin"){
                                    this.sndChannel1 = this.sndGamewin.play();
                                    this.sndChannel1.soundTransform = this.sfxVolume;
                                    this.sndChannel1Used = true;
                                } else {
                                    if (_arg_1 == "fallloop"){
                                        this.sndChannel1 = this.sndFallloop.play(0, int.MAX_VALUE);
                                        this.sndChannel1.soundTransform = this.sfxVolume;
                                        this.sndChannel1Used = true;
                                    } else {
                                        if (_arg_1 == "playerland"){
                                            this.sndChannel2.stop();
                                            this.sndChannel1 = this.sndPlayerland.play();
                                            this.sndChannel1.soundTransform = this.sfxVolume;
                                            this.sndChannel1Used = true;
                                        } else {
                                            if (_arg_1 == "playerfallstart"){
                                                this.sndChannel2.stop();
                                                this.sndChannel1 = this.sndPlayerfallstart.play();
                                                this.sndChannel1.soundTransform = this.sfxVolume;
                                                this.sndChannel1Used = true;
                                            } else {
                                                if (_arg_1 == "gamefail"){
                                                    this.sndChannel1 = this.sndGameFail.play();
                                                    this.sndChannel1.soundTransform = this.sfxVolume;
                                                    this.sndChannel1Used = true;
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            } else {
                if (((!(_arg_1 == this.sndChannel2LastSound)) || (this.sndChannel2LastUsedN > 4))){
                    this.sndChannel2LastSound = _arg_1;
                    this.sndChannel2LastUsedN = 0;
                    if (this.sndChannel2Used){
                        this.sndChannel2.stop();
                    };
                    if (_arg_1 == "bounce"){
                        this.sndChannel2 = this.sndBounce.play();
                        this.sndChannel2.soundTransform = this.sfxVolume;
                        this.sndChannel2Used = true;
                    } else {
                        if (_arg_1 == "airpoint"){
                            this.sndChannel2 = this.sndAirpoint.play();
                            this.sndChannel2.soundTransform = this.sfxVolume;
                            this.sndChannel2Used = true;
                        } else {
                            if (_arg_1 == "gamestart"){
                                this.sndChannel2 = this.sndGamestart.play();
                                this.sndChannel2.soundTransform = this.sfxVolume;
                                this.sndChannel2Used = true;
                            } else {
                                if (_arg_1 == "gamewin"){
                                    this.sndChannel2 = this.sndGamewin.play();
                                    this.sndChannel2.soundTransform = this.sfxVolume;
                                    this.sndChannel2Used = true;
                                } else {
                                    if (_arg_1 == "fallloop"){
                                        this.sndChannel2 = this.sndFallloop.play(0, int.MAX_VALUE);
                                        this.sndChannel2.soundTransform = this.sfxVolume;
                                        this.sndChannel2Used = true;
                                    } else {
                                        if (_arg_1 == "playerland"){
                                            this.sndChannel1.stop();
                                            this.sndChannel2 = this.sndPlayerland.play();
                                            this.sndChannel2.soundTransform = this.sfxVolume;
                                            this.sndChannel2Used = true;
                                        } else {
                                            if (_arg_1 == "playerfallstart"){
                                                this.sndChannel1.stop();
                                                this.sndChannel2 = this.sndPlayerfallstart.play();
                                                this.sndChannel2.soundTransform = this.sfxVolume;
                                                this.sndChannel2Used = true;
                                            } else {
                                                if (_arg_1 == "gamefail"){
                                                    this.sndChannel2 = this.sndGameFail.play();
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
                };
            };
        }

        public function toggleSoundEffects(_arg_1:*):*{
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

        public function findDistance(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void{
            this.distX = Math.round((_arg_3 - _arg_1));
            this.distY = Math.round((_arg_4 - _arg_2));
            this.Distance = Math.round(Math.sqrt(((this.distX * this.distX) + (this.distY * this.distY))));
        }

        public function cleanUp():*{
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

        private function showGameOver(_arg_1:int, _arg_2:int=-1, _arg_3:Boolean=false):void{
            this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mousemove);
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.mousedown);
            this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseup);
            this.removeEventListener(Event.ENTER_FRAME, this.frameEvent);
            trace("remove game sounds");
            if (this.sndChannel1 != null){
                this.sndChannel1.stop();
            };
            if (this.sndChannel2 != null){
                this.sndChannel2.stop();
            };
            this.endGameVO = new EndGameVO();
            var _local_4:Object = {
                "showGameOverModal":false,
                "numCrystals":_arg_1,
                "gameCompleted":_arg_3,
                "gameOverModalPath":END_GAME_SCREEN_PATH
            };
            _arg_2 = 852;
            trace("\n");
            trace("________________________________________");
            trace(("showGameOverModal: " + _local_4.showGameOverModal));
            trace(("score (numCrystals): " + _local_4.numCrystals));
            trace(("gameCompleted: " + _local_4.gameCompleted));
            trace(("gameOverModalPath: " + END_GAME_SCREEN_PATH));
            trace(("roomToJoin: " + _arg_2));
            trace("________________________________________");
            this.endGameVO.setScore((_arg_1 / 10));
            this.endGameVO.setGameCompletedParams(_local_4);
            if (_arg_2 != -1){
            };
            this.endGameVO.setRoomToJoin(_arg_2);
            this.showEndGamePopup();
        }

        private function showEndGamePopup():void{
            var _local_1:GameOverScreen = new GameOverScreen();
            this.addChild(_local_1);
            _local_1.x = ((stage.stageWidth / 2) - (_local_1.width / 2));
            _local_1.y = ((stage.stageHeight / 2) - (_local_1.height / 2));
            _local_1.btn_done.addEventListener(MouseEvent.CLICK, this.rejoinGame);
            trace(("BOUNCE - WHAT LANGUAGE ARE WE USING L:::: " + this.host.getLocale()));
            _local_1.scoreTxt.text = (this.getScoreString() + String((this.endGameVO.getScore() * 10)));
            _local_1.ticketsTxt.text = (this.getTicketString() + String(this.endGameVO.getScore()));
            _local_1.btn_txt.text = this.getButtonString();
            _local_1.btn_txt.mouseEnabled = false;
            _local_1.btn_txt.selectable = false;
        }
        private function rejoinGame(_arg_1:MouseEvent):void{
            this.host.showEndGame(this.endGameVO);
        }

        private function getScoreString():String{
            var _local_1:String = "";
            switch (this.host.getLocale()){
                case 1:
                    _local_1 = "Your score : ";
                    break;
                case 2:
                    _local_1 = "Seus pontos : ";
                    break;
                case 3:
                    _local_1 = "Ton score : ";
                    break;
                case 4:
                    _local_1 = "Tu puntaje : ";
                    break;
                case 5:
                    _local_1 = "Deine Punkte : ";
                    break;
                case 6:
                    _local_1 = "Твой счёт : ";
                    break;
                default:
                    _local_1 = "Your score : ";
            };
            return (_local_1);
        }

        private function getTicketString():String{
            var _local_1:String = "";
            switch (this.host.getLocale()){
                case 1:
                    _local_1 = "Tickets : ";
                    break;
                case 2:
                    _local_1 = "Tíquetes : ";
                    break;
                case 3:
                    _local_1 = "Tickets : ";
                    break;
                case 4:
                    _local_1 = "Billetes : ";
                    break;
                case 5:
                    _local_1 = "Tickets : ";
                    break;
                case 6:
                    _local_1 = "Билеты : ";
                    break;
                default:
                    _local_1 = "Tickets : ";
            };
            return (_local_1);
        }

        private function getButtonString():String{
            var _local_1:String = "";
            switch (this.host.getLocale()){
                case 1:
                    _local_1 = "DONE";
                    break;
                case 2:
                    _local_1 = "PRONTO";
                    break;
                case 3:
                    _local_1 = "TERMINÉ";
                    break;
                case 4:
                    _local_1 = "LISTO";
                    break;
                case 5:
                    _local_1 = "FERTIG";
                    break;
                case 6:
                    _local_1 = "Готово";
                    break;
                default:
                    _local_1 = "DONE";
            };
            return (_local_1);
        }


    }
}//package com.clubpenguin.games.bounce
