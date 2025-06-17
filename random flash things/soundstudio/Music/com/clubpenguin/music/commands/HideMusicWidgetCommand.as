//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.widget.MusicPlayerWidget;

    public class HideMusicWidgetCommand extends SignalCommand 
    {


        override public function execute():void
        {
            Log.debug("");
            var module:MusicPlayerWidget = (contextView.getChildByName(MusicModule.MUSIC_WIDGET_INSTANCE_NAME) as MusicPlayerWidget);
            if (module)
            {
                module.destroy();
                contextView.removeChild(module);
            };
        }


    }
}//package com.clubpenguin.music.commands
