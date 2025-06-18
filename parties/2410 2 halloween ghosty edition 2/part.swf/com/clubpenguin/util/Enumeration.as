
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.util.Enumeration
    {
        var __constructor__, _value;
        function Enumeration (_arg_3) {
            var _local_2 = __constructor__;
            if (_arg_3 == null) {
                _value = ((_local_2.__enumCount == null) ? ((_local_2.__enumCount = 0)) : (++_local_2.__enumCount));
            } else {
                _value = _arg_3;
                if ((_local_2.__enumCount == null) || (_arg_3 > _local_2.__enumCount)) {
                    _local_2.__enumCount = _arg_3;
                }
            }
        }
        function get name() {
            for (var _local_2 in __constructor__) {
                if (this == __constructor__[_local_2]) {
                    return(_local_2);
                }
            }
            return(null);
        }
        function get value() {
            return(_value);
        }
    }
