//Created by Action Script Viewer - https://www.buraks.com/asv
package askAuntArctic_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var askAuntArctic:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 438;
            this.visibleHeight = 454;
        }


    }
}//package askAuntArctic_fla
    //force all classes
    import askAuntArctic_fla.MainTimeline; askAuntArctic_fla.MainTimeline;
