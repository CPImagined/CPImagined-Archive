//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.transitions.BroadcasterMX
    {
        var _listeners;
        function BroadcasterMX () {
        }
        static function initialize(o, dontCreateArray) {
            if (o.broadcastMessage != undefined) {
                delete o.broadcastMessage;
            }
            o.addListener = mx.transitions.BroadcasterMX.prototype.addListener;
            o.removeListener = mx.transitions.BroadcasterMX.prototype.removeListener;
            if (!dontCreateArray) {
                o._listeners = new Array();
            }
        }
        function addListener(o) {
            this.removeListener(o);
            if (broadcastMessage == undefined) {
                broadcastMessage = mx.transitions.BroadcasterMX.prototype.broadcastMessage;
            }
            return(_listeners.push(o));
        }
        function removeListener(o) {
            var _local_2 = _listeners;
            var _local_3 = _local_2.length;
            while (_local_3--) {
                if (_local_2[_local_3] == o) {
                    _local_2.splice(_local_3, 1);
                    if (!_local_2.length) {
                        broadcastMessage = undefined;
                    }
                    return(true);
                }
            }
            return(false);
        }
        function broadcastMessage() {
            var _local_5 = String(arguments.shift());
            var _local_4 = _listeners.concat();
            var _local_6 = _local_4.length;
            var _local_3 = 0;
            while (_local_3 < _local_6) {
                _local_4[_local_3][_local_5].apply(_local_4[_local_3], arguments);
                _local_3++;
            }
        }
        static var version = "1.1.0.52";
    }
