class com.clubpenguin.util.TickerUI extends MovieClip
{
	private var _timer;
	private var _view;
	private var _numDigits;
	private var _stage;

	public function TickerUI(stage, view, digits)
	{
		super();

		this._stage = stage;
		this._view = view;
		this._timer = new com.clubpenguin.util.Timer();
		this._numDigits = digits;

		// Initialize to 0
		this.updateCounter();

		this._timer.callback = com.clubpenguin.util.Delegate.create(this, this.updateCounter);
		this._timer.startCallback = com.clubpenguin.util.Delegate.create(this, this.startCounter);
		this._timer.endCallback = com.clubpenguin.util.Delegate.create(this, this.endCounter);
	}

	public function set targetDate(newTargetDate)
	{
		this._timer.targetDate = newTargetDate;
	}

	public function get targetDate()
	{
		return this._timer.targetDate;
	}

	public function get running()
	{
		return this._timer.running;
	}

	public function startCounter()
	{
		this._stage.startCounter();
	}

	public function endCounter()
	{
		this._stage.endCounter();
	}

	public function randomizeDigits()
	{
		var i = 0;
		while (i < this._numDigits)
		{
			// Create random number
			var randNum = Number(Math.floor(Math.random() * 9));

			// Grab its MovieClip
			var curDigitMc = this._view["digit" + Number(i + 1)];

			curDigitMc.gotoAndStop("d_" + randNum);

			i++;
		}
	}

	public function updateCounter(newCounterVal)
	{
		var currValAsString;

		if (newCounterVal == undefined)
		{
			// We can assume this is always the case
			currValAsString = "0";
		}
		else
		{
			var daysAsString = newCounterVal.days.toString();
			var hoursAsString = newCounterVal.hours.toString();
			var minAsString = newCounterVal.minutes.toString();
			var secAsString = newCounterVal.seconds.toString();

			currValAsString = daysAsString + ":" + hoursAsString + ":" + minAsString + ":" + secAsString;
		}

		// Now split it up into digits
		var digits = currValAsString.split("");

		var i = 0;
		while (i < this._numDigits)
		{
			// Grab current digit
			var curDigit = digits[digits.length - (1 + i)];

			// Grab its MovieClip
			var curDigitMc = this._view["digit" + Number(i + 1)];

			// This digit doesn't exist right now so just empty the MovieClip.
			// Colon is also treated as a special case because this UI doesn't
			// have a colon graphic. We'll just display the "blank" frame cuz
			// that gets the point across.

			// UPDATE: Swapped to animate to blank instead.

			if (curDigitMc.onEnterFrame != undefined)
			{
				delete curDigitMc.onEnterFrame;
			}

			if (curDigit == undefined || curDigit == ":")
			{
				curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, this.trackDigitAnim, curDigitMc, "blank");
			}
			else
			{
				curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, this.trackDigitAnim, curDigitMc, curDigit);
			}

			i++;
		}
	}

	public function beginCountdown()
	{
		this.randomizeDigits();
		this._timer.beginTicking();
	}

	public function stopCountdown()
	{
		this.blankenFrames();
		this._timer.stopTicking();
	}

	private function trackDigitAnim(mc, targetFrame)
	{
		var currLabelInt;

		if (mc._currentLabel == "blank") {
			// Bail us out
			mc.gotoAndStop("d_0");

			// Gotta specify for this case
			// because mc._currentLabel takes a
			// few frames to update.
			currLabelInt = 0;
		} else {
			currLabelInt = parseInt(mc._currentLabel.charAt(2));
			currLabelInt = mc._currentLabel.split("d_")[1];
		}

		if (currLabelInt == targetFrame)
		{
			// Reached target
			delete mc.onEnterFrame;
		}
		// Frame for d_1 + exceptions for blank frames.
		else if (mc._currentframe < 6 && targetFrame != "blank" && targetFrame != "toblank")
		{
			// Loop back around
			mc.gotoAndStop(45);
			currLabelInt = 0;
		}
		else
		{
			// Keep flipping down
			mc.prevFrame();
		}
	}

	public function blankenFrames()
	{
		trace("blankenFrames called");

		var i = 0;
		while (i < this._numDigits)
		{

			// Grab its MovieClip
			var curDigitMc = this._view["digit" + Number(i + 1)];

			if (curDigitMc.onEnterFrame != undefined)
			{
				delete curDigitMc.onEnterFrame;
			}

			curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, animBlankFrames, curDigitMc);

			i++;
		}
	}

	private function animBlankFrames(mc)
	{
		if (mc._currentframe == 50)
		{
			// Reached target
			delete mc.onEnterFrame;
		}
		else
		{
			// Keep flipping down
			mc.prevFrame();
		}
	}

	function destroy()
	{
		this._stage = undefined;
		this._view = undefined;
		
		this._timer.stopCountdown();
		this._timer.destroy();
		this._timer = undefined;
	}
}