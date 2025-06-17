//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    import org.robotlegs.core.IInjector;

    public class WindowModuleContext extends BaseModuleContext 
    {

        public var isWindowLoaded:Boolean = false;

        public function WindowModuleContext(contextView:BaseModule, injector:IInjector, autoStartup:Boolean=true)
        {
            super(contextView, injector, autoStartup);
        }

    }
}//package com.clubpenguin.lib.module
