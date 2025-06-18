package com.clubpenguin.games.diving.gui
{
	import com.clubpenguin.game.HostAccess;
	import com.clubpenguin.game.ICPGameHost;
	import com.clubpenguin.games.diving.DivingEngine;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.clubpenguin.lib.util.math.MathUtil;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.clubpenguin.lib.IDisposable;

	public class GameHUD extends MovieClip implements IDisposable
	{
		public var score_lbl:TextField;
		
		public var score_txt:TextField;
		
		public var timer_mc:MovieClip;

		public var exit_btn:SimpleButton;
		
		public var host:ICPGameHost;
		
		public var game:DivingEngine;
		
		private var __timeToPlay:int = 0;
		private var __gameTimer:Timer;
		private var __timerWarningStart:uint = 0;

		public function GameHUD()
		{
			super();
			
			this.game = DivingEngine.instance;
			
			this.host = HostAccess.getHost();
			
			this.score_lbl.text = this.host.localizeString("diving_score");
			
			if (XMLUtil.getStringFromConfig(this.game.gameConfig, "wantTimer", "1").length != 0)
			{
				this.__timerWarningStart = XMLUtil.getIntFromConfig(this.game.gameConfig, "timerWarningStart", 5);
				this.__timeToPlay = XMLUtil.getIntFromConfig(this.game.gameConfig, "timeToPlay", 100);
				
				this.__gameTimer = new Timer(1000, this.__timeToPlay);
				this.__gameTimer.addEventListener(TimerEvent.TIMER, this.updateTimer);
				this.__gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.gameOver);
			}
			else
			{
				// Timer is off for debugging.
				this.__timeToPlay = 0;
			}
			
			this.resetTimer();

			this.exit_btn.addEventListener(MouseEvent.CLICK,this.onExitClicked);
		}
		
		public function get timeLeft():Number
		{
			return this.__timeToPlay - this.__gameTimer.currentCount;
		}
		
		private function resetTimer():void
		{
			this.timer_mc.timer_txt.text = String(this.__timeToPlay);
			
			this.timer_mc.gotoAndStop(this.timer_mc.totalFrames);
			
			if (this.__gameTimer != null)
			{
				this.__gameTimer.reset();
			}
		}
		
		public function startTimer():void
		{
			if (this.__gameTimer != null && !this.__gameTimer.running)
			{
				this.__gameTimer.start();
			}
		}
		
		private function updateTimer(evt:TimerEvent)
		{
			var timeLeft = this.timeLeft;
			
			if (timeLeft == 0)
			{
				this.game.soundManager.play("timer_done");
			}
			else if (timeLeft < this.__timerWarningStart)
			{
				this.game.soundManager.play("timer_warning");
			}
			
			this.timer_mc.timer_txt.text = String(timeLeft);
			
			// This logic allows the timer to dynamically update based on any time specified.
			this.timer_mc.gotoAndStop(Math.round(MathUtil.linearInterpolate(1, this.timer_mc.totalFrames, timeLeft / this.__timeToPlay)));
		}
		
		private function endGame():void
		{
			this.resetTimer();
			
			this.game.setGameState(DivingEngine.GAME_STATE_END);
		}
		
		private function gameOver(evt:TimerEvent):void
		{
			this.endGame();
		}

		private function onExitClicked(evt:MouseEvent):void
		{
			this.endGame();
		}
		
		public function dispose():void
		{
			if (this.__gameTimer != null)
			{
				this.__gameTimer.stop();
				this.__gameTimer.removeEventListener(TimerEvent.TIMER, this.updateTimer);
				this.__gameTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.gameOver);
				this.__gameTimer = null;
			}
		}
	}
}