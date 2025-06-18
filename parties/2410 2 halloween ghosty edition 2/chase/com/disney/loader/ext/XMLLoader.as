package com.disney.loader.ext
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	public class XMLLoader extends LoaderBase
	{
		public function XMLLoader(_xmlFileName:String, _completeHandler:Function)
		{
			this.signalComplete = new Signal(XML);
			
			super(_xmlFileName, _completeHandler);
		}

		override protected function load():void
		{
			var configLoader:URLLoader = null;
			var request:URLRequest = new URLRequest(this.__fileName);
			
			Log.getLogger(this.getUniqueName()).debug("Trying to load " + this.__fileName);
			Log.getLogger(this.getUniqueName()).debug("...as URLRequest: " + request.url);
			
			configLoader = new URLLoader();
			configLoader.dataFormat = URLLoaderDataFormat.TEXT;
			configLoader.addEventListener(Event.COMPLETE,this.onLoaded);
			configLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
			configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
			configLoader.load(request);
		}

		override protected function onLoaded(evt:Event):void
		{
			var xml:XML = XML(evt.target.data);
			xml.normalize();
			this.signalComplete.dispatch(xml);
			
			super.onLoaded(evt);
		}
		
		override public function getUniqueName():String
		{
			return "XMLLoader";
		}
	}
}