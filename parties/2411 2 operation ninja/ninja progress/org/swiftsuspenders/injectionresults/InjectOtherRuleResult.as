//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionresults
{
    import org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.Injector;

    public class InjectOtherRuleResult extends InjectionResult 
    {

        private var m_rule:InjectionConfig;

        public function InjectOtherRuleResult(rule:InjectionConfig)
        {
            this.m_rule = rule;
        }

        override public function getResponse(injector:Injector):Object
        {
            return (this.m_rule.getResponse(injector));
        }


    }
}//package org.swiftsuspenders.injectionresults
