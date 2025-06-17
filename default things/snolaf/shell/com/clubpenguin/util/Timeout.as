//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Timeout
    {
        var __get__onStop;
        function Timeout (time, func, params, scope) {
            _time = time * com.clubpenguin.util.Time.ONE_SECOND_IN_MILLISECONDS;
            _func = func;
            _params = params;
            _scope = scope;
        }
        function start() {
            _id = _global.setTimeout(com.clubpenguin.util.Delegate.create(this, handler), _time, _params);
        }
        function stop() {
            _global.clearTimeout(_id);
            _onStop(this);
            cleanUp();
        }
        function handler(params) {
            if (_scope == undefined) {
                _func(params);
            } else {
                _func.call(_scope, params);
            }
            this.stop();
        }
        function cleanUp() {
            _id = -1;
            _time = -1;
            _func = undefined;
            _params = undefined;
            _scope = undefined;
            _onStop = undefined;
        }
        function set onStop(func) {
            _onStop = func;
            //return(__get__onStop());
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "Timeout -> ";
            _local_2 = _local_2 + (" id: " + _id);
            _local_2 = _local_2 + (" time: " + _time);
            _local_2 = _local_2 + (" func: " + _func);
            _local_2 = _local_2 + (" params: " + _params);
            _local_2 = _local_2 + (" scope: " + _scope);
            _local_2 = _local_2 + (" onStop: " + _onStop);
            return(_local_2);
        }
        var _id = -1;
        var _time = -1;
        var _func = undefined;
        var _params = undefined;
        var _scope = undefined;
        var _onStop = undefined;
    }
