//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Delegate
    {
        function Delegate () {
        }
        static function create(target, handler) {
            var _local_2 = function () {
                var _local_2 = arguments.callee;
                var _local_3 = arguments.concat(_local_2.initArgs);
                return(_local_2.handler.apply(_local_2.target, _local_3));
            };
            _local_2.target = target;
            _local_2.handler = handler;
            _local_2.initArgs = arguments.slice(2);
            return(_local_2);
        }
    }
