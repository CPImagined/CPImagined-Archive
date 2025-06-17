//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.soundStudio.logo.SoundStudioLogo extends MovieClip
    {
        var _SHELL, _ENGINE, _INTERFACE, gotoAndStop;
        function SoundStudioLogo () {
            super();
            _SHELL = _global.getCurrentShell();
            _ENGINE = _global.getCurrentEngine();
            _INTERFACE = _global.getCurrentInterface();
            localize();
        }
        function localize() {
            var _local_2 = "en";
            if (_SHELL.getLanguageAbbreviation() != undefined) {
                _local_2 = _SHELL.getLanguageAbbreviation();
            }
            this.gotoAndStop(_local_2);
        }
    }
