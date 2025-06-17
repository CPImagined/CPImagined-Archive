//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.services.socket.puffles.PuffleCareItemsService;
    import com.clubpenguin.main.signal.LoadMapTriggersSignal;

    public class HandleJoinWorldCommand extends SignalCommand 
    {

        [Inject]
        public var getPuffleCareInventoryService:PuffleCareItemsService;
        [Inject]
        public var loadMapTriggersSignal:LoadMapTriggersSignal;


        override public function execute():void
        {
            this.getPuffleCareInventoryService.receivedCareInventory.add(this.onReceivedCareInventory);
            this.getPuffleCareInventoryService.requestInventory();
        }

        private function onReceivedCareInventory():void
        {
            this.loadMapTriggersSignal.dispatch();
        }


    }
}//package com.clubpenguin.main.command
