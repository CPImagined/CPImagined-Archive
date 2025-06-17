//Created by Action Script Viewer - https://www.buraks.com/asv
package jokesAndRiddles_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var jokesAndRiddles:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 159.45;
            this.visibleHeight = 585.25;
        }


    }
}//package jokesAndRiddles_fla
    //force all classes
    import jokesAndRiddles_fla.MainTimeline; jokesAndRiddles_fla.MainTimeline;
