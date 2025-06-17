//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.music.widget.MusicPlayerWidget;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.music.MusicModule;

    public class InitializeWidgetCommand extends SignalCommand 
    {

        [Inject]
        public var musicService:IMusicService;
        public var model:MusicWidgetModel;


        override public function execute():void
        {
            Log.debug("");
            var module:MusicPlayerWidget = (contextView.getChildByName("musicwidget") as MusicPlayerWidget);
            if (module)
            {
                return;
            };
            module = new MusicPlayerWidget((contextView as BaseModule));
            module.name = MusicModule.MUSIC_WIDGET_INSTANCE_NAME;
            module.injector = injector;
            module.initWithService(this.musicService);
            contextView.addChild(module);
        }


    }
}//package com.clubpenguin.music.commands
