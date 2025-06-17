//Created by Action Script Viewer - https://www.buraks.com/asv
package 
{
    import flash.display.MovieClip;

    public dynamic class music_progress extends MovieClip 
    {

        public var bar:MovieClip;//instance name

        public function music_progress()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package 
