//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.GameplayObstacle
    {
        var game, gameplayWorld, gameplayHolder, obstacleHolder, idNumber, settingN, movie;
        function GameplayObstacle (_arg_10, _arg_5, _arg_8, _arg_4, _arg_2, _arg_7, _arg_6, _arg_3, _arg_9) {
            game = _arg_10;
            gameplayWorld = _arg_5;
            gameplayHolder = _arg_8;
            obstacleHolder = _arg_4;
            idNumber = _arg_2;
            settingN = _arg_9;
            movie = obstacleHolder.attachMovie("obstacle", "Obj" + _arg_2, _arg_2);
            movie._x = _arg_7;
            movie._y = _arg_6;
            movie._rotation = _arg_3;
        }
        function destroy() {
            movie.removeMovieClip();
        }
    }
