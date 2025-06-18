//Created by Action Script Viewer - https://www.buraks.com/asv
    class hockey.HockeyGame
    {
        static var controller;
        function HockeyGame () {
        }
        static function setContainer(container_mc) {
            initOnEnterFrameBeacon();
            var _local_1 = new hockey.BallGroup(container_mc);
            var _local_2 = container_mc.boundingBox_mc;
            _local_1.xMin = _local_2._x;
            _local_1.yMin = _local_2._y;
            _local_1.xMax = _local_2._x + _local_2._width;
            _local_1.yMax = _local_2._y + _local_2._height;
            _local_2._visible = false;
            _local_1.puck = new hockey.Ball(0, 0);
            _local_1.puck.sprite = container_mc.puck_mc;
            _local_1.addItem(_local_1.puck);
            _local_1.addNets(container_mc.netBlockLeft_mc, container_mc.netBlockRight_mc);
            _local_1.draw();
            controller = _local_1;
        }
        static function initOnEnterFrameBeacon() {
            var _local_4 = _global["MovieClip"];
            if (!_root.__OnEnterFrameBeacon) {
                _global.AsBroadcaster.initialize(_local_4);
                var _local_3 = _root.createEmptyMovieClip("__OnEnterFrameBeacon", 9876);
                _local_3.onEnterFrame = function () {
                    _global["MovieClip"].broadcastMessage("onEnterFrame");
                };
            }
        }
    }
