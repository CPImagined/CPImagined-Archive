//Created by Action Script Viewer - https://www.buraks.com/asv
package prompt_assets_fla
{
    import flash.display.MovieClip;

    public dynamic class loading_2 extends MovieClip 
    {

        public function loading_2()
        {
            addFrameScript(0, this.frame1, 20, this.frame21);
        }

        internal function frame1():*
        {
            stop();
        }

        internal function frame21():*
        {
            gotoAndPlay(2);
        }


    }
}//package prompt_assets_fla
