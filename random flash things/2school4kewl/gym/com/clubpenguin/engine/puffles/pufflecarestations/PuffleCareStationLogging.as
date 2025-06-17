class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
{
    function PuffleCareStationLogging()
    {
    } // End of the function
    static function sendPuffleCareStationBI(careStationName, careStationAction, careItem)
    {
        var _loc3 = new Object();
        var _loc6 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle.color;
        if (_global.getCurrentShell().getMyPlayerObject().attachedPuffle.isWildPuffle())
        {
            _loc6 = _loc6 + ("_" + String(_global.getCurrentShell().getMyPlayerObject().attachedPuffle.subTypeID));
        } // end if
        var _loc4;
        var _loc2 = _global.getCurrentEngine().puffleCareEmoteManager;
        var _loc5 = "no";
        if (careItem != undefined && careItem != null)
        {
            _loc4 = "|menu=" + String(careItem);
        }
        else
        {
            _loc4 = "";
        } // end else if
        if (_loc2.careStationTypeEmoted != null && _loc2.careStationTypeEmoted == careStationAction)
        {
            _loc5 = _loc2.careStationTypeEmoted;
        } // end if
        _loc3.message = "station_type=" + careStationName + "|puffle=" + _loc6 + _loc4 + "|emoted=" + _loc5;
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.LOGGING_TYPE, _loc3);
    } // End of the function
    static var LOGGING_TYPE = "puffle_station";
} // End of Class
