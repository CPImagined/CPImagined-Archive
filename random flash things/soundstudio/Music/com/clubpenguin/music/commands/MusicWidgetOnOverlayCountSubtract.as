//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.music.widget.MusicPlayerWidget;
    import com.clubpenguin.music.MusicModule;

    public class MusicWidgetOnOverlayCountSubtract extends SignalCommand 
    {

        [Inject]
        public var model:MusicWidgetModel;


        override public function execute():void
        {
            var module:MusicPlayerWidget;
            this.model.overlayCount--;
            if (this.model.overlayCount < 1)
            {
                this.model.overlayCount = 0;
            };
            if (this.model.overlayCount == 0)
            {
                module = (contextView.getChildByName(MusicModule.MUSIC_WIDGET_INSTANCE_NAME) as MusicPlayerWidget);
                module.visible = true;
            };
        }


    }
}//package com.clubpenguin.music.commands
