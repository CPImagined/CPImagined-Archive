//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.music.MusicModule;
    import com.clubpenguin.music.widget.MusicPlayerWidget;

    public class MusicWidgetOnOverlayCountAdd extends SignalCommand 
    {

        [Inject]
        public var model:MusicWidgetModel;


        override public function execute():void
        {
            this.model.overlayCount = (this.model.overlayCount + 1);
            var module:MusicPlayerWidget = (contextView.getChildByName(MusicModule.MUSIC_WIDGET_INSTANCE_NAME) as MusicPlayerWidget);
            module.visible = false;
        }


    }
}//package com.clubpenguin.music.commands
