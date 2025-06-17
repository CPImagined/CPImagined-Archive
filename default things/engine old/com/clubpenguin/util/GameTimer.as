class com.clubpenguin.util.GameTimer
{
    var movie, startTime, endTime, currentTime, timerID, mask_mc, mask_width, mask_x, mask_y, mask_radius_inner, mask_radius_outer, mask_start_angle, callbackFunc, callbackValue, totalTime;
    function GameTimer(ref_movie)
    {
        if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("ref_movie = " + ref_movie);
        } // end if
        if (ref_movie)
        {
            movie = ref_movie;
            this.init();
        }
        else if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("Fatal: GameTimer -- Empty movie reference passed to constructor");
        } // end else if
    } // End of the function
    function init()
    {
        startTime = getTimer();
        endTime = com.clubpenguin.util.GameTimer.VAR_NOT_SET;
        currentTime = com.clubpenguin.util.GameTimer.VAR_NOT_SET;
        timerID = com.clubpenguin.util.GameTimer.VAR_NOT_SET;
        mask_mc = movie.hands_mc.createEmptyMovieClip("timer_mask", 1);
        mask_width = movie.hands_mc._width;
        mask_x = mask_width / 2;
        mask_y = mask_width / 2;
        mask_radius_inner = 0;
        mask_radius_outer = mask_width;
        mask_start_angle = -0.250000;
        if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("init: mask_width = " + mask_width);
            this.debugTrace("init: mask_mc = " + mask_mc);
            this.debugTrace("init: movie = " + movie);
        } // end if
    } // End of the function
    function destroy(Void)
    {
        movie.removeMovieClip();
        stop ();
        false;
    } // End of the function
    function start(Void)
    {
        if (timerID == com.clubpenguin.util.GameTimer.VAR_NOT_SET)
        {
            timerID = setInterval(com.clubpenguin.util.Delegate.create(this, tick), com.clubpenguin.util.GameTimer.TIMER_SECOND);
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
                this.debugTrace("start: timerID = " + timerID);
            } // end if
        }
        else if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("start: Warning: trying to start a running timer ( timerID = " + timerID + ")");
        } // end else if
    } // End of the function
    function stop(Void)
    {
        if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("stop: timerID = " + timerID);
        } // end if
        if (timerID != com.clubpenguin.util.GameTimer.VAR_NOT_SET)
        {
            clearInterval(timerID);
            timerID = com.clubpenguin.util.GameTimer.VAR_NOT_SET;
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
                this.debugTrace("stop: timerID has been stopped");
            } // end if
        }
        else if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("stop: Warning: trying to stop a stopped timer ( timerID = " + timerID + ")");
        } // end else if
    } // End of the function
    function setCallback(scope, func, funcValue)
    {
        if (func && typeof(func) == "function")
        {
            callbackFunc = com.clubpenguin.util.Delegate.create(scope, func);
            callbackValue = funcValue;
        }
        else if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
            this.debugTrace("setCallback: func is not a function (" + typeof(func) + ")");
        } // end else if
    } // End of the function
    function setTime(seconds)
    {
        if (seconds)
        {
            currentTime = seconds;
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
                this.debugTrace("setTime: seconds = " + seconds);
            } // end if
            if (currentTime < 0)
            {
                currentTime = Math.abs(seconds);
            }
            else if (currentTime > com.clubpenguin.util.GameTimer.MAX_STEPS)
            {
                currentTime = com.clubpenguin.util.GameTimer.MAX_STEPS;
            } // end else if
            totalTime = currentTime;
            this.drawMask();
            movie.timer_txt.text = currentTime;
            movie.hands_mc.setMask(mask_mc);
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
            } // end if
        } // end if
    } // End of the function
    function setCurrentTime(seconds)
    {
        if (seconds)
        {
            currentTime = seconds;
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
                this.debugTrace("setTime: seconds = " + seconds);
            } // end if
            if (currentTime < 0)
            {
                currentTime = Math.abs(seconds);
            }
            else if (currentTime > com.clubpenguin.util.GameTimer.MAX_STEPS)
            {
                currentTime = com.clubpenguin.util.GameTimer.MAX_STEPS;
            } // end else if
            this.drawMask();
            movie.timer_txt.text = currentTime;
            movie.hands_mc.setMask(mask_mc);
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
            } // end if
        } // end if
    } // End of the function
    function getTime(Void)
    {
        if (!currentTime)
        {
            currentTime = 0;
        } // end if
        return (currentTime);
    } // End of the function
    function tick(Void)
    {
        if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
        } // end if
        if (--currentTime <= 0)
        {
            clearInterval(timerID);
            currentTime = 0;
            this.callbackFunc(callbackValue);
            if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
            {
                if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
                {
                    this.debugTrace("tick: TIME\'S UP!");
                } // end if
            } // end if
        } // end if
        this.drawMask();
        movie.timer_txt.text = currentTime;
        return (currentTime);
    } // End of the function
    function setPosition(newX, newY)
    {
        if (newX && newY)
        {
            movie._x = newX;
            movie._y = newY;
        } // end if
    } // End of the function
    function setSize(newWidth, newHeight)
    {
        if (newWidth && newHeight)
        {
            movie._width = newWidth;
            movie._height = newHeight;
        } // end if
    } // End of the function
    function drawMask(Void)
    {
        var _loc9 = (360 - (totalTime - currentTime) * (360 / totalTime)) / 360;
        var _loc6 = _loc9 / com.clubpenguin.util.GameTimer.DRAW_STEPS;
        var _loc3;
        var _loc2;
        var _loc7;
        var _loc5 = mask_x + Math.cos(mask_start_angle * com.clubpenguin.util.GameTimer.twoPI) * mask_radius_inner;
        var _loc4 = mask_y + Math.sin(mask_start_angle * com.clubpenguin.util.GameTimer.twoPI) * mask_radius_inner;
        var _loc8 = {x: _loc5, y: _loc4};
        mask_mc.clear();
        mask_mc.beginFill(255, 75);
        mask_mc.moveTo(_loc8.x, _loc8.y);
        for (var _loc2 = 1; _loc2 <= com.clubpenguin.util.GameTimer.DRAW_STEPS; ++_loc2)
        {
            _loc3 = (mask_start_angle + _loc2 * _loc6) * com.clubpenguin.util.GameTimer.twoPI;
            _loc5 = mask_x + Math.cos(_loc3) * mask_radius_inner;
            _loc4 = mask_y + Math.sin(_loc3) * mask_radius_inner;
            mask_mc.lineTo(_loc5, _loc4);
        } // end of for
        _loc7 = mask_start_angle + _loc9;
        for (var _loc2 = 0; _loc2 <= com.clubpenguin.util.GameTimer.DRAW_STEPS; ++_loc2)
        {
            _loc3 = (_loc7 - _loc2 * _loc6) * com.clubpenguin.util.GameTimer.twoPI;
            _loc5 = mask_x + Math.cos(_loc3) * mask_radius_outer;
            _loc4 = mask_y + Math.sin(_loc3) * mask_radius_outer;
            mask_mc.lineTo(_loc5, _loc4);
        } // end of for
        mask_mc.lineTo(_loc8.x, _loc8.y);
        mask_mc.endFill();
    } // End of the function
    function debugTrace(message)
    {
        if (com.clubpenguin.util.GameTimer.DEBUG_LOGGING)
        {
        } // end if
    } // End of the function
    static var DEBUG_LOGGING = false;
    static var twoPI = 6.283185;
    static var MAX_STEPS = 360;
    static var DRAW_STEPS = 36;
    static var TIMER_SECOND = 1000;
    static var VAR_NOT_SET = -1;
} // End of Class
