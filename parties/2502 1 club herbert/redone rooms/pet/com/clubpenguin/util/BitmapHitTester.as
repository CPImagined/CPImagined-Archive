//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.BitmapHitTester
    {
        function BitmapHitTester () {
        }
        static function getHitTestRectangle(_arg_11, _arg_9, _arg_12) {
            if (_arg_12 == undefined) {
                _arg_12 = 255;
            }
            var _local_10 = getClipRectangle(_arg_11, _root);
            var _local_8 = getClipRectangle(_arg_9, _root);
            if (!_local_10.intersects(_local_8)) {
                return(null);
            }
            var _local_4 = _local_10.intersection(_local_8);
            var _local_5 = new flash.display.BitmapData(Math.ceil(_local_4.width), Math.ceil(_local_4.height), false);
            var _local_3 = _arg_11.transform.matrix;
            var _local_2 = _arg_11._parent;
            while (_local_2 != _root) {
                _local_3.concat(_local_2.transform.matrix);
                _local_2 = _local_2._parent;
            }
            _local_3.tx = _local_3.tx - _local_4.left;
            _local_3.ty = _local_3.ty - _local_4.top;
            _local_5.draw(_arg_11, _local_3, new flash.geom.ColorTransform(1, 1, 1, 1, 255, -255, -255, _arg_12));
            _local_3 = _arg_9.transform.matrix;
            _local_2 = _arg_9._parent;
            while (_local_2 != _root) {
                _local_3.concat(_local_2.transform.matrix);
                _local_2 = _local_2._parent;
            }
            _local_3.tx = _local_3.tx - _local_4.left;
            _local_3.ty = _local_3.ty - _local_4.top;
            _local_5.draw(_arg_9, _local_3, new flash.geom.ColorTransform(1, 1, 1, 1, 255, 255, 255, _arg_12), "difference");
            var _local_6 = _local_5.getColorBoundsRect(4294967295, 4278255615);
            var _local_7 = _root.createEmptyMovieClip("bitmapHitTesterPreview", _root.getNextHighestDepth());
            _local_7.attachBitmap(_local_5, _local_7.getNextHighestDepth());
            _local_7._xscale = (_local_7._yscale = 100);
            _local_5.dispose();
            if (_local_6.width == 0) {
                return(null);
            }
            _local_6.x = _local_6.x + _local_4.left;
            _local_6.y = _local_6.y + _local_4.top;
            return(_local_6);
        }
        static function doesHit(_arg_3, _arg_2, _arg_4) {
            var _local_1 = getHitTestRectangle(_arg_3, _arg_2, _arg_4);
            if (_local_1 == null) {
                return(false);
            }
            return(true);
        }
        static function getClipRectangle(_arg_3, _arg_2) {
            if (_arg_2 == undefined) {
                _arg_2 = _arg_3._parent;
            }
            var _local_1 = _arg_3.getBounds(_arg_2);
            return(new flash.geom.Rectangle(_local_1.xMin, _local_1.yMin, _local_1.xMax - _local_1.xMin, _local_1.yMax - _local_1.yMin));
        }
    }
