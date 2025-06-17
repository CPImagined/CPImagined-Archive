//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.endscreens
{
    import com.clubpenguin.lib.module.BaseModuleContext;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.endscreens.model.MiniGameEndScreensModel;
    import com.clubpenguin.endscreens.controller.MiniGameEndScreensController;
    import com.clubpenguin.endscreens.view.MiniGameEndScreensView;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.module.BaseModule;
    import org.robotlegs.core.IInjector;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.clubpenguin.endscreens.service.MiniGameEndScreensService;
    import com.clubpenguin.endscreens.view.ScrollingStampsView;
    import com.clubpenguin.endscreens.mediator.StampsViewMediator;
    import com.clubpenguin.endscreens.mediator.MinigameEndScreenViewMediator;
    import com.clubpenguin.endscreens.view.CoinsView;
    import com.clubpenguin.endscreens.mediator.CoinsViewMediator;
    import com.clubpenguin.endscreens.command.RequestEndGameScreenConfigData;
    import com.clubpenguin.endscreens.command.JoinRoomCommmand;

    public class MiniGameEndScreensContext extends BaseModuleContext 
    {

        private var _bridge:IAVMBridgeService;
        private var _startupParams:Object;
        private var _model:MiniGameEndScreensModel = new MiniGameEndScreensModel();
        private var _controller:MiniGameEndScreensController = new MiniGameEndScreensController();
        private var _view:MiniGameEndScreensView = new MiniGameEndScreensView();
        public var requestEndScreenDataSignal:Signal = new Signal();
        public var joinRoomSignal:Signal = new Signal();

        public function MiniGameEndScreensContext(contextView:BaseModule, injector:IInjector, params:Object)
        {
            var key:String;
            this._startupParams = params;
            for (key in this._startupParams)
            {
                Log.debug(((("\t\tMiniGameEndScreensContext :: startupParams[" + key) + "] = ") + this._startupParams[key]));
            };
            super(contextView, injector);
            this._model.init(this._startupParams);
        }

        override public function startup():void
        {
            super.startup();
            contextView.visible = false;
            contextView.addChild(this._view);
            var timer:Timer = new Timer(800);
            timer.addEventListener(TimerEvent.TIMER, this.makeVisible);
            timer.start();
        }

        private function makeVisible(e:TimerEvent):void
        {
            contextView.visible = true;
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(MiniGameEndScreensContext, this);
            this._bridge = injector.getInstance(IAVMBridgeService);
            injector.mapSingleton(MiniGameEndScreensService);
            injector.mapValue(MiniGameEndScreensModel, this._model);
            injector.mapValue(MiniGameEndScreensView, this._view);
            injector.mapValue(MiniGameEndScreensController, this._controller);
            injector.mapValue(MiniGameEndScreensContext, this);
            mediatorMap.mapView(ScrollingStampsView, StampsViewMediator);
            mediatorMap.mapView(MiniGameEndScreensView, MinigameEndScreenViewMediator);
            mediatorMap.mapView(CoinsView, CoinsViewMediator);
            signalCommandMap.mapSignal(this.requestEndScreenDataSignal, RequestEndGameScreenConfigData);
            signalCommandMap.mapSignal(this.joinRoomSignal, JoinRoomCommmand);
            injector.injectInto(this._controller);
            injector.injectInto(this._model);
            this._controller.init();
            this.requestEndScreenDataSignal.dispatch();
        }


    }
}//package com.clubpenguin.endscreens
