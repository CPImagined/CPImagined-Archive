//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Delegate
    {
        function Delegate () {
        }
        static function create(_arg_5, _arg_6) {
            var _local_2 = function () {
                var _local_2 = arguments.callee;
                var _local_3 = arguments.concat(_local_2.initArgs);
                return(_local_2.handler.apply(_local_2.target, _local_3));
            };
            _local_2.target = _arg_5;
            _local_2.handler = _arg_6;
            _local_2.initArgs = arguments.slice(2);
            return(_local_2);
        }
    }
