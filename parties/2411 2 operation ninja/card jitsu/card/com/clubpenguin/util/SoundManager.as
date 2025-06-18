//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.SoundManager
    {
        static var _instance;
        var pSounds, iVolume;
        function SoundManager () {
            pSounds = {};
            iVolume = 100;
        }
        static function getInstance() {
            if (_instance == undefined) {
                _instance = new com.clubpenguin.util.SoundManager();
            }
            return(_instance);
        }
        function toString() {
            return("[SoundPlayer]");
        }
        function get volume() {
            return(iVolume);
        }
        function set volume(volume) {
            if (isNaN(volume)) {
                return;
            }
            if (volume < 0) {
                iVolume = 0;
            } else if (volume > 100) {
                iVolume = 100;
            } else {
                iVolume = volume;
            }
            //return(this.volume);
        }
        function play(p) {
            if (!(pSounds[p.iID] instanceof Sound)) {
                com.clubpenguin.util.Debug.log(((("Attempting to PLAY a Sound that is not loaded or has an invalid ID: <" + p.iID) + "> => '") + pSounds[p.iID].sName) + "'", "ERROR");
                if (p.cpFinish) {
                    p.cpFinish.i[p.cpFinish.f].apply(p.cpFinish.i, p.cpFinish.p);
                }
            } else {
                pSounds[p.iID].setVolume((p.iVolume ? (p.iVolume) : (iVolume)));
                if (p.cpFinish) {
                    pSounds[p.iID].onSoundComplete = function () {
                        p.cpFinish.i[p.cpFinish.f].apply(p.cpFinish.i, p.cpFinish.p);
                    };
                }
                pSounds[p.iID].start();
            }
        }
        function stop(p) {
            if (!(pSounds[p.iID] instanceof Sound)) {
                com.clubpenguin.util.Debug.log(((("Attempting to STOP a Sound that is not loaded or has an invalid ID: <" + p.iID) + "> => '") + pSounds[p.iID].sName) + "'", "ERROR");
            } else {
                pSounds[p.iID].onSoundComplete = function () {
                };
                pSounds[p.iID].stop();
            }
        }
        function pause(p) {
            if (!(pSounds[p.iID] instanceof Sound)) {
                com.clubpenguin.util.Debug.log(((("Attempting to PAUSE a Sound that is not loaded or has an invalid ID: <" + p.iID) + "> => '") + pSounds[p.iID].sName) + "'");
            } else if (pSounds[p.iID].position < pSounds[p.iID].duration) {
                pSounds[p.iID].bPaused = true;
                pSounds[p.iID].stop();
            }
        }
        function resume(p) {
            if (!(pSounds[p.iID] instanceof Sound)) {
                com.clubpenguin.util.Debug.log(((("Attempting to RESUME a Sound that is not loaded or has an invalid ID: <" + p.iID) + "> => '") + pSounds[p.iID].sName) + "'");
            } else {
                if (pSounds[p.iID].bPaused) {
                    pSounds[p.iID].start(pSounds[p.iID].position / 1000);
                }
                delete pSounds[p.iID].bPaused;
            }
        }
        function load(p) {
            var _local_2 = (p.sPath ? (p.sPath) : "");
            var iID = (_nextId++);
            pSounds[iID] = new Sound();
            pSounds[iID].sName = (p.sName ? (p.sName) : (p.sFile));
            var m = this;
            pSounds[iID].onLoad = function (bSuccess) {
                if (bSuccess == false) {
                    com.clubpenguin.util.Debug.log(((("Sound Not Found --- Deleting: <" + iID) + "> => '") + m.pSounds[iID].sName) + "'", "ERROR");
                    delete m.pSounds[iID];
                }
                if (p.cpFinish) {
                    p.cpFinish.i[p.cpFinish.f].apply(p.cpFinish.i, p.cpFinish.p);
                }
            };
            pSounds[iID].loadSound((_local_2 + p.sFile) + ".mp3");
            return(iID);
        }
        function unload(p) {
            if (pSounds[p.iID] != undefined) {
                delete pSounds[p.iID];
            }
        }
        static var _nextId = 0;
    }
