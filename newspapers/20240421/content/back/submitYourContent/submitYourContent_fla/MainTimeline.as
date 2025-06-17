//Created by Action Script Viewer - https://www.buraks.com/asv
package submitYourContent_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var submitYourContent:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 454.75;
            this.visibleHeight = 320;
        }


    }
}//package submitYourContent_fla
    //force all classes
    import submitYourContent_fla.MainTimeline; submitYourContent_fla.MainTimeline;
