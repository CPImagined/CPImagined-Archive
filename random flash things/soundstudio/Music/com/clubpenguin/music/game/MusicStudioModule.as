//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game
{
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.game.context.MusicStudioContext;

    public class MusicStudioModule extends BaseModule 
    {

        protected var parentContextView:BaseModule;

        public function MusicStudioModule(parentContextVew:BaseModule)
        {
            this.parentContextView = parentContextVew;
        }

        override public function init():void
        {
            Log.debug("");
            context = new MusicStudioContext(this.parentContextView, injector);
        }


    }
}//package com.clubpenguin.music.game
