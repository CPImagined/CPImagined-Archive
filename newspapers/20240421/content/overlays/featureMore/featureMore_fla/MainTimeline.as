//Created by Action Script Viewer - https://www.buraks.com/asv
package featureMore_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var featureMore:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 493.35;
            this.visibleHeight = 236.55;
        }


    }
}//package featureMore_fla
    //force all classes
    import featureMore_fla.MainTimeline; featureMore_fla.MainTimeline;
