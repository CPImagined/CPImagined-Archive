package com.clubpenguin.games.diving.gui
{
	import com.clubpenguin.game.HostAccess;
	import com.clubpenguin.game.ICPGameHost;
	import com.clubpenguin.games.diving.DivingEngine;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	public class EndMC extends MovieClip
	{
		public var scorelbl_txt:TextField;
		public var score_txt:TextField;
		
		public var totalscorelbl_txt:TextField;
		public var totalscore_txt:TextField;
		
		public var coinslbl_txt:TextField;
		public var coins_txt:TextField;
		
		public var play_again_btn:MovieClip;
		public var exit_btn:MovieClip;
		
		public var exit_x_btn:SimpleButton;

		public var host:ICPGameHost;
		
		public var game:DivingEngine;

		public function EndMC()
		{
			super();
			
			this.game = DivingEngine.instance;

			this.host = HostAccess.getHost();
			
			this.scorelbl_txt.text = this.host.localizeString("diving_score");
			
			this.totalscorelbl_txt.text = this.host.localizeString("diving_total_score");
			
			this.coinslbl_txt.text = this.host.localizeString("diving_coins");

			this.exit_x_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked);
			
			this.exit_btn.btn_text.text = this.host.localizeString("diving_exit");
			this.exit_btn.btn.addEventListener(MouseEvent.CLICK,this.onExitClicked);
			
			this.play_again_btn.btn_text.text = this.host.localizeString("diving_play_again");
			this.play_again_btn.btn.addEventListener(MouseEvent.CLICK, this.onPlayAgainClicked);
			
			this.addFrameScript(19, this.stop);
			
			this.stop();
		}
		
		public function tallyResults():void
		{
			this.score_txt.text = String(this.game.scoreThisRound);
			this.totalscore_txt.text = String(this.game.scoreN);
			this.coins_txt.text = String(this.game.getGameCoins());
		}
		
		private function onPlayAgainClicked(evt:MouseEvent):void
		{
			this.visible = false;
			
			this.game.setGameState(DivingEngine.GAME_STATE_PLAY);
		}

		private function onExitClicked(evt:MouseEvent):void
		{
			this.visible = false;
			
			this.game.endGame();
		}
	}
}