package com.clubpenguin.games.gui
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;

	public class ButtonContainer extends MovieClip
	{
		public var btn_text:TextField;
		
		public var btn:SimpleButton;

		public function ButtonContainer()
		{
			super();
			
			// Prevent text from eating the button mouse inputs.
			this.btn_text.mouseEnabled = false;
		}
	}
}