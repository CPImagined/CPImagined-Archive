class com.clubpenguin.world.rooms2014.music.soundStudio.logo.SoundStudioLogo extends MovieClip
{
    var _SHELL, _ENGINE, _INTERFACE, gotoAndStop;
    function SoundStudioLogo()
    {
        super();
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _INTERFACE = _global.getCurrentInterface();
        this.localize();
    } // End of the function
    function localize()
    {
        var _loc2 = "en";
        if (_SHELL.getLanguageAbbreviation() != undefined)
        {
            _loc2 = _SHELL.getLanguageAbbreviation();
        } // end if
        this.gotoAndStop(_loc2);
    } // End of the function
} // End of Class
