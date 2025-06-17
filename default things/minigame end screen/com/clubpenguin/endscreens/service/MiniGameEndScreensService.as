//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens.service
{
    import com.clubpenguin.lib.vo.endscreen.MiniGameEndScreenVO;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.service.webservice.WebServiceType;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public class MiniGameEndScreensService 
    {

        private const PARAMS_OBJECT:String = "endGameParams";

        private var _miniGameEndScreenVO:MiniGameEndScreenVO = new MiniGameEndScreenVO();
        [Inject]
        public var appModel:MainModel;
        [Inject]
        public var webServiceManager:WebServiceManagerProxy;
        public var endGameServiceCompleteSignal:Signal = new Signal();


        public function init():void
        {
        }

        public function handleEndGameConfigData(configData:Object):void
        {
            var key:String;
            var t:String;
            for (key in configData)
            {
                for (t in configData[key])
                {
                };
            };
            this._miniGameEndScreenVO.gameKey = (configData[this.PARAMS_OBJECT].gameKey as String);
            this._miniGameEndScreenVO.gameName = (configData[this.PARAMS_OBJECT].gameName as String);
            this._miniGameEndScreenVO.isTableGame = (configData[this.PARAMS_OBJECT].is_table as Boolean);
            this._miniGameEndScreenVO.playerTotalCoins = (configData[this.PARAMS_OBJECT].total as int);
            this._miniGameEndScreenVO.coinsEarnedInSession = (configData[this.PARAMS_OBJECT].earned as int);
            this._miniGameEndScreenVO.numberOfStampsEarnedForGame = (configData[this.PARAMS_OBJECT].totalNumberOfGameStampsEarned as int);
            this._miniGameEndScreenVO.stampIdsEarnedInSession = (configData[this.PARAMS_OBJECT].stampIds as Array);
            this._miniGameEndScreenVO.isBlackHoleGame = (configData[this.PARAMS_OBJECT].isBlackHoleGame as Boolean);
            this._miniGameEndScreenVO.ownedStampIds = (configData[this.PARAMS_OBJECT].ownedStampIds as Array);
            this._miniGameEndScreenVO.playerTotalStamps = (configData[this.PARAMS_OBJECT].totalNumberOfStamps as int);
            this._miniGameEndScreenVO.exitRoom = (configData[this.PARAMS_OBJECT].gameOverRoomData.roomName as String);
            this._miniGameEndScreenVO.exitRoomXpos = (configData[this.PARAMS_OBJECT].gameOverRoomData.xPos as int);
            this._miniGameEndScreenVO.exitRoomYpos = (configData[this.PARAMS_OBJECT].gameOverRoomData.yPos as int);
            this._miniGameEndScreenVO.isCardJitsu = (configData[this.PARAMS_OBJECT].isCardJitsu as Boolean);
            this._miniGameEndScreenVO.stampsGroupId = this.fetchStampsGroupId();
            this._miniGameEndScreenVO.stampIdsForGame = this.createStampData();
            if (this._miniGameEndScreenVO.isTableGame)
            {
                this._miniGameEndScreenVO.gameKey = null;
            };
            this.endGameServiceCompleteSignal.dispatch(this._miniGameEndScreenVO);
        }

        private function createStampData():Array
        {
            var stampData:Object;
            var stamp:Object;
            var stampsData:WebServiceDataVO = this.webServiceManager.getDataByName(WebServiceType.STAMPS.name);
            var stampIdsForGame:Array = new Array();
            for each (stampData in stampsData.data)
            {
                if (this._miniGameEndScreenVO.stampsGroupId == stampData.group_id)
                {
                    for each (stamp in stampData.stamps)
                    {
                        stampIdsForGame.push(stamp.stamp_id);
                    };
                };
            };
            return (stampIdsForGame);
        }

        public function fetchStampsGroupId():int
        {
            var stampsGroupId:int;
            var gameObject:Object;
            var gameName:String = this._miniGameEndScreenVO.gameName;
            var gamesData:WebServiceDataVO = this.webServiceManager.getDataByName(WebServiceType.GAMES.name);
            for each (gameObject in gamesData.data)
            {
                if ((gameObject.name as String) == gameName)
                {
                    if (gameObject.stamp_group_id != 0)
                    {
                        stampsGroupId = gameObject.stamp_group_id;
                    };
                };
            };
            return (stampsGroupId);
        }


    }
}//package com.clubpenguin.endscreens.service
