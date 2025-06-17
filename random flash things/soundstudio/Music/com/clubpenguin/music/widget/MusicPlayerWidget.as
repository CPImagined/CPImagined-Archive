//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget
{
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.services.socket.music.IMusicService;

    public class MusicPlayerWidget extends BaseModule 
    {

        protected var parentContextView:BaseModule;

        public function MusicPlayerWidget(parentContextView:BaseModule)
        {
            this.parentContextView = parentContextView;
        }

        public function initWithService(musicService:IMusicService):void
        {
            super.init();
            Log.debug("");
            context = new MusicWidgetContext(this.parentContextView, injector, musicService);
        }


    }
}//package com.clubpenguin.music.widget
