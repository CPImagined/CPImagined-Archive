//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
    {
        function PuffleCareStationLogging () {
        }
        static function sendPuffleCareStationBI(careStationName, careStationAction, careItem) {
            var _local_2 = new Object();
            var _local_5 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle["color"];
            var _local_3;
            if ((careItem != undefined) && (careItem != null)) {
                _local_3 = "|menu=" + String(careItem);
            } else {
                _local_3 = "";
            }
            _local_2.message = ((("station_type=" + careStationName) + "|puffle=") + _local_5) + _local_3;
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, LOGGING_TYPE, _local_2);
        }
        static var LOGGING_TYPE = "puffle_station";
    }
