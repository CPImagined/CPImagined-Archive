//Created by Action Script Viewer - https://www.buraks.com/asv
package upcomingEvents_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var upcomingEvents:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 438;
            this.visibleHeight = 319.55;
        }


    }
}//package upcomingEvents_fla
    //force all classes
    import upcomingEvents_fla.MainTimeline; upcomingEvents_fla.MainTimeline;
    import upcomingEvents_fla.vanillaVice_26; upcomingEvents_fla.vanillaVice_26;
