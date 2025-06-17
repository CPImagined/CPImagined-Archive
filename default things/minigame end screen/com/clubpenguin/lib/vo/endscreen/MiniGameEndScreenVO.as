//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.vo.endscreen
{
    public class MiniGameEndScreenVO 
    {

        public var gameKey:String;
        public var gameName:String;
        public var isTableGame:Boolean;
        public var totalGameStampsEarned:int;
        public var playerTotalCoins:int;
        public var coinsEarnedInSession:int;
        public var numberOfStampsEarnedForGame:int;
        public var stampIdsEarnedInSession:Array = [];
        public var stampIdsForGame:Array = [];
        public var ownedStampIds:Array = [];
        public var playerTotalStamps:int;
        public var exitRoom:String;
        public var exitRoomXpos:int;
        public var exitRoomYpos:int;
        public var isBlackHoleGame:Boolean = true;
        public var isCardJitsu:Boolean;
        public var stampsGroupId:int;


    }
}//package com.clubpenguin.lib.vo.endscreen
