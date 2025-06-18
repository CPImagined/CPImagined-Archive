//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.vo.ErrorVO;

    public class BridgeErrorCommand extends SignalCommand 
    {

        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var errorVO:ErrorVO;


        override public function execute():void
        {
        }


    }
}//package com.clubpenguin.main.command
