//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO
    {
        var _id, hostId, participant, state;
        function PerformanceVO () {
            _id = NEXT_ID++;
        }
        static function fromObject(obj) {
            var _local_1 = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO();
            _local_1.hostId = obj.hostId;
            _local_1.participant = obj.participant;
            _local_1.state = (obj.open ? (com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.BOARDING) : (com.clubpenguin.world.rooms2014.muppets.performance.states.PerformanceStateEnum.PERFORMING));
            return(_local_1);
        }
        function get id() {
            return(_id);
        }
        function clone() {
            var _local_2 = new com.clubpenguin.world.rooms2014.muppets.performance.PerformanceVO();
            _local_2.hostId = hostId;
            _local_2.participant = participant;
            _local_2.state = state;
            return(_local_2);
        }
        function containsParticipant(playerId) {
            if (playerId == participant) {
                return(true);
            }
            return(false);
        }
        function containsPlayer(playerId) {
            return((((hostId == playerId) || (containsParticipant(playerId))) ? true : false));
        }
        function participantEqual(other) {
            if (other.participant == participant) {
                return(true);
            }
            return(false);
        }
        function equals(other) {
            return(((hostId == other.hostId) && (state == other.state)) && (participantEqual(other)));
        }
        function toString() {
            return(((((("PerformanceVO{ hostId=" + hostId) + ", participant=") + participant) + ", state=") + state) + " }");
        }
        static var NEXT_ID = 0;
    }
