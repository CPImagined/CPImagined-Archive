//Created by Action Script Viewer - https://www.buraks.com/asv
package secretOverlay_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var secretOverlay:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 352.85;
            this.visibleHeight = 451;
        }


    }
}//package secretOverlay_fla
    //force all classes
    import secretOverlay_fla.MainTimeline; secretOverlay_fla.MainTimeline;
