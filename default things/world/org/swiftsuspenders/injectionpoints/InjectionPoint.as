//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;

    public class InjectionPoint 
    {

        public function InjectionPoint(node:XML, injector:Injector)
        {
            this.initializeInjection(node, injector);
        }

        public function applyInjection(target:Object, injector:Injector):Object
        {
            return (target);
        }

        protected function initializeInjection(node:XML, injector:Injector):void
        {
        }


    }
}//package org.swiftsuspenders.injectionpoints
