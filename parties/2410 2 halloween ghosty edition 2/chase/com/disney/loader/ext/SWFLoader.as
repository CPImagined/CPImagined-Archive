package com.disney.loader.ext
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import org.osflash.signals.Signal;
	import org.osmf.logging.Log;

	public class SWFLoader extends LoaderBase
	{
		private var __context:LoaderContext;

		public function SWFLoader(_swfFileName:String, _completeHandler:Function, _context:LoaderContext=null)
		{
			this.signalComplete = new Signal(DisplayObject);
			
			this.__context = _context;
			
			super(_swfFileName, _completeHandler);
		}

		override protected function load():void
		{
			var swfLoader:Loader = null;
			var request:URLRequest = new URLRequest(this.__fileName);
			
			Log.getLogger(this.getUniqueName()).debug("Trying to load " + this.__fileName);
			Log.getLogger(this.getUniqueName()).debug("...as URLRequest: " + request.url);
			
			try
			{
				swfLoader = new Loader();
				swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
				swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoaded);
				swfLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
				swfLoader.load(request,this.__context);
			}
			catch (e:Error)
			{
				Log.getLogger(this.getUniqueName()).error(e.message);
				
				this.signalComplete.dispatch(null);
				
				this.dispose();
			}
		}

		private function onProgress(evt:ProgressEvent):void
		{
		}

		override protected function onLoaded(evt:Event):void
		{
			this.signalComplete.dispatch(DisplayObject(evt.target.content));
			
			super.onLoaded(evt);
		}
		
		override public function getUniqueName():String
		{
			return "SWFLoader";
		}
		
		override public function dispose():void
		{
			this.__context = null;
			
			super.dispose();
		}
	}
}