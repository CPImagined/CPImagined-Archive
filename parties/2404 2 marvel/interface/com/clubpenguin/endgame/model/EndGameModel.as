//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.model.EndGameModel
    {
        var _shell, _params, _isJustCompleted, _gameName;
        function EndGameModel (shell, endGameParams) {
            _shell = shell;
            _params = endGameParams;
            _isJustCompleted = (_params.newStamps.length >= 1) && (_params.numCompletedStamps == _params.numTotalStamps);
            var _local_2 = (_params.isTable ? (_shell.getGameCrumbsByName(_params.activeTable.name)) : (_shell.getGameCrumbsById(_params.gameRoomId)));
            _gameName = _local_2.name;
        }
        function get shell() {
            return(_shell);
        }
        function get endGameParams() {
            return(_params);
        }
        function get gameName() {
            return(_gameName);
        }
        function get isJustCompleted() {
            return(_isJustCompleted);
        }
    }
