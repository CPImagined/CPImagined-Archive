//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Delegate
    {
        function Delegate () {
        }
        static function create(target, handler) {
            var func = function () {
                var context = arguments.callee;
                var args = arguments.concat(context.initArgs);
                return(context.handler.apply(context.target, args));
            };
            func.target = target;
            func.handler = handler;
            func.initArgs = arguments.slice(2);
            return(func);
        }
    }
