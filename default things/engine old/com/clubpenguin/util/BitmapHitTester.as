class com.clubpenguin.util.BitmapHitTester
{
    function BitmapHitTester()
    {
    } // End of the function
    static function getHitTestRectangle(targetClip1, targetClip2, alphaTolerance)
    {
        if (alphaTolerance == undefined)
        {
            alphaTolerance = 255;
        } // end if
        var _loc10 = com.clubpenguin.util.BitmapHitTester.getClipRectangle(targetClip1, _root);
        var _loc8 = com.clubpenguin.util.BitmapHitTester.getClipRectangle(targetClip2, _root);
        if (!_loc10.intersects(_loc8))
        {
            return (null);
        } // end if
        var _loc4 = _loc10.intersection(_loc8);
        var _loc5 = new flash.display.BitmapData(Math.ceil(_loc4.width), Math.ceil(_loc4.height), false);
        var _loc3 = targetClip1.transform.matrix;
        for (var _loc2 = targetClip1._parent; _loc2 != _root; _loc2 = _loc2._parent)
        {
            _loc3.concat(_loc2.transform.matrix);
        } // end of for
        _loc3.tx = _loc3.tx - _loc4.left;
        _loc3.ty = _loc3.ty - _loc4.top;
        _loc5.draw(targetClip1, _loc3, new flash.geom.ColorTransform(1, 1, 1, 1, 255, -255, -255, alphaTolerance));
        _loc3 = targetClip2.transform.matrix;
        for (var _loc2 = targetClip2._parent; _loc2 != _root; _loc2 = _loc2._parent)
        {
            _loc3.concat(_loc2.transform.matrix);
        } // end of for
        _loc3.tx = _loc3.tx - _loc4.left;
        _loc3.ty = _loc3.ty - _loc4.top;
        _loc5.draw(targetClip2, _loc3, new flash.geom.ColorTransform(1, 1, 1, 1, 255, 255, 255, alphaTolerance), "difference");
        var _loc6 = _loc5.getColorBoundsRect(4294967295.000000, 4278255615.000000);
        var _loc7 = _root.createEmptyMovieClip("bitmapHitTesterPreview", _root.getNextHighestDepth());
        _loc7.attachBitmap(_loc5, _loc7.getNextHighestDepth());
        _loc7._xscale = _loc7._yscale = 100;
        _loc5.dispose();
        if (_loc6.width == 0)
        {
            return (null);
        } // end if
        _loc6.x = _loc6.x + _loc4.left;
        _loc6.y = _loc6.y + _loc4.top;
        return (_loc6);
    } // End of the function
    static function doesHit(targetClip1, targetClip2, alphaTolerance)
    {
        var _loc1 = com.clubpenguin.util.BitmapHitTester.getHitTestRectangle(targetClip1, targetClip2, alphaTolerance);
        if (_loc1 == null)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    static function getClipRectangle(clip, referenceClip)
    {
        if (referenceClip == undefined)
        {
            referenceClip = clip._parent;
        } // end if
        var _loc1 = clip.getBounds(referenceClip);
        return (new flash.geom.Rectangle(_loc1.xMin, _loc1.yMin, _loc1.xMax - _loc1.xMin, _loc1.yMax - _loc1.yMin));
    } // End of the function
} // End of Class
