class com.clubpenguin.util.Sequence
{
    var aEventQueue, bRunning, fOncancel, refSoundManager, iCurrentSound, cpSoundComplete, iDelay, iIntervalId, iDelayStartTimer, iDelayPauseTimer;
    function Sequence()
    {
        aEventQueue = [];
        bRunning = false;
        fOncancel = undefined;
        refSoundManager = com.clubpenguin.util.SoundManager.getInstance();
        iCurrentSound = null;
        cpSoundComplete = {i: this, f: "_execute", p: []};
        iDelay = null;
        iIntervalId = null;
        iDelayStartTimer = null;
        iDelayPauseTimer = null;
    } // End of the function
    function addSound(iID, iVol)
    {
        aEventQueue.push({eType: com.clubpenguin.util.Sequence.SOUND, uData: iID, iVolume: iVol});
        this.start();
    } // End of the function
    function addFunction(cpFunction)
    {
        aEventQueue.push({eType: com.clubpenguin.util.Sequence.FUNCTION, uData: cpFunction});
        this.start();
    } // End of the function
    function addMovie(mcTarget, sFrame, bPlay)
    {
        aEventQueue.push({eType: com.clubpenguin.util.Sequence.MOVIE, uData: {mcTarget: mcTarget, sFrame: sFrame, bPlay: bPlay}});
        this.start();
    } // End of the function
    function addDelay(iTime)
    {
        aEventQueue.push({eType: com.clubpenguin.util.Sequence.DELAY, uData: iTime});
        this.start();
    } // End of the function
    function setOncancel(fFunction)
    {
        fOncancel = fFunction;
    } // End of the function
    function start()
    {
        if (!bRunning)
        {
            bRunning = true;
            this._execute();
        } // end if
    } // End of the function
    function cancel()
    {
        if (!bRunning)
        {
            return;
        } // end if
        bRunning = false;
        aEventQueue = [];
        if (iCurrentSound != null)
        {
            refSoundManager.stop({iID: iCurrentSound});
            iCurrentSound = null;
        } // end if
        if (iIntervalId != null)
        {
            clearInterval(iIntervalId);
            iIntervalId = null;
            iDelay = null;
            iDelayStartTimer = null;
            iDelayPauseTimer = null;
        } // end if
        if (fOncancel != null)
        {
            this.fOncancel();
            fOncancel = undefined;
        } // end if
    } // End of the function
    function pause()
    {
        if (iCurrentSound != null)
        {
            refSoundManager.pause({iID: iCurrentSound});
        } // end if
        if (iIntervalId != null)
        {
            iDelayPauseTimer = getTimer();
            clearInterval(iIntervalId);
        } // end if
    } // End of the function
    function resume()
    {
        if (iCurrentSound != null)
        {
            refSoundManager.resume({iID: iCurrentSound});
        } // end if
        if (iIntervalId != null)
        {
            var _loc2 = iDelayPauseTimer - iDelayStartTimer;
            iDelay = iDelay - _loc2;
            iDelayPauseTimer = null;
            iDelayStartTimer = getTimer();
            iIntervalId = setInterval(this, "_execute", iDelay);
        } // end if
    } // End of the function
    function _execute()
    {
        iCurrentSound = null;
        if (iIntervalId != null)
        {
            clearInterval(iIntervalId);
            iIntervalId = null;
        } // end if
        if (aEventQueue.length == 0)
        {
            bRunning = false;
            return;
        } // end if
        var _loc2 = aEventQueue.shift();
        switch (_loc2.eType)
        {
            case com.clubpenguin.util.Sequence.SOUND:
            {
                iCurrentSound = _loc2.uData;
                refSoundManager.play({iID: _loc2.uData, iVolume: _loc2.iVolume, cpFinish: cpSoundComplete});
                break;
            } 
            case com.clubpenguin.util.Sequence.FUNCTION:
            {
                _loc2.uData.i[_loc2.uData.f].apply(_loc2.uData.i, _loc2.uData.p);
                this._execute();
                break;
            } 
            case com.clubpenguin.util.Sequence.DELAY:
            {
                iDelayStartTimer = getTimer();
                iDelay = _loc2.uData;
                iIntervalId = setInterval(this, "_execute", iDelay);
                break;
            } 
            case com.clubpenguin.util.Sequence.MOVIE:
            {
                if (_loc2.uData.bPlay)
                {
                    _loc2.uData.mcTarget.gotoAndPlay(_loc2.uData.sFrame);
                }
                else
                {
                    _loc2.uData.mcTarget.gotoAndStop(_loc2.uData.sFrame);
                } // end else if
                this._execute();
                break;
            } 
            default:
            {
                break;
            } 
        } // End of switch
    } // End of the function
    static var SOUND = 0;
    static var FUNCTION = 1;
    static var DELAY = 2;
    static var MOVIE = 3;
} // End of Class
