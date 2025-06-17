class com.clubpenguin.world.rooms2013.common.LocalizedMovieClip extends MovieClip
{
    var gotoAndStop;
    function LocalizedMovieClip()
    {
        super();
        var _loc4 = _global.getCurrentShell();
        var _loc5 = "en";
        if (_loc4.getLanguageAbbreviation() != undefined)
        {
            _loc5 = _loc4.getLanguageAbbreviation();
        } // end if
        this.gotoAndStop(_loc5);
    } // End of the function
} // End of Class
