dynamic class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
{
    static var LOGGING_TYPE: String = "puffle_station";

    function PuffleCareStationLogging()
    {
    }

    static function sendPuffleCareStationBI(careStationName, careStationAction, careItem)
    {
        var __reg6 = new Object();
        var __reg2 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle.color;
        if (_global.getCurrentShell().getMyPlayerObject().attachedPuffle.isWildPuffle()) 
        {
            __reg2 = __reg2 + ("_" + String(_global.getCurrentShell().getMyPlayerObject().attachedPuffle.subTypeID));
        }
        var __reg3 = undefined;
        var __reg4 = _global.getCurrentEngine().puffleCareEmoteManager;
        var __reg5 = "no";
        if (careItem != undefined && careItem != null) 
        {
            __reg3 = "|menu=" + String(careItem);
        }
        else 
        {
            __reg3 = "";
        }
        if (__reg4.careStationTypeEmoted != null && __reg4.careStationTypeEmoted == careStationAction) 
        {
            __reg5 = __reg4.careStationTypeEmoted;
        }
        __reg6.message = "station_type=" + careStationName + "|puffle=" + __reg2 + __reg3 + "|emoted=" + __reg5;
        com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging.LOGGING_TYPE, __reg6);
    }

}
