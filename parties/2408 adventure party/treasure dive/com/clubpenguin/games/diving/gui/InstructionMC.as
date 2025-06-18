package com.clubpenguin.games.diving.gui
{
	import com.clubpenguin.game.HostAccess;
	import com.clubpenguin.game.ICPGameHost;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class InstructionMC extends MovieClip
	{
		public var treasure_txt:TextField;
		
		public var move_txt:TextField;
		
		public var puffle_txt:TextField;
		
		public var puffle_mc:MovieClip;

		public var exit_btn:SimpleButton;

		public var host:ICPGameHost;

		public function InstructionMC()
		{
			super();

			this.host = HostAccess.getHost();
			this.gotoAndStop(1);
			this.visible = false;
			
			this.treasure_txt.text = this.host.localizeString("diving_instructions_treasure");
			this.move_txt.text = this.host.localizeString("diving_instructions_move");
			this.puffle_txt.text = this.host.localizeString("diving_instructions_puffle");
			
			var textFormat = this.treasure_txt.getTextFormat();
			textFormat.size = uint(this.host.localizeString("diving_instructions_text_size"));
			this.treasure_txt.setTextFormat(textFormat);
			this.move_txt.setTextFormat(textFormat);
			this.puffle_txt.setTextFormat(textFormat);

			this.exit_btn.addEventListener(MouseEvent.CLICK, this.onExitClicked);
			
			this.addFrameScript(19, this.stopAnim);
		}

		private function onExitClicked(evt:MouseEvent):void
		{
			this.visible = false;
			this.gotoAndStop(1);
		}
		
		internal function stopAnim() {
			this.stop();
		}
	}
}