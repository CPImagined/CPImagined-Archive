//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.world.model.WorldModel;
    import com.clubpenguin.world.vo.AirtowerVO;

    public class LogAirTowerEventCommand extends SignalCommand 
    {

        [Inject]
        public var model:WorldModel;
        [Inject]
        public var airTowerVO:AirtowerVO;


        override public function execute():void
        {
        }


    }
}//package com.clubpenguin.world.command
