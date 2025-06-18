package com.clubpenguin.games.gui
{
	import com.disney.lib.IUniquelyNamable;
	import com.clubpenguin.lib.IDisposable;
	import com.clubpenguin.games.gui.ButtonContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class ButtonContainerContainer extends MovieClip implements IDisposable,IUniquelyNamable
	{
		public var container:ButtonContainer;
		
		private var __callback:Function;

		public function ButtonContainerContainer()
		{
			super();
		}

		public function set click_callback(callback:Function):void
		{
			if (!this.container.btn.hasEventListener(MouseEvent.CLICK))
			{
				this.container.btn.addEventListener(MouseEvent.CLICK, callback);
				
				this.__callback = callback;
			}
			else
			{
				trace(this.getUniqueName() + " Click callback already registered; did not register another one.");
			}
		}
		
		public function dispose():void
		{
			if (this.container.btn.hasEventListener(MouseEvent.CLICK))
			{
				this.container.btn.removeEventListener(MouseEvent.CLICK, this.__callback);
				
				this.__callback = null;
			}
		}
		
		public function getUniqueName():String
		{
			return "[ButtonContainerContainer " + this.name + "]";
		}
	}
}