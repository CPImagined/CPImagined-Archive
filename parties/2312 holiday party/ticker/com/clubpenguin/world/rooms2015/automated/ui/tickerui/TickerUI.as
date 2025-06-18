class com.clubpenguin.world.rooms2015.automated.ui.tickerui.TickerUI extends MovieClip
{
	static var NUM_DIGITS = 11;
	
	var _timer;

	function TickerUI()
	{
		super();
		
		this._timer = new com.clubpenguin.util.Timer();
		
		// Initialize to 0
		this.updateCounter();
		this.randomizeDigits();
		
		this._timer.setCallback(com.clubpenguin.util.Delegate.create(this, this.updateCounter));
		
		// Uncomment this to see how it works.
		// Counts from now to January 6th next year at 2 PM EST.
		var targetDate = new Date(Date.UTC(2024, 0, 6, 7, 0, 0, 0));
		this.setTargetDate(targetDate);
		
		this.beginCountdown();
	}
	function randomizeDigits()
	{
		var i = 0;
		while (i < com.clubpenguin.world.rooms2015.automated.ui.tickerui.TickerUI.NUM_DIGITS)
		{
			// Create random number
			var randNum = Number(Math.floor(Math.random( ) * 9));

			// Grab its MovieClip
			var curDigitMc = this["digit" + Number(i + 1)];

			curDigitMc.gotoAndStop("d_" + randNum);
			
			i++;
		}
	}
	function setTargetDate(newTargetDate)
	{
		this._timer.setTargetDate(newTargetDate);
	}
	
	function updateCounter(newCounterVal)
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
		while (i < com.clubpenguin.world.rooms2015.automated.ui.tickerui.TickerUI.NUM_DIGITS)
		{
			// Grab current digit
			var curDigit = digits[digits.length - (1 + i)];

			// Grab its MovieClip
			var curDigitMc = this["digit" + Number(i + 1)];

			// This digit doesn't exist right now so just empty the MovieClip.
			// Colon is also treated as a special case because this UI doesn't
			// have a colon graphic. We'll just display the "blank" frame cuz
			// that gets the point across.
			if (curDigit == undefined || curDigit == ":")
			{
				curDigitMc.gotoAndStop("blank");
			}
			else
			{
				if (curDigitMc.onEnterFrame != undefined)
				{
					delete curDigitMc.onEnterFrame;
				}
				curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, this.trackDigitAnim, curDigitMc, curDigit);
			}
			i++;
		}
	}

	function beginCountdown()
	{
		this._timer.beginTicking();
	}

	function stopCountdown()
	{
		this._timer.stopTicking();
	}
	
	function trackDigitAnim(mc, targetFrame)
	{
		var currLabelInt;
		
		if (mc._currentLabel == "blank")
		{
			// Bail us out
			mc.gotoAndStop("d_0");
			
			// Gotta specify for this case
			// because mc._currentLabel takes a
			// few frames to update.
			currLabelInt = 0;
		}
		else
		{
			currLabelInt = parseInt(mc._currentLabel.charAt(2));
		}
		
		if (currLabelInt == targetFrame)
		{
			// Reached target
			delete mc.onEnterFrame;
		}
		else if (mc._currentframe < 6)  // Frame for d_1
		{
			// Loop back around
			mc.gotoAndStop(mc._totalframes);
		}
		else
		{
			// Keep flipping down
			mc.prevFrame();
		}
	}
}