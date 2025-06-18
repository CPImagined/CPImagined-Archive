package com.clubpenguin.games.diving.gui
{
	import com.clubpenguin.game.HostAccess;
	import com.clubpenguin.game.ICPGameHost;
	import com.clubpenguin.games.diving.DivingEngine;
	import com.clubpenguin.games.diving.gui.InstructionMC;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import com.clubpenguin.games.gui.ButtonContainer;

	public class TitleMC extends MovieClip
	{
		public var start_btn:MovieClip;
		
		public var instruction_btn:MovieClip;
		
		public var instructions:InstructionMC;

		public var host:ICPGameHost;
		
		public var game:DivingEngine;
		
		public var exit_btn:SimpleButton;

		public function TitleMC()
		{
			super();
			
			this.game = DivingEngine.instance;

			this.host = HostAccess.getHost();
			
			this.start_btn.btn_text.text = this.host.localizeString("diving_start_btn");
			this.instruction_btn.btn_text.text = this.host.localizeString("diving_instructions_btn");
			var textFormat = this.instruction_btn.btn_text.getTextFormat();
			// Slightly too large; scale it down.
			textFormat.size = uint(this.host.localizeString("diving_instructions_btn_text_size"));
			this.instruction_btn.btn_text.setTextFormat(textFormat);

			this.start_btn.btn.addEventListener(MouseEvent.CLICK, this.onStartClicked);
			this.instruction_btn.btn.addEventListener(MouseEvent.CLICK, this.onInstructionsClicked);
			this.exit_btn.addEventListener(MouseEvent.CLICK, this.onExitClicked);
		}

		private function onStartClicked(evt:MouseEvent):void
		{
			this.instructions.visible = false;
			
			this.game.setGameState(DivingEngine.GAME_STATE_PLAY);
		}
		
		private function onInstructionsClicked(evt:MouseEvent):void
		{
			this.instructions.visible = true;
			this.instructions.gotoAndPlay(2);
		}
		
		private function onExitClicked(evt:MouseEvent):void
		{
			this.visible = false;
			
			this.game.endGame();
		}
	}
}