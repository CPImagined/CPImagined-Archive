//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.BattleVO
    {
        var creatorId, challengerId, state, _id;
        function BattleVO (creatorId, challengerId, state) {
            this.creatorId = creatorId;
            this.challengerId = challengerId;
            this.state = state;
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
        static var STATE_OPENED = 0;
        static var STATE_BATTLING = 1;
        static var STATE_ENDING = 2;
        static var STATE_REMOVED = 3;
    }
