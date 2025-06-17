//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.adapters
{
    import org.swiftsuspenders.Injector;
    import org.robotlegs.core.IInjector;
    import flash.system.ApplicationDomain;

    public class SwiftSuspendersInjector extends Injector implements IInjector 
    {

        protected static const XML_CONFIG:XML = <types>
				<type name='org.robotlegs.mvcs::Actor'>
					<field name='eventDispatcher'/>
				</type>
				<type name='org.robotlegs.mvcs::Command'>
					<field name='contextView'/>
					<field name='mediatorMap'/>
					<field name='eventDispatcher'/>
					<field name='injector'/>
					<field name='commandMap'/>
				</type>
				<type name='org.robotlegs.mvcs::Mediator'>
					<field name='contextView'/>
					<field name='mediatorMap'/>
					<field name='eventDispatcher'/>
				</type>
			</types>
        ;

        public function SwiftSuspendersInjector(xmlConfig:XML=null)
        {
            var typeNode:XML;
            if (xmlConfig)
            {
                for each (typeNode in XML_CONFIG.children())
                {
                    xmlConfig.appendChild(typeNode);
                };
            };
            super(xmlConfig);
        }

        public function createChild(applicationDomain:ApplicationDomain=null):IInjector
        {
            var injector:SwiftSuspendersInjector = new SwiftSuspendersInjector();
            injector.setApplicationDomain(applicationDomain);
            injector.setParentInjector(this);
            return (injector);
        }

        public function get applicationDomain():ApplicationDomain
        {
            return (getApplicationDomain());
        }

        public function set applicationDomain(value:ApplicationDomain):void
        {
            setApplicationDomain(value);
        }


    }
}//package org.robotlegs.adapters
