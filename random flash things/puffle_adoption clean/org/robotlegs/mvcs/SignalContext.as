//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.mvcs
{
    import org.robotlegs.core.ISignalContext;
    import org.robotlegs.core.ISignalCommandMap;
    import flash.display.DisplayObjectContainer;
    import flash.system.ApplicationDomain;
    import org.robotlegs.core.IInjector;
    import org.robotlegs.base.SignalCommandMap;

    public class SignalContext extends Context implements ISignalContext 
    {

        protected var _signalCommandMap:ISignalCommandMap;

        public function SignalContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
        {
            super(contextView, autoStartup);
        }

        public function get signalCommandMap():ISignalCommandMap
        {
            var domain:ApplicationDomain;
            var childInjector:IInjector;
            if (!this._signalCommandMap)
            {
                domain = getApplicationDomainFromContextView();
                childInjector = injector.createChild(domain);
                this._signalCommandMap = new SignalCommandMap(childInjector);
            };
            return (this._signalCommandMap);
        }

        public function set signalCommandMap(value:ISignalCommandMap):void
        {
            this._signalCommandMap = value;
        }

        override protected function mapInjections():void
        {
            super.mapInjections();
            injector.mapValue(ISignalCommandMap, this.signalCommandMap);
        }


    }
}//package org.robotlegs.mvcs
