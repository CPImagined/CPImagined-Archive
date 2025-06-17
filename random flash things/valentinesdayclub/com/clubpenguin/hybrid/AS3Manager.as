class com.clubpenguin.hybrid.AS3Manager
{
    function AS3Manager()
    {
    } // End of the function
    static function isUnderAS3()
    {
        return (com.clubpenguin.hybrid.AS3Manager.isRunningUnderAS3);
    } // End of the function
    static function isUnderAS2()
    {
        return (com.clubpenguin.hybrid.AS3Manager.isRunningUnderAS2);
    } // End of the function
    static var isRunningUnderAS3 = _level0 == undefined ? (true) : (false);
    static var isRunningUnderAS2 = _level0 == undefined ? (false) : (true);
} // End of Class
