package com.disney.loader
{
    import org.osflash.signals.Signal;
    import flash.display.DisplayObject;
    import flash.system.LoaderContext;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class SWFLoader 
    {

        private const signalComplete:Signal = new Signal(DisplayObject);

        private var __swfFileName:String;
        private var __context:LoaderContext;

        public function SWFLoader(_arg_1:String, _arg_2:Function, _arg_3:LoaderContext):void
        {
            this.__context = _arg_3;
            this.__swfFileName = _arg_1;
            this.signalComplete.addOnce(_arg_2);
            this.loadSWF();
        }

        protected function loadSWF():void
        {
            var swfLoader:Loader;
            trace(("[SWFLoader] trying to load " + this.__swfFileName));
            trace(("[SWFLoader] as urlrequest: " + new URLRequest(this.__swfFileName).url));
            try
            {
                swfLoader = new Loader();
                swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
                swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onSWFLoaded);
                swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
                swfLoader.load(new URLRequest(this.__swfFileName), this.__context);
            }
            catch(e:Error)
            {
                trace(("[SWFLoader] Error: " + e.message));
                signalComplete.dispatch(null);
            };
        }

        private function onProgress(_arg_1:ProgressEvent):void
        {
        }

        private function onIOError(_arg_1:IOErrorEvent):void
        {
            trace(("[SWFLoader] IOERROR: " + _arg_1));
            this.signalComplete.dispatch(null);
        }

        private function onSWFLoaded(_arg_1:Event):void
        {
            this.signalComplete.dispatch(DisplayObject(_arg_1.target.content));
        }


    }
}//package com.disney.loader
