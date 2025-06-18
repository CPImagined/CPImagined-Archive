class com.clubpenguin.util.Timer
{
	var _now;
	var _targetMilliseconds;

	var _tickRate = 1000;
	var _ivalId = 0;
	var _running = false;
	
	var _callback;

	function Timer(targetDate, callback)
	{
		this._now = new Date();

		this.setTargetDate(targetDate);
		this.setCallback(callback);
	}

	function setTickRate(newTickRate)
	{
		this._tickRate = newTickRate;
	}

	function setTargetDate(newTargetDate)
	{
		this._targetMilliseconds = newTargetDate.getTime();
	}
	
	function setCallback(newCallback)
	{
		this._callback = newCallback;
	}

	function prependZero(num)
	{
		// Adds a 0 to the front to
		// make single digit numbers
		// double digit.
		if (num >= 10)
		{
			return num;
		}
		return "0" + num;
	}

	function __countdownTick()
	{
		// Time from now until the target time...
		var timeRemaining = (this._targetMilliseconds - this._now.getTime());

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

		if ((((daysRemaining <= 0) && (hoursRemaining <= 0)) && (minutesRemaining <= 0)) && (secondsRemaining <= 0))
		{
			formattedTimeLeft.days = 0;
			formattedTimeLeft.hours = 0;
			formattedTimeLeft.minutes = 0;
			formattedTimeLeft.seconds = 0;

			this.stopTicking();
		}
		else
		{
			formattedTimeLeft.days = this.prependZero(sanitizedDays);
			formattedTimeLeft.hours = this.prependZero(sanitizedHours);
			formattedTimeLeft.minutes = this.prependZero(sanitizedMinutes);
			formattedTimeLeft.seconds = this.prependZero(sanitizedSeconds);
			
			this._now.setTime(this._now.getTime() + this._tickRate);
		}
		
		// This is how we will pass the values out to wherever they need to go.
		this._callback(formattedTimeLeft);

		trace(formattedTimeLeft.days + ":" + formattedTimeLeft.hours + ":" + formattedTimeLeft.minutes + ":" + formattedTimeLeft.seconds);
	}

	function beginTicking()
	{
		if (!this._running)
		{
			// Kickoff the ticks
			this._running = true;

			// Count the first second
			this.__countdownTick();

			this._ivalId = setInterval(this, "__countdownTick", this._tickRate);
		}
		else
		{
			trace("Did not begin because we're already running.");
		}
	}

	function stopTicking()
	{
		if (this._running)
		{
			// Stop the ticks
			this._running = false;
			
			clearInterval(this._ivalId);
		}
	}
}