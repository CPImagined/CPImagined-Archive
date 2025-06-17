//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Debris
    {
        var game, gameplayWorld, gameplayHolder, particleHolder, idNumber, settingN, movie, motionX, motionY, motionR;
        function Debris (_arg_10, _arg_4, _arg_8, _arg_5, _arg_3, _arg_7, _arg_6, _arg_9, _arg_12, _arg_11) {
            super(_arg_10, _arg_4, _arg_8, _arg_5, _arg_3, _arg_7, _arg_6, _arg_9);
            game = _arg_10;
            gameplayWorld = _arg_4;
            gameplayHolder = _arg_8;
            particleHolder = _arg_5;
            idNumber = _arg_3;
            settingN = _arg_9;
            movie = particleHolder.attachMovie("debris", "Obj" + _arg_3, _arg_3);
            movie._x = _arg_7;
            movie._y = _arg_6;
            movie.gotoAndStop(settingN);
            motionX = _arg_12;
            motionY = _arg_11;
            motionX = motionX * (random(15) / 10);
            motionY = motionY * (random(15) / 10);
            motionR = Math.abs(motionX) + Math.abs(motionY);
        }
        function updateGameplay() {
            motionY = motionY + 1;
            motionX = motionX * 0.98;
            motionY = motionY * 0.98;
            motionR = motionR * 0.98;
            movie._x = movie._x + motionX;
            movie._y = movie._y + motionY;
            movie._rotation = movie._rotation + motionR;
            if (movie._y > game.fallZoneObj.movie._y) {
                game.removeObject(this, game.debrisArray);
            }
        }
    }
