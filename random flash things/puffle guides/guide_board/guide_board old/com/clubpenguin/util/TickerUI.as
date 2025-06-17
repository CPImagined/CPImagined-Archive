class com.clubpenguin.util.TickerUI extends MovieClip
{
	var _timer, _view, theDate, NUM_DIGITS, _stage;

	function TickerUI(stage, view, digits, startDate) {
		super();
		
		_stage = stage;
		_view = view;
		_timer = new com.clubpenguin.util.Timer();
		NUM_DIGITS = digits;
		theDate = startDate;
		
		// Initialize to 0
		updateCounter();

		_timer.setCallback(com.clubpenguin.util.Delegate.create(this, updateCounter));
		_timer.setStartCallback(com.clubpenguin.util.Delegate.create(this, startCounter));
		_timer.setEndCallback(com.clubpenguin.util.Delegate.create(this, endCounter));
		
		// Uncomment this to see how it works.
		// Counts from now to January 6th next year at 2 PM EST.
		//var targetDate = new Date(Date.UTC(2024, 0, 6, 19, 0, 0, 0));
		setTargetDate(theDate);
		
		beginCountdown();
	}

	function startCounter() {
		_stage.startCounter();
	}

	function endCounter() {
		_stage.endCounter();
	}

	function get targetDate() {
		return(theDate);
	}
	
	function set targetDate(newDate) {
		theDate = newDate;
		setTargetDate(theDate);
	}

	function randomizeDigits() {
		var i = 0;
		while (i < NUM_DIGITS) {
			// Create random number
			var randNum = Number(Math.floor(Math.random( ) * 9));

			// Grab its MovieClip
			var curDigitMc = _view["digit" + Number(i + 1)];

			curDigitMc.gotoAndStop("d_" + randNum);
			
			i++;
		}
	}
	function setTargetDate(newTargetDate) {
		_timer.setTargetDate(newTargetDate);
	}
	
	function updateCounter(newCounterVal) {
		var currValAsString;
		
		if (newCounterVal == undefined) {
			// We can assume this is always the case
			currValAsString = "0";
		} else {
			var daysAsString = newCounterVal.days.toString();
			var hoursAsString = newCounterVal.hours.toString();
			var minAsString = newCounterVal.minutes.toString();
			var secAsString = newCounterVal.seconds.toString();
			
			currValAsString = daysAsString + ":" + hoursAsString + ":" + minAsString + ":" + secAsString;
		}

		// Now split it up into digits
		var digits = currValAsString.split("");

		var i = 0;
		while (i < NUM_DIGITS) {
			// Grab current digit
			var curDigit = digits[digits.length - (1 + i)];

			// Grab its MovieClip
			var curDigitMc = _view["digit" + Number(i + 1)];

			// This digit doesn't exist right now so just empty the MovieClip.
			// Colon is also treated as a special case because this UI doesn't
			// have a colon graphic. We'll just display the "blank" frame cuz
			// that gets the point across.
			// UPDATE: swapped to animate to blank instead.
			if (curDigitMc.onEnterFrame != undefined) {
				delete curDigitMc.onEnterFrame;
			};
			if (curDigit == undefined || curDigit == ":") {
				curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackDigitAnim, curDigitMc, "blank");
			} else {
				curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackDigitAnim, curDigitMc, curDigit);
			}
			i++;
		}
	}

	function beginCountdown() {
		randomizeDigits();
		_timer.beginTicking();
	}

	function stopCountdown() {
		blankenFrames();
		_timer.stopTicking();
	}
	
	function trackDigitAnim(mc, targetFrame) {
		var currLabelInt;
		
		//if (mc._currentLabel == "blank") {
			// Bail us out
			//mc.gotoAndStop("d_0");
			
			// Gotta specify for this case
			// because mc._currentLabel takes a
			// few frames to update.
			//currLabelInt = 0;
		//} else {
			//currLabelInt = parseInt(mc._currentLabel.charAt(2));
			currLabelInt = mc._currentLabel.split("d_")[1];
		//};
		
		if (currLabelInt == targetFrame) {
			// Reached target
			delete mc.onEnterFrame;
		} else if (mc._currentframe < 6 && targetFrame != "blank" && targetFrame != "toblank") {  // Frame for d_1 + exceptions for blank frames
			// Loop back around
			mc.gotoAndStop(45);
			currLabelInt = 0;
		} else {
			// Keep flipping down
			mc.prevFrame();
		};
	}
	
	function blankenFrames() {
		trace("blankenFrames called");
		var i = 0;
		while (i < NUM_DIGITS) {

			// Grab its MovieClip
			var curDigitMc = _view["digit" + Number(i + 1)];

			if (curDigitMc.onEnterFrame != undefined) {
				delete curDigitMc.onEnterFrame;
			};
			curDigitMc.onEnterFrame = com.clubpenguin.util.Delegate.create(this, animBlankFrames, curDigitMc);
			i++;
		}
	}
	
	function animBlankFrames(mc) {
		if (mc._currentframe == 50) {
			// Reached target
			delete mc.onEnterFrame;
		} else {
			// Keep flipping down
			mc.prevFrame();
		};
	}
	
	function destroy() {
		_stage = undefined;
		_view = undefined;
		_timer.destroy();
		_timer = undefined;
	}
}