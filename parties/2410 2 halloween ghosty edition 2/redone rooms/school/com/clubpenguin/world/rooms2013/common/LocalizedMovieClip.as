//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.common.LocalizedMovieClip extends MovieClip
    {
        var gotoAndStop;
        function LocalizedMovieClip () {
            super();
            var _local_4 = _global.getCurrentShell();
            var _local_5 = "en";
            if (_local_4.getLanguageAbbreviation() != undefined) {
                _local_5 = _local_4.getLanguageAbbreviation();
            }
            this.gotoAndStop(_local_5);
        }
    }
