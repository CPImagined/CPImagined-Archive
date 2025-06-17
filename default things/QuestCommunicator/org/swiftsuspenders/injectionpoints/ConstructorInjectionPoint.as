//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;
    import flash.utils.describeType;

    public class ConstructorInjectionPoint extends MethodInjectionPoint 
    {

        public function ConstructorInjectionPoint(node:XML, clazz:Class, injector:Injector)
        {
            if (node.parameter.(@type == "*").length() == node.parameter.@type.length())
            {
                this.createDummyInstance(node, clazz);
            };
            super(node, injector);
        }

        override public function applyInjection(target:Object, injector:Injector):Object
        {
            var p:Array = gatherParameterValues(target, injector);
            switch (p.length)
            {
                case 0:
                    return (new (target)());
                case 1:
                    return (new target(p[0]));
                case 2:
                    return (new target(p[0], p[1]));
                case 3:
                    return (new target(p[0], p[1], p[2]));
                case 4:
                    return (new target(p[0], p[1], p[2], p[3]));
                case 5:
                    return (new target(p[0], p[1], p[2], p[3], p[4]));
                case 6:
                    return (new target(p[0], p[1], p[2], p[3], p[4], p[5]));
                case 7:
                    return (new target(p[0], p[1], p[2], p[3], p[4], p[5], p[6]));
                case 8:
                    return (new target(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]));
                case 9:
                    return (new target(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]));
                case 10:
                    return (new target(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9]));
            };
            return (null);
        }

        override protected function initializeInjection(node:XML, injector:Injector):void
        {
            var nameArgs:XMLList;
            nameArgs = node.parent().metadata.(@name == "Inject").arg.(@key == "name");
            methodName = "constructor";
            gatherParameters(node, nameArgs, injector);
        }

        private function createDummyInstance(constructorNode:XML, clazz:Class):void
        {
            try
            {
                switch (constructorNode.children().length())
                {
                    case 0:
                        new (clazz)();
                        break;
                    case 1:
                        new (clazz)(null);
                        break;
                    case 2:
                        new (clazz)(null, null);
                        break;
                    case 3:
                        new (clazz)(null, null, null);
                        break;
                    case 4:
                        new (clazz)(null, null, null, null);
                        break;
                    case 5:
                        new (clazz)(null, null, null, null, null);
                        break;
                    case 6:
                        new (clazz)(null, null, null, null, null, null);
                        break;
                    case 7:
                        new (clazz)(null, null, null, null, null, null, null);
                        break;
                    case 8:
                        new (clazz)(null, null, null, null, null, null, null, null);
                        break;
                    case 9:
                        new (clazz)(null, null, null, null, null, null, null, null, null);
                        break;
                    case 10:
                        new (clazz)(null, null, null, null, null, null, null, null, null, null);
                        break;
                };
            }
            catch(error:Error)
            {
                trace(error);
            };
            constructorNode.setChildren(describeType(clazz).factory.constructor[0].children());
        }


    }
}//package org.swiftsuspenders.injectionpoints
