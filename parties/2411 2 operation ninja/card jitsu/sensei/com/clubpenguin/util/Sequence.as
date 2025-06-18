//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.Sequence
    {
        var aEventQueue, bRunning, fOncancel, refSoundManager, iCurrentSound, cpSoundComplete, iDelay, iIntervalId, iDelayStartTimer, iDelayPauseTimer;
        function Sequence () {
            aEventQueue = [];
            bRunning = false;
            fOncancel = undefined;
            refSoundManager = com.clubpenguin.util.SoundManager.getInstance();
            iCurrentSound = null;
            cpSoundComplete = {i:this, f:"_execute", p:[]};
            iDelay = null;
            iIntervalId = null;
            iDelayStartTimer = null;
            iDelayPauseTimer = null;
        }
        function addSound(iID, iVol) {
            aEventQueue.push({eType:SOUND, uData:iID, iVolume:iVol});
            this.start();
        }
        function addFunction(cpFunction) {
            aEventQueue.push({eType:FUNCTION, uData:cpFunction});
            this.start();
        }
        function addMovie(mcTarget, sFrame, bPlay) {
            aEventQueue.push({eType:MOVIE, uData:{mcTarget:mcTarget, sFrame:sFrame, bPlay:bPlay}});
            this.start();
        }
        function addDelay(iTime) {
            aEventQueue.push({eType:DELAY, uData:iTime});
            this.start();
        }
        function setOncancel(fFunction) {
            fOncancel = fFunction;
        }
        function start() {
            if (!bRunning) {
                bRunning = true;
                _execute();
            }
        }
        function cancel() {
            if (!bRunning) {
                return(undefined);
            }
            bRunning = false;
            aEventQueue = [];
            if (iCurrentSound != null) {
                refSoundManager.stop({iID:iCurrentSound});
                iCurrentSound = null;
            }
            if (iIntervalId != null) {
                clearInterval(iIntervalId);
                iIntervalId = null;
                iDelay = null;
                iDelayStartTimer = null;
                iDelayPauseTimer = null;
            }
            if (fOncancel != null) {
                fOncancel();
                fOncancel = undefined;
            }
        }
        function pause() {
            if (iCurrentSound != null) {
                refSoundManager.pause({iID:iCurrentSound});
            }
            if (iIntervalId != null) {
                iDelayPauseTimer = getTimer();
                clearInterval(iIntervalId);
            }
        }
        function resume() {
            if (iCurrentSound != null) {
                refSoundManager.resume({iID:iCurrentSound});
            }
            if (iIntervalId != null) {
                var _local_2 = iDelayPauseTimer - iDelayStartTimer;
                iDelay = iDelay - _local_2;
                iDelayPauseTimer = null;
                iDelayStartTimer = getTimer();
                iIntervalId = setInterval(this, "_execute", iDelay);
            }
        }
        function _execute() {
            iCurrentSound = null;
            if (iIntervalId != null) {
                clearInterval(iIntervalId);
                iIntervalId = null;
            }
            if (aEventQueue.length == 0) {
                bRunning = false;
                return(undefined);
            }
            var _local_2 = aEventQueue.shift();
            switch (_local_2.eType) {
                case SOUND : 
                    iCurrentSound = _local_2.uData;
                    refSoundManager.play({iID:_local_2.uData, iVolume:_local_2.iVolume, cpFinish:cpSoundComplete});
                    break;
                case FUNCTION : 
                    _local_2.uData.i[_local_2.uData.f].apply(_local_2.uData.i, _local_2.uData.p);
                    _execute();
                    break;
                case DELAY : 
                    iDelayStartTimer = getTimer();
                    iDelay = _local_2.uData;
                    iIntervalId = setInterval(this, "_execute", iDelay);
                    break;
                case MOVIE : 
                    if (_local_2.uData.bPlay) {
                        _local_2.uData.mcTarget.gotoAndPlay(_local_2.uData.sFrame);
                    } else {
                        _local_2.uData.mcTarget.gotoAndStop(_local_2.uData.sFrame);
                    }
                    _execute();
                    break;
                default : 
                    break;
            }
        }
        static var SOUND = 0;
        static var FUNCTION = 1;
        static var DELAY = 2;
        static var MOVIE = 3;
    }
