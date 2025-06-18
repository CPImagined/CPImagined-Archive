//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.model.EndGameParams
    {
        var totalCoins, earnedCoins, numTotalStamps, numCompletedStamps, newStamps, isTable, activeTable, gameRoomId;
        function EndGameParams () {
            totalCoins = 0;
            earnedCoins = 0;
            numTotalStamps = 0;
            numCompletedStamps = 0;
            newStamps = [];
            isTable = false;
            activeTable = null;
            gameRoomId = 0;
        }
        function toString() {
            var _local_2 = "EndGameParams:";
            _local_2 = _local_2 + ("\n\t-totalCoins             = " + totalCoins);
            _local_2 = _local_2 + ("\n\t-earnedCoins            = " + earnedCoins);
            _local_2 = _local_2 + ("\n\t-numTotalStamps         = " + numTotalStamps);
            _local_2 = _local_2 + ("\n\t-numCompletedStamps     = " + numCompletedStamps);
            _local_2 = _local_2 + ("\n\t-newStamps              = " + newStamps);
            _local_2 = _local_2 + ("\n\t-isTable                = " + isTable);
            _local_2 = _local_2 + ("\n\t-activeTable            = " + activeTable);
            _local_2 = _local_2 + ("\n\t-gameRoomId             = " + gameRoomId);
            return(_local_2);
        }
    }
