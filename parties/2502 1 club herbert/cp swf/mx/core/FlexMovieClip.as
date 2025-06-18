//Created by Action Script Viewer - https://www.buraks.com/asv
package mx.core
{
    import flash.display.MovieClip;
    import mx.utils.NameUtil;

    public class FlexMovieClip extends MovieClip 
    {

        mx_internal static const VERSION:String = "4.1.0.16076";

        public function FlexMovieClip()
        {
            super();
            try
            {
                name = NameUtil.createUniqueName(this);
            }
            catch(e:Error)
            {
            };
        }

        override public function toString():String
        {
            return (NameUtil.displayObjectToString(this));
        }


    }
}//package mx.core
