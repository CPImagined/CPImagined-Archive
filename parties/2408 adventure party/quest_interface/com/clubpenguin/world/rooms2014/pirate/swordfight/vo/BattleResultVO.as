//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleResultVO
    {
        var resultForCreator, creatorAttack, challengerAttack, creatorPoints, challengerPoints;
        function BattleResultVO (resultForCreator, creatorAttack, challengerAttack, creatorPoints, challengerPoints) {
            this.resultForCreator = resultForCreator;
            this.creatorAttack = creatorAttack;
            this.challengerAttack = challengerAttack;
            this.creatorPoints = creatorPoints;
            this.challengerPoints = challengerPoints;
        }
        function toString() {
            return(((((((((("BattleResultVO{resultForCreator=" + resultForCreator) + ", creatorAttack=") + creatorAttack) + ", challengerAttack=") + challengerAttack) + ", creatorPoints=") + creatorPoints) + ", challengerPoints=") + challengerPoints) + "}");
        }
        static var RESULT_WIN = 0;
        static var RESULT_LOSS = 1;
        static var RESULT_DRAW = 2;
    }
