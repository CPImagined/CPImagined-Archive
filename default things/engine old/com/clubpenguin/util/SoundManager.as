class com.clubpenguin.util.SoundManager
{
    var pSounds, iVolume, __get__volume, __set__volume;
    static var _instance;
    function SoundManager()
    {
        pSounds = {};
        iVolume = 100;
    } // End of the function
    static function getInstance()
    {
        if (com.clubpenguin.util.SoundManager._instance == undefined)
        {
            _instance = new com.clubpenguin.util.SoundManager();
        } // end if
        return (com.clubpenguin.util.SoundManager._instance);
    } // End of the function
    function toString()
    {
        return ("[SoundPlayer]");
    } // End of the function
    function get volume()
    {
        return (iVolume);
    } // End of the function
    function set volume(volume)
    {
        if (isNaN(volume))
        {
            return;
        } // end if
        if (volume < 0)
        {
            iVolume = 0;
        }
        else if (volume > 100)
        {
            iVolume = 100;
        }
        else
        {
            iVolume = volume;
        } // end else if
        //return (this.volume());
        null;
    } // End of the function
    function play(p)
    {
        if (!(pSounds[p.iID] instanceof Sound))
        {
            if (p.cpFinish)
            {
                p.cpFinish.i[p.cpFinish.f].apply(p.cpFinish.i, p.cpFinish.p);
            } // end if
        }
        else
        {
            pSounds[p.iID].setVolume(p.iVolume ? (p.iVolume) : (iVolume));
            if (p.cpFinish)
            {
                pSounds[p.iID].onSoundComplete = function ()
                {
                    p.cpFinish.i[p.cpFinish.f].apply(p.cpFinish.i, p.cpFinish.p);
                };
            } // end if
            pSounds[p.iID].start();
        } // end else if
    } // End of the function
    function stop(p)
    {
        if (!(pSounds[p.iID] instanceof Sound))
        {
        }
        else
        {
            pSounds[p.iID].onSoundComplete = function ()
            {
            };
            pSounds[p.iID].stop();
        } // end else if
    } // End of the function
    function pause(p)
    {
        if (!(pSounds[p.iID] instanceof Sound))
        {
        }
        else if (pSounds[p.iID].position < pSounds[p.iID].duration)
        {
            pSounds[p.iID].bPaused = true;
            pSounds[p.iID].stop();
        } // end else if
    } // End of the function
    function resume(p)
    {
        if (!(pSounds[p.iID] instanceof Sound))
        {
        }
        else
        {
            if (pSounds[p.iID].bPaused)
            {
                pSounds[p.iID].start(pSounds[p.iID].position / 1000);
            } // end if
            delete pSounds[p.iID].bPaused;
        } // end else if
    } // End of the function
    function load(p)
    {
        var _loc2 = p.sPath ? (p.sPath) : ("");
        _nextId = ++com.clubpenguin.util.SoundManager._nextId;
        var iID = com.clubpenguin.util.SoundManager._nextId;
        pSounds[iID] = new Sound();
        pSounds[iID].sName = p.sName ? (p.sName) : (p.sFile);
        var m = this;
        pSounds[iID].onLoad = function (bSuccess)
        {
            if (bSuccess == false)
            {
                delete m.pSounds[iID];
            } // end if
            if (p.cpFinish)
            {
                p.cpFinish.i[p.cpFinish.f].apply(p.cpFinish.i, p.cpFinish.p);
            } // end if
        };
        pSounds[iID].loadSound(_loc2 + p.sFile + ".mp3");
        return (iID);
    } // End of the function
    function unload(p)
    {
        if (pSounds[p.iID] != undefined)
        {
            delete pSounds[p.iID];
        } // end if
    } // End of the function
    static var _nextId = 0;
} // End of Class
