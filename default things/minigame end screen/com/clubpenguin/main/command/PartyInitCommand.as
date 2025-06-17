//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.party.PartyVO;
    import com.clubpenguin.lib.util.Log;

    public class PartyInitCommand extends SignalCommand 
    {

        [Inject]
        public var partyVO:PartyVO;


        override public function execute():void
        {
            Log.debug("[PartyInitCommand] Party is initialized and active");
            this.partyVO.isActive = true;
        }


    }
}//package com.clubpenguin.main.command
