//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.Injector;
    import org.swiftsuspenders.InjectorError;

    public class PropertyInjectionPoint extends InjectionPoint 
    {

        private var propertyName:String;
        private var propertyType:String;
        private var m_injectionConfig:InjectionConfig;

        public function PropertyInjectionPoint(node:XML, injector:Injector)
        {
            super(node, injector);
        }

        override public function applyInjection(target:Object, injector:Injector):Object
        {
            var injection:Object = this.m_injectionConfig.getResponse(injector);
            if (injection == null)
            {
                throw (new InjectorError(((("Injector is missing a rule to handle injection into target " + target) + ". Target dependency: ") + this.propertyType)));
            };
            target[this.propertyName] = injection;
            return (target);
        }

        override protected function initializeInjection(node:XML, injector:Injector):void
        {
            this.propertyType = node.parent().@type.toString();
            this.propertyName = node.parent().@name.toString();
            this.m_injectionConfig = injector.getMapping(Class(injector.getApplicationDomain().getDefinition(this.propertyType)), node.arg.attribute("value").toString());
        }


    }
}//package org.swiftsuspenders.injectionpoints
