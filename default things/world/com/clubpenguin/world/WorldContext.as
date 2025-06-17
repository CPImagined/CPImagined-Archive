//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import org.osflash.signals.Signal;
    import com.clubpenguin.world.view.AS2ContentView;
    import com.clubpenguin.world.model.WorldModel;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.world.command.startup.LoadAS2Command;
    import com.clubpenguin.world.command.startup.InitAVMCommunicationCommand;
    import com.clubpenguin.world.command.startup.SendAVM1FlashVarsCommand;
    import com.clubpenguin.world.command.SendUserSubmissionCommand;
    import com.clubpenguin.world.command.SendBICommand;
    import com.clubpenguin.world.signal.AirTowerSignal;
    import com.clubpenguin.world.command.LogAirTowerEventCommand;
    import com.clubpenguin.world.mediator.WorldMediator;
    import com.clubpenguin.main.model.MainModel;

    public class WorldContext extends BaseModuleContext 
    {

        private var loadAS2Signal:Signal = new Signal();
        private var initAVMCommunicationSignal:Signal = new Signal();
        private var sendAVM1FlashVarsSignal:Signal = new Signal();
        private var as2ContentContainer:AS2ContentView = new AS2ContentView();
        private var worldModel:WorldModel = new WorldModel();

        public function WorldContext(contextView:BaseModule, injector:IInjector)
        {
            super(contextView, injector);
        }

        override public function startup():void
        {
            var signalBus:IAppSignalBus = injector.getInstance(IAppSignalBus);
            injector.mapValue(WorldModel, this.worldModel);
            injector.mapValue(WorldContext, this);
            injector.mapValue(AS2ContentView, this.as2ContentContainer);
            signalCommandMap.mapSignal(this.loadAS2Signal, LoadAS2Command);
            signalCommandMap.mapSignal(this.initAVMCommunicationSignal, InitAVMCommunicationCommand);
            signalCommandMap.mapSignal(this.sendAVM1FlashVarsSignal, SendAVM1FlashVarsCommand);
            signalCommandMap.mapSignal(signalBus.getSendUserSubmission(), SendUserSubmissionCommand);
            signalCommandMap.mapSignal(signalBus.getSendBI(), SendBICommand);
            signalCommandMap.mapSignalClass(AirTowerSignal, LogAirTowerEventCommand);
            mediatorMap.mapView(AS2ContentView, WorldMediator);
            contextView.addChild(this.as2ContentContainer);
            this.loadAS2Signal.dispatch();
        }

        override public function shutdown():void
        {
            var signalBus:IAppSignalBus = injector.getInstance(IAppSignalBus);
            signalCommandMap.unmapSignal(signalBus.getSendUserSubmission(), SendUserSubmissionCommand);
            signalCommandMap.unmapSignal(signalBus.getSendBI(), SendBICommand);
        }

        public function onAS2Loaded():void
        {
            MainModel(injector.getInstance(MainModel)).createAVMBridge();
            this.initAVMCommunicationSignal.dispatch();
        }

        public function onAVMCommunicationReady():void
        {
            this.sendAVM1FlashVarsSignal.dispatch();
        }


    }
}//package com.clubpenguin.world
