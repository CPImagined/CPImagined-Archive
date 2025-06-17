//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders
{
    import org.swiftsuspenders.injectionresults.InjectionResult;

    public class InjectionConfig 
    {

        public var request:Class;
        public var injectionName:String;
        private var m_injector:Injector;
        private var m_result:InjectionResult;

        public function InjectionConfig(request:Class, injectionName:String)
        {
            this.request = request;
            this.injectionName = injectionName;
        }

        public function getResponse(injector:Injector):Object
        {
            if (this.m_result)
            {
                return (this.m_result.getResponse(((this.m_injector) || (injector))));
            };
            var parentConfig:InjectionConfig = ((this.m_injector) || (injector)).getAncestorMapping(this.request, this.injectionName);
            if (parentConfig)
            {
                return (parentConfig.getResponse(injector));
            };
            return (null);
        }

        public function hasResponse(injector:Injector):Boolean
        {
            if (this.m_result)
            {
                return (true);
            };
            var parentConfig:InjectionConfig = ((this.m_injector) || (injector)).getAncestorMapping(this.request, this.injectionName);
            return (!(parentConfig == null));
        }

        public function hasOwnResponse():Boolean
        {
            return (!(this.m_result == null));
        }

        public function setResult(result:InjectionResult):void
        {
            this.m_result = result;
        }

        public function setInjector(injector:Injector):void
        {
            this.m_injector = injector;
        }


    }
}//package org.swiftsuspenders
