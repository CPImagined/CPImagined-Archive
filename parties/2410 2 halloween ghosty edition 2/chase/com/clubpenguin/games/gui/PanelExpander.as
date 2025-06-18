package com.clubpenguin.games.gui
{
	import com.disney.lib.IDisposable;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	class PanelExpander implements IDisposable
	{
		private var __panel:InteractiveObject;
		private var __expanded:Boolean = false;

		public function PanelExpander(panel:InteractiveObject)
		{
			this.__panel = panel;
			
			this.__panel.addEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this.__panel.addEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
		}

		public function dispose():void
		{
			this.__expanded = false;
			
			this.__panel.removeEventListener(MouseEvent.ROLL_OVER, this.handleRollOver);
			this.__panel.removeEventListener(MouseEvent.ROLL_OUT, this.handleRollOut);
			
			this.__panel = null;
		}

		private function handleRollOver(evt:MouseEvent):void
		{
			if (!this.__expanded)
			{
				this.__expanded = true;

				evt.currentTarget.onExpand();
			}
		}

		private function handleRollOut(evt:MouseEvent):void
		{
			if (this.__expanded)
			{
				this.__expanded = false;

				evt.currentTarget.onCollapse();
			}
		}

		public function get expanded():Boolean
		{
			return this.__expanded;
		}
	}
}