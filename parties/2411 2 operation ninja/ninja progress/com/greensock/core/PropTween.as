//Created by Action Script Viewer - https://www.buraks.com/asv
package com.greensock.core
{
    public final class PropTween 
    {

        public var priority:int;
        public var start:Number;
        public var prevNode:PropTween;
        public var change:Number;
        public var target:Object;
        public var name:String;
        public var property:String;
        public var nextNode:PropTween;
        public var isPlugin:Boolean;

        public function PropTween(target:Object, property:String, start:Number, change:Number, name:String, isPlugin:Boolean, nextNode:PropTween=null, priority:int=0)
        {
            this.target = target;
            this.property = property;
            this.start = start;
            this.change = change;
            this.name = name;
            this.isPlugin = isPlugin;
            if (nextNode)
            {
                nextNode.prevNode = this;
                this.nextNode = nextNode;
            };
            this.priority = priority;
        }

    }
}//package com.greensock.core
