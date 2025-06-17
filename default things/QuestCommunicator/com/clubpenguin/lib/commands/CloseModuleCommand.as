//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.commands
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.module.BaseModule;
    import com.clubpenguin.lib.module.IAppSignalBus;
    import org.osflash.signals.Signal;

    public class CloseModuleCommand extends Command 
    {

        [Inject]
        public var baseModule:BaseModule;
        [Inject]
        public var appSignalBus:IAppSignalBus;


        override public function execute():void
        {
            Signal(this.appSignalBus.getCloseView()).dispatch(this.baseModule);
        }


    }
}//package com.clubpenguin.lib.commands
