//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main
{
    import org.robotlegs.mvcs.SignalContext;
    import com.clubpenguin.lib.module.IAppContext;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.services.AVMBridgeService;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.services.socket.Connection;
    import com.clubpenguin.main.service.DLearningService;
    import com.clubpenguin.managers.resource.ResourceManager;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.services.socket.abtest.ABTestService;
    import com.clubpenguin.lib.model.IABTestModel;
    import com.clubpenguin.main.model.ABTestModel;
    import com.clubpenguin.lib.model.IMetricsModel;
    import com.clubpenguin.game.ICPGame;
    import com.clubpenguin.tools.localtext.core.ILocalText;
    import com.clubpenguin.tools.localtext.core.LocalText;
    import com.clubpenguin.services.socket.music.MusicService;
    import com.clubpenguin.services.socket.music.MusicLikesService;
    import com.clubpenguin.managers.LoginFloodManager;
    import com.clubpenguin.main.mediator.dialogs.AssetPromptMediator;
    import flash.display.DisplayObjectContainer;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.managers.localization.LocalizationManager;
    import com.clubpenguin.main.view.MainView;
    import com.clubpenguin.managers.AssetManager;
    import com.clubpenguin.main.view.ErrorDialogView;
    import com.clubpenguin.services.socket.puffles.PuffleCareItemsService;
    import com.clubpenguin.main.model.MapDataModel;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import com.clubpenguin.main.model.LoadingScreenModel;
    import com.clubpenguin.lib.services.http.DirectoryListingWebService;
    import com.clubpenguin.main.analytics.OmnitureAnalytics;
    import com.clubpenguin.main.analytics.WebLoggerAnalytics;
    import com.clubpenguin.services.socket.TrackingService;
    import com.clubpenguin.main.analytics.PersistentABTestData;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.tools.localtext.core.LanguageEnum;
    import com.clubpenguin.tools.localtext.core.LocalTextProxy;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.main.model.MetricsModel;
    import flash.display.MovieClip;
    import com.playdom.baseactors.BasePlayerStats;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.services.socket.music.IMusicService;
    import com.clubpenguin.services.socket.music.IMusicLikesService;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.main.model.ActiveQuestsModel;
    import com.clubpenguin.lib.vo.party.PartyVO;
    import com.clubpenguin.lib.services.bi.DimgBiService;
    import com.clubpenguin.main.command.StartupCommand;
    import com.clubpenguin.main.command.LoadModuleCommand;
    import com.clubpenguin.main.command.StartTrackerCommand;
    import com.clubpenguin.main.command.TrackerEventCommand;
    import com.clubpenguin.main.command.ShowPuffleCertificateCommand;
    import com.clubpenguin.main.command.ShowErrorDialogCommand;
    import com.clubpenguin.main.command.SendMyPuffleAddedToAS2Command;
    import com.clubpenguin.main.command.SendMyPuffleRemovedToAS2Command;
    import com.clubpenguin.main.command.SendPuffleMoodToAS2Command;
    import com.clubpenguin.main.command.HandleJoinWorldCommand;
    import com.clubpenguin.main.command.LoadMembershipPromptCommand;
    import com.clubpenguin.main.command.LoadMembershipPufflePromptCommand;
    import com.clubpenguin.main.command.LoadMembershipFAQCommand;
    import com.clubpenguin.main.command.AutoLoginCommand;
    import com.clubpenguin.main.command.IdlePlayerTimeoutCommand;
    import com.clubpenguin.main.command.ShowPosterCommand;
    import com.clubpenguin.main.command.modelsync.SyncPlayerDataCommand;
    import com.clubpenguin.main.command.SendWebServiceDataCommand;
    import com.clubpenguin.main.command.MapActionCommand;
    import com.clubpenguin.main.command.TriggerReceivedCommand;
    import com.clubpenguin.main.command.ShowPromptCommand;
    import com.clubpenguin.main.command.ShowComplexPromptCommand;
    import com.clubpenguin.main.command.ShowAssetPromptCommand;
    import com.clubpenguin.main.command.RoomLoadedCommand;
    import com.clubpenguin.main.command.UpdatedRoomCommand;
    import com.clubpenguin.main.command.LogRawBiEventCommand;
    import com.clubpenguin.main.command.BridgeErrorCommand;
    import com.clubpenguin.main.command.PartyInitCommand;
    import com.clubpenguin.main.command.ShowPartyLoginCommand;
    import com.clubpenguin.main.command.LoadPuffleTreasureInfographicCommand;
    import com.clubpenguin.main.command.UpdateLoginFloodManagerCommand;
    import com.clubpenguin.main.signal.InitTrackingSignal;
    import com.clubpenguin.main.command.InitTrackingCommand;
    import com.clubpenguin.main.signal.GetDefaultPufflesSignal;
    import com.clubpenguin.main.command.GetDefaultPufflesCommand;
    import com.clubpenguin.main.signal.LoadPuffleCareItemsSignal;
    import com.clubpenguin.main.command.LoadPuffleCareItemsCommand;
    import com.clubpenguin.main.signal.LoadConfigSignal;
    import com.clubpenguin.main.command.LoadConfigCommand;
    import com.clubpenguin.main.signal.LoadLocalizationDataSignal;
    import com.clubpenguin.main.command.SetLocalizationDataCommand;
    import com.clubpenguin.main.signal.LoadPathsDataSignal;
    import com.clubpenguin.main.command.SetPathsDataCommand;
    import com.clubpenguin.main.signal.LoadSwfAddress;
    import com.clubpenguin.main.command.LoadSwfAddressCommand;
    import com.clubpenguin.main.signal.MultiClientCheckSignal;
    import com.clubpenguin.main.command.MultiClientCheckCommand;
    import com.clubpenguin.main.signal.LoadNotificationSystemSignal;
    import com.clubpenguin.main.signal.LoadBanningModuleSignal;
    import com.clubpenguin.main.command.LoadBanningModuleCommand;
    import com.clubpenguin.main.signal.LoadMapTriggersSignal;
    import com.clubpenguin.main.command.LoadMapTriggersCommand;
    import com.clubpenguin.main.signal.LoadFontLibrarySignal;
    import com.clubpenguin.main.command.LoadFontLibraryCommand;
    import com.clubpenguin.main.signal.LoadWebServicesSignal;
    import com.clubpenguin.main.command.LoadWebServicesCommand;
    import com.clubpenguin.main.signal.LoadLogoSignal;
    import com.clubpenguin.main.command.LoadLogoCommand;
    import com.clubpenguin.main.signal.LoadWebServiceFatalErrorSignal;
    import com.clubpenguin.main.command.LoadWebServiceFatalErrorCommand;
    import com.clubpenguin.main.signal.as2world.ShowAS2WorldSignal;
    import com.clubpenguin.main.command.as2world.ShowAS2WorldCommand;
    import com.clubpenguin.main.signal.as2world.HideAS2WorldSignal;
    import com.clubpenguin.main.command.as2world.HideAS2WorldCommand;
    import com.clubpenguin.main.signal.QuestStatusUpdatedSignal;
    import com.clubpenguin.main.command.QuestStatusCommand;
    import com.clubpenguin.main.signal.QuestSettingsSignal;
    import com.clubpenguin.main.command.QuestSettingsCommand;
    import com.clubpenguin.main.signal.loadingScreen.ShowLoadingScreenSignal;
    import com.clubpenguin.main.command.loadingScreen.ShowLoadingScreenCommand;
    import com.clubpenguin.main.signal.loadingScreen.HideLoadingScreenSignal;
    import com.clubpenguin.main.command.loadingScreen.HideLoadingScreenCommand;
    import com.clubpenguin.main.signal.loadingScreen.UpdateLoadingScreenSignal;
    import com.clubpenguin.main.command.loadingScreen.UpdateLoadingScreenCommand;
    import com.clubpenguin.main.command.debug.ConsoleDebugCommand;
    import com.clubpenguin.main.mediator.MainViewMediator;
    import com.clubpenguin.main.overlays.view.MultipleOverlayView;
    import com.clubpenguin.main.overlays.mediator.MultipleOverlayViewMediator;
    import com.clubpenguin.main.mediator.dialogs.ErrorDialogMediator;
    import com.clubpenguin.main.view.PromptView;
    import com.clubpenguin.main.mediator.dialogs.PromptMediator;
    import com.clubpenguin.main.view.ui.LoadingScreenView;
    import com.clubpenguin.main.mediator.LoadingScreenViewMediator;
    import com.clubpenguin.main.view.dialogs.LoadingDialogView;
    import com.clubpenguin.main.mediator.dialogs.LoadingDialogMediator;
    import com.clubpenguin.main.command.HideOverlayCommand;
    import com.clubpenguin.main.command.ShowOverlayCommand;
    import com.clubpenguin.main.command.UpdateRewardReadyIconCommand;
    import com.clubpenguin.main.command.QuestIconUpdateCommand;
    import com.clubpenguin.lib.friends.FriendsMappings;
    import com.clubpenguin.main.view.ui.MainBackground;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import com.clubpenguin.lib.managers.resource.IResourceManager;
    import org.robotlegs.core.ISignalCommandMap;
    import org.robotlegs.core.IMediatorMap;
    import com.clubpenguin.main.view.LogoView;

    public class MainContext extends SignalContext implements IAppContext 
    {

        private var startupSignal:Signal = new Signal();
        private var signalBus:SignalBus = new SignalBus();
        private var bridge:AVMBridgeService = new AVMBridgeService();
        private var mainModel:MainModel = new MainModel();
        private var socketConnection:IConnection = new Connection();
        private var dlearningService:DLearningService = new DLearningService();
        private var resourceManager:ResourceManager = new ResourceManager();
        private var tracker:Tracker;
        private var __redirectURL:String = "";
        private var abTestService:ABTestService = new ABTestService();
        private var abTestModel:IABTestModel = new ABTestModel();
        private var metricsModel:IMetricsModel;
        private var activeGame:ICPGame;
        private var localText:ILocalText = new LocalText();
        private var _musicService:MusicService;
        private var _musicLikesService:MusicLikesService;
        private var loginFloodManager:LoginFloodManager = new LoginFloodManager();
        public var assetPromptMediator:AssetPromptMediator = new AssetPromptMediator();

        public function MainContext(contextView:DisplayObjectContainer)
        {
            super(contextView);
        }

        override protected function mapInjections():void
        {
            Log.debug("\tMainContext.mapInjections()");
            super.mapInjections();
            injector.mapSingletonOf(ILocalizationManager, LocalizationManager);
            injector.mapSingleton(MainView);
            injector.mapSingleton(AssetManager);
            injector.mapSingleton(ErrorDialogView);
            injector.mapSingleton(PuffleCareItemsService);
            injector.mapSingleton(MapDataModel);
            injector.mapSingleton(ModuleModel);
            injector.mapSingleton(WebServiceManagerProxy);
            injector.mapSingleton(LoadingScreenModel);
            injector.mapSingleton(DirectoryListingWebService);
            injector.mapSingleton(OmnitureAnalytics);
            injector.mapSingleton(WebLoggerAnalytics);
            injector.mapSingleton(TrackingService);
            injector.mapSingleton(PersistentABTestData);
            injector.mapValue(IAVMBridgeService, this.bridge);
            injector.mapValue(IConnection, this.socketConnection);
            injector.mapValue(MainModel, this.mainModel);
            injector.mapValue(MainContext, this);
            injector.mapValue(SignalBus, this.signalBus);
            injector.mapValue(IAppModel, this.mainModel);
            injector.mapValue(IAppContext, this);
            injector.mapValue(IAppSignalBus, this.signalBus);
            injector.mapValue(IABTestModel, this.abTestModel);
            injector.mapValue(ILocalText, this.localText);
            LocalText(this.localText).init(LanguageEnum.getEnumByLangString(contextView.stage.loaderInfo.parameters.lang), false);
            LocalTextProxy.localText = this.localText;
            injector.mapSingleton(Tracker);
            injector.mapValue(LoginFloodManager, this.loginFloodManager);
            injector.mapValue(IInjector, injector);
            injector.mapValue(DisplayObjectContainer, contextView);
            injector.mapValue(Object, contextView.stage.loaderInfo.parameters, "flashVars");
            injector.mapValue(ResourceManager, this.resourceManager);
            injector.mapValue(DLearningService, this.dlearningService);
            this.metricsModel = new MetricsModel(MovieClip(this.contextView));
            injector.mapValue(IMetricsModel, this.metricsModel);
            this.mainModel.signalBus = this.signalBus;
            this.mainModel.moduleModel = injector.getInstance(ModuleModel);
            this.mainModel.resourceManager = this.resourceManager;
            this.mainModel.mainView = injector.getInstance(MainView);
            this.mainModel.sessionUuid = contextView.stage.loaderInfo.parameters.tid;
            this.mainModel.browserId = contextView.stage.loaderInfo.parameters.bid;
            var app:String = this.getEnvironmentFromURL();
            this.tracker = Tracker(injector.getInstance(Tracker));
            this.tracker.initialize("-1", app, "", false, false, this.getLocale(contextView.stage.loaderInfo.parameters.lang), this.mainModel.sessionUuid, this.mainModel.browserId);
            this.tracker.defaultPlayerStats = BasePlayerStats.getInstance(0, 0);
            Connection(this.socketConnection).init(this.bridge);
            this.mainModel.init(this.bridge, this.socketConnection, injector.getInstance(ILocalizationManager), injector.getInstance(DLearningService));
            injector.mapValue(EnvironmentDataVO, this.mainModel.getEnvironmentData());
            this._musicService = new MusicService();
            injector.mapValue(IMusicService, this._musicService);
            this._musicLikesService = new MusicLikesService();
            injector.mapValue(IMusicLikesService, this._musicLikesService);
            injector.mapValue(PlayerVO, this.mainModel.getPlayerVO());
            injector.mapValue(PathsVO, this.mainModel.pathsVO);
            injector.mapValue(ActiveQuestsModel, this.mainModel.getPlayerVO().quests);
            injector.mapValue(PartyVO, this.mainModel.partyVO);
            injector.mapValue(AssetPromptMediator, this.assetPromptMediator);
            injector.mapSingleton(DimgBiService);
            signalCommandMap.mapSignal(this.startupSignal, StartupCommand);
            signalCommandMap.mapSignal(this.signalBus.loadModule, LoadModuleCommand);
            signalCommandMap.mapSignal(this.signalBus.startTracker, StartTrackerCommand);
            signalCommandMap.mapSignal(this.signalBus.trackerEvent, TrackerEventCommand);
            signalCommandMap.mapSignal(this.signalBus.showPuffleCertificate, ShowPuffleCertificateCommand);
            signalCommandMap.mapSignal(this.signalBus.showError, ShowErrorDialogCommand);
            signalCommandMap.mapSignal(this.mainModel.myPlayerVO.puffles.itemAdded, SendMyPuffleAddedToAS2Command);
            signalCommandMap.mapSignal(this.mainModel.myPlayerVO.puffles.itemRemoved, SendMyPuffleRemovedToAS2Command);
            signalCommandMap.mapSignal(this.mainModel.myPufflesStateManager.moodUpdated, SendPuffleMoodToAS2Command);
            signalCommandMap.mapSignal(this.mainModel.roomPufflesStateManager.moodUpdated, SendPuffleMoodToAS2Command);
            signalCommandMap.mapSignal(this.signalBus.joinedWorld, HandleJoinWorldCommand);
            signalCommandMap.mapSignal(this.signalBus.loadMembershipPrompt, LoadMembershipPromptCommand);
            signalCommandMap.mapSignal(this.signalBus.loadMembershipPufflePrompt, LoadMembershipPufflePromptCommand);
            signalCommandMap.mapSignal(this.signalBus.loadMembershipFAQ, LoadMembershipFAQCommand);
            signalCommandMap.mapSignal(this.signalBus.autoLogin, AutoLoginCommand);
            signalCommandMap.mapSignal(this.signalBus.idlePlayerTimeout, IdlePlayerTimeoutCommand);
            signalCommandMap.mapSignal(this.bridge.showPoster, ShowPosterCommand);
            signalCommandMap.mapSignal(this.signalBus.syncPlayerData, SyncPlayerDataCommand);
            signalCommandMap.mapSignal(this.bridge.sendWSData, SendWebServiceDataCommand);
            signalCommandMap.mapSignal(this.bridge.mapAction, MapActionCommand);
            signalCommandMap.mapSignal(this.bridge.triggerReceived, TriggerReceivedCommand);
            signalCommandMap.mapSignal(this.bridge.showPrompt, ShowPromptCommand);
            signalCommandMap.mapSignal(this.bridge.showComplexPrompt, ShowComplexPromptCommand);
            signalCommandMap.mapSignal(this.bridge.showAssetPrompt, ShowAssetPromptCommand);
            signalCommandMap.mapSignal(this.bridge.roomLoaded, RoomLoadedCommand);
            signalCommandMap.mapSignal(this.mainModel.onRoomUpdated, UpdatedRoomCommand);
            signalCommandMap.mapSignal(this.signalBus.logDimgBiEvent, LogDimgBiEventCommand);
            signalCommandMap.mapSignal(this.signalBus.logRawBiEvent, LogRawBiEventCommand);
            signalCommandMap.mapSignal(this.signalBus.bridgeError, BridgeErrorCommand);
            signalCommandMap.mapSignal(this.bridge.getPartyInit(), PartyInitCommand);
            signalCommandMap.mapSignal(this.signalBus.showPartyLogin, ShowPartyLoginCommand);
            signalCommandMap.mapSignal(this.bridge.getPartyInit(), PartyInitCommand);
            signalCommandMap.mapSignal(this.signalBus.showPartyLogin, ShowPartyLoginCommand);
            signalCommandMap.mapSignal(this.bridge.loadPuffleTreasureInfographic, LoadPuffleTreasureInfographicCommand);
            signalCommandMap.mapSignal(this.mainModel.updateLoginFloodManager, UpdateLoginFloodManagerCommand);
            signalCommandMap.mapSignalClass(InitTrackingSignal, InitTrackingCommand);
            signalCommandMap.mapSignalClass(GetDefaultPufflesSignal, GetDefaultPufflesCommand);
            signalCommandMap.mapSignalClass(LoadPuffleCareItemsSignal, LoadPuffleCareItemsCommand);
            signalCommandMap.mapSignalClass(LoadConfigSignal, LoadConfigCommand);
            signalCommandMap.mapSignalClass(LoadLocalizationDataSignal, SetLocalizationDataCommand);
            signalCommandMap.mapSignalClass(LoadPathsDataSignal, SetPathsDataCommand);
            signalCommandMap.mapSignalClass(LoadSwfAddress, LoadSwfAddressCommand);
            signalCommandMap.mapSignalClass(MultiClientCheckSignal, MultiClientCheckCommand);
            signalCommandMap.mapSignalClass(LoadNotificationSystemSignal, LoadNotificationSystemCommand);
            signalCommandMap.mapSignalClass(LoadBanningModuleSignal, LoadBanningModuleCommand);
            signalCommandMap.mapSignalClass(LoadMapTriggersSignal, LoadMapTriggersCommand);
            signalCommandMap.mapSignalClass(LoadFontLibrarySignal, LoadFontLibraryCommand);
            signalCommandMap.mapSignalClass(LoadWebServicesSignal, LoadWebServicesCommand);
            signalCommandMap.mapSignalClass(LoadLogoSignal, LoadLogoCommand);
            signalCommandMap.mapSignalClass(LoadWebServiceFatalErrorSignal, LoadWebServiceFatalErrorCommand);
            signalCommandMap.mapSignalClass(ShowAS2WorldSignal, ShowAS2WorldCommand);
            signalCommandMap.mapSignalClass(HideAS2WorldSignal, HideAS2WorldCommand);
            signalCommandMap.mapSignalClass(QuestStatusUpdatedSignal, QuestStatusCommand);
            signalCommandMap.mapSignalClass(QuestSettingsSignal, QuestSettingsCommand);
            signalCommandMap.mapSignalClass(ShowLoadingScreenSignal, ShowLoadingScreenCommand);
            signalCommandMap.mapSignalClass(HideLoadingScreenSignal, HideLoadingScreenCommand);
            signalCommandMap.mapSignalClass(UpdateLoadingScreenSignal, UpdateLoadingScreenCommand);
            signalCommandMap.mapSignal(this.bridge.getConsoleDebug(), ConsoleDebugCommand);
            mediatorMap.mapView(MainView, MainViewMediator);
            mediatorMap.mapView(MultipleOverlayView, MultipleOverlayViewMediator);
            mediatorMap.mapView(ErrorDialogView, ErrorDialogMediator);
            mediatorMap.mapView(PromptView, PromptMediator);
            mediatorMap.mapView(LoadingScreenView, LoadingScreenViewMediator);
            mediatorMap.mapView(LoadingDialogView, LoadingDialogMediator);
            signalCommandMap.mapSignal(this.bridge.getStopNotificationServices(), HideOverlayCommand);
            signalCommandMap.mapSignal(this.bridge.getStartNotificationServices(), ShowOverlayCommand);
            signalCommandMap.mapSignal(ActiveQuestsModel.rewardsReadyChanged, UpdateRewardReadyIconCommand);
            signalCommandMap.mapSignal(ActiveQuestsModel.questUpdate, QuestIconUpdateCommand);
            new FriendsMappings(injector, signalCommandMap);
            injector.injectInto(this.bridge);
            injector.injectInto(this.mainModel);
            injector.injectInto(this.assetPromptMediator);
            injector.injectInto(this.mainModel.getPlayerVO().quests);
            injector.injectInto(this.abTestModel);
        }

        private function getLocale(lang:String):String
        {
            switch (lang)
            {
                case "en":
                    return ("en_US");
                case "fr":
                    return ("fr_FR");
                case "pt":
                    return ("pt_BR");
                case "es":
                    return ("es_ES");
                case "de":
                    return ("de_DE");
                case "ru":
                    return ("ru_RU");
            };
            throw (new Error((("MainContext could not determine the locale for the specified langauge. Make sure that '" + lang) + "' has been added to the switch.")));
        }

        private function getEnvironmentFromURL():String
        {
            var result:String = "clubpenguin";
            var path:Array = contextView.stage.loaderInfo.url.toLowerCase().split("://");
            var protocol:String = path[0];
            var domainName:Array = path[1].split(".");
            if ((((((domainName[0].indexOf("sandbox") == 0) || (domainName[1].indexOf("sandbox") == 0)) || (domainName[0].indexOf("qa") == 0)) || (domainName[0].indexOf("dev") == 0)) || (domainName[0].indexOf("stage") == 0)))
            {
                result = "qa_clubpenguin";
            };
            return (result);
        }

        override public function startup():void
        {
            Log.debug("\tMainContext.startup()");
            this.bridge.addTimerMC(MovieClip(this.contextView));
            mediatorMap.createMediator(contextView);
            contextView.addChild(new MainBackground());
            var overlaysView:MultipleOverlayView = new MultipleOverlayView();
            contextView.addChild(overlaysView);
            var borderMask:Sprite = new Sprite();
            borderMask.graphics.beginFill(0, 1);
            borderMask.graphics.lineStyle(0);
            borderMask.graphics.drawRoundRect(3.25, 3.25, 752, 473, 4);
            borderMask.graphics.endFill();
            contextView.addChild(borderMask);
            overlaysView.mask = borderMask;
            var wsmProxy:WebServiceManagerProxy = injector.getInstance(WebServiceManagerProxy);
            wsmProxy.setLoadMethod(WebServiceManagerProxy.ZIP_LOAD);
            this.loginFloodManager.init();
            this.mainModel.getEnvironmentData().isLoginFloodControlActive = this.loginFloodManager.isFloodControlActive;
            this.startupSignal.dispatch();
            this.metricsModel.startTimers();
            var directoryServices:DirectoryListingWebService = (injector.getInstance(DirectoryListingWebService) as DirectoryListingWebService);
            directoryServices.submitRequest();
            var reloadButton:Sprite = new Sprite();
            reloadButton.graphics.beginFill(0xFFFFFF);
            reloadButton.graphics.drawRect(20, 50, 50, 50);
            reloadButton.graphics.endFill();
            reloadButton.buttonMode = true;
            reloadButton.addEventListener(MouseEvent.CLICK, this.onReloadClick);
            try
            {
                ExternalInterface.addCallback("handleLogOff", this.handleJavascriptCall);
                ExternalInterface.addCallback("handleWindowUnload", this.handleJavascriptCall);
                ExternalInterface.addCallback("handleBack", this.handleJavascriptCall);
                ExternalInterface.addCallback("handleMPInstanceClose", this.handleMPInstanceClose);
                ExternalInterface.addCallback("handleNameResubmit", this.handleNameResubmit);
                ExternalInterface.addCallback("handleShowPreactivation", this.handleShowPreactivation);
            }
            catch(error:Error)
            {
            };
            this.abTestService.init(this.socketConnection, this.abTestModel);
            this._musicService.init(this.socketConnection);
            this._musicLikesService.init(this.socketConnection);
        }

        public function handleJavascriptCall(_value:String=""):void
        {
            var message:AVMBridgeMessage;
            this.__redirectURL = _value;
            if (this.bridge != null)
            {
                if (this.bridge.isConnected())
                {
                    message = new AVMBridgeMessage(AVMBridgeMessage.MSG_LOG_OFF_CLUB_PENGUIN);
                    this.bridge.send(message);
                    Signal(this.signalBus.getLogOffCleanupComplete()).add(this.handleAS2CleanupComplete);
                    return;
                };
                this.handleAS2CleanupComplete();
                return;
            };
            this.handleAS2CleanupComplete();
        }

        public function handleAS2CleanupComplete():void
        {
            var url:String;
            var request:URLRequest;
            this.metricsModel.stopTimers();
            if (((!(this.bridge == null)) && (this.bridge.isConnected())))
            {
                this.bridge.close();
            };
            while (contextView.numChildren > 0)
            {
                contextView.removeChildAt(0);
            };
            if (this.__redirectURL != "")
            {
                url = this.__redirectURL;
                request = new URLRequest(url);
                navigateToURL(request, "_self");
            };
        }

        public function handleMPInstanceClose(cmdString:String):void
        {
            Log.info((("[App MainContext] handleMPInstanceClose(" + cmdString) + ")"));
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_HANDLE_MP_INSTANCE_CLOSE);
            message.data = cmdString;
            this.bridge.send(message);
            Log.info(("[App MainContext]\t-activeGame:" + this.activeGame));
            this.activeGame.endGame();
            this.activeGame = null;
        }

        public function handleNameResubmit(newName:String, token:String, loginDataRaw:String):void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_HANDLE_NAME_RESUBMIT);
            var obj:Object = new Object();
            obj.newName = newName;
            obj.token = token;
            obj.loginDataRaw = loginDataRaw;
            message.data = obj;
            this.bridge.send(message);
        }

        public function handleShowPreactivation():void
        {
            var message:AVMBridgeMessage = new AVMBridgeMessage(AVMBridgeMessage.MSG_HANDLE_SHOW_ABOUT_ACTIVATION);
            var data:Object = new Object();
            message.data = data;
            this.bridge.send(message);
        }

        private function onReloadClick(event:MouseEvent):void
        {
            var loadMapTrigger:LoadMapTriggersSignal = LoadMapTriggersSignal(injector.getInstance(LoadMapTriggersSignal));
            loadMapTrigger.dispatch(new Signal());
        }

        public function getInjector():IInjector
        {
            return (this.injector);
        }

        public function getSignalBus():IAppSignalBus
        {
            return (this.signalBus);
        }

        public function getModel():IAppModel
        {
            return (this.mainModel);
        }

        public function getLocalizationManager():ILocalizationManager
        {
            return (injector.getInstance(ILocalizationManager));
        }

        public function getResourceManager():IResourceManager
        {
            return (this.resourceManager);
        }

        public function getSocketConnection():IConnection
        {
            return (this.socketConnection);
        }

        public function getSignalCommandMap():ISignalCommandMap
        {
            return (signalCommandMap);
        }

        public function getMediatorMap():IMediatorMap
        {
            return (mediatorMap);
        }

        public function setActiveGame(game:ICPGame):void
        {
            this.activeGame = game;
        }

        public function getLogoView():LogoView
        {
            return (injector.getInstance(LogoView));
        }


    }
}//package com.clubpenguin.main
