//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.Injector;

    public class InjectSingletonResult extends InjectionResult 
    {

        private var m_responseType:Class;
        private var m_response:Object;

        public function InjectSingletonResult(responseType:Class)
        {
            this.m_responseType = responseType;
        }

        override public function getResponse(injector:Injector):Object
        {
            return (this.m_response = ((this.m_response) || (this.createResponse(injector))));
        }

        private function createResponse(injector:Injector):Object
        {
            return (injector.instantiate(this.m_responseType));
        }


    }
}//package org.swiftsuspenders.injectionresults
