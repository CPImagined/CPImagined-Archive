//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    import org.robotlegs.mvcs.SignalContext;
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.signals.CloseModuleSignal;
    import com.clubpenguin.lib.commands.CloseModuleCommand;

    public class BaseModuleContext extends SignalContext 
    {

        public function BaseModuleContext(contextView:BaseModule, injector:IInjector, autoStartup:Boolean=true)
        {
            if (injector)
            {
                this.injector = injector;
            }
            else
            {
                trace("[BaseModuleContext] Injector should not be null");
            };
            super(contextView, autoStartup);
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            signalCommandMap.mapSignalClass(CloseModuleSignal, CloseModuleCommand);
        }

        protected function injectMockClasses():void
        {
        }


    }
}//package com.clubpenguin.lib.module
