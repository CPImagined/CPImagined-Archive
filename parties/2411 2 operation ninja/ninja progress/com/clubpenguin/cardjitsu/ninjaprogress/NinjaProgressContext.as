//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.NinjaProgressClassicCoupler;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.command.NinjaProgressServerRequestCommand;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.command.NinjaProgressServerResponseCommand;
    import com.clubpenguin.cardjitsu.ninjaprogress.coupler.command.LoadCardsJsonCommand;
    import com.clubpenguin.lib.module.IAppContext;

    public class NinjaProgressContext extends BaseModuleContext 
    {

        private var _coupler:NinjaProgressClassicCoupler = new NinjaProgressClassicCoupler();

        public function NinjaProgressContext(contextView:BaseModule, injector:IInjector)
        {
            super(contextView, injector);
        }

        override public function startup():void
        {
            injector.mapValue(NinjaProgressClassicCoupler, this._coupler);
            signalCommandMap.mapSignal(this._coupler.sendServerRequest, NinjaProgressServerRequestCommand);
            signalCommandMap.mapSignal(IConnection(injector.getInstance(IConnection)).getResponded(), NinjaProgressServerResponseCommand);
            signalCommandMap.mapSignal(this._coupler.loadCardsJson, LoadCardsJsonCommand);
            injector.injectInto(this._coupler);
            var appContext:IAppContext = injector.getInstance(IAppContext);
            this._coupler.setLocalizationManager(appContext.getLocalizationManager());
            this._coupler.setMainModel(appContext.getModel());
            this._coupler.setLoadModule(appContext.getSignalBus().getLoadModule());
            this._coupler.setVideoComplete(appContext.getSignalBus().getVideoComplete());
            this._coupler.init(contextView);
        }

        override public function shutdown():void
        {
            injector.unmap(NinjaProgressClassicCoupler);
            signalCommandMap.unmapSignal(this._coupler.sendServerRequest, NinjaProgressServerRequestCommand);
            signalCommandMap.unmapSignal(IConnection(injector.getInstance(IConnection)).getResponded(), NinjaProgressServerResponseCommand);
            signalCommandMap.unmapSignal(this._coupler.loadCardsJson, LoadCardsJsonCommand);
            this._coupler.destroy();
            this._coupler = null;
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress
