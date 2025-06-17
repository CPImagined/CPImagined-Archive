//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import org.osflash.signals.Signal;
    import com.clubpenguin.puffles.adoption.signals.AdoptionSignalBus;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.puffles.adoption.services.PuffleAdoptionDLearningService;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.module.BaseModule;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.puffles.adoption.commands.SetupViewsCommand;
    import com.clubpenguin.puffles.adoption.commands.SetSelectedPuffleCommand;
    import com.clubpenguin.puffles.adoption.commands.SendErrorCommand;
    import com.clubpenguin.puffles.adoption.commands.ShowHiddenPuffleInAS2Command;
    import com.clubpenguin.puffles.adoption.view.RainbowAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.RainbowAdoptionMediator;
    import com.clubpenguin.puffles.adoption.view.GoldCongratsView;
    import com.clubpenguin.puffles.adoption.mediators.GoldCongratsMediator;
    import com.clubpenguin.puffles.adoption.view.GoldAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.GoldAdoptionMediator;
    import com.clubpenguin.puffles.adoption.view.DinoAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.DinoAdoptionViewMediator;
    import com.clubpenguin.puffles.adoption.view.DinoCertificateView;
    import com.clubpenguin.puffles.adoption.mediators.DinoCertificateViewMediator;
    import com.clubpenguin.puffles.adoption.view.SnowAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.SnowAdoptionMediator;
    import com.clubpenguin.puffles.adoption.view.SnowCongratsView;
    import com.clubpenguin.puffles.adoption.mediators.SnowCertificateViewMediator;
    import com.clubpenguin.puffles.adoption.view.GhostAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.GhostAdoptionMediator;
    import com.clubpenguin.puffles.adoption.view.GhostCongratsView;
    import com.clubpenguin.puffles.adoption.mediators.GhostCertificateViewMediator;
    import com.clubpenguin.puffles.adoption.view.CrystalAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.CrystalAdoptionMediator;
    import com.clubpenguin.puffles.adoption.view.CrystalCongratsView;
    import com.clubpenguin.puffles.adoption.mediators.CrystalCertificateViewMediator;
    import com.clubpenguin.puffles.adoption.view.PuffleAdoptionView;
    import com.clubpenguin.puffles.adoption.mediators.PuffleAdoptionViewMediator;
    import com.clubpenguin.puffles.adoption.view.PuffleView;
    import com.clubpenguin.puffles.adoption.mediators.PuffleMediator;
    import com.clubpenguin.puffles.adoption.view.PufflePenView;
    import com.clubpenguin.puffles.adoption.mediators.PufflePenMediator;
    import com.clubpenguin.puffles.adoption.view.AdoptionDialogView;
    import com.clubpenguin.puffles.adoption.mediators.AdoptionDialogMediator;
    import com.clubpenguin.puffles.adoption.view.PuffleCongratsView;
    import com.clubpenguin.puffles.adoption.mediators.PuffleCongratsMediator;
    import com.clubpenguin.main.signal.as2world.ShowAS2WorldSignal;

    public class AdoptionContext extends BaseModuleContext 
    {

        private var startupSignal:Signal = new Signal();
        private var signalBus:AdoptionSignalBus = new AdoptionSignalBus();
        private var model:AdoptionModel = new AdoptionModel();
        private var socketConnection:IConnection;
        private var dlearningService:PuffleAdoptionDLearningService = new PuffleAdoptionDLearningService();
        private var _mainSignalBus:SignalBus;

        public function AdoptionContext(injector:IInjector, contextView:BaseModule, puffleAdoptionType:String)
        {
            super(contextView, injector);
            var appContext:MainContext = injector.getInstance(MainContext);
            this.socketConnection = appContext.getSocketConnection();
            this.model.puffleAdoptType = puffleAdoptionType;
            this.model.signalBus = this.signalBus;
            this.model.clientPath = appContext.getModel().getClientPath();
            this.model.playerVO = PlayerVO(appContext.getModel().getLocalPlayerVO());
            this.model.setLocalizationManager(appContext.getLocalizationManager());
            this.signalBus.closeModule = injector.getInstance(CloseModuleSignal);
            this.signalBus.openModule = appContext.getSignalBus().getLoadModule();
            this.signalBus.showError = appContext.getSignalBus().getShowError();
            this.signalBus.showOverlay = appContext.getSignalBus().getShowOverlay();
        }

        override public function startup():void
        {
            injector.mapValue(AdoptionContext, this);
            injector.mapValue(IConnection, this.socketConnection);
            injector.mapValue(AdoptionModel, this.model);
            injector.mapValue(AdoptionSignalBus, this.signalBus);
            injector.mapValue(PuffleAdoptionDLearningService, this.dlearningService);
            this.model.init(this.socketConnection, injector.getInstance(SignalBus), injector.getInstance(Tracker));
            signalCommandMap.mapSignal(this.startupSignal, SetupViewsCommand);
            signalCommandMap.mapSignal(this.signalBus.setChosenPuffle, SetSelectedPuffleCommand);
            signalCommandMap.mapSignal(this.signalBus.sendError, SendErrorCommand);
            signalCommandMap.mapSignal(this.signalBus.showPuffleSignal, ShowHiddenPuffleInAS2Command);
            if (!this._mainSignalBus)
            {
                this._mainSignalBus = injector.getInstance(SignalBus);
            };
            signalCommandMap.mapSignal(this._mainSignalBus.highlightPuffle, SetSelectedPuffleCommand);
            mediatorMap.mapView(RainbowAdoptionView, RainbowAdoptionMediator);
            mediatorMap.mapView(GoldCongratsView, GoldCongratsMediator);
            mediatorMap.mapView(GoldAdoptionView, GoldAdoptionMediator);
            mediatorMap.mapView(DinoAdoptionView, DinoAdoptionViewMediator);
            mediatorMap.mapView(DinoCertificateView, DinoCertificateViewMediator);
            mediatorMap.mapView(SnowAdoptionView, SnowAdoptionMediator);
            mediatorMap.mapView(SnowCongratsView, SnowCertificateViewMediator);
            mediatorMap.mapView(GhostAdoptionView, GhostAdoptionMediator);
            mediatorMap.mapView(GhostCongratsView, GhostCertificateViewMediator);
            mediatorMap.mapView(CrystalAdoptionView, CrystalAdoptionMediator);
            mediatorMap.mapView(CrystalCongratsView, CrystalCertificateViewMediator);
            mediatorMap.mapView(PuffleAdoptionView, PuffleAdoptionViewMediator);
            mediatorMap.mapView(PuffleView, PuffleMediator);
            mediatorMap.mapView(PufflePenView, PufflePenMediator);
            mediatorMap.mapView(AdoptionDialogView, AdoptionDialogMediator);
            mediatorMap.mapView(PuffleCongratsView, PuffleCongratsMediator);
            this.startupSignal.dispatch();
        }

        override public function shutdown():void
        {
            this.dlearningService.stopPuffleAdoption();
            signalCommandMap.unmapSignal(this.signalBus.setChosenPuffle, SetSelectedPuffleCommand);
            signalCommandMap.unmapSignal(this.startupSignal, SetupViewsCommand);
            signalCommandMap.unmapSignal(this.signalBus.sendError, SendErrorCommand);
            signalCommandMap.unmapSignal(this.signalBus.showPuffleSignal, ShowHiddenPuffleInAS2Command);
            signalCommandMap.unmapSignal(this._mainSignalBus.highlightPuffle, SetSelectedPuffleCommand);
            injector.unmap(IConnection);
            injector.unmap(AdoptionModel);
            injector.unmap(AdoptionSignalBus);
            this.model.sendTracking();
            this.model.destroy();
            var showAS2WorldSignal:ShowAS2WorldSignal = injector.getInstance(ShowAS2WorldSignal);
            showAS2WorldSignal.dispatch();
        }


    }
}//package com.clubpenguin.puffles.adoption
