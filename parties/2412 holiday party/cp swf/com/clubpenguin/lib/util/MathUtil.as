//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.geom.Point;

    public class MathUtil 
    {

        public static const SECOND_IN_MILLISECONDS:int = 60000;


        public static function randomRange(max:Number, min:Number=0):Number
        {
            return (Math.round(((Math.random() * (max - min)) + min)));
        }

        public static function convertTimeToSeconds(time:Number):Number
        {
            return (Math.floor((time / SECOND_IN_MILLISECONDS)));
        }

        public static function getDistanceOnCartesianPlane(set1:Point, set2:Point):Number
        {
            var xDiff:Number = (set1.x - set2.x);
            var yDiff:Number = (set1.y - set2.y);
            var diffXSquared:Number = Math.pow(xDiff, 2);
            var diffYSquared:Number = Math.pow(yDiff, 2);
            var diffsAdded:Number = (diffXSquared + diffYSquared);
            var distanceOnCartesianPlane:Number = Math.pow(diffsAdded, 0.5);
            return (distanceOnCartesianPlane);
        }

        public static function getHypotenuse(triangleWidth:Number, triangleHeight:Number):Number
        {
            var widthSquared:Number = Math.pow(triangleWidth, 2);
            var heightSquared:Number = Math.pow(triangleHeight, 2);
            var bothSquared:Number = (widthSquared + heightSquared);
            var hypoteneuse:Number = Math.pow(bothSquared, 0.5);
            return (hypoteneuse);
        }


    }
}//package com.clubpenguin.lib.util
