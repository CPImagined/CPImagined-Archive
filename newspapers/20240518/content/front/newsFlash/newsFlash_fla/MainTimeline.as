//Created by Action Script Viewer - https://www.buraks.com/asv
package newsFlash_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var newsFlash:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 159.25;
            this.visibleHeight = 85.2;
        }


    }
}//package newsFlash_fla
    //force all classes
    import newsFlash_fla.MainTimeline; newsFlash_fla.MainTimeline;
