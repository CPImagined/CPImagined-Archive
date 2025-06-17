//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.model.StampProgressModel
    {
        var _shell, _numStampsEarned, _numTotalStamps, _completedPercent;
        function StampProgressModel (shell, numStampsEarned, numTotalStamps) {
            _shell = shell;
            _numStampsEarned = numStampsEarned;
            _numTotalStamps = numTotalStamps;
            _completedPercent = Math.floor(100 * (_numStampsEarned / _numTotalStamps));
        }
        function get shell() {
            return(_shell);
        }
        function get completedPercent() {
            return(_completedPercent);
        }
    }
