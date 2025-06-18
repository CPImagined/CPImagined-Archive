    class com.clubpenguin.util.Enumeration
    {
        var __constructor__, _value;
        function Enumeration (value_p) {
            var _local_2 = __constructor__;
            if (value_p == null) {
                _value = ((_local_2.__enumCount == null) ? ((_local_2.__enumCount = 0)) : (++_local_2.__enumCount));
            } else {
                _value = value_p;
                if ((_local_2.__enumCount == null) || (value_p > _local_2.__enumCount)) {
                    _local_2.__enumCount = value_p;
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
