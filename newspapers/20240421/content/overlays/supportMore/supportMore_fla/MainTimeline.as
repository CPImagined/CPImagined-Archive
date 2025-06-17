//Created by Action Script Viewer - https://www.buraks.com/asv
package supportMore_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var supportMore:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 497.5;
            this.visibleHeight = 183.9;
        }


    }
}//package supportMore_fla
    //force all classes
    import supportMore_fla.MainTimeline; supportMore_fla.MainTimeline;
