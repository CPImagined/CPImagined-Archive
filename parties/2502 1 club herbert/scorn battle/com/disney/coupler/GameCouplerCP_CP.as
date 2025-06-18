package com.disney.coupler{
    import com.clubpenguin.game.ICPHost;
    import com.clubpenguin.game.ICPGameHost;
    import com.clubpenguin.game.ICPGame;
    import com.clubpenguin.lib.IDisposable;
    import flash.system.LoaderContext;
    import com.clubpenguin.lib.locale.ILocaleHandler;
    import com.clubpenguin.lib.security.ISecurityHandler;
    import flash.system.ApplicationDomain;
    import flash.system.Security;
    import flash.system.SecurityDomain;
    import flash.events.Event;
    import com.clubpenguin.lib.security.SecurityHandler;
    import com.disney.loader.XMLLoader;
    import com.disney.loader.SWFLoader;
    import flash.display.DisplayObject;
    import com.clubpenguin.lib.locale.LocaleHandler;
    import com.clubpenguin.game.HostAccess;
    import com.clubpenguin.lib.vo.IPlayerVO;
    import com.clubpenguin.lib.vo.IEndGameVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.MPGameVO;

    public class GameCouplerCP_CP extends GameCoupler implements ICouplerHost, ICouplerGame, ICPHost, ICPGameHost, ICPGame, IDisposable {

        private const DEFAULT_LOCALE:String = "en";
        private const DEFAULT_GAMEID:int = -1;

        protected var __cpHost:ICPHost;
        protected var __contentSchema:XML;
        protected var __cpGame:ICPGame;
        protected var __context:LoaderContext;
        protected var __defaultContentSchema:XML;
        protected var __gameConfig:XML;
        private var __currentFPS:Number;
        private var __hostFPS:Number;
        protected var __localeHandler:ILocaleHandler;
        protected var __securityHandler:ISecurityHandler;

        public function GameCouplerCP_CP():void{
            this.__defaultContentSchema = new XML();
            this.__context = new LoaderContext();
            this.__context.applicationDomain = ApplicationDomain.currentDomain;
            if (Security.sandboxType == Security.REMOTE){
                this.__context.securityDomain = SecurityDomain.currentDomain;
            };
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
        }

        private function onAddedToStageHandler(_arg_1:Event):void{
            if (_arg_1.target == this){
                trace("CRITICAL: Coupler was added to the stage. It is either root or was attached improperly");
                removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
            };
        }

        override public function setHost(_arg_1:ICouplerHost):void{
            super.setHost(_arg_1);
            this.__cpHost = (_arg_1 as ICPHost);
            if (this.__cpHost == null){
                throw (this.getUniqueName() + " host is not a valid ICPHost");
            };
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
            this.generateContentSchema();
        }

        protected function checkSecurity():void{
            this.__securityHandler = new SecurityHandler();
            this.__securityHandler.getSecurityCheckSuccess().add(this.onSecurityCheckSuccess);
            this.__securityHandler.doSecurityCheck(this);
        }

        private function onSecurityCheckSuccess():void{
            trace("[GameCouplerCP_CP] security check passed!");
            this.generateContentSchema();
        }

        override public function setGame(_arg_1:ICouplerGame):void{
            super.setGame(_arg_1);
            this.__cpGame = (_arg_1 as ICPGame);
            trace(("[GameCouplerCP_CP] setGame is " + this.__cpGame));
            if (this.__cpGame == null){
                throw (this.getUniqueName() + " game is not a valid ICPGame");
            };
        }

        protected function generateContentSchema():void{
            new XMLLoader((this.getBaseConfigPath() + "config.xml"), this.onConfigLoaded);
        }

        private function onConfigLoaded(_arg_1:XML):void{
            if (_arg_1 != null){
                this.__contentSchema = _arg_1;
            } else {
                trace("[GameCouplerCP_CP] using defaultContentSchema");
                this.__contentSchema = this.__defaultContentSchema;
            };
            this.sendContentSchema();
        }

        protected function sendContentSchema():void{
            if (this.__contentSchema == null){
                throw ("[GameCouplerCP_CP] contentSchema is null. Can not proceed.");
            };
            if (this.__contentSchema.child("gameConfig").length() != 0){
                trace(("[GameCouplerCP_CP] loadingGameConfig " + this.__contentSchema.gameConfig));
                new XMLLoader((this.getBaseConfigPath() + this.__contentSchema.gameConfig), this.onGameConfigLoaded);
            } else {
                this.loadGameAssets();
            };
        }

        protected function onGameConfigLoaded(_arg_1:XML):void{
            this.__gameConfig = _arg_1;
            this.loadGameAssets();
        }

        protected function loadGameAssets():void{
            if (this.__contentSchema.child("gameAssets").length() != 0){
                trace(("[GameCouplerCP_CP] loadingGameAssets " + this.__contentSchema.gameAssets));
                new SWFLoader((this.getBasePath() + this.__contentSchema.gameAssets), this.onAssetsLoaded, this.__context);
            } else {
                this.setupGameSpace();
            };
        }

        private function onAssetsLoaded(_arg_1:DisplayObject):void{
            trace("[GameCouplerCP_CP] loaded assets, next:setupGame()");
            this.setupGameSpace();
        }

        protected function setupGameSpace():void{
            var _local_1:int;
            var _local_2:String;
            var _local_3:int;
            _local_3 = int(this.getIntFromConfig("gameID", this.DEFAULT_GAMEID));
            this.__localeHandler = new LocaleHandler();
            this.__localeHandler.setGameID(_local_3);
            this.__localeHandler.setGameURL(this.getBasePath());
            _local_1 = int(this.__cpHost.getLocale());
            if (_local_1 != -1){
                this.__localeHandler.setLocaleByID(_local_1);
            } else {
                _local_2 = this.getStringFromConfig("gameLocale", this.DEFAULT_LOCALE);
                this.__localeHandler.setLocaleByName(_local_2);
            };
            this.__localeHandler.setLocaleAssetNames(this.getArrayFromConfig("gameLocaleAssets", ["locale"]));
            if (!this.__contentSchema.hasOwnProperty("gameLocaleFalse")){
                trace("[GameCoupler] loading locale file");
                this.__localeHandler.load(this.onLocaleLoaded);
            } else {
                trace("[GameCoupler] bypass locale file");
                this.onLocaleLoaded(true);
            };
        }

        private function getArrayFromConfig(_arg_1:String, _arg_2:Array):Array{
            var _local_3:Array;
            var _local_4:XML;
            if (this.__contentSchema.child(_arg_1).length() != 0){
                _local_4 = this.__contentSchema[_arg_1];
                trace(("[GameCoupler] assetList from config localization schema:\n" + _local_4));
            } else {
                if (this.__defaultContentSchema.child(_arg_1).length() != 0){
                    _local_4 = this.__defaultContentSchema[_arg_1];
                    trace(("[GameCoupler] assetList from default localization schema:\n" + _local_4));
                } else {
                    _local_3 = _arg_2;
                };
            };
            return (_local_3);
        }

        private function getStringFromConfig(_arg_1:String, _arg_2:String):String{
            var _local_3:String;
            if (this.__contentSchema.child(_arg_1).length() != 0){
                _local_3 = this.__contentSchema[_arg_1];
            } else {
                if (this.__defaultContentSchema.child(_arg_1).length() != 0){
                    _local_3 = this.__defaultContentSchema[_arg_1];
                } else {
                    _local_3 = _arg_2;
                };
            };
            return (_local_3);
        }

        private function getIntFromConfig(_arg_1:String, _arg_2:int):int{
            var _local_3:int;
            var _local_4:XMLList;
            _local_4 = this.__contentSchema.child(_arg_1);
            if (((!(_local_4 == null)) && (!(_local_4.length() == 0)))){
                _local_3 = int(parseInt(this.__contentSchema[_arg_1]));
            } else {
                _local_4 = this.__defaultContentSchema.child(_arg_1);
                if (((!(_local_4 == null)) && (!(_local_4.length() == 0)))){
                    _local_3 = int(parseInt(this.__defaultContentSchema[_arg_1]));
                } else {
                    _local_3 = int(_arg_2);
                };
            };
            return (_local_3);
        }

        private function onLocaleLoaded(_arg_1:Boolean):void{
            if (_arg_1){
                trace("[GameCouplerCP_CP] locale loaded ok!");
                HostAccess.setHost(this);
                this.setupGame();
            } else {
                throw ("[GameCouplerCP_CP] unsuccessful locale load!");
            };
        }

        protected function setupGame():void{
            trace("[GameCouplerCP_CP] setupGame()");
            try {
                this.createGame(this.__contentSchema.gameLinkage);
            } catch(e:Error) {
                trace(((("[GameCouplerCP_CP] Failed to create game from linkage '" + __contentSchema.gameLinkage) + "' ") + e.message));
            };
            try {
                if (this.__cpGame == null){
                    this.createGame(this.__contentSchema.gameClass);
                };
            } catch(e:Error) {
                throw (e);
            };
            if (this.__cpGame == null){
                trace("[GameCouplerCP_CP] prepareGame THIS");
                this.prepareGame(this);
            };
        }

        protected function addGameToHost():void{
            if (this.__cpHost == null){
                throw (this.getUniqueName() + " Error: Attempted to attach game to a host that has not been set.");
            };
            this.__cpHost.addChild((this.__cpGame as DisplayObject));
            this.__cpGame.startGame();
        }

        protected function createGame(_arg_1:String):void{
            var _local_2:Class;
            var _local_3:ICPGame;
            trace(("[GameCoupler] trying to create game from " + _arg_1));
            _local_2 = (loaderInfo.applicationDomain.getDefinition(_arg_1) as Class);
            _local_3 = new (_local_2)();
            this.prepareGame(_local_3);
        }

        protected function prepareGame(_arg_1:ICPGame):void{
            trace(("[GameCouplerCP_CP] Game is " + _arg_1));
            _arg_1.setName("mcGameEngine");
            this.setGame((_arg_1 as ICouplerGame));
            this.addGameToHost();
            _arg_1.setHost(this.__cpHost);
            _arg_1.setup(this.__gameConfig);
        }

        override public function getUniqueName():String{
            return (((super.getUniqueName() + "[GameCouplerClubPenguin") + __uid) + "]");
        }

        public function setup(_arg_1:XML=null, _arg_2:Boolean=false):void{
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
            this.__cpGame.endGame();
        }

        public function pauseGame(_arg_1:Boolean):void{
        }

        public function getSaveGame():String{
            return (null);
        }

        public function loadGame(_arg_1:String, _arg_2:String):void{
        }

        public function getLocale():int{
            return (this.__localeHandler.getLocaleID());
        }

        public function localizeString(_arg_1:String):String{
            return (this.__localeHandler.getString(_arg_1));
        }

        public function localizeImage(_arg_1:String):DisplayObject{
            return (this.__localeHandler.getImage(_arg_1));
        }

        public function getPlayerVO():IPlayerVO{
            return (this.__cpHost.getPlayerVO());
        }

        public function showEndGame(_arg_1:IEndGameVO):void{
            this.__cpHost.showEndGame(_arg_1);
        }

        public function getBasePath():String{
            return (this.__cpHost.getBasePath());
        }

        public function getBaseConfigPath():String{
            return (this.__cpHost.getBasePath().replace("media1", "media2"));
        }

        public function showMembershipPrompt(_arg_1:String, _arg_2:String=null):void{
            this.__cpHost.showMembershipPrompt(_arg_1, _arg_2);
        }

        public function isMusicMuted():Boolean{
            return (this.__cpHost.isMusicMuted());
        }

        public function stampEarned(_arg_1:int, _arg_2:Boolean=false):void{
            this.__cpHost.stampEarned(_arg_1, _arg_2);
        }

        public function isStampEarned(_arg_1:int):Boolean{
            return (this.__cpHost.isStampEarned(_arg_1));
        }

        public function levelComplete(_arg_1:int):void{
            this.__cpHost.levelComplete(_arg_1);
        }

        public function levelStart(_arg_1:int):void{
            this.__cpHost.levelStart(_arg_1);
        }

        public function requestFPS(_arg_1:int):Boolean{
            var _local_2:Boolean;
            if (isNaN(this.__hostFPS)){
                this.__hostFPS = (this.__cpHost as DisplayObject).stage.frameRate;
                this.__currentFPS = this.__hostFPS;
            };
            if (this.__currentFPS != _arg_1){
                this.__currentFPS = _arg_1;
                (this.__cpHost as DisplayObject).stage.frameRate = this.__currentFPS;
            };
            return (this.__currentFPS == _arg_1);
        }

        public function getPlayerColor():int{
            return (this.__cpHost.getPlayerColor());
        }

        public function purchaseItem(_arg_1:int):void{
            this.__cpHost.purchaseItem(_arg_1);
        }

        public function getDoesPlayerOwnItem(_arg_1:int):Signal{
            return (this.__cpHost.getDoesPlayerOwnItem(_arg_1));
        }

        public function playMusic(_arg_1:int):void{
            this.__cpHost.playMusic(_arg_1);
        }

        public function getGameStartParams():Object{
            trace("HSF GameCouplerCP_CP.getGameStartParams");
            trace(("HSF __cpHost.getGameStartParams = " + this.__cpHost.getGameStartParams));
            return (this.__cpHost.getGameStartParams());
        }

        public function dispose():void{
            (this.__cpHost as DisplayObject).stage.frameRate = this.__hostFPS;
        }

        public function launchMPGame(_arg_1:MPGameVO):void{
            this.__cpHost.launchMPGame(_arg_1);
        }


    }
}//package com.disney.coupler
