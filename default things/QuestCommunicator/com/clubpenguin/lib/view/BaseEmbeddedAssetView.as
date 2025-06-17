//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.view
{
    import flash.display.MovieClip;
    import org.osflash.signals.Signal;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.display.DisplayObject;

    public class BaseEmbeddedAssetView extends MovieClip 
    {

        public const onCompleted:Signal = new Signal();

        public var loaded:Boolean = false;
        protected var instance:DisplayObjectContainer;
        protected var view:DisplayObjectContainer;
        private var AssetClass:Class;
        private var instanceName:String;

        public function BaseEmbeddedAssetView(AssetClass:Class, instanceName:String)
        {
            this.AssetClass = AssetClass;
            this.instanceName = instanceName;
            this.setupInstanceByName();
        }

        protected function setupInstanceByName():void
        {
            this.instance = new this.AssetClass();
            this.instance.addEventListener(Event.COMPLETE, this.onViewComplete);
        }

        protected function onViewComplete(event:Event):void
        {
            addChild(this.instance);
            var loader:DisplayObjectContainer = (this.instance.getChildAt(0) as DisplayObjectContainer);
            var scene:DisplayObjectContainer = (loader.getChildAt(0) as DisplayObjectContainer);
            this.view = (scene.getChildByName(this.instanceName) as DisplayObjectContainer);
            this.loaded = true;
            this.onCompleted.dispatch();
        }

        public function printHeirarchy(doc:DisplayObjectContainer, prepend:String=""):void
        {
            var child:DisplayObject;
            var i:uint;
            while (i < doc.numChildren)
            {
                child = doc.getChildAt(i);
                trace((((prepend + child.name) + " type: ") + child));
                if ((child is DisplayObjectContainer))
                {
                    this.printHeirarchy((child as DisplayObjectContainer), (prepend + "-"));
                };
                i++;
            };
        }


    }
}//package com.clubpenguin.lib.view
