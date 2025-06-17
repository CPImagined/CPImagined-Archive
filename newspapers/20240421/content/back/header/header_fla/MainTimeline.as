//Created by Action Script Viewer - https://www.buraks.com/asv
package header_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var header:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 597;
            this.visibleHeight = 93.95;
        }


    }
}//package header_fla
    //force all classes
    import header_fla.MainTimeline; header_fla.MainTimeline;
