//Created by Action Script Viewer - https://www.buraks.com/asv
package supportStory_fla
{
    import flash.display.MovieClip;

    public dynamic class MainTimeline extends MovieClip 
    {

        public var supportStory:MovieClip;//instance name
        public var visibleWidth:Number;
        public var visibleHeight:Number;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.visibleWidth = 438.4;
            this.visibleHeight = 359.25;
        }


    }
}//package supportStory_fla
    //force all classes
    import supportStory_fla.MainTimeline; supportStory_fla.MainTimeline;
