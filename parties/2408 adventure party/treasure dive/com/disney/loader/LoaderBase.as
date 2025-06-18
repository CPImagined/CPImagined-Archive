package com.disney.loader
{

	import com.disney.lib.IUniquelyNamable;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import org.osflash.signals.Signal;

	public class LoaderBase implements IUniquelyNamable
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
		}

		protected function onError(evt:Event):void
		{
			trace(this.getUniqueName() + " Error: " + evt["text"]);
			this.signalComplete.dispatch(null);
		}
		
		public function getUniqueName():String
		{
			return "[LoaderBase]";
		}
	}
}