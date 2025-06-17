//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.resources
{
    public class Utils 
    {


        public static function AnimatePropertyToTarget(property:Number, target:Number, threshold:Number=0.2, factor:Number=5, instant:Boolean=false):Number
        {
            if (((property == target) || (instant)))
            {
                return (target);
            };
            if (Math.abs((property - target)) > threshold)
            {
                property = (property - ((property - target) / factor));
            }
            else
            {
                property = target;
            };
            return (property);
        }


    }
}//package com.clubpenguin.music.resources
