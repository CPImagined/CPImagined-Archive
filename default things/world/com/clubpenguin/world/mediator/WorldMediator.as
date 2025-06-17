//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.world.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.world.model.WorldModel;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import com.clubpenguin.world.view.AS2ContentView;
    import com.clubpenguin.world.WorldContext;
    import org.osflash.signals.Signal;

    public class WorldMediator extends Mediator 
    {

        [Inject]
        public var model:WorldModel;
        [Inject]
        public var signalBus:IAppSignalBus;
        [Inject]
        public var view:AS2ContentView;
        [Inject]
        public var context:WorldContext;


        override public function onRegister():void
        {
            this.signalBus.getUnloadAs2World().addOnce(this.onUnloadAs2World);
        }

        override public function onRemove():void
        {
            this.signalBus.getUnloadAs2World().remove(this.onUnloadAs2World);
        }

        private function onUnloadAs2World(onComplete:Signal):void
        {
            this.view.unload();
            this.view.parent.removeChild(this.view);
            this.view = null;
            onComplete.dispatch();
        }


    }
}//package com.clubpenguin.world.mediator
