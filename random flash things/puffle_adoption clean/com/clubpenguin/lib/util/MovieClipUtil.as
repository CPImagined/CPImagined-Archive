//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.display.FrameLabel;
    import flash.display.MovieClip;

    public class MovieClipUtil 
    {


        public static function getFrameNumberByLabel(movieClip:MovieClip, label:String):int
        {
            var labelArray:Array = movieClip.currentLabels;
            var i:uint;
            while (i < labelArray.length)
            {
                if (FrameLabel(labelArray[i]).name == label)
                {
                    return (FrameLabel(labelArray[i]).frame);
                };
                i++;
            };
            return (-1);
        }


    }
}//package com.clubpenguin.lib.util
