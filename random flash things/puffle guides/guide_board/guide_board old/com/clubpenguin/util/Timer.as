class com.clubpenguin.util.Timer
{
	var _now;
	var _targetMilliseconds;

	var _tickRate = 1000;
	var _ivalId = 0;
	var _running = false;
	
	var _callback;
	var _startCallback;
	var _endCallback;

	function Timer(targetDate, callback, startCallback, endCallback) {
		_now = new Date();

		setTargetDate(targetDate);
		setCallback(callback);
		setStartCallback(startCallback);
		setEndCallback(endCallback);
	}

	function setTickRate(newTickRate) {
		_tickRate = newTickRate;
	}

	function setTargetDate(newTargetDate) {
		_targetMilliseconds = newTargetDate.getTime();
		
		_now.setTime(_now.getTime() + _tickRate);
		
		if (_now.getTime() < _targetMilliseconds) {
			beginTicking();
		};
	}
	
	function setCallback(newCallback) {
		_callback = newCallback;
	}
	
	function setStartCallback(newCallback) {
		_startCallback = newCallback;
	}
	
	function setEndCallback(newCallback) {
		_endCallback = newCallback;
	}

	function prependZero(num) {
		// Adds a 0 to the front to
		// make single digit numbers
		// double digit.
		if (num >= 10) {
			return num;
		};
		return "0" + num;
	}

	function __countdownTick() {
		// Time from now until the target time...
		var timeRemaining = (_targetMilliseconds - _now.getTime());

		var secondsRemaining = Math.floor(timeRemaining / 1000);
		var minutesRemaining = Math.floor(secondsRemaining / 60);
		var hoursRemaining = Math.floor(minutesRemaining / 60);
		var daysRemaining = Math.floor(hoursRemaining / 24);

		// Clamp the values if they're larger than a day.
		var sanitizedSeconds = Math.floor(secondsRemaining % 60);
		var sanitizedMinutes = Math.floor(minutesRemaining % 60);
		var sanitizedHours = Math.floor(hoursRemaining % 24);
		var sanitizedDays = Math.floor(daysRemaining % 24);

		// Put all the numbers into this object so they can be nicely returned.
		var formattedTimeLeft = new Object();

		if ((((daysRemaining <= 0) && (hoursRemaining <= 0)) && (minutesRemaining <= 0)) && (secondsRemaining <= 0)) {
			formattedTimeLeft.days = prependZero(0);
			formattedTimeLeft.hours = prependZero(0);
			formattedTimeLeft.minutes = prependZero(0);
			formattedTimeLeft.seconds = prependZero(0);

			stopTicking();
		} else {
			formattedTimeLeft.days = prependZero(sanitizedDays);
			formattedTimeLeft.hours = prependZero(sanitizedHours);
			formattedTimeLeft.minutes = prependZero(sanitizedMinutes);
			formattedTimeLeft.seconds = prependZero(sanitizedSeconds);
			
			_now.setTime(_now.getTime() + _tickRate);
		};
		
		// This is how we will pass the values out to wherever they need to go.
		_callback(formattedTimeLeft);

		trace(formattedTimeLeft.days + ":" + formattedTimeLeft.hours + ":" + formattedTimeLeft.minutes + ":" + formattedTimeLeft.seconds);
	}

	function beginTicking() {
		if (!_running) {
			if (_now.getTime() < _targetMilliseconds) {
				// Kickoff the ticks
				_running = true;
	
				// Count the first second
				__countdownTick();
	
				_ivalId = setInterval(this, "__countdownTick", _tickRate);
				_startCallback();
			} else {
				__countdownTick();
				trace("Past date given, did not start.");
			};
		} else {
			trace("Did not begin because we're already running.");
		};
	}

	function stopTicking() {
		if (_running) {
			// Stop the ticks
			_running = false;
			
			clearInterval(_ivalId);
			_endCallback();
		};
	}
	
	function destroy() {
		_running = false;
		clearInterval(_ivalId);
		_callback = undefined;
		_startCallback = undefined;
		_endCallback = undefined;
	}
}