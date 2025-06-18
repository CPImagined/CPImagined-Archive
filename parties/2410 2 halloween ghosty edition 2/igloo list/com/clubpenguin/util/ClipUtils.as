//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.ClipUtils
    {
        function ClipUtils () {
        }
        static function swapDepths(clip1, clip2) {
            if ((clip1 == undefined) || (clip2 == undefined)) {
                return(false);
            }
            if (clip1._parent != clip2._parent) {
                return(false);
            }
            var _local_4 = clip1.getDepth();
            var _local_3 = clip2.getDepth();
            clip1.swapDepths(_local_3);
            clip2.swapDepths(_local_4);
            return(true);
        }
        static function getBoundsRectangle(clip, referenceClip) {
            if (referenceClip == undefined) {
                referenceClip = clip._parent;
            }
            var _local_1 = clip.getBounds(referenceClip);
            return(new flash.geom.Rectangle(_local_1.xMin, _local_1.yMin, _local_1.xMax - _local_1.xMin, _local_1.yMax - _local_1.yMin));
        }
        static function resizeClip(clip, maxW, maxH, shouldConstrainProportions) {
            if (shouldConstrainProportions == undefined) {
                shouldConstrainProportions = true;
            }
            clip._width = maxW;
            clip._height = maxH;
            if (shouldConstrainProportions) {
                ((clip._xscale < clip._yscale) ? ((clip._yscale = clip._xscale)) : ((clip._xscale = clip._yscale)));
            }
        }
    }
