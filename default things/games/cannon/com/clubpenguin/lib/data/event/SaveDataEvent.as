//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.lib.data.event.SaveDataEvent extends com.clubpenguin.lib.event.Event
    {
        var __dataSet, __orgString;
        function SaveDataEvent (_arg_5, _arg_3, _arg_6, _arg_7, _arg_4) {
            super(_arg_5, _arg_3, _arg_6);
            __dataSet = _arg_7;
            __orgString = _arg_4;
        }
        function get dataSet() {
            return(__dataSet);
        }
        function get stringSource() {
            return(__orgString);
        }
        static var EVENT_GET_GAME_DATA = "eventGetGameData";
    }
