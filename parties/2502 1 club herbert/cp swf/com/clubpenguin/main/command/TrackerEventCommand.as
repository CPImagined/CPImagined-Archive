//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class TrackerEventCommand extends SignalCommand 
    {

        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var message:Object;
        [Inject]
        public var type:String;
        [Inject]
        public var mainModel:MainModel;


        override public function execute():void
        {
            try
            {
                switch (this.type)
                {
                    case AVMBridgeMessage.MSG_START_ASSET_LOAD:
                        this.trackAssetStartLoad();
                        break;
                    default:
                        throw (new Error("No type associated to the Tracker Event type being sent to TrackerEventCommand"));
                };
            }
            catch(error:Error)
            {
            };
        }

        private function trackAssetStartLoad():void
        {
            if (this.message.path == undefined)
            {
                this.message["path"] = "";
            };
            if (this.message.result == undefined)
            {
                this.message["result"] = "";
            };
            if (this.message.world_id != undefined)
            {
                this.mainModel.onCurrentWorldReceived({"id":this.message.world_id});
            };
        }


    }
}//package com.clubpenguin.main.command
