
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.LogChannel
    {
        function LogChannel (_arg_2) {
            _name = _arg_2;
            _bitMask = 1 << _numMasks;
            _numMasks++;
            com.clubpenguin.util.Log.ALL._bitMask = com.clubpenguin.util.Log.ALL._bitMask + bitMask;
        }
        function get name() {
            return(_name);
        }
        function get bitMask() {
            return(_bitMask);
        }
        static var _numMasks = 0;
        var _name = "";
        var _bitMask = 0;
    }
