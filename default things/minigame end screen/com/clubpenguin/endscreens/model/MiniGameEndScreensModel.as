//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.model
{
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import com.clubpenguin.endscreens.service.MiniGameEndScreensService;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.vo.endscreen.MiniGameEndScreenVO;
    import com.clubpenguin.endscreens.MiniGameEndScreensConstants;
    import com.clubpenguin.main.service.webservice.WebServiceType;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public class MiniGameEndScreensModel 
    {

        [Inject]
        public var webServiceManager:WebServiceManagerProxy;
        [Inject]
        public var miniGameEndScreensService:MiniGameEndScreensService;
        public var update:Signal = new Signal();
        private var _gameKey:String;
        private var _gameName:String;
        private var _frameName:String;
        private var _isTableGame:Boolean;
        private var _playerTotalCoins:int;
        private var _playerTotalStamps:int;
        private var _coinsEarnedInSession:int;
        private var _totalGameStampsEarned:int;
        private var _numberOfStampsEarnedForGame:int;
        private var _stampIdsForGame:Array;
        private var _ownedStampIds:Array;
        private var _stampsGroupId:int;
        private var _stamps:Array = new Array();
        private var _exitRoom:String;
        private var _exitRoomXpos:int;
        private var _exitRoomYpos:int;
        private var _earnedStampIds:Array;
        public var gameWithStamps:Boolean;
        private var _isBlackHoleGame:Boolean;
        public var _isCardJitsu:Boolean;


        public function get gameName():String
        {
            return (this._gameName);
        }

        public function get frameName():String
        {
            return (this._frameName);
        }

        public function get playerTotalCoins():int
        {
            return (this._playerTotalCoins);
        }

        public function get playerTotalStamps():int
        {
            return (this._playerTotalStamps);
        }

        public function get coinsEarnedInSession():int
        {
            return (this._coinsEarnedInSession);
        }

        public function get numberOfGameStamps():int
        {
            return (this.stampIdsForGame.length);
        }

        public function get numberOfStampsEarnedForGame():int
        {
            return (this._numberOfStampsEarnedForGame);
        }

        public function get stampIdsForGame():Array
        {
            return (this._stampIdsForGame);
        }

        public function get ownedStampIds():Array
        {
            return (this._ownedStampIds);
        }

        public function get stampsGroupId():int
        {
            return (this._stampsGroupId);
        }

        public function get stamps():Array
        {
            return (this._stamps);
        }

        public function get exitRoom():String
        {
            return (this._exitRoom);
        }

        public function get exitRoomXpos():int
        {
            return (this._exitRoomXpos);
        }

        public function get exitRoomYpos():int
        {
            return (this._exitRoomYpos);
        }

        public function get earnedStampIds():Array
        {
            return (this._earnedStampIds);
        }

        public function get isBlackHoleGame():Boolean
        {
            return (this._isBlackHoleGame);
        }

        public function get isCardJitsu():Boolean
        {
            return (this._isCardJitsu);
        }

        public function init(params:Object):void
        {
            this.miniGameEndScreensService.endGameServiceCompleteSignal.add(this.endGameScreenConfigData);
        }

        public function gameHasStamps():Boolean
        {
            if (this.numberOfGameStamps > 0)
            {
                this.gameWithStamps = true;
                return (true);
            };
            return (false);
        }

        public function isdoubleCoins():Boolean
        {
            if (((this.gameHasStamps()) && (this.numberOfGameStamps == this._numberOfStampsEarnedForGame)))
            {
                return (true);
            };
            return (false);
        }

        public function endGameScreenConfigData(configData:MiniGameEndScreenVO):void
        {
            this._gameKey = configData.gameKey;
            this._gameName = configData.gameName;
            this._playerTotalCoins = configData.playerTotalCoins;
            this._coinsEarnedInSession = configData.coinsEarnedInSession;
            this._totalGameStampsEarned = configData.totalGameStampsEarned;
            this._numberOfStampsEarnedForGame = configData.numberOfStampsEarnedForGame;
            this._earnedStampIds = configData.stampIdsEarnedInSession;
            this._playerTotalStamps = configData.playerTotalStamps;
            this._ownedStampIds = configData.ownedStampIds;
            this._stampsGroupId = configData.stampsGroupId;
            this._exitRoom = configData.exitRoom;
            this._exitRoomXpos = configData.exitRoomXpos;
            this._exitRoomYpos = configData.exitRoomYpos;
            this._isTableGame = configData.isTableGame;
            this._isBlackHoleGame = configData.isBlackHoleGame;
            this._isCardJitsu = configData.isCardJitsu;
            this._stampIdsForGame = configData.stampIdsForGame;
            if (this._isTableGame)
            {
                this._frameName = this._gameName;
            }
            else
            {
                this._frameName = this._gameKey;
            };
            if (this.gameHasStamps())
            {
                this.createStampList(this.stampIdsForGame);
                this.updateStampState(this._ownedStampIds, this._earnedStampIds);
            };
            this.update.dispatch();
        }

        private function createStampList(stamps:Array):void
        {
            var stampData:Object;
            var stampCount:int;
            var stampVO:StampVO;
            var gameStampData:Object = this.fetchWebServiceObjectForGame();
            for each (stampData in gameStampData)
            {
                stampCount = 0;
                while (stampCount < stamps.length)
                {
                    if ((stampData[MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_STAMP_ID] as int) == (stamps[stampCount] as int))
                    {
                        stampVO = new StampVO();
                        stampVO.state = StampVO.STAMP_STATE_DEFAULT;
                        stampVO.sortPriority = StampVO.SORT_RIGHT;
                        stampVO.id = this.stampIdsForGame[stampCount];
                        stampVO.title = stampData[MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_NAME];
                        stampVO.description = stampData[MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_DESCRIPTION];
                        stampVO.member = stampData[MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_IS_MEMBER];
                        stampVO.rank = stampData[MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_RANK];
                        this._stamps.push(stampVO);
                    };
                    stampCount++;
                };
            };
        }

        private function fetchWebServiceObjectForGame():Object
        {
            var stampObject:Object;
            var stampsWebService:WebServiceDataVO = this.webServiceManager.getDataByName(WebServiceType.STAMPS.name);
            for each (stampObject in stampsWebService.data)
            {
                if (stampObject.group_id == this._stampsGroupId)
                {
                    return (stampObject[MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_STAMPS]);
                };
            };
            return (null);
        }

        private function updateStampState(ownedStamps:Array, earnedStamps:Array):void
        {
            var ownedStamp:int;
            var earnedStamp:int;
            var gameStamp:int;
            while (gameStamp < this._stamps.length)
            {
                ownedStamp = 0;
                while (ownedStamp < ownedStamps.length)
                {
                    if ((this._stamps[gameStamp] as StampVO).id == ownedStamps[ownedStamp])
                    {
                        (this._stamps[gameStamp] as StampVO).state = StampVO.STAMP_STATE_OWNED;
                    };
                    ownedStamp++;
                };
                earnedStamp = 0;
                while (earnedStamp < earnedStamps.length)
                {
                    if ((this._stamps[gameStamp] as StampVO).id == earnedStamps[earnedStamp])
                    {
                        (this._stamps[gameStamp] as StampVO).state = StampVO.STAMP_STATE_JUST_EARNED;
                    };
                    earnedStamp++;
                };
                gameStamp++;
            };
            this.sortStamps();
        }

        private function sortStamps():void
        {
            var earnedList:Array = new Array();
            var remainingList:Array = new Array();
            var i:int;
            while (i < this._stamps.length)
            {
                if ((this._stamps[i] as StampVO).state == StampVO.STAMP_STATE_JUST_EARNED)
                {
                    earnedList.push(this._stamps[i]);
                };
                i++;
            };
            earnedList.sortOn(MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_RANK, Array.NUMERIC);
            var j:int;
            while (j < this._stamps.length)
            {
                if ((((this._stamps[j] as StampVO).state == StampVO.STAMP_STATE_OWNED) || ((this._stamps[j] as StampVO).state == StampVO.STAMP_STATE_DEFAULT)))
                {
                    remainingList.push(this._stamps[j]);
                };
                j++;
            };
            remainingList.sortOn(MiniGameEndScreensConstants.STAMPS_WEB_SERVICE_RANK, Array.NUMERIC);
            var sortedArray:Array = earnedList.concat(remainingList);
            this._stamps = sortedArray;
        }


    }
}//package com.clubpenguin.endscreens.model
