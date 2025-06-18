//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Enumeration
    {
        var __constructor__, _value;
        function Enumeration (value_p) {
            var acp = __constructor__;
            if (value_p == null) {
                _value = ((acp.__enumCount == null) ? ((acp.__enumCount = 0)) : (++acp.__enumCount));
            } else {
                _value = value_p;
                if ((acp.__enumCount == null) || (value_p > acp.__enumCount)) {
                    acp.__enumCount = value_p;
                }
            }
        }
        function get name() {
            for (var prop in __constructor__) {
                if (this == __constructor__[prop]) {
                    return(prop);
                }
            }
            return(null);
        }
        function get value() {
            return(_value);
        }
    }
