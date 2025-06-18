//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.Injector;

    public class InjectValueResult extends InjectionResult 
    {

        private var m_value:Object;

        public function InjectValueResult(value:Object)
        {
            this.m_value = value;
        }

        override public function getResponse(injector:Injector):Object
        {
            return (this.m_value);
        }


    }
}//package org.swiftsuspenders.injectionresults
