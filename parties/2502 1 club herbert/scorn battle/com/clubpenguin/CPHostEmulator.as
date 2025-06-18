//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin
{
    import flash.display.Sprite;
    import com.disney.coupler.ICouplerHost;
    import com.clubpenguin.game.ICPHost;
    import com.disney.coupler.ICouplerGame;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.display.LoaderInfo;
    import com.clubpenguin.lib.vo.IPlayerVO;
    import com.clubpenguin.lib.vo.IEndGameVO;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.MPGameVO;

    public class CPHostEmulator extends Sprite implements ICouplerHost, ICPHost 
    {

        protected var __hostedGameName:String;
        protected var __hostedGame:ICouplerGame;

        public function CPHostEmulator()
        {
            this.__hostedGameName = this.getHostGameName();
            this.loadAsEmulator();
        }

        protected function getHostGameName():String
        {
            throw ("[HostEmulator] you must override getHostGameName() in your emulator implementation");
        }

        private function loadAsEmulator():void
        {
            var mcl:Loader;
            var gameToLoad:URLRequest;
            trace(("[HostEmulator] CP specific, going to load " + this.__hostedGameName));
            gameToLoad = new URLRequest(this.__hostedGameName);
            mcl = new Loader();
            mcl.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
            mcl.load(gameToLoad);
        }

        private function onLoadComplete(_eventObj:Event):void
        {
            var ldi:LoaderInfo;
            ldi = (_eventObj.target as LoaderInfo);
            this.__hostedGame = (ldi.content as ICouplerGame);
            this.__hostedGame.setHost(this);
        }

        public function launchGame():void
        {
        }

        public function getLocale():int
        {
            return (-1);
        }

        public function getPlayerVO():IPlayerVO
        {
            return (null);
        }

        public function showEndGame(endGameVO:IEndGameVO):void
        {
        }

        public function getBasePath():String
        {
            return ("");
        }
		
		public function getBaseConfigPath():String
		{
			return "";
		}

        public function showMembershipPrompt(_filename:String, _biTag:String=null):void
        {
        }

        public function isMusicMuted():Boolean
        {
            return (false);
        }

        public function stampEarned(_stampID:int, _isServerSide:Boolean=false):void
        {
        }

        public function isStampEarned(stampID:int):Boolean
        {
            return (true);
        }

        public function levelComplete(_level:int):void
        {
        }

        public function levelStart(_level:int):void
        {
        }

        public function getMyPuffles():Array
        {
            return (null);
        }

        public function requestFPS(_fps:int):Boolean
        {
            return (false);
        }

        public function getPlayerColor():int
        {
            return (0);
        }

        public function purchaseItem(itemID:int):void
        {
        }

        public function getDoesPlayerOwnItem(itemID:int):Signal
        {
            return (new Signal(int, Boolean));
        }

        public function playMusic(musicID:int):void
        {
        }

        public function getGameStartParams():Object
        {
            return ({});
        }

        public function launchMPGame(game:MPGameVO):void
        {
        }


    }
}//package com.clubpenguin
