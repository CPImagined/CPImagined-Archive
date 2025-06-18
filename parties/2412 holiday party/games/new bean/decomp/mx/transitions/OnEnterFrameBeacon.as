//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.transitions.OnEnterFrameBeacon
    {
        function OnEnterFrameBeacon () {
        }
        static function init() {
            var _local_4 = _global["MovieClip"];
            if (!_root.__OnEnterFrameBeacon) {
                mx.transitions.BroadcasterMX.initialize(_local_4);
                var _local_3 = _root.createEmptyMovieClip("__OnEnterFrameBeacon", 9876);
                _local_3.onEnterFrame = function () {
                    _global["MovieClip"].broadcastMessage("onEnterFrame");
                };
            }
        }
        static var version = "1.1.0.52";
    }
