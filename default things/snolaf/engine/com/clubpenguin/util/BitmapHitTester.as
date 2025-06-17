//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.BitmapHitTester
    {
        function BitmapHitTester () {
        }
        static function getHitTestRectangle(targetClip1, targetClip2, alphaTolerance) {
            if (alphaTolerance == undefined) {
                alphaTolerance = 255;
            }
            var _local_10 = getClipRectangle(targetClip1, _root);
            var _local_8 = getClipRectangle(targetClip2, _root);
            if (!_local_10.intersects(_local_8)) {
                return(null);
            }
            var _local_4 = _local_10.intersection(_local_8);
            var _local_5 = new flash.display.BitmapData(Math.ceil(_local_4.width), Math.ceil(_local_4.height), false);
            var _local_3 = targetClip1.transform.matrix;
            var _local_2 = targetClip1._parent;
            while (_local_2 != _root) {
                _local_3.concat(_local_2.transform.matrix);
                _local_2 = _local_2._parent;
            }
            _local_3.tx = _local_3.tx - _local_4.left;
            _local_3.ty = _local_3.ty - _local_4.top;
            _local_5.draw(targetClip1, _local_3, new flash.geom.ColorTransform(1, 1, 1, 1, 255, -255, -255, alphaTolerance));
            _local_3 = targetClip2.transform.matrix;
            _local_2 = targetClip2._parent;
            while (_local_2 != _root) {
                _local_3.concat(_local_2.transform.matrix);
                _local_2 = _local_2._parent;
            }
            _local_3.tx = _local_3.tx - _local_4.left;
            _local_3.ty = _local_3.ty - _local_4.top;
            _local_5.draw(targetClip2, _local_3, new flash.geom.ColorTransform(1, 1, 1, 1, 255, 255, 255, alphaTolerance), "difference");
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
        static function doesHit(targetClip1, targetClip2, alphaTolerance) {
            var _local_1 = getHitTestRectangle(targetClip1, targetClip2, alphaTolerance);
            if (_local_1 == null) {
                return(false);
            }
            return(true);
        }
        static function getClipRectangle(clip, referenceClip) {
            if (referenceClip == undefined) {
                referenceClip = clip._parent;
            }
            var _local_1 = clip.getBounds(referenceClip);
            return(new flash.geom.Rectangle(_local_1.xMin, _local_1.yMin, _local_1.xMax - _local_1.xMin, _local_1.yMax - _local_1.yMin));
        }
    }
