//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.music.view.IMusicModuleContextView;
    import com.clubpenguin.music.widget.MusicPlayerWidget;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.mysonglist.MySongList;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.widget.events.MusicWidgetEvent;

    public class HideMySongListCommand extends Command 
    {

        [Inject]
        public var musicModuleContextView:IMusicModuleContextView;


        override public function execute():void
        {
            var widget:MusicPlayerWidget;
            Log.debug("");
            var module:MySongList = (contextView.getChildByName(MusicModule.SONG_LIST_INSTANCE_NAME) as MySongList);
            if (module)
            {
                module.destroy();
                contextView.removeChild(module);
            };
            if (this.musicModuleContextView.isMusicWidgetOpen)
            {
                widget = (contextView.getChildByName(MusicModule.MUSIC_WIDGET_INSTANCE_NAME) as MusicPlayerWidget);
                (widget as BaseModule).getContext().eventDispatcher.dispatchEvent(new MusicWidgetEvent(MusicWidgetEvent.GET_BROADCASTS));
            };
        }


    }
}//package com.clubpenguin.music.commands
