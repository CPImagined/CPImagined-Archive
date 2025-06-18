
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.puffles.pufflecarestations.PuffleCareStationLogging
    {
        function PuffleCareStationLogging () {
        }
        static function sendPuffleCareStationBI(_arg_6, _arg_7, _arg_4) {
            var _local_2 = new Object();
            var _local_5 = _global.getCurrentShell().getMyPlayerObject().attachedPuffle["color"];
            var _local_3;
            if ((_arg_4 != undefined) && (_arg_4 != null)) {
                _local_3 = "|menu=" + String(_arg_4);
            } else {
                _local_3 = "";
            }
            _local_2.message = ((("station_type=" + _arg_6) + "|puffle=") + _local_5) + _local_3;
            com.clubpenguin.util.TrackerAS2.getInstance().trackGameAction(_arg_7, LOGGING_TYPE, _local_2);
        }
        static var LOGGING_TYPE = "puffle_station";
    }
