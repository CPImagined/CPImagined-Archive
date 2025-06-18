//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.pirate.swordfight.vo.BattleVO
    {
        var creatorId, challengerId, state, duelId, _id;
        function BattleVO (creatorId, challengerId, state, duelId) {
            this.creatorId = creatorId;
            this.challengerId = challengerId;
            this.state = state;
            this.duelId = duelId;
            _id = NEXT_ID++;
        }
        function get id() {
            return(_id);
        }
        function containsPlayer(playerId) {
            return((creatorId == playerId) || (challengerId == playerId));
        }
        function toString() {
            return(((((((("BattleVO{_id=" + _id) + ", creatorId=") + creatorId) + ", challengerId=") + challengerId) + ", state=") + state) + "}");
        }
        static var NEXT_ID = 0;
    }
