//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.LocalizedMovieClip extends MovieClip
    {
        var gotoAndStop;
        function LocalizedMovieClip () {
            super();
            var _SHELL = _global.getCurrentShell();
            var language = "en";
            if (_SHELL.getLanguageAbbreviation() != undefined) {
                language = _SHELL.getLanguageAbbreviation();
            }
            this.gotoAndStop(language);
        }
    }
