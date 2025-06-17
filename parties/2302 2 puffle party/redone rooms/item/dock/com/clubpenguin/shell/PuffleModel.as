//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.PuffleModel
    {
        var mood, hat, stats;
        function PuffleModel () {
            mood = new com.clubpenguin.shell.PuffleMoodVO();
            hat = new com.clubpenguin.shell.puffle.PuffleHatVO();
            stats = new com.clubpenguin.shell.PuffleStatsVO();
        }
        function hasHat() {
            return(((hat.hatType == com.clubpenguin.shell.puffle.PuffleHatEnum.ACTUAL_HAT) ? true : false));
        }
        function updateStats() {
            trace("Update stats");
        }
        function updatePuffleState(puffleState) {
            _puffleState = puffleState;
        }
        function getPuffleState() {
            return(_puffleState);
        }
        var id = -1;
        var typeID = -1;
        var name = "";
        var _puffleState = 0;
    }
