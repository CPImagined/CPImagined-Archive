//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    import flash.display.MovieClip;
    import org.robotlegs.core.IInjector;
    import flash.display.Loader;
    import org.osflash.signals.Signal;

    public class BaseModule extends MovieClip 
    {

        protected var context:BaseModuleContext;
        public var injector:IInjector = null;
        public var data:Object = null;
        public var parentLoader:Loader = null;


        public function init():void
        {
        }

        public function getContext():BaseModuleContext
        {
            return (this.context);
        }

        public function destroy():void
        {
            if (this.context)
            {
                this.context.shutdown();
            };
            this.injector = null;
            this.data = null;
            this.context = null;
            if (this.parentLoader)
            {
                this.parentLoader.unload();
                this.parentLoader = null;
            };
        }

        public function closeModule():void
        {
            var signalBus:IAppSignalBus;
            if (this.injector)
            {
                signalBus = this.injector.getInstance(IAppSignalBus);
                Signal(signalBus.getCloseView()).dispatch(this);
            };
        }


    }
}//package com.clubpenguin.lib.module
