//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.model.MapDataModel;
    import com.clubpenguin.main.model.ModuleModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.lib.module.ModuleFilenamesEnum;

    public class TriggerReceivedCommand extends SignalCommand 
    {

        [Inject]
        public var triggerName:String;
        [Inject]
        public var mapDataModel:MapDataModel;
        [Inject]
        public var moduleModel:ModuleModel;
        [Inject]
        public var signalBus:SignalBus;


        override public function execute():void
        {
            var key:ModuleFilenamesEnum = ModuleFilenamesEnum.MAP_TRIGGERS;
            if (this.moduleModel.isModuleOpen(key))
            {
                this.signalBus.closeView.dispatch(this.moduleModel.getModuleWithKey(key));
            };
            this.mapDataModel.setTriggerVisitedByName(this.triggerName);
        }


    }
}//package com.clubpenguin.main.command
