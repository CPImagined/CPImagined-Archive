dynamic class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
{
    static var LOGGING_TYPE: String = "puffle_station";

    function PuffleCareStationLogging()
    {
    }

    static function sendPuffleCareStationBI(careStationName, careStationAction, careItem)
    {
        var __reg3 = new Object();
        var __reg6 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle.color;
        if (_global.getCurrentShell().getMyPlayerObject().attachedPuffle.isWildPuffle()) 
        {
            __reg6 = __reg6 + ("_" + String(_global.getCurrentShell().getMyPlayerObject().attachedPuffle.subTypeID));
        }
        var __reg4 = undefined;
        var __reg2 = _global.getCurrentEngine().puffleCareEmoteManager;
        var __reg5 = "no";
        if (careItem != undefined && careItem != null) 
        {
            __reg4 = "|menu=" + String(careItem);
        }
        else 
        {
            __reg4 = "";
        }
        if (__reg2.careStationTypeEmoted != null && __reg2.careStationTypeEmoted == careStationAction) 
        {
            __reg5 = __reg2.careStationTypeEmoted;
        }
        __reg3.message = "station_type=" + careStationName + "|puffle=" + __reg6 + __reg4 + "|emoted=" + __reg5;
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.LOGGING_TYPE, __reg3);
    }

}
