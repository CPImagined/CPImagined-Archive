//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.utils.Delegate extends Object
    {
        var func;
        function Delegate (f) {
            super();
            func = f;
        }
        static function create(obj, func) {
            var _local_2 = function () {
                var _local_2 = arguments.callee.target;
                var _local_3 = arguments.callee.func;
                return(_local_3.apply(_local_2, arguments));
            };
            _local_2.target = obj;
            _local_2.func = func;
            return(_local_2);
        }
        function createDelegate(obj) {
            return(create(obj, func));
        }
    }
