//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.model.ActiveQuestsModel;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.lib.vo.party.PartyVO;
    import com.clubpenguin.main.model.LoadingScreenModel;
    import flash.net.URLLoader;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.vo.quest.QuestVO;
    import com.clubpenguin.lib.vo.quest.QuestStateEnum;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequestMethod;
    import flash.net.URLLoaderDataFormat;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class UpdatedRoomCommand extends SignalCommand 
    {

        [Inject]
        public var appModel:MainModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var bridge:IAVMBridgeService;
        [Inject]
        public var activeQuestsModel:ActiveQuestsModel;
        [Inject]
        public var moduleModel:ModuleModel;
        [Inject]
        public var partyVO:PartyVO;
        [Inject]
        public var loadingScreenModel:LoadingScreenModel;
        private var _urlLoader:URLLoader = new URLLoader();
        private var _localPlayer:PlayerVO;


        override public function execute():void
        {
            Log.debug("\tUpdatedRoomCommand.execute()");
            Log.debug("\n");
            Log.debug("----------------------------------------------------");
            this._localPlayer = PlayerVO(this.appModel.getLocalPlayerVO());
            if (this.loadingScreenModel.isShowing)
            {
                Log.debug(("\t\tWait for room entry logic, loadingScreenModel.isShowing:" + this.loadingScreenModel.isShowing));
                this.loadingScreenModel.closingLoadingScreen.addOnce(this.roomEntryConditions);
            }
            else
            {
                Log.debug(("\t\tstart room entry logic, loadingScreenModel.isShowing:" + this.loadingScreenModel.isShowing));
                this.roomEntryConditions();
            };
            Log.debug(("\t\tappModel.currentRoomId : " + this.appModel.currentRoomId));
            Log.debug(("\t\tappModel.getEnvironmentData().nau: " + this.appModel.getEnvironmentData().nau));
            Log.debug(("\t\tappModel.getEnvironmentData().nal: " + this.appModel.getEnvironmentData().nal));
            Log.debug(("\t\tappModel.getEnvironmentData().nad: " + this.appModel.getEnvironmentData().nad));
            Log.debug("----------------------------------------------------");
        }

        private function roomEntryConditions():void
        {
            var quest:QuestVO;
            Log.debug("\tUpdatedRoomCommand.roomEntryConditions()");
            var playerQuests:Array = this.activeQuestsModel.getAllItems();
            var questsActivated:Boolean;
            Log.debug(("\t\tplayerQuests: " + playerQuests));
            for each (quest in playerQuests)
            {
                Log.debug(("\t\t\t-quest.questState.id: " + quest.questState.id));
                if (quest.questState.id != QuestStateEnum.NOT_AVAILABLE.id)
                {
                    questsActivated = true;
                    break;
                };
            };
            this.signalBus.music.dispatch();
            if ((((this.appModel.loginRoomload) && (playerQuests.length > 0)) && (questsActivated == false)))
            {
                this.firstLoginQuest();
            }
            else
            {
                if (this.appModel.loginRoomload)
                {
                    this.returnLoginQuest();
                }
                else
                {
                    this.regularRoomChange();
                };
            };
        }

        private function firstLoginQuest():void
        {
            Log.debug("\tUpdatedRoomCommand.firstLoginQuest()");
            this.appModel.loginRoomload = false;
            this.appModel.firstLogin = true;
            this.clearCookie();
            this.signalBus.onIntroToCP.dispatch(true);
        }

        private function returnLoginQuest():void
        {
            Log.debug("\tUpdatedRoomCommand.returnLoginQuest()");
            this.appModel.loginRoomload = false;
            this.showMapIcon();
            this.signalBus.onIntroToCP.dispatch(false);
            if (this.partyVO.isActive)
            {
                this.signalBus.showPartyLogin.dispatch();
            };
        }

        private function regularRoomChange():void
        {
            Log.debug("\tUpdatedRoomCommand.regularRoomChange()");
            this.showMapIcon();
        }

        private function clearCookie():void
        {
            Log.debug("\tUpdatedRoomCommand.clearCookie()");
            var urlRequest:URLRequest = new URLRequest((this.appModel.getEnvironmentData().getBaseConfigPath() + "/web_service/activate_player.php"));
            var urlVariables:URLVariables = new URLVariables();
            this._urlLoader.addEventListener(Event.COMPLETE, this.onComplete);
            this._urlLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            urlVariables.action = "reset_key";
            urlVariables.username = this.appModel.getEnvironmentData().nau;
            urlVariables.nal = this.appModel.getEnvironmentData().nal;
            urlRequest.data = urlVariables;
            urlRequest.method = URLRequestMethod.POST;
            this._urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
            this._urlLoader.load(urlRequest);
        }

        private function showMapIcon():void
        {
            Log.debug("\tUpdatedRoomCommand.showMapIcon()");
            var showAs2MapIcon:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_AS2_INTERFACE_ACTION);
            showAs2MapIcon.data = new Object();
            showAs2MapIcon.data.iconType = "Map";
            showAs2MapIcon.data.iconAction = "show";
            this.bridge.send(showAs2MapIcon);
        }

        private function onComplete(e:Event):void
        {
            Log.debug("\ncookie clearing completed! ");
            Log.debug(this._urlLoader.data);
        }

        private function onError(e:Event):void
        {
            Log.debug((("\nERROR: cookie clearing not completed! " + e) + "\n"));
        }


    }
}//package com.clubpenguin.main.command
