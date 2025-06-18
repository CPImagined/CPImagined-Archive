//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.view.CardJitsuEndGameView extends com.clubpenguin.endgame.view.BaseEndGameView
    {
        var _shell, _model;
        function CardJitsuEndGameView () {
            super();
        }
        function createCongratsMessage() {
            var _local_2 = _shell.getLocalizedString("end_game_no_coins_congrats");
            _local_2 = com.clubpenguin.util.StringUtils.replaceString("%game_name%", String(_model.gameName), _local_2);
            return(_local_2);
        }
        static var LINKAGE_ID = "com.clubpenguin.endgame.view.CardJitsuEndGameView";
    }
