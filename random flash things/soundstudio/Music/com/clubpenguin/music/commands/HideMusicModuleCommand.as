//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.util.Log;

    public class HideMusicModuleCommand extends Command 
    {


        override public function execute():void
        {
            Log.debug("");
            commandMap.execute(HideMusicStudioCommand);
            commandMap.execute(HideMusicWidgetCommand);
            commandMap.execute(HideMySongListCommand);
        }


    }
}//package com.clubpenguin.music.commands
