//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.view.CoinEndGameView extends com.clubpenguin.endgame.view.BaseEndGameView
    {
        var _earnedCoinsTxt, coins_mc, _earnedCoinsShadowTxt, _totalCoinsTxt, _currentFrameLabel, _params, _shell;
        function CoinEndGameView () {
            super();
        }
        function initReferences() {
            super.initReferences();
            _earnedCoinsTxt = coins_mc.earned_txt;
            _earnedCoinsShadowTxt = coins_mc.earned_shadow_txt;
            _totalCoinsTxt = coins_mc.total_txt;
            setupCoins();
        }
        function setupCoins() {
            if (_currentFrameLabel == com.clubpenguin.endgame.view.BaseEndGameView.FRAME_HOWTO) {
                return(undefined);
            }
            var _local_2;
            if ((_params.numCompletedStamps == _params.numTotalStamps) && (_params.numTotalStamps > 0)) {
                _local_2 = "end_game_coins_earned_double";
                _local_2 = _shell.getLocalizedString(_local_2);
                _local_2 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.earnedCoins / 2), _local_2);
                _local_2 = com.clubpenguin.util.StringUtils.replaceString("%num_x2%", String(_params.earnedCoins), _local_2);
            } else {
                _local_2 = ((_params.earnedCoins == 1) ? "end_game_one_coin_earned" : "end_game_coins_earned");
                _local_2 = _shell.getLocalizedString(_local_2);
                if (_params.earnedCoins != 1) {
                    _local_2 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.earnedCoins), _local_2);
                }
            }
            var _local_3 = _shell.getLocalizedString("end_game_total_coins");
            _local_3 = com.clubpenguin.util.StringUtils.replaceString("%num%", String(_params.totalCoins), _local_3);
            _earnedCoinsTxt.text = _local_2;
            _earnedCoinsShadowTxt.text = _local_2;
            _totalCoinsTxt.text = _local_3;
        }
        static var LINKAGE_ID = "com.clubpenguin.endgame.view.CoinEndGameView";
    }
