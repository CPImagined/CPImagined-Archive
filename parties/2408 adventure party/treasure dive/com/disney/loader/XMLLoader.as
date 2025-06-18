package com.disney.loader{
    import org.osflash.signals.Signal;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLRequest;

    public class XMLLoader {

        private const signalComplete:Signal = new Signal(XML);

        private var __xmlFileName:String;

        public function XMLLoader(_arg_1:String, _arg_2:Function):void{
            this.__xmlFileName = _arg_1;
            this.signalComplete.addOnce(_arg_2);
            this.loadXML();
        }

        protected function loadXML():void{
            var _local_1:URLLoader;
            _local_1 = new URLLoader();
            _local_1.dataFormat = URLLoaderDataFormat.TEXT;
            _local_1.addEventListener(Event.COMPLETE, this.onXMLLoaded);
            _local_1.addEventListener(IOErrorEvent.IO_ERROR, this.onXMLError);
            _local_1.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onXMLError);
            _local_1.load(new URLRequest(this.__xmlFileName));
        }

        private function onXMLLoaded(_arg_1:Event):void{
            var _local_2:XML = XML(_arg_1.target.data);
            _local_2.normalize();
            this.signalComplete.dispatch(_local_2);
        }

        private function onXMLError(_arg_1:Event):void{
            this.signalComplete.dispatch(null);
        }


    }
}//package com.disney.loader
