//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.events.MusicModuleEvent;

    public class TemporaryTriggersMediator extends Mediator 
    {


        override public function onRegister():void
        {
            Log.debug("");
            addViewListener("TEMP_TRIGGER", this.onButtonClick);
        }

        private function onButtonClick(e:MusicModuleEvent):void
        {
            var index:int = (e.payload as int);
            Log.debug(("" + index));
            switch (index)
            {
                case 0:
                    dispatch(new MusicModuleEvent(MusicModuleEvent.SHOW_STUDIO, MusicModule.MUSIC_STUDIO_INSTANCE_NAME));
                    break;
                case 1:
                    dispatch(new MusicModuleEvent(MusicModuleEvent.SHOW_WIDGET, MusicModule.MUSIC_WIDGET_INSTANCE_NAME));
                    break;
                case 2:
                    dispatch(new MusicModuleEvent(MusicModuleEvent.SHOW_MYSONGLIST, MusicModule.MUSIC_STUDIO_INSTANCE_NAME));
                    break;
            };
        }


    }
}//package com.clubpenguin.music
