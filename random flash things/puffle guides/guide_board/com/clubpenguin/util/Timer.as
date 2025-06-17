class com.clubpenguin.util.Timer
{
	private var _now;
	private var _targetMilliseconds;

	private var _tickRate = 1000;
	private var _ivalId = 0;
	private var _running = false;

	private var _callback;
	private var _startCallback;
	private var _endCallback;

	public function Timer()
	{
		this._now = new Date();
	}

	public function set tickRate(newTickRate)
	{
		this._tickRate = newTickRate;
	}

	public function get tickRate()
	{
		return this._tickRate;
	}

	public function set targetDate(newTargetDate)
	{
		this._targetMilliseconds = newTargetDate.getTime();

		this._now.setTime(this._now.getTime() + this._tickRate);
	}

	public function get targetDate()
	{
		return this._targetMilliseconds;
	}

	public function set callback(newCallback)
	{
		this._callback = newCallback;
	}

	public function get callback()
	{
		return this._callback;
	}

	public function set startCallback(newCallback)
	{
		this._startCallback = newCallback;
	}

	public function get startCallback()
	{
		return this._startCallback;
	}

	public function set endCallback(newCallback)
	{
		this._endCallback = newCallback;
	}

	public function get endCallback()
	{
		return this._endCallback;
	}

	public function get running()
	{
		return this._running;
	}

	public static function prependZero(num)
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

	private function countdownTick()
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
			formattedTimeLeft.days = com.clubpenguin.util.Timer.prependZero(0);
			formattedTimeLeft.hours = com.clubpenguin.util.Timer.prependZero(0);
			formattedTimeLeft.minutes = com.clubpenguin.util.Timer.prependZero(0);
			formattedTimeLeft.seconds = com.clubpenguin.util.Timer.prependZero(0);

			this.stopTicking();
		}
		else
		{
			formattedTimeLeft.days = com.clubpenguin.util.Timer.prependZero(sanitizedDays);
			formattedTimeLeft.hours = com.clubpenguin.util.Timer.prependZero(sanitizedHours);
			formattedTimeLeft.minutes = com.clubpenguin.util.Timer.prependZero(sanitizedMinutes);
			formattedTimeLeft.seconds = com.clubpenguin.util.Timer.prependZero(sanitizedSeconds);

			this._now.setTime(this._now.getTime() + this._tickRate);
		}

		// This is how we will pass the values out to wherever they need to go.
		this.callback(formattedTimeLeft);

		trace(formattedTimeLeft.days + ":" + formattedTimeLeft.hours + ":" + formattedTimeLeft.minutes + ":" + formattedTimeLeft.seconds);
	}

	public function beginTicking()
	{
		if (!this._running)
		{
			if (this._now.getTime() < this._targetMilliseconds)
			{
				// Kickoff the ticks
				this._running = true;

				// Count the first second
				this.countdownTick();

				this._ivalId = setInterval(this, "countdownTick", this._tickRate);
				this.startCallback();
			}
			else
			{
				this.countdownTick();
				trace("Past date given, did not start.");
			}
		}
		else
		{
			trace("Did not begin because we're already running.");
		}
	}

	public function stopTicking()
	{
		if (this._running)
		{
			// Stop the ticks
			this._running = false;

			clearInterval(this._ivalId);
			this.endCallback();
		}
	}

	public function destroy()
	{
		this._running = false;

		clearInterval(this._ivalId);

		this._callback = undefined;
		this._startCallback = undefined;
		this._endCallback = undefined;
	}
}