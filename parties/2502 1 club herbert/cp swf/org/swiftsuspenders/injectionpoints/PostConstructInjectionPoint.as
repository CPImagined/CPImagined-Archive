//Created by Action Script Viewer - https://www.buraks.com/asv
package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;

    public class PostConstructInjectionPoint extends InjectionPoint 
    {

        protected var methodName:String;
        protected var orderValue:int;

        public function PostConstructInjectionPoint(node:XML, injector:Injector)
        {
            super(node, injector);
        }

        public function get order():int
        {
            return (this.orderValue);
        }

        override public function applyInjection(target:Object, injector:Injector):Object
        {
            var _local_3:* = target;
            (_local_3[this.methodName]());
            return (target);
        }

        override protected function initializeInjection(node:XML, injector:Injector):void
        {
            var orderArg:XMLList;
            var methodNode:XML;
            orderArg = node.arg.(@key == "order");
            methodNode = node.parent();
            this.orderValue = int(orderArg.@value);
            this.methodName = methodNode.@name.toString();
        }


    }
}//package org.swiftsuspenders.injectionpoints
