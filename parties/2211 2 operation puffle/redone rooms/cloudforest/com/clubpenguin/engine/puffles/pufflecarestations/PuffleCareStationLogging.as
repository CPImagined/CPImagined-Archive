//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
    {
        function PuffleCareStationLogging () {
        }
        static function sendPuffleCareStationBI(careStationName, careStationAction, careItem) {
            var _local_3 = new Object();
            var _local_6 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle["color"];
            if (_global.getCurrentShell().getMyPlayerObject().attachedPuffle.isWildPuffle()) {
                _local_6 = _local_6 + ("_" + String(_global.getCurrentShell().getMyPlayerObject().attachedPuffle.subTypeID));
            }
            var _local_4;
            var _local_2 = _global.getCurrentEngine().puffleCareEmoteManager;
            var _local_5 = "no";
            if ((careItem != undefined) && (careItem != null)) {
                _local_4 = "|menu=" + String(careItem);
            } else {
                _local_4 = "";
            }
            if ((_local_2.careStationTypeEmoted != null) && (_local_2.careStationTypeEmoted == careStationAction)) {
                _local_5 = _local_2.careStationTypeEmoted;
            }
            _local_3.message = ((((("station_type=" + careStationName) + "|puffle=") + _local_6) + _local_4) + "|emoted=") + _local_5;
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(careStationAction, LOGGING_TYPE, _local_3);
        }
        static var LOGGING_TYPE = "puffle_station";
    }
