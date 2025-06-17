//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.Music
    {
        var container, globalVolume, musicClip;
        function Music (container) {
            this.container = container;
            globalVolume = new Sound(null);
        }
        function playMusicURL(url) {
            if (isMuted || (url == currentURL)) {
                return(false);
            }
            if (url.length) {
                musicClip = container.createEmptyMovieClip("music", 0);
                currentURL = url;
                var _local_3 = com.clubpenguin.util.URLUtils.getCacheResetURL(url);
                musicClip.loadMovie(_local_3);
                return(true);
            }
            stopMusic();
            return(false);
        }
        function stopMusic() {
            if (!currentURL.length) {
                return(false);
            }
            musicClip.removeMovieClip();
            currentURL = "";
            return(true);
        }
        function muteMusic() {
            isMuted = true;
            stopMusic();
            _global.getCurrentShell().updateListeners(_global.getCurrentShell().UPDATE_MUSIC, null);
            _global.getCurrentShell().sendMuteMusicPlayer();
        }
        function unMuteMusic() {
            isMuted = false;
            _global.getCurrentShell().updateListeners(_global.getCurrentShell().UPDATE_MUSIC, null);
            _global.getCurrentShell().sendUnmuteMusicPlayer();
        }
        function isMusicMuted() {
            return(isMuted);
        }
        function muteSound() {
            isSoundMuted = true;
            stopSound();
        }
        function stopSound() {
            globalVolume.setVolume(0);
            return(true);
        }
        function unMuteSound() {
            globalVolume.setVolume(100);
            isSoundMuted = false;
        }
        function isAllSoundMuted() {
            return(isSoundMuted);
        }
        var currentURL = "";
        var isMuted = false;
        var isSoundMuted = false;
    }
