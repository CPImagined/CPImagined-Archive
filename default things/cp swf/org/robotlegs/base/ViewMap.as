//Created by Action Script Viewer - https://www.buraks.com/asv
package org.robotlegs.base
{
    import org.robotlegs.core.IViewMap;
    import flash.utils.Dictionary;
    import flash.display.DisplayObjectContainer;
    import org.robotlegs.core.IInjector;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import flash.utils.getQualifiedClassName;

    public class ViewMap extends ViewMapBase implements IViewMap 
    {

        protected var mappedPackages:Array;
        protected var mappedTypes:Dictionary;
        protected var injectedViews:Dictionary;

        public function ViewMap(contextView:DisplayObjectContainer, injector:IInjector)
        {
            super(contextView, injector);
            this.mappedPackages = new Array();
            this.mappedTypes = new Dictionary(false);
            this.injectedViews = new Dictionary(true);
        }

        public function mapPackage(packageName:String):void
        {
            if (this.mappedPackages.indexOf(packageName) == -1)
            {
                this.mappedPackages.push(packageName);
                viewListenerCount++;
                if (viewListenerCount == 1)
                {
                    this.addListeners();
                };
            };
        }

        public function unmapPackage(packageName:String):void
        {
            var index:int = this.mappedPackages.indexOf(packageName);
            if (index > -1)
            {
                this.mappedPackages.splice(index, 1);
                viewListenerCount--;
                if (viewListenerCount == 0)
                {
                    this.removeListeners();
                };
            };
        }

        public function mapType(_arg_1:Class):void
        {
            if (this.mappedTypes[_arg_1])
            {
                return;
            };
            this.mappedTypes[_arg_1] = _arg_1;
            viewListenerCount++;
            if (viewListenerCount == 1)
            {
                this.addListeners();
            };
            if (((contextView) && (contextView is _arg_1)))
            {
                this.injectInto(contextView);
            };
        }

        public function unmapType(_arg_1:Class):void
        {
            var mapping:Class = this.mappedTypes[_arg_1];
            delete this.mappedTypes[_arg_1];
            if (mapping)
            {
                viewListenerCount--;
                if (viewListenerCount == 0)
                {
                    this.removeListeners();
                };
            };
        }

        public function hasType(_arg_1:Class):Boolean
        {
            return (!(this.mappedTypes[_arg_1] == null));
        }

        public function hasPackage(packageName:String):Boolean
        {
            return (this.mappedPackages.indexOf(packageName) > -1);
        }

        override protected function addListeners():void
        {
            if (((contextView) && (enabled)))
            {
                contextView.addEventListener(Event.ADDED_TO_STAGE, this.onViewAdded, useCapture, 0, true);
            };
        }

        override protected function removeListeners():void
        {
            if (contextView)
            {
                contextView.removeEventListener(Event.ADDED_TO_STAGE, this.onViewAdded, useCapture);
            };
        }

        override protected function onViewAdded(e:Event):void
        {
            var _local_3:Class;
            var len:int;
            var className:String;
            var i:int;
            var packageName:String;
            var target:DisplayObject = DisplayObject(e.target);
            if (this.injectedViews[target])
            {
                return;
            };
            for each (_local_3 in this.mappedTypes)
            {
                if ((target is _local_3))
                {
                    this.injectInto(target);
                    return;
                };
            };
            len = this.mappedPackages.length;
            if (len > 0)
            {
                className = getQualifiedClassName(target);
                i = 0;
                while (i < len)
                {
                    packageName = this.mappedPackages[i];
                    if (className.indexOf(packageName) == 0)
                    {
                        this.injectInto(target);
                        return;
                    };
                    i++;
                };
            };
        }

        protected function injectInto(target:DisplayObject):void
        {
            injector.injectInto(target);
            this.injectedViews[target] = true;
        }


    }
}//package org.robotlegs.base
