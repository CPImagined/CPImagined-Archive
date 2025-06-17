//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.Brush
    {
        var hud, movie, settingN, itemType, grabMode, grabbing, gameplayWorld, bgArtHolder;
        function Brush (_arg_2, _arg_3, _arg_4) {
            hud = _arg_2;
            movie = hud.attachMovie("brush", "brush", 100);
            movie._x = _xmouse;
            movie._y = _ymouse;
            settingN = 0;
            itemType = "none";
            grabMode = "drag";
            grabbing = false;
            movie.gotoAndStop(itemType);
            movie.art.gotoAndStop(settingN);
            gameplayWorld = _arg_3;
            bgArtHolder = _arg_4;
        }
        function update() {
            movie._x = _xmouse;
            movie._y = _ymouse;
            movie._x = Math.round(movie._x / 10) * 10;
            movie._y = Math.round(movie._y / 10) * 10;
            if (movie._x < 615) {
                movie._alpha = 100;
            } else {
                movie._alpha = 40;
            }
            if (movie._xscale < gameplayWorld._xscale) {
                movie._xscale = movie._xscale + 5;
                movie._yscale = movie._yscale + 5;
            } else if (movie._xscale > gameplayWorld._xscale) {
                movie._xscale = gameplayWorld._xscale;
                movie._yscale = gameplayWorld._yscale;
            }
        }
        function selectItem(_arg_2, _arg_3) {
            if ((settingN == _arg_3) && (itemType == _arg_2)) {
                itemType = "none";
                settingN = 0;
            } else {
                settingN = _arg_3;
                itemType = _arg_2;
            }
            movie.gotoAndStop(itemType);
            movie.art.gotoAndStop(settingN);
        }
        function setGrabMode(_arg_2) {
            itemType = "none";
            settingN = 0;
            grabMode = _arg_2;
            movie.gotoAndStop(itemType);
            movie.art.gotoAndStop(settingN);
        }
        function setGrabbing(_arg_2) {
            grabbing = _arg_2;
        }
        function getItemType(Void) {
            return(itemType);
        }
        function getSettingN(Void) {
            return(settingN);
        }
        function getGrabMode(Void) {
            return(grabMode);
        }
        function getGrabbing(Void) {
            return(grabbing);
        }
        function getXpos(Void) {
            return(movie._x);
        }
        function getYpos(Void) {
            return(movie._y);
        }
        function paintValid(Void) {
            if ((movie._x < 615) && (settingN != 0)) {
                return(true);
            }
            return(false);
        }
        function grabValid(Void) {
            if (movie._x < 615) {
                return(true);
            }
            return(false);
        }
        function mouseClick() {
            if (paintValid()) {
                movie._xscale = movie._xscale * 0.8;
                movie._yscale = movie._yscale * 0.8;
            }
        }
    }
