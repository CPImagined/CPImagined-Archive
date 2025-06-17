//Created by Action Script Viewer - https://www.buraks.com/asv
package com.disney.loader
{
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class XMLLoader 
    {

        private const signalComplete:Signal = new Signal(XML);

        private var __xmlFileName:String;

        public function XMLLoader(_xmlFileName:String, _completeHandler:Function):void
        {
            this.__xmlFileName = _xmlFileName;
            this.signalComplete.addOnce(_completeHandler);
            this.loadXML();
        }

        protected function loadXML():void
        {
            var configLoader:URLLoader;
            configLoader = new URLLoader();
            configLoader.dataFormat = URLLoaderDataFormat.TEXT;
            configLoader.addEventListener(Event.COMPLETE, this.onXMLLoaded);
            configLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onXMLError);
            configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onXMLError);
            configLoader.load(new URLRequest(this.__xmlFileName));
        }

        private function onXMLLoaded(event:Event):void
        {
            var xml:XML = XML(event.target.data);
            xml.normalize();
            this.signalComplete.dispatch(xml);
        }

        private function onXMLError(event:Event):void
        {
            this.signalComplete.dispatch(null);
        }


    }
}//package com.disney.loader
