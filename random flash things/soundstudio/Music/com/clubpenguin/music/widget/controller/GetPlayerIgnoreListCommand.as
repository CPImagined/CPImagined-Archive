//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.widget.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.music.widget.model.MusicWidgetModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class GetPlayerIgnoreListCommand extends Command 
    {

        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var model:MusicWidgetModel;


        override public function execute():void
        {
            Log.debug("");
            var getLocalPlayerIgnoreList:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_GET_LOCAL_PLAYER_IGNORE_LIST);
            this.bridge.getLocalPlayerIgnoreList().addOnce(this.savePlayerIgnoreList);
            this.bridge.send(getLocalPlayerIgnoreList);
        }

        protected function savePlayerIgnoreList(data:Array):void
        {
            Log.debug(("data " + data));
            this.model.localPlayerIgnoreList = data;
            if (this.model.localPlayerIgnoreList.length > 0)
            {
                Log.debug(("model.localPlayerIgnoreList first ignored player " + this.model.localPlayerIgnoreList[0].player_id));
            };
            this.bridge.getLocalPlayerIgnoreList().remove(this.savePlayerIgnoreList);
        }


    }
}//package com.clubpenguin.music.widget.controller
