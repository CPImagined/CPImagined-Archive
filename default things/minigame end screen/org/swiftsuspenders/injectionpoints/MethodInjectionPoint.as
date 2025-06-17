//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;
    import org.swiftsuspenders.InjectionConfig;
    import org.swiftsuspenders.InjectorError;
    import flash.utils.getQualifiedClassName;

    public class MethodInjectionPoint extends InjectionPoint 
    {

        protected var methodName:String;
        protected var m_injectionConfigs:Array;
        protected var requiredParameters:int = 0;

        public function MethodInjectionPoint(node:XML, injector:Injector)
        {
            super(node, injector);
        }

        override public function applyInjection(target:Object, injector:Injector):Object
        {
            var parameters:Array = this.gatherParameterValues(target, injector);
            var method:Function = target[this.methodName];
            method.apply(target, parameters);
            return (target);
        }

        override protected function initializeInjection(node:XML, injector:Injector):void
        {
            var nameArgs:XMLList;
            var methodNode:XML;
            nameArgs = node.arg.(@key == "name");
            methodNode = node.parent();
            this.methodName = methodNode.@name.toString();
            this.gatherParameters(methodNode, nameArgs, injector);
        }

        protected function gatherParameters(methodNode:XML, nameArgs:XMLList, injector:Injector):void
        {
            var parameter:XML;
            var injectionName:String;
            var parameterTypeName:String;
            var parameterType:Class;
            this.m_injectionConfigs = [];
            var i:int;
            for each (parameter in methodNode.parameter)
            {
                injectionName = "";
                if (nameArgs[i])
                {
                    injectionName = nameArgs[i].@value.toString();
                };
                parameterTypeName = parameter.@type.toString();
                if (parameterTypeName == "*")
                {
                    if (parameter.@optional.toString() == "false")
                    {
                        throw (new Error(("Error in method definition of injectee. Required " + "parameters can't have type \"*\".")));
                    };
                    parameterTypeName = null;
                }
                else
                {
                    parameterType = Class(injector.getApplicationDomain().getDefinition(parameterTypeName));
                };
                this.m_injectionConfigs.push(injector.getMapping(parameterType, injectionName));
                if (parameter.@optional.toString() == "false")
                {
                    this.requiredParameters++;
                };
                i++;
            };
        }

        protected function gatherParameterValues(target:Object, injector:Injector):Array
        {
            var config:InjectionConfig;
            var injection:Object;
            var parameters:Array = [];
            var length:int = this.m_injectionConfigs.length;
            var i:int;
            while (i < length)
            {
                config = this.m_injectionConfigs[i];
                injection = config.getResponse(injector);
                if (injection == null)
                {
                    if (i >= this.requiredParameters)
                    {
                        break;
                    };
                    throw (new InjectorError(((((((("Injector is missing a rule to handle injection into target " + target) + ". Target dependency: ") + getQualifiedClassName(config.request)) + ", method: ") + this.methodName) + ", parameter: ") + (i + 1))));
                };
                parameters[i] = injection;
                i++;
            };
            return (parameters);
        }


    }
}//package org.swiftsuspenders.injectionpoints
