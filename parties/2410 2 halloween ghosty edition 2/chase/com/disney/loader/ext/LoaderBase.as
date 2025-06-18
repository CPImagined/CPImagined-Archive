package com.disney.loader.ext
{
	import com.disney.lib.*;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	internal class LoaderBase implements ILoader,IDisposable,IUniquelyNamable
	{
		protected var signalComplete:Signal;

		protected var __fileName:String;

		public function LoaderBase(_fileName:String, _completeHandler:Function)
		{
			super();
		
			this.__fileName = _fileName;
			this.signalComplete.addOnce(_completeHandler);
			
			this.load();
		}

		protected function load():void
		{
		}

		protected function onLoaded(evt:Event):void
		{
			this.dispose();
		}

		protected function onError(evt:Event):void
		{
			Log.getLogger(this.getUniqueName()).error(evt["text"]);
			
			this.signalComplete.dispatch(null);
			
			this.dispose();
		}
		
		public function getUniqueName():String
		{
			return "LoaderBase";
		}
		
		public function dispose():void
		{
			this.signalComplete.removeAll();
			this.signalComplete = null;
		}
	}
}